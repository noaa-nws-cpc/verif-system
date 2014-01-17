/**
@fileOverview A collection of functions related to web browser compatibility
*/

//-------------------------------------------------------------------
// Define browser requirements
//
// Note that the engine version (WebKit, Gecko, etc.) is different
// than the browser version, so we'll define both here.
//
// See http://en.wikipedia.org/wiki/List_of_web_browser_engines
//-------------------------------------------------------------------
// Define the required engine versions for each browser name
var requiredEngineVersion = new Array();
requiredEngineVersion['mozilla'] = '1.9';
requiredEngineVersion['msie'] = '8';
// Define the required engine versions for each browser name
var requiredBrowserVersion = new Array();
requiredBrowserVersion['mozilla'] = '3.6';
requiredBrowserVersion['msie'] = '8';

/**
@namespace A collection of functions related to web browser compatibility
*/
BrowserCompatibility = {
	/**
	Gets the name of the current web browser using jQuery
	*/
	getBrowserName: function() {
		return $.uaMatch(navigator.userAgent).browser;
	},
	/**
	Gets the version of the current web browser's rendering engine using jQuery
	*/
	getEngineVersion: function() {
		return $.browser.version;
	},
	/**
	Gets the minimum version of the current web browser's rendering engine
	required in order for the VWT to work, using jQuery. The array storing
	the minimum required version is defined at the top of this script.

	@param {String} [browserName] Name of the browser (optional)
	*/
	getRequiredEngineVersion: function(browserName) {
		// If no browser was provided, use the current browser, otherwise
		// use the provided browser
		if (!browserName) {
			return requiredEngineVersion[this.getBrowserName()];
		} else {
			return requiredEngineVersion[browserName];
		}
	},
	/**
	Gets the minimum version of the current web browser required in order
	for the VWT to work, using jQuery. The array storing the minimum required
	version is defined at the top of this script.

	@param {String} [browserName] Name of the browser (optional)
	*/
	getRequiredBrowserVersion: function(browserName) {
		// If no browser was provided, use the current browser, otherwise
		// use the provided browser
		if (!browserName) {
			return requiredBrowserVersion[this.getBrowserName()];
		} else {
			return requiredBrowserVersion[browserName];
		}
	},
	/**
	Checks the compatibility of the current web browser by comparing the
	version of the current browser's engine with the minimum required
	version specified in an array at the top of this script.
	*/
	checkCompatibility: function() {
		// If we've specified a required version for this browser, then check
		// the version, otherwise just let the browser pass the test automatically
		if (typeof requiredEngineVersion[this.getBrowserName()] == "undefined") {
			return 1;
		} else {
			// Make sure the version of the browser is >= the required version
			if (parseFloat(this.getEngineVersion()) >= parseFloat(requiredEngineVersion[this.getBrowserName()])) {
				return 1;
			} else {
				return 0;
			}
		}
	}
}
