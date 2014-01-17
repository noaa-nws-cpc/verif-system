package gov.noaa.ncep.cpc.resources;

import java.net.URL;

public class Resources
{
  private static Resources myResource = new Resources();

  // NOTE: there is no error checking here so if parameter is mistyped
  // somewhere else in code, then this will probably throw a null pointer exception
  public static URL getURL(String name)
  {
    return myResource.getClass().getResource(name);
  }
}
