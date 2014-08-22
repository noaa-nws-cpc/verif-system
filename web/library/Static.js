/**
@fileOverview A collection of functions related to the static verification page
*/

//-------------------------------------------------------------------
// Define variables and constants
//-------------------------------------------------------------------
// Define a global settings variable to be accessed by all functions
var settings = new Array();
// Get URL parameters
var urlVars = Util.getUrlVars();
// Set names of the variables found in the ASCII header
var headerVarName = [];
headerVarName['percentValid'] = "Percent of valid scores";
// Constants
percentValidScoresRequired = 95;
// File vars
var file;
/**
@namespace A collection of functions related to the static verification page
*/
Static = {
	/**
	Updates the results display based on the settings selected in the settings panel.
	*/
	updateResults: function() {
		// Clear current contents in the errorPanel
		this.clearErrorPanel();
		// Get current page
		var page = urlVars['page'];
		if (typeof(page) == 'undefined') { page = 'chart'; } // default to 'chart'
		// Set variables based on the page
		var scoreDimension = '';
		if (page === 'map') {
			scoreDimension = 'space';
		} else if (page === 'chart') {
			scoreDimension = 'time';
		}
		// Get form settings
		settings = this.getSettings();
		// Right now fcstSource is always manual. This could be made a form variable in the future.
		settings['fcstSource'] = "manual";
		// Right now categoryType is always total. This could be made a form variable in the future.
		settings['categoryType'] = "Combined Categories";
		//-----------------------------------------------------------
		// Settings
		//-----------------------------------------------------------
		var verifPeriod;
		var filePath = this.getBaseURL() + "/products/verification/land_air/all_ranges/conus/verif_web_tool";
		//alert(filePath);
		if (settings['fcstType'] === "6-10day") {
			settings['leadTime']  = '08d';
			settings['aveWindow'] = '05d';
			if (page === 'map') {
				verifPeriod = ["030d","090d","365d","all"];
			} else if (page === 'chart') {
				verifPeriod = ["030d","090d","365d"];
			}
		} else if (settings['fcstType'] === "8-14day") {
			settings['leadTime']  = '11d';
			settings['aveWindow'] = '07d';
			verifPeriod           = ["030d","090d","365d"];
		} else if (settings['fcstType'] === "monthly") {
			settings['leadTime']  = '01m';
			settings['aveWindow'] = '01m';
			if (page === 'map') {
				verifPeriod = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","all"];
			} else if (page === 'chart') {
				verifPeriod = ["005y","all"];
			}
		} else if (settings['fcstType'] === "monthlyRevised") {
			settings['leadTime']  = '0pt5m';
			settings['aveWindow'] = '01m';
			if (page === 'map') {
				verifPeriod = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","all"];
			} else if (page === 'chart') {
				verifPeriod = ["005y","all"];
			}
		} else if (settings['fcstType'] === "seasonal") {
			settings['leadTime']  = '02m';
			settings['aveWindow'] = '03m';
			if (page === 'map') {
				verifPeriod = ["DJF","JFM","FMA","MAM","AMJ","MJJ","JJA","JAS","ASO","SON","OND","NDJ","all"];
			} else if (page === 'chart') {
				verifPeriod = ["005y","all"];
			}
		}
		//-----------------------------------------------------------
		// Construct table of resulting images
		//-----------------------------------------------------------
		// Keep a count of the warnings so we can link to specific ones in the errorPanel ("why" link
		// when the image was not found)
		var error_count = 1;
		// Start the HTML table
		var htmlString = "<table class='center'><tr>";
		// Loop over all verifPeriod's and build the HTML string
		var count = 1;
		for (var i in verifPeriod) {
			// Convert verifPeriod to plain english
			var verifPeriodPlainEnglish = this.verifPeriod_to_plainEnglish(verifPeriod[i]);
			// Convert verifPeriod to plain english for titles
			var verifPeriodTitlePlainEnglish = this.verifPeriodTitle_to_plainEnglish(verifPeriod[i]);
			// Construct the name of the image and ascii filenames
			var fileNameWithoutExtension = 'verif_'+settings['variable']+'_'+settings['fcstSource']+'_'+settings['leadTime']+'_'+settings['aveWindow']+'_grid2deg_'+settings['scoreType']+'_'+scoreDimension+'_'+verifPeriod[i];
			var imageFileName = fileNameWithoutExtension+".png";
			var asciiFileName = fileNameWithoutExtension+".txt";
			// Check if the file exists
			if (! this.fileExists(filePath+"/"+asciiFileName)) {
				// Add a table cell with an "image not available" message
				htmlString += "<td><h3>"+verifPeriodTitlePlainEnglish+"</h3><div class=\"image_not_available\"><div class=\"container\"><span>Image not available</span><br><span data-tooltip='There were technical issues while generating the verification data'>[Why?]</span></div></div></td>";
				// Send an error to the errorPanel
				this.addError("<span>Input data file necessary to produce a plot covering "+verifPeriodPlainEnglish+" was not found <span class='tooltip' data-tooltip='There were technical issues while generating the verification data'>[Why?]</span></span>");
				// Increment the number of warnings so far
				error_count++;
			} else {
				//-------------------------------------------------------------
				// Check if the percent good data meets the requirement
				//
				// Get the header variables from the ascii file
				var headerVars = this.getAsciiHeaderVars(filePath+"/"+asciiFileName);
				// Add the fcstType and categoryType to the header variable name provided at the top to make the
				// full name of the header variable storing the percent valid scores
				var percentValidHeaderVarName = headerVarName['percentValid']+" for "+settings['fcstSource']+" forecast "+settings['categoryType']+" category";
				// If the header doesn't contain a percentage, make it zero
				var percentValidScores;
				if (typeof(headerVars[percentValidHeaderVarName]) == 'undefined') {
					percentValidScores = 0;
				} else {
					percentValidScores = parseFloat(headerVars[percentValidHeaderVarName].match(/\d*/));
				}
				if (percentValidScores < percentValidScoresRequired) { // Data fails QC
					// Add a table cell with an "image not available" message
					htmlString += "<td><h3>"+verifPeriodTitlePlainEnglish+"</h3><div class=\"image_not_available\"><div class=\"container\"><span>Image not available</span><br><span data-tooltip='In order for an image to be produced, at least 95% of the verification scores must be available but "+percentValidScores+"% of the verification scores were found.'>[Why?]</span></div></div></td>";
					// Send an error to the errorPanel
					this.addError("<span>Insufficient data available to pass quality control, plot not produced covering "+verifPeriodPlainEnglish+" <span class='tooltip' data-tooltip='In order for an image to be produced, at least 95% of the verification scores must be available but "+percentValidScores+"% of the verification scores were found.'>[Why?]</span></span>");
					// Increment the number of warnings so far
					error_count++;
				} else if (percentValidScores >= percentValidScoresRequired && percentValidScores < 100) { // Data passes QC but not 100%
					// Send a warning to the errorPanel
					this.addWarning("<a name=\"warning"+error_count+"\">"+(100-percentValidScores)+"% of the input data points used to produce a plot covering "+verifPeriodPlainEnglish+" were missing.</a>");
					// Increment the number of warnings so far
					error_count++;
					// Add a table cell with the image, and a link to download the raw data
					htmlString += "<td><h3>"+verifPeriodTitlePlainEnglish+"</h3><a class='popupImage' rel='gallery' title='"+verifPeriod[i]+"'  href='"+filePath+"/"+imageFileName+"'><img class='"+page+"' src='"+filePath+"/"+imageFileName+"' /></a><br><a target=\"_blank\" href=\""+filePath+"/"+asciiFileName+"\">Download data</a></td>";
				} else {
					// One final check for the image itself
					if (! this.fileExists(filePath+"/"+imageFileName)) {
						// Add a table cell with an "image not available" message
						htmlString += "<td><h3>"+verifPeriodTitlePlainEnglish+"</h3><div class=\"image_not_available\"><div class=\"container\"><span>Image not available</span><br><span data-tooltip='There were technical issues while generating the verification image'>[Why?]</span></div></div></td>";
						// Send an error to the errorPanel
						this.addError("<span>An image was not found covering "+verifPeriodPlainEnglish+" <span data-tooltip='There were technical issues while generating the verification image'>[Why?]</span></span>");
						// Increment the number of warnings so far
						error_count++;
					} else {
						// Add a table cell with the image, and a link to download the raw data
						htmlString += "<td><h3>"+verifPeriodTitlePlainEnglish+"</h3><a class='popupImage' rel='gallery' title='"+verifPeriod[i]+"'  href='"+filePath+"/"+imageFileName+"'><img class='"+page+"' src='"+filePath+"/"+imageFileName+"' /></a><br><a target=\"_blank\" href=\""+filePath+"/"+asciiFileName+"\">Download data</a></td>";
					}
				}
			}
			// When we've reached a count of 3, finish the <tr> and start a new one.
			// This ensures we never have more than 3 images per table row.
			if (count == 3) {
				// Close the HTML table row
				htmlString += "</tr><tr>";
				// Reset the counter
				count=0;
			}
			// Increment the count of images for this table row
			count++;
		}
		htmlString += "</tr></table>";
		// Insert the HTML string into the results panel
		$('#resultsPanel div.content').html(htmlString);
		// Create a tooltip popup for all errors
		this.create_tooltips();
		// Set up FancyBox, the jQuery image popup software
		$('a.popupImage').fancybox({
			'titleShow': true
		});
		//---------------------------------------------------------------------
		// Update the info panel with information for the appropriate score
		//
		// If chart display Interpreting axis info
		if (page === 'chart') {
			var fileAxis = this.titleCase(page)+"AxisText.html";
			file = this.titleCase(settings['scoreType'])+"Text.html";
			fileContents = this.getFileContents("include/"+fileAxis);
			fileContents = "<h4> Interpreting the X and Y Axes</h4> \n" + fileContents + "\n" + "<h4>Understanding the skill score</h4>" + this.getFileContents("include/"+file);
		}
		else if (page === 'map') {
			// Construct input file name
			file = this.titleCase(settings['scoreType'])+"Text.html";
			// Get contents of HTML file
			fileContents = "<b>Understanding the skill score</b>" + this.getFileContents("include/"+file);
		}
		else {
			// Print nothing
		}
		// Insert HTML contents into the infoPanel
		$('#infoPanelText').html(fileContents);
	},

	/**
	Gets the settings from the settings form
	*/
	getSettings: function() {
		// Create an empty settings array
		var settings = new Array();
		// Loop over all form inputs
		$(':input:visible').each(function() {
			settings[$(this).attr('name')] = $(this).val();
		});
		// Return the settings array
		return settings;
	},

	/**
	Converts the given verif period to plain English

	@param {string} verifPeriod  verification period

	@returns Plain English version of the verification period
	*/
	verifPeriod_to_plainEnglish: function(verifPeriod) {
		switch(verifPeriod) {
			case "030d":
				return "the last 30 days";
				break;
			case "090d":
				return "the last 90 days";
				break;
			case "365d":
				return "the last 365 days";
				break;
			case "005y":
				return "the last 5 years";
				break;
			case "Jan":
				return "all Januarys";
				break;
			case "Feb":
				return "all Februarys";
				break;
			case "Mar":
				return "all Marchs";
				break;
			case "Apr":
				return "all Aprils";
				break;
			case "May":
				return "all Mays";
				break;
			case "Jun":
				return "all Junes";
				break;
			case "Jul":
				return "all Julys";
				break;
			case "Aug":
				return "all Augusts";
				break;
			case "Sep":
				return "all Septembers";
				break;
			case "Oct":
				return "all Octobers";
				break;
			case "Nov":
				return "all Novembers";
				break;
			case "Dec":
				return "all Decembers";
				break;
			case "JFM":
				return "all January through March seasons";
				break;
			case "FMA":
				return "all February through April seasons";
				break;
			case "MAM":
				return "all March through May seasons";
				break;
			case "AMJ":
				return "all April through June seasons";
				break;
			case "MJJ":
				return "all May through July seasons";
				break;
			case "JJA":
				return "all June through August seasons";
				break;
			case "JAS":
				return "all July through September seasons";
				break;
			case "ASO":
				return "all August through October seasons";
				break;
			case "SON":
				return "all September through November seasons";
				break;
			case "OND":
				return "all October through December seasons";
				break;
			case "NDJ":
				return "all November through January seasons";
				break;
			case "DJF":
				return "all December through February seasons";
				break;
			case "all":
				return "the entire record";
				break;
		}
	},

/**
	Converts the given verif period to plain English for the extended range (6-10,8-14 day) plot labels.

	@param {string} verifPeriod  verification period

	@returns Plain English version of the verification period
	*/
	verifPeriodTitle_to_plainEnglish: function(verifPeriod) {
		switch(verifPeriod) {
			case "030d":
				return "last 30 days";
				break;
			case "090d":
				return "last 90 days";
				break;
			case "365d":
				return "last 365 days";
				break;
			case "005y":
				return "last 5 years";
				break;
			case "Jan":
				return "Jan";
				break;
			case "Feb":
				return "Feb";
				break;
			case "Mar":
				return "Mar";
				break;
			case "Apr":
				return "Apr";
				break;
			case "May":
				return "May";
				break;
			case "Jun":
				return "Jun";
				break;
			case "Jul":
				return "Jul";
				break;
			case "Aug":
				return "Aug";
				break;
			case "Sep":
				return "Sep";
				break;
			case "Oct":
				return "Oct";
				break;
			case "Nov":
				return "Nov";
				break;
			case "Dec":
				return "Dec";
				break;
			case "JFM":
				return "Jan-Feb-Mar";
				break;
			case "FMA":
				return "Feb-Mar-Apr";
				break;
			case "MAM":
				return "Mar-Apr-May";
				break;
			case "AMJ":
				return "Apr-May-Jun";
				break;
			case "MJJ":
				return "May-Jun-Jul";
				break;
			case "JJA":
				return "Jun-Jul-Aug";
				break;
			case "JAS":
				return "Jul-Aug-Sep";
				break;
			case "ASO":
				return "Aug-Sep-Oct";
				break;
			case "SON":
				return "Sep-oct-Nov";
				break;
			case "OND":
				return "Oct-Nov-Dec";
				break;
			case "NDJ":
				return "Nov-Dec-Jan";
				break;
			case "DJF":
				return "Dec-Jan-Feb";
				break;
			case "all":
				return "All seasons";
				break;
		}
	},


	/**
	Checks the data quality by checking the percentage of good data available (in the header of the ascii file)

	@param {string}  file              ASCII file containing the header with a quality control percentage
	@param {integer} percentThreshold  Percent (without '%') needed to pass quality control

	@returns 0 if it fails, between 0 & 1 if it passes but is still not 100%, and 1 if it has 100%
	*/
	checkDataQuality: function(file, percentThreshold) {
		// Get the header variables from the ascii file
		var headerVars = this.getAsciiHeaderVars(file);
		// Add the fcstType and categoryType to the header variable name provided at the top to make the
		// full name of the header variable storing the percent valid scores
		var percentValidHeaderVarName = headerVarName['percentValid']+" for "+settings['fcstSource']+" forecast "+settings['categoryType']+" category";
		// If the header doesn't contain a percentage, fail the file
		if (typeof(headerVars[percentValidHeaderVarName]) == 'undefined') {
			return 0;
		} else {
			// If the percentage found in the header is below the threshold percentage provided, return 0 (fail),
			// otherwise return 1 (pass)
			var percent = parseFloat(headerVars[percentValidHeaderVarName].match(/\d*/));
			if (percent >= 100) {
				return 1;
			} else if (percent >= percentThreshold) {
				return 0.5;
			} else {
				return 0;
			}
		}
	},

	/**
	Adds the given warning to the errorPanel

	$param {String} warning  Warning message to append to the error panel
	*/
	addWarning: function(warning) {
		$('#errorPanelText').append("<span class=\"warning\">[ ! ] " + warning + "</span><br>");
	},

	/**
	Adds the given error to the errorPanel

	$param {String} error  Error message to append to the error panel
	*/
	addError: function(error) {
		$('#errorPanelText').append("<span class=\"error\">[ x ] " + error + "</span><br>");
	},

	/**
	Clears the contents of the errorPanel
	*/
	clearErrorPanel: function(error) {
		$('#errorPanelText').html("");
	},

	/**
	Checks if a file exists

	@param {String} file  File to check existence of

	@returns {integer}  success value (1 for success, 0 for failure)
	*/
	fileExists: function(file) {
		// Initilize vars
		var existence = 0;
		//---------------------------------------------------------------------------
		// Use jQuery ajax() function to open the text file
		//
		// Make the data variable have scope in the rest of this script. This is set
		// make to true after the jQuery ajax() function is executed.
		$.ajaxSetup({ async: false });
		// Execute the jQuery ajax() function. If the function is successful, then
		// the function defined in "success" is executed. If it's no successful, then
		// the function defined in "error" is executed.
		$.ajax({
			url: file,
			success: function() {
				existence = 1;
			},
			error: function(request, errorType, errorString) {
				if (errorString === "Not Found") {
					existence = 0;
				} else {
					existence = 1;
				}
			}
		});
		// Set back to true (the default value)
		$.ajaxSetup({ async: true });
		// Return the file existence
		return existence;
	},

	/**
	Retrieves the contents of an ASCII file

	@param {String} file  File to open

	@returns {String}  String containing the file contents
	*/
	getFileContents: function(file) {
		// Initialize variables
		var fileContents = ''; // Variable to store the contents of the ASCII file
		var data         = ''; // Variable to store the ASCII file contents (retrieved from the AJAX call)
		//---------------------------------------------------------------------------
		// Use jQuery ajax() function to open the text file
		//
		// Make the data variable have scope in the rest of this script. This is set
		// make to true after the jQuery ajax() function is executed.
		$.ajaxSetup({ async: false });
		// Execute the jQuery ajax() function. If the function is successful, then
		// the function defined in "success" is executed. If it's no successful, then
		// the function defined in "error" is executed.
		$.ajax({
			url: file,
			success: function(data) {
				fileContents = data;
			},
			error: function(request, ajaxErrorType, ajaxErrorString) {
				errorString = ajaxErrorString;
			}
		});
		$.ajaxSetup({ async: true });
		return fileContents;
	},

	/**
	Gets all variables found in the header of the given ascii file, and returns them in an array

	@param {String} file  File to read header variables from

	@returns {String}  String containing the header variables from file
	*/
	getAsciiHeaderVars: function(file) {
		// Initialize variables
		var headerVars = new Array();
		// Use the getFileContents() function to retrieve the file contents
		var fileContents = this.getFileContents(file);
		// Put contents into an array, one line per record
		var lines = fileContents.split("\n");
		// Loop over each line
		$.each(lines, function(i, line) {
			// If this is a comment, grab the key/val pair. The key is the text describing the
			// variable (eg. "Variable verified"), and the val is the value of the variable,
			// following the colon (eg. "temperature").
			//
			// This if-statement uses the Javascript RegExp.test() function. It's matching any line
			// that starts with a '#' and has one or more words, a colon, and then one or more words.
			var regexp = /^#\s*(.*):\s*(.*)\s*/m;
			// If the line matches, it's a comment...
			if (regexp.test(line)) {
				// Split the match into a key and val pair
				var regexpMatch = line.match(regexp);
				var key = regexpMatch[1].replace(/\s*$/gi,''); // Remove trailing whitespace
				var val = regexpMatch[2].replace(/\s*$/gi,''); // Remove trailing whitespace
				headerVars[key] = val;
			}
		});
		return headerVars;
	},

	/**
 	Get the base URL of the current page

	@ returns String  base of the current page's URL
	*/
	getBaseURL: function() {
		return location.protocol + "//" + location.hostname + (location.port && ":" + location.port);
	},

	/**
	Converts a string to "title case", where the first letter of each word is an upper case letter

	@param {String} str  String to convert to title case

	@returns String converted to title case
	*/
	titleCase: function(str) {
		return str.toLowerCase().replace(/\b[a-z]/g, function(letter) {
			    return letter.toUpperCase();
		});
	},

	/**
	Create a tooltip for all <span>s containing a data-tooltip attribute. The
	content will be contained in the data-tooltip attribute, and the title will
	the content in the title attribute.
	*/
	create_tooltips: function() {
		//---------------------------------------------------------------------
		// Use "qTip2", a jQuery tooltip plugin, to create a tooltip
		//
        // Apply the jQuery qTip function to attach a popup tooltip
        $('span[data-tooltip]').each(function() {
			$(this).qtip({
	            position: {
	                my: 'bottom center', // Position my top left...
	                at: 'top center',    // at the bottom right of...
	                target: $(this)      // this target element
	            },
	            content: {
	                text: $(this).attr('data-tooltip'),
	                title: {
	                    text: $(this).attr('title'),
	                    button: "close"
	                }
	            },
	            style: {
	                classes: 'ui-tooltip-custom ui-tooltip-rounded'
	            },
	            show: {
	                event: 'click',
	                delay: 0,
	                solo: true
	            },
	            hide: {
	                event: 'unfocus click'
	            }
    	    });
		});
	}

}
