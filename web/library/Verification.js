/**
@fileOverview A collection of functions related to the VWT, including map functions and interaction between the page and any webforms.
*/

//-----------------------------------------------------------
// Initialize global variables and constants
// Region map type
settings['regionType'] = 'climateRegion';
// Time options type
settings['datesValidType'] = 'dateRange';
// Hash array showing whether a region is selected
var selected = new Array();
// jsGraphics object where region highlighting will take place
var jg = null;
// Region map image object
var regionMapImage;
// Minimum date found in the database
var MIN_DATE = new Array();
MIN_DATE['6-10day']  = '20080101';
MIN_DATE['8-14day']  = '20080101';
MIN_DATE['monthly']  = '199501';
MIN_DATE['seasonal'] = '199501';
// Max allowed days in date range selection
var MAX_SELECTED_DATES = 365;

//-----------------------------------------------------------
// Preload region chooser map images
//
var map_climateRegions   = new Image();
var map_states           = new Image();
var map_climateDivisions = new Image();
map_climateRegions.src   = "images/map_climateRegions.jpg";
map_states.src           = "images/map_states.jpg";
map_climateDivisions.src = "images/map_climateDivisions.jpg";

/**
@namespace A collection of functions related to the VWT.
*/
Verification = {
	/**
	Sets the region(s) in the options form when the user clicks one
	of the regions in the region selection map. The strings
	representing the regions in the form's text field are comma-delimited,
	and are formatted as follows:

	<table class="custom">
		<tr>
			<th>Region Type</th><th>Format</th><th>Example</th>
		</tr>
		<tr>
			<td>Climate Regions</td><td>1 or 2-digit code</td><td>NE, SE, S</td>
		</tr>
		<tr>
			<td>States</td><td>2-digit state code</td><td>NY, MD, FL</td>
		</tr>
		<tr>
			<td>Climate Divisions</td><td>3-digit number</td><td>005, 021, 101</td>
		</tr>
	</table>

	Note: By default, the text box contains the word "CONUS", which is converted to
	a list of all the possible regions by the Java code. If the word "CONUS" is in the
	text box when this function is called, it is cleared before settings the region.

	@param {String}  clickedRegion  Region clicked by the user
	*/
	setRegion: function(clickedRegion)
	{
		// Get the current region
		regionObj = document.getElementById("regionSelect");
		oldRegion = regionObj.value;
		// If region is set to "CONUS", then clear it first
		if (oldRegion=="CONUS" || oldRegion=="") {
			regionObj.value = clickedRegion;
		} else {
			regionObj.value = oldRegion + "," + clickedRegion;
		}
	},
	/**
	Attempt to allow Javascript to see events (hasn't worked yet).
	Source : http://www.java2s.com/Tutorial/JavaScript/0300__Event/IsShiftkeypressedduringthemouseclick.htm

	@param  oEvent  Event to handle
	*/
	handleEvent: function(oEvent) {
		var oTextbox = document.getElementById("txt1");
		oTextbox.value += "\n    button down is " + oEvent.button;

		var arrKeys = [];
		if (oEvent.shiftKey) {
			arrKeys.push("Shift");
			alert("Pressed key is shift!");
		}
		oTextbox.value += "\n    keys down are " + arrKeys;
		alert( "    keys down are " + arrKeys);
	},
	/**
	Performs validation on the form in the VWT.
	<br><br>
	Some variables are adjust before sending them to the Java code.
	For example, the forecast sources that are checked are concatenated,
	separated by commas, into a string before sending to the Java code.
	<br><br>
	This function is called by {@link Verification.processForm}.
	*/
	validateForm: function() {
		// Assume true by default
		var success = true;

		//-----------------------------------------------------------
		// All the following form settings will be retrieved with jQuery
		//
		//     setting['xxx'] = $('#settingsForm li[data-setting=xxx]:visible yyy').val();
		//
		// where:
		//
		//     #settingsForm         Settings form
		//     li[data-setting=xxx]  <li> element for the setting wanted
		//
		//                           (replace xxx with setting name)
		//     yyy:visible           element containing the setting's value
		//                           (replace yyy with a CSS selector)
		//                           (we want the visible one, since there may be
		//                           multiple version of a setting, dependent on
		//                           other settings in the form)
		// For example:
		//
		//     $('#settingsForm li[data-setting=variable] select:visible').val();

		///////////////////////////////////////////////////////
		// Variable
		//
		settings['variable'] = $('#settingsForm li[data-setting=variable] select:visible').val();

		///////////////////////////////////////////////////////
		// Forecast type
		//
		settings['leadTime'];
		settings['aveWindow'];
		settings['fcstType'] = $('#settingsForm li[data-setting=fcsttype] select:visible').val();

		// Get the lead time
		if (settings['fcstType'] === "6-10day") {
			settings['leadTime'] = $('#settingsForm input[name=leadTime_6-10day]:checked').val();
			settings['aveWindow'] = "05d";
		} else if (settings['fcstType'] === "8-14day") {
			settings['leadTime'] = $('#settingsForm input[name=leadTime_8-14day]:checked').val();
			settings['aveWindow'] = "07d";
		} else if (settings['fcstType'] === "monthly") {
			settings['leadTime']  = $('#settingsForm input[name=leadTime_monthly]:checked').val();
			settings['aveWindow'] = "01m";
		} else if (settings['fcstType'] === "seasonal") {
			settings['leadTime']  = $('#settingsForm li[data-setting=leadtime] select:visible').val();
			settings['aveWindow'] = "03m";
		}

		///////////////////////////////////////////////////////
		// Spatial type
		//
		settings['spatialType'] = $('#settingsPanel select[name=spatialType]').val();

		///////////////////////////////////////////////////////
		// Forecast source
		//
		// Get list of forecast sources checked
		settings['fcstSources'] = "";
		var fcstType = settings['fcstType'];
		var fcstSourceArray = $('li[data-setting=fcstsource] div:visible input:checked, #toolSelector input:checked');
		fcstSourceArray.each(function() {
			settings['fcstSources'] += $(this).val() + ",";
		});
		// Trim the last character of fcstSource
		settings['fcstSources'] = settings['fcstSources'].substring(0,settings['fcstSources'].length-1);
		// Make sure at least one option is set
		if (settings['fcstSources'] === "") {
			alert("Please select at least one forecast source");
			return false;
		}

		///////////////////////////////////////////////////////
		// DatesValid
		//
		// Date range
		if (settings['datesValidType'] === 'dateRange') {
			// Set required date formats
			if (settings['fcstType'] === '6-10day' || settings['fcstType'] === '8-14day') {
				requiredDateFormat = 'YYYYMMDD';
			} else if (settings['fcstType'] === 'seasonal' || settings['fcstType'] === 'monthly') {
				requiredDateFormat = 'YYYYMM';
			}
			//-------------------------------------------------------
			// Start date
			//
			startDate = $('#settingsForm li[data-setting=startdate] input:visible').val();
			// Make sure the user has entered something
			if ( startDate == $('#settingsForm li[data-setting=startdate] input:visible').attr('placeholder') ) {
				alert("Please provide a start date in the form " + requiredDateFormat);
				return false;
			}
			// Check string length
			if (settings['fcstType'] === '6-10day' || settings['fcstType'] === '8-14day') {
				if (startDate.length != 8) {
					alert("Start date is invalid. Please provide a start date in the form " + requiredDateFormat);
					return false;
				}
			} else if (settings['fcstType'] === 'seasonal' || settings['fcstType'] === 'monthly') {
				if (startDate.length != 6) {
					alert("Start date is invalid. Please provide a start date in the form " + requiredDateFormat);
					return false;
				}
			}
			// Validate startDate
			var yyyy_start = startDate.substring(0,4);
			var mm_start   = startDate.substring(4,6);
			var dd_start   = startDate.substring(6,8);
			var yyyy_min   = MIN_DATE[fcstType].substring(0,4);
			var mm_min     = MIN_DATE[fcstType].substring(4,6);
			var dd_min     = MIN_DATE[fcstType].substring(6,8);
			if (!(Dates.isValidDate(yyyy_start, mm_start, dd_start))){
				alert("Start date is not a valid date. Please provide a start date in the form " + requiredDateFormat);
				return false;
			}
			// Make sure the start date is at least the minimum required date
			if (new Date(yyyy_start, mm_start-1, dd_start, 0, 0, 0) < new Date(yyyy_min, mm_min-1, dd_min, 0, 0, 0)) {
				alert("The start date must be "+MIN_DATE[fcstType]+" or after.");
				return false;
			}
			//-------------------------------------------------------
			// End date
			//
			endDate = $('#settingsForm li[data-setting=enddate] input:visible').val();
			// Make sure the user has entered something
			if ( endDate == $('#settingsForm li[data-setting=startdate] input:visible').attr('placeholder') ) {
				alert("Please provide an end date in the form " + requiredDateFormat);
				return false;
			}
			// Check string length
			if (settings['fcstType'] === '6-10day' || settings['fcstType'] === '8-14day') {
				if (endDate.length != 8) {
					alert("End date is invalid. Please provide a start date in the form " + requiredDateFormat);
					return false;
				}
			} else if (settings['fcstType'] === 'seasonal' || settings['fcstType'] === 'monthly') {
				if (endDate.length != 6) {
					alert("End date is invalid. Please provide a start date in the form " + requiredDateFormat);
					return false;
				}
			}
			// Validate endDate
			var yyyy_end = endDate.substring(0,4);
			var mm_end   = endDate.substring(4,6);
			var dd_end   = endDate.substring(6,8);
			if (!(Dates.isValidDate(yyyy_end, mm_end, dd_end))){
				alert("End date is not a valid date. Please provide an end date in the form " + requiredDateFormat);
				return false;
			}
			// Make sure the end date is >= start date
			if (new Date(yyyy_end, mm_end-1, dd_end, 0, 0, 0) < new Date(yyyy_start, mm_start-1, dd_start, 0, 0, 0)) {
				alert("The end date must occur after the start date.");
				return false;
			}
			// Make sure the end date is less than or equal to today
			if (settings['fcstType'] === '6-10day' || settings['fcstType'] === '8-14day') {
				var testDate = new Date();
				testDate.setDate(testDate.getDate());
				var month = testDate.getMonth() + 1;
				var day = testDate.getDate();
				var year = testDate.getFullYear();
				if (new Date(yyyy_end, mm_end-1, dd_end, 0, 0, 0) > testDate) {
					alert("The end date must be today or earlier (see the \"help\" section)");
					return false;
				}
			}
			// Make sure there isn't more than X number of days between the start and end dates (for ERF dateRange only)
//			if (settings['fcstType'] === '6-10day' || settings['fcstType'] === '8-14day') {
//				var num_dates_selected = Math.ceil(((new Date(yyyy_end,mm_end-1,dd_end,0,0,0))-(new Date(yyyy_start,mm_start-1,dd_start,0,0,0)))/86400000);
//				if (num_dates_selected > MAX_SELECTED_DATES) {
//					alert("The range of dates selected is too large ("+num_dates_selected+"), please limit the date range to "+MAX_SELECTED_DATES+" days or less");
//					return false;
//				}
//			}
			// Convert start and end dates to a single datesValid variable
			settings['datesValid'] = startDate + "," + endDate;
		} else if (settings['datesValidType'] === 'selectMonths') {
			// Set settings['datesValid']
			months = this.getSelectedMonths();
			if (months === '') {
			  if (settings['fcstType'] === 'seasonal') {
				  alert("Please select at least one season");
			  } else {
			    alert("Please select at least one month");
			  }
				return 0;
			}
			settings['datesValid'] = months;
		} else if (settings['datesValidType'] === 'selectMonthsYears') {
			// Set settings['datesValid']
			var months = this.getSelectedMonths();
			if (months === '') {
				alert("Please select at least one month");
				return 0;
			}
			var years  = this.getSelectedYears();
			if (years === '') {
				alert("Please select at least one year");
				return 0;
			}
			settings['datesValid'] = months + ";" + years;
		} else if (settings['datesValidType'] === 'selectSeasonalSignal') {
			// Determine which seasonalSignalType bullet is selected (use jQuery
			// to get the <input> with a name of 'seasonalSignalType')
			var signalType = $('input[name=seasonalSignalType]:checked').val();
			// Determine the value of the selected seasonalSignalType (use jQuery
			// to get the <select> with a name of whatever the signalType is)
			var signalValue = $('select[name='+signalType+']').val();
			settings['datesValid'] = signalType+';'+signalValue;
		}

		///////////////////////////////////////////////////////
		// Region type
		//
		// Remove 's' from regionType
		if (settings['regionType'] == "states") {
			settings['regionType'] = "state";
		} else if (settings['regionType'] == "climateRegions") {
			settings['regionType'] = "climateRegion";
		} else if (settings['regionType'] == "climateDivisions") {
			settings['regionType'] = "climateDivision";
		}

		///////////////////////////////////////////////////////
		// Region(s)
		//
		// Only validate the region(s) if outputType is "chart"
		if (settings['outputType'] === "chart") {
			settings['regions'] = $('#settingsForm li[data-setting=regions] input:visible').val();
			if (settings['regions'] == "") {
				alert("Please select a region.");
				return;
			// Currently we only have AK temp
			} else if (/\b(AK|103)\b/.test(settings['regions']) && settings['variable'] !== "temp") {
				alert("Currently only temperature can be verified for Alaska");
				return;
			// Currently we only have AK stations
			} else if (/\b(AK|103)\b/.test(settings['regions']) && settings['spatialType'] !== "station") {
				alert("Currently only station verification is available for Alaska");
				return;
			// Currently we only have AK 6-10day and 8-14day
			} else if (/\b(AK|103)\b/.test(settings['regions']) && !(settings['fcstType'] === '6-10day' || settings['fcstType'] === '8-14day')) {
				alert("Currently only Alaska forecasts can only be verified for the 6-10day and 8-14day periods");
				return;
			}
		} else {
			settings['regions'] = "CONUS";
		}

		///////////////////////////////////////////////////////
		// Spatial type
		//
		settings['spatialType'] = $('#settingsForm li[data-setting=spatialtype] select:visible').val();

		///////////////////////////////////////////////////////
		// Output type
		//
		// Gotten from the outer tab

		///////////////////////////////////////////////////////
		// Score type
		//
		settings['scoreType'] = $('#settingsForm li[data-setting=scoretype] select:visible').val();

		///////////////////////////////////////////////////////
		// Output dimension
		//
		// If outputType is map, then the dimension is space.
		// If it's chart, then the dimension is time.
		if (settings['outputType'] === "chart") {
			settings['outputDimension'] = "time";
		} else if (settings['outputType'] === "map") {
			settings['outputDimension'] = "space";
		}
		// If scoreType is relibility, outputDimension needs to be probability
		if (settings['scoreType'] === "reliability") {
			settings['outputDimension'] = "probability";
		}

		///////////////////////////////////////////////////////
		// Category type
		//
		if (settings['scoreType'] === "rpss") {
			settings['categoryType'] = "total";
		} else {
			settings['categoryType'] = $('#settingsForm li[data-setting=categorytype] select:visible').val();
		}

		///////////////////////////////////////////////////////
		// EC Type
		//
		// Eventually there will be validation here when the EC Type
		// is an actual option on the page. For now it's just set to
		// default in the background.
		settings['ECType'] = "default";

		return true;
	},

	/**
	Processes the VWT form. This includes validation, displaying a
	processing message, and calling the update method of the Java
	code.
	*/
	processForm: function()
	{
		// Validate form fields
		var success = this.validateForm();

		// If validation was successful, continue
		if (! success) {
			return false;
		}

		// Inform the user that results are being processed
		$("#resultsPanel > h2").html("Processing, please wait...");
		$('#settingsForm .runStatus').css('color','#900');
		$('#settingsForm .runStatus').html("Processing, please wait...");
		$('#settingsForm .runStatus').show();

        // Convert the settings to XML to be sent to the servlet
        servlet_request = settings_to_servlet_request(settings);

		//------------------------------------------------------------------------------------------
		// Update the plot
		//
 		result = this.updatePlot();
	},

	/**
	Calls the Java update method, sending the appropriate variables.
	*/
	updatePlot: function() {
		//-------------------------------------------------------
		// Append settings used to the infoPanel
		//
		// ONLY FOR USER TESTING!!!
		//
		var str = "variable=" + settings['variable'] + ", " +
		"fcstSources=" + settings['fcstSources'] + ", " +
		"leadTime=" + settings['leadTime'] + ", " +
		"aveWindow=" + settings['aveWindow'] + ", " +
		"datesValidType=" + settings['datesValidType'] + ", " +
		"datesValid=" + settings['datesValid'] + ", " +
		"regionType=" + settings['regionType'] + ", " +
		"regions=" + settings['regions'] + ", " +
		"spatialType=" + settings['spatialType'] + ", " +
		"outputType=" + settings['outputType'] + ", " +
		"outputDimension=" + settings['outputDimension'] + ", " +
		"scoreType=" + settings['scoreType'] + ", " +
		"categoryType=" + settings['categoryType'] + ", " +
		"ECType=" + settings['ECType'];
		$('#printSettingsPanel p.content').html(str);

		// -----------------------------------------------------------------------------------------
        // Call the servlet
        //
        call_servlet(servlet_request);
	},

	/**
	Updates the VWT info panel with the given HTML.
	@param {String} html  HTML to insert into the VWT info panel
	*/
	updateInfoPanel: function(html) {
		$('#infoPanelText').html(html);
	},

	/**
	Updates the VWT plot title with the given HTML.
	@param {String} html  HTML to insert into the VWT plot title
	*/
	updatePlotTitle: function(html) {
		 $("#resultsPanel > h2").html(html);
	},

	/**
	Clears any selected polygons in the region selection map.
	<br><br>
	This method calls {@link clear}
	*/
	clearRegions: function() {
		// If jg is null, then do nothing, otherwise clear it
		if (jg!=null) {
			// Clear all polygons
			jg.clear();
			// Set the region select box to the default ("CONUS")
			$('#regionSelect').val("CONUS");
		}
	},

	/**
	Draws a polygon over a given region. This function parses a string
	of coordinates and uses the {@link wz_jsgraphics.js} script to
	plot a polygon on the webpage.

	@param {String}  regionLocation  Name of the region (currently unused)
	@param {String}  regionCoord     x,y coordinates to use when drawing polygon
	*/
	DRAW: function(regionLocation,regionCoord) {
		// If jg hasn't been created yet, then create it now. Otherwise, use the
		// jg that already exists.
		if (jg==null) {
			jg = new jsGraphics("canvas");
		}
		// Split the coordinates by comma delimeter
		regionCoord=regionCoord.split(",");
		var numRegionCoords = regionCoord.length; // Get Array length
		var xArray = []; // Initialize Arrays for x and y coordinates
		var yArray = [];
		var i = 0;
		var arrayIndex = 0;//Array index
		// Parse polygon coordinates into x and y coordinates and put into arrays
		while (i<numRegionCoords)
		{
			xArray[arrayIndex] = parseInt(regionCoord[i]);
			yArray[arrayIndex] = parseInt(regionCoord[i+1]);
			arrayIndex = arrayIndex + 1;
			i = i+2;
		}
		// Draw a red polygon over the region
		jg.setColor("red");
		jg.fillPolygon(xArray,yArray);
		// Outline the polygon in blue
		jg.setColor("red");
		jg.setStroke(3);
		jg.drawPolygon(xArray,yArray);
		jg.paint();
	},


	/**
	Sets the clicked tab to 'selected', and 'unselects' the remaining tabs.
	@param {String}  tabsId       ID of the tab to select
	@param {Number}  selectedTab  Number of the tab currently selected (beginning with 0)
	*/
	selectTab: function(tabsSelector, selectedTab) {
		// Unselect all tabs
		$(tabsSelector+' li.tab').removeClass("selected");
		// Set the appropriate class to "selected"
		var counter=0;
		$(tabsSelector+' li.tab').each(function() {
			if (selectedTab == counter) {
				$(this).addClass("selected");
				return false; // Break the jQuery 'each' loop
			}
			counter++;
		});
	},

	/**
	Changes the region chooser map depending on the tab that's clicked.
	<br><br>
	The possible map types are:
	<ul>
		<li>climateRegions</li>
		<li>states</li>
		<li>climateDivisions</li>
	</ul>
	@param {String}  newRegionType  Region type selected
	*/
	changeMap: function(newRegionType) {
		// Get the region map image
		var image = document.getElementById("regionMapImage");
		var now   = new Date();
		// Set the new image properties
		if (newRegionType === "climateRegions") {
			image.src    = map_climateRegions.src;
			image.useMap = "#imageMap_climateRegions";
		} else if (newRegionType === "states") {
			image.src    = map_states.src;
			image.useMap = "#imageMap_states";
		} else if (newRegionType === "climateDivisions") {
			image.src    = map_climateDivisions.src;
			image.useMap = "#imageMap_climateDivisions";
		}
		// Set the new properties of the <img>
		$('#regionMapImage').attr("src",image.src);
		$('#regionMapImage').attr("useMap",image.useMap);
		// Set the correct background-image in the parent <div> (for the jQuery maphilight class)
		$('div#canvas > div').css('background-image',"url(" + image.src + ")");
		// Set up highlighting for the new region map
		$('.highlightedMap').maphilight({
			fill: true,
			fillColor: 'FF0000',
			fade: false,
		});
		// Set the regionType to the new region
		settings['regionType'] = newRegionType;
	},

	/**
	Disables clicks on all elements in a given group. The group is defined by a selector (CSS3).
	<br><br>

	Example:
	<blockquote>disableClick('#tabs_regionType a[data-regionType]')</blockquote>

	will disable clicking on any links that have a data-regionType attribute

	@param {String}  selector  CSS3 selector of the elements to disable clicking on
	*/
	disableClick: function(selector, alertMessage) {
		// Remove any existing click binds
		$(selector).unbind('click');
		// Set up a jQuery event listener for a mouse click
		$(selector).bind('click',function() {
			// If an alert message was provided, display it
			if (typeof alertMessage !== "undefined") {
				alert(alertMessage);
			}
			// Return false to halt any further events
			return false;
		});
	},

	/**
	Enables clicks on all elements in a given group. The group is defined by a selector (CSS3).
	<br><br>

	Example:
	<blockquote>enableClick('#tabs_regionType a[data-regionType]')</blockquote>

	will enable clicking on any links that have a data-regionType attribute

	@param {String}  selector  CSS3 selector of the elements to enable clicking on
	*/
	enableClick: function(selector) {
		// Set up a jQuery event listener for a mouse click
		$(selector).unbind('click');
	},

	/**
	Changes the type of time options available depending on the tab that's clicked.
	<br><br>
	The possible time options are:
	<ul>
		<li>dateRange</li>
		<li>selectMonths</li>
		<li>selectMonthsYears</li>
		<li>selectSeasonalSignal</li>
	</ul>
	@param {String}  newDatesValid  Type of time options selected
	*/
	changeDatesValidType: function(newDatesValidType) {
		// Unselect all months/seasons
		$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table td').removeClass('selected');
		// Hide all time options
		$('#datesValidPanel div[data-datesvalidtype]').hide();
		// Show the time options requested
		$('#datesValidPanel div[data-datesvalidtype=' + newDatesValidType + ']').show();
		// Set years back to "all"
		$('#datesValidPanel div[data-datesvalidtype=' + newDatesValidType + '] div[data-type=years] :input[name=datesValidType]').removeAttr('checked');
		$('#datesValidPanel div[data-datesvalidtype=' + newDatesValidType + '] div[data-type=years] :input[name=datesValidType][value=selectMonths]').attr('checked','checked');
		$('#datesValidPanel div[data-datesvalidtype=' + newDatesValidType + '] div[data-type=years] :input[name=datesValidType][value=selectMonths]').trigger('change');
		// Change the datesValidType variable
		settings['datesValidType'] = newDatesValidType;
	},

	/**
	Clears everything that was changed in the webpage by {@link mapper.js}
	*/
	clearMapper: function() {
		// Get the region map image
		regionMapImage = document.getElementById('regionMapImage');
		// Get the image dimensions
		var imageHeight = regionMapImage.naturalHeight;
		var imageWidth  = regionMapImage.naturalWidth;
		// Remove the preceding '#' from the useMap
		var temp = regionMapImage.useMap.replace("#","");

		// Clear any highlighted regions
		this.clearRegions();

		// Clear the div containing the region map <img>
//		var innerCanvas = document.getElementById("innerCanvas");
//		innerCanvas.setAttribute('style','position: relative; height: ' + imageHeight + 'px; width: ' + imageWidth + 'px; padding: 0px; -moz-user-select: none;');

		// Delete the divs created by the mapper
		//image_mapper_image  = document.getElementById("regionMapImage_image");
		//image_mapper_canvas = document.getElementById("regionMapImage_canvas");
		//image_mapper_blind  = document.getElementById(temp + '_blind');

		//if (image_mapper_image  != null) {image_mapper_image.parentNode.removeChild(image_mapper_image);}
		//if (image_mapper_canvas != null) {image_mapper_canvas.parentNode.removeChild(image_mapper_canvas);}
		//if (image_mapper_blind  != null) {image_mapper_blind.parentNode.removeChild(image_mapper_blind);}
	},

	/**
	Returns a comma-delimited string of all months selected by the user. The table that
	contains the months is found under the HTML div with an id of datesValid_selectMonths.

	@returns {String} A comma-delimited list of selected months
	*/
	getSelectedMonths: function() {
		// Get all selected datesValid_selectMonths table cells
		var months = '';
		$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table td.selected').each(function() {
			if (settings['fcstType'] === "seasonal") {
				months = months + Verification.formatMonthRange($(this).html()) + ',';
			} else {
				months = months + Verification.formatMonth($(this).html()) + ',';
			}
		});
		if (months === '') {
			return '';
		}
		// Trim last comma
		months = months.substring(0, months.length-1);
		return months;
	},

	/**
	Returns a comma-delimited string of all years selected by the user. The table that
	contains the years is found under the HTML div with an id of datesValid_selectMonths.

	@returns {String} A comma-delimited list of selected monthyears
	*/
	getSelectedYears: function() {
		// Get all selected datesValid_selectMonths table cells
		var years = '';
		$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select option:selected').each(function() {
			years += $(this).text() + ',';
		});
		if (years === '') {
			return '';
		}
		// Trim last comma
		years = years.substring(0, years.length-1);

		return years;
	},

	/**
	Converts a 3-month range to a single month (center month)

	@param {String} 3-month range

	@returns {String} single month
	*/
	formatMonthRange: function(month) {
		// Create a hash array containing the conversions
		var hash = new Array();
		hash["dec-feb"] = "01";
		hash["jan-mar"] = "02";
		hash["feb-apr"] = "03";
		hash["mar-may"] = "04";
		hash["apr-jun"] = "05";
		hash["may-jul"] = "06";
		hash["jun-aug"] = "07";
		hash["jul-sep"] = "08";
		hash["aug-oct"] = "09";
		hash["sep-nov"] = "10";
		hash["oct-dec"] = "11";
		hash["nov-jan"] = "12";
		return hash[month.toLowerCase()];
	},

	/**
	Converts a 3-character month to a 2-digit month

	@param {String} 3-character month

	@returns {String} 2-digit month
	*/
	formatMonth: function(month) {
		// Create a hash array containing the conversions
		var hash = new Array();
		hash["jan"] = "01";
		hash["feb"] = "02";
		hash["mar"] = "03";
		hash["apr"] = "04";
		hash["may"] = "05";
		hash["jun"] = "06";
		hash["jul"] = "07";
		hash["aug"] = "08";
		hash["sep"] = "09";
		hash["oct"] = "10";
		hash["nov"] = "11";
		hash["dec"] = "12";
		return hash[month.toLowerCase()];
	}
}

/**
Report verification failure

This function is called if the AJAX fails, or the response from the servlet indicates an error
occurred.
*/
function report_failure(error, error_type) {
    if (error_type === 'ajax') {
        title_error = 'There was a problem communicating with the server, please report this error';
    } else if (error_type === 'servlet') {
        title_error = 'There was a problem generating the score, see Warnings and Errors below';
    }
    Verification.updatePlotTitle(title_error);
    // Hide the resultsInteractionPanel
    $('#resultsInteractionPanel').hide();
    // Hide the "Processing, please wait... in the options box
    $('#settingsForm .runStatus').hide();
    // Display the error on the error panel
    $('#errorPanelText').append("<span class=\"error\">[ x ] " + error + "</span><br>");
}
