package gov.noaa.ncep.cpc.services;

import gov.noaa.ncep.cpc.driver.VerificationDriver;
import gov.noaa.ncep.cpc.resources.Resources;

import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis2.AxisFault;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;
import org.apache.axis2.transport.http.HTTPConstants;
import org.apache.log4j.Logger;
import org.ini4j.Wini;

//
// This class provides a thread that will request a Results object from the
// web services when a call to doQuery is made. This was done because the
// axis2 webservice libraries access resources that an unsigned applet
// is not allowed to make and calls to the applet needing this functionality
// are made thru JavaScript. If this thread is started in the applets init
// the thread can make the requests as a signed applet. The JavaScrip calls
// just hand the thread the settings array to use for the request.
//
public class ServiceCallThread implements Runnable
{
  // Set up logger
  static protected Logger logger = Logger.getLogger(VerificationDriver.class.getName());
  
  public static String serviceURL;

   // Load MySQL settings from a configuration file
  static {
    Wini ini = null;
    try {
      ini = new Wini(Resources.getURL("verif.conf"));
    } catch (Exception e) {
      logger.fatal("Cannot open configuration file verif.conf. Did you create a verif_client.conf file in the input directory?");
      System.exit(0);
    }
    serviceURL = ini.get("services","URL");
    logger.debug("Web services URL: "+serviceURL);
  }
   
  private volatile Thread queryThread;
  private Vector<QueryObject> queries = new Vector<QueryObject>();
  
  public Results doQuery(String[] settings)
  {
    // if the thread is not running return null
    if (queryThread != null)
    {
      // create the query object and to hand to the thread
      QueryObject query = new QueryObject(settings);
      synchronized (query)
      {
        synchronized (this)
        {
          // hand the query object to the thread
          queries.add(query);
          // wake up the thread
          notify();
        }
        try
        {
          // wait until we know we have the result
          query.wait();
        }
        catch (InterruptedException e)
        {
        }
      } 
      // return the results
      return query.results;
    }
    return null;
  }
  
  public synchronized void start()
  {
    if (queryThread == null)
    {
      queryThread = new Thread(this);
      queryThread.start();
    }
  }
  
  public synchronized void stop()
  {
    queryThread = null;
    notify();
  }
  
  public void run()
  {
    Thread currentThread = Thread.currentThread();
    synchronized(this)
    {
      // while the thread has not been stoped
      while (queryThread == currentThread)
      {
        try
        {
          // if the thread has not been stopped and there are no queries to process then wait
          while (queryThread==currentThread && queries.isEmpty())
          {
            wait();
          }
        }
        catch (InterruptedException e)
        {         
        }
        // if the thread has not been stopped and we have queries to make, do them
        if (queryThread==currentThread && !queries.isEmpty())
        {
          QueryObject query = queries.remove(0);
          query.setResults(callGetResultsWebService(query.getSettings()));
          synchronized(query)
          {
            // wake up the thread waiting on this specific result
            query.notify();
          }
        }
      }
    }
  }
  
  private Results callGetResultsWebService(String[] settings)
  {
    Results results = null;
    
    RPCServiceClient serviceClient = null;
    try
    {
      serviceClient = new RPCServiceClient();
      
      Options options = serviceClient.getOptions();
      
      EndpointReference targetEPR = new EndpointReference(serviceURL);
      options.setTo(targetEPR);
      options.setProperty(HTTPConstants.SO_TIMEOUT, new Integer(120000));
      
      
      QName opGetFittedCurveObs =
        new QName("http://VerificationSystemTool/xsd", "getResults");
      
      Object[] args = new Object[1];
      args[0] = settings;
      
      Class[] returnType = new Class[] {Results.class};
      
      Object[] response = serviceClient.invokeBlocking(opGetFittedCurveObs, args, returnType);
      
      results = (Results)response[0];
    }
    catch (AxisFault fault)
    {
      fault.printStackTrace();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      if (serviceClient != null)
      {
        try
        {
          serviceClient.cleanupTransport();
        }
        catch (AxisFault fault)
        {
        }
      }
    }
    
    return results;
  }
  
  class QueryObject
  {
    String[] settings;
    Results results;
    
    public QueryObject(String[] settings)
    {
      this.settings = settings;
    }
    
    public String[] getSettings()
    {
      return settings;
    }
    
    public Results getResults()
    {
      return results;
    }
    
    public void setResults(Results results)
    {
      this.results = results;
    }
  }
  
}
