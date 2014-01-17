package gov.noaa.ncep.cpc.qc;

// Import needed packages
import gov.noaa.ncep.cpc.format.FormatLibrary;
import netscape.javascript.JSObject;

import org.apache.log4j.Logger;

/**
Class handles errors and display of errors, including on a JSObject for applets.
*/
public class Log {

	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.qc.Log.class);
	static JSObject window = null;  // JSObject containing the window

	/**
	Passes a warning message in String (HTML) format as well as the div to pass to in a web GUI,
	including an applet. Correct implementation of this method should be followed
	by following the usage instructions below. The result should be allowing
	other external classes that import the qc package to call this method with an
	associated warning message and have the warning display in the specified div tag
	on a GUI.
	<br>
	<b>Usage : </b>
	<br>
	<b>Set up instructions. This only needs to be done once to use logging througout software :</b>
	<br>
	In the code containing the GUI, ie. the applet code init() method that creates a JSObject with
	the web display, set the JSObject in the Log.java class (which is in the qc package):
	<br>ie. in Applet.java : <br>
	<b><i>import netscape.javascript.JSObject;</b>//At top of code<br>
	<b><i>import gov.noaa.ncep.cpc.qc.*; </b>//At top of code<br>
	<b>window = JSObject.getWindow(this); </b>// In init() method of applet<br>
	<b>Log.setJSObject(JSObject window); </b>//Right after the window is obtained.</i></b>
	<br>
	Where jsobject is a GUI part in Javascript that the warning should write to.
	<br><br>
	<b>To use logging in code(s) once set-up in any class:</b><br>
	<i><b>import gov.noaa.ncep.cpc.qc.*; </b>//At top of code<br>
	<b>Log.warning(String htmlString, String cssSelector);</i><br></b>
	Where <i>htmlString</i> is an HTML formatted warning string to display, and
	<br><i>cssSelector</i> is a String representing the CSS selector of the page element
	you wish to append the log message to. For example, use cssSelector="#errorPanelText"
	to send text to the panel with an id="errorPanelText".
	<br>
	<b>Log message formatting information:</b><br>
	<ul>
	<li>The String message that you pass should not be wrapped in a &lt;p&gt; tag because by default, all messages will have
	a &lt;span&gt; tag surrounding it.
	</li>
	<li>Also, "[ ! ]" is prepended to the log message signifying that it's a warning.
	</li>
	<li>If you want to include a Java command or information included in the
	message, create a concatenated String with that info and then pass the string
	as the first String argument to Log.warning.<br>
	<b>For example: </b>You want to include the value of output type in the warning string displayed:<br>
	<i><b>String warning = "settingsObj.getOutputType() + " is not a valid outputType!";<br>
	Log.warning(warning,"#errorPanelText");</b>// "#errorPanelText" is the div tag to display to.</i>
	</li>
	</ul>
	@param warningStr  String of warning message.
	@param cssSelector CSS selector of the page element to send text to.
	*/
	public static void warning(String warningStr, String cssSelector) {
		logger.trace("web logging level WARNING being called");
		// Format the warning and div so that it can be passed to Javascript as an object
		// Put the warning and div in a 1-D array
		String[] strArray = new String[3];
		//strArray[0] = warningStr;
		// Add <p> tags to the warning string so that each warning will be on a new line.
		strArray[0] = "<span class=\"warning\">[ ! ] " + warningStr + "</span><br>";
		strArray[1] = cssSelector;
		String concatString = FormatLibrary.arrayToString(strArray,";");
		logger.trace("Concatenated string for warning logging display is : " + concatString);
		Object[] warningObj = {concatString};
		// Try to log to web
		try {
			if (window == null) {
// 				logger.warn("Web logging not set up properly because the JSObject window is null. Make sure your applet with JSObject calls the setJSObject(JSObject window) method in this class first.");
			}
			else {
				// Set appropriate JS class
				JSObject messagingClass = (JSObject) window.getMember("Messaging");
				// Print message to window
				messagingClass.call("appendToPageElement",warningObj);
			}
		}
		catch (Exception e) {
		}
 	} // End method warning()

	/**
	Passes an error in String (HTML) format as well as the div to pass to in a web GUI,
	including an applet. Correct implementation of this method should be followed
	by following the usage instructions below. The result should be allowing
	other external classes that import the qc package to call this method with an
	associated error message and have the error display in the specified div tag
	on a GUI.
	<br>
	<b>Usage : </b>
	<br>
	<b>Set up instructions. This only needs to be done once to use logging througout software :</b>
	<br>
	In the code containing the GUI, ie. the applet code init() method that creates a JSObject with
	the web display, set the JSObject in the Log.java class (which is in the qc package):
	<br>ie. in Applet.java : <br>
	<b><i>import netscape.javascript.JSObject;</b>//At top of code<br>
	<b><i>import gov.noaa.ncep.cpc.qc.*; </b>//At top of code<br>
	<b>window = JSObject.getWindow(this); </b>// In init() method of applet<br>
	<b>Log.setJSObject(JSObject window); </b>//Right after the window is obtained.</i></b>
	<br>
	Where jsobject is a GUI part in Javascript that the error should write to.
	<br><br>
	<b>To use logging in code(s) once set-up in any class:</b><br>
	<i><b>import gov.noaa.ncep.cpc.qc.*; </b>//At top of code<br>
	<b>Log.error(String htmlString, String cssSelector);</i><br></b>
	Where <i>htmlString</i> is an HTML formatted error string to display, and
	<br><i>divName</i> is a String representing CSS selector of the page element
	you wish to append the log message to. For example, use cssSelector="#errorPanelText"
	to send text to the panel with an id="errorPanelText".
	<br>
	<b>Log message formatting information:</b><br>
	<ul>
	<li>The String message that you pass should not be wrapped in a &lt;p&gt; tag because by default, all messages will have
	a &lt;br&gt; tag surrounding it.
	</li>
	<li>Also, "[ x ]" is prepended to the log message signifying that it's an error.
	</li>
	<li>If you want to include a Java command or information included in the
	message, create a concatenated String with that info and then pass the string
	as the first String argument to Log.error.<br>
	<b>For example: </b>You want to include the value of output type in the error string displayed:<br>
	<i><b>String error = "settingsObj.getOutputType() + " is not a valid outputType!";<br>
	Log.error(error,"#errorPanelText");</b>// "#errorPanelText" is the CSS selector of the page element to send text to.</i>
	</li>
	</ul>
	@param errorStr    String of error message.
	@param cssSelector CSS selector of the page element to send text to.
	*/
	public static void error(String errorStr, String cssSelector) {
		logger.trace("web logging level ERROR being called");
		// Format the error and div so that it can be passed to Javascript as an object
		// Put the error and div in a 1-D array
		String[] strArray = new String[3];
		//strArray[0] = errorStr;
		// Add <p> tags to the error string so that each error will be on a new line.
		strArray[0] = "<span class=\"error\">[ x ] " + errorStr + "</span><br>";
		strArray[1] = cssSelector;
		String concatString = FormatLibrary.arrayToString(strArray,";");
		logger.trace("Concatenated string for error logging display is : " + concatString);
		Object[] errorObj = {concatString};
		// Try to log to web
		try {
			if (window == null) {
 				logger.warn("Web logging not set up properly because the JSObject window is null. Make sure your applet with JSObject calls the setJSObject(JSObject window) method in this class first.");
			}
			else {
				// Set appropriate JS class
				JSObject messagingClass = (JSObject) window.getMember("Messaging");
				// Print message to window
				messagingClass.call("appendToPageElement",errorObj);
			}
		}
		catch (Exception e) {
		}
 	} // End method error()

	/**
	Passes an error in String (HTML) format to a pop-up panel in the JSObject window
	that is associated with the settings object. This would typically be called
	for a more serious warning, like a fatal error.
	<br>
	<b>Usage : </b>
	<br>
	<b>Set up instructions. This only needs to be done once to use logging througout software :</b>
	<br>
	In the code containing the GUI, ie. the applet code init() method that creates a JSObject with
	the web display, set the JSObject in the Log.java class (which is in the qc package):
	<br>ie. in Applet.java : <br>
	<b><i>import netscape.javascript.JSObject;</b>//At top of code<br>
	<b><i>import gov.noaa.ncep.cpc.qc.*; </b>//At top of code<br>
	<b>window = JSObject.getWindow(this); </b>// In init() method of applet<br>
	<b>Log.setJSObject(JSObject window); </b>//Right after the window is obtained.</i></b>
	<br>
	Where jsobject is a GUI part in Javascript that the error should write to.
	<br><br>
	<b>To use logging in code(s) once set-up in any class:</b><br>
	<i><b>import gov.noaa.ncep.cpc.qc.*; </b>//At top of code<br>
	<b>Log.fatal(String htmlString);</i><br></b>
	Where <i>htmlString</i> is an HTML formatted error string to display.
	<br>
	<ul>
	<li>If you want to include a Java command or information included in the
	message, create a concatenated String with that info and then pass the string
	as the first String argument to Log.fatal.<br>
	<b>For example: </b>You want to include the value of output type in the error string displayed:<br>
	<i><b>String fatalStr = "settingsObj.getOutputType() + " is not a valid outputType!";<br>
	Log.error(fatalStr, cssSelector);</b></i>
	</li>
	</ul>
	@param fatalStr    String of a fatal error message.
    @param cssSelector CSS selector of the page element to send text to.
	*/
	public static void fatal(String fatalStr, String cssSelector) {
		logger.trace("web logging level FATAL being called");
		//---------------------------------------------------------------------
		// First call the error() method, since for a fatal error we still
		// want to append a message to the panel
		//
		error(fatalStr,cssSelector);
		//---------------------------------------------------------------------
		// Now perform the fatal call
		//
		String[] strArray = new String[2];
		strArray[0] = fatalStr;
		strArray[1] = cssSelector;
		logger.trace("Fatal String is " + fatalStr);
		Object[] fatalObj = {fatalStr};
		// Try to log to web
		try {
			if (window == null) {
 				logger.warn("Web logging not set up properly because the JSObject window is null. Make sure your applet with JSObject calls the setJSObject(JSObject window) method in this class first.");
			}
			else {
				// Set appropriate JS class
				JSObject messagingClass = (JSObject) window.getMember("Messaging");
				// Print message to window
				messagingClass.call("popup",fatalObj);
			}
		} // End try block
		catch (Exception e) {
			logger.warn("Couldn't log the following message to the browser: "+fatalStr);
		}
	}

	/**
	Empties the area in the passed cssSelector argument. This method calls the method in Javascript,
	in Messaging.js, clearPageElement(cssSelector) empties the passed element, defined by the CSS selector.
	This must be called at the beginning of the init() and update() method(s) in the applet. Make sure
	to call this after the window is set (Log.setJSObject() ) in this class.
	@param cssSelector CSS selector of the element to empty.
	*/
	public static void empty(String cssSelector) {
		Object[] cssSelectorObj = {cssSelector};
		try {
			// Set appropriate JS class
			JSObject messagingClass = (JSObject) window.getMember("Messaging");
			// Print message to window
			messagingClass.call("clearPageElement",cssSelectorObj);
		}
		catch (Exception e) {
			logger.warn("Could not empty the messaging error panel");
		}
	}

	/**
	Sets the Javascript window object (JSObject window) that can be accessed by this class later on. This is used for browser displayed errors to users that can be inserted in code.
	(See error() method in Log.java in qc package for more info).
	@param passedWindow A Javascript object window, typically passed by an applet. Typical usage would be by the browser GUI displaying a growable warning panel.
	*/
	public static void setJSObject(JSObject passedWindow) {
		logger = Logger.getLogger(Log.class.getName());
		logger.debug("Setting JSObject window");
		window = passedWindow;
	}

}
