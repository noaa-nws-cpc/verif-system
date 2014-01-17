/**
@fileOverview A collection of functions related to spatial plotting using the Google Earth API
*/

// Standard variables
var centerLat   = 39;
var centerLon   = -98;
var centerPoint = new google.maps.LatLng(centerLat,centerLon);
var mapOptions= {
	zoom: 4,
	center: centerPoint,
	mapTypeId: google.maps.MapTypeId.ROADMAP,
	scrollwheel: false
};
var map;
var plotNulls = 0;

// Table element variable
var tableEle;

// Array to hold markers, which allows for their storage and deletion from the map.
var markersarray=[];

/**
@namespace A collection of functions related to spatial plotting using the Google Earth API
*/
GoogleEarth = {
	/**
	Updates the Google Earth map in the spatial VWT page.

	@param {String} xml  XML (not KML) to use to update the map
	*/
	updateGoogleEarth: function(xml) {
		// Convert xml into a document that Javascript can understand
		var xmlDoc = (new DOMParser()).parseFromString(xml, "text/xml");
		var points = xmlDoc.getElementsByTagName("Placemark");
		// Calls clearMap function, which clears the map.
		this.clearMap();
		// Loop over all points in the XML, and place markers
		for(var i=0;i<points.length;i++){
			var lat         = points[i].getElementsByTagName("Lat")[0].firstChild.data;
			var lon         = points[i].getElementsByTagName("Lon")[0].firstChild.data;
			var name        = points[i].getElementsByTagName("Name")[0].firstChild.data;
			var description = points[i].getElementsByTagName("Description")[0].firstChild.data;
			var image       = points[i].getElementsByTagName("StyleURL")[0].firstChild.data;
			var label       = 	"<table class=\"googleTable\">" +
								"	<tr><td><b>Name:</b> </td><td>" + name + "</td></tr>" +
								"	<tr><td><b>Value:</b> </td><td>" + description + "</td></tr>" +
								"	<tr><td><b>Lat:</b> </td><td>" + lat + "</td></tr>" +
								"	<tr><td><b>Lon:</b> </td><td>" + lon + "</td></tr>" +
								"</table>";
			var latlon      = new google.maps.LatLng(lat,lon);
			// If plotNulls is true, always plot the icon, otherwise plot
			// the icon if the description is NOT NaN
			if (plotNulls == 1 || (plotNulls == 0 && description != "NaN")) {
				var gmark = new google.maps.Marker({
					position: latlon,
					icon: image
				});
				this.describe(gmark,label);
				markersarray.push(gmark);
			}
		}
		this.addmarkers();
		this.updateMapTitle();
	},

	addmarkers: function() {
		for (i in markersarray){
			markersarray[i].setMap(map);
		}
	},

	/**
	Clears the map of all markers
	*/
	clearMap: function() {
		if (markersarray){
			for (i in markersarray){
				markersarray[i].setMap(null);
			}
		}
		markersarray.length=0;
	},

	/**
	Updates the map title with the appropriate settings. It should match
	the static plot titles. The settings are retrieved from the form.
	*/
	updateMapTitle: function() {
		var scoreType = document.forms[0].scoreType.value;
		var categoryType = document.forms[0].categoryType.value;
		var variable = document.forms[0].variable.value;
		var fcstType = document.forms[0].fcstType.value;
		firstLetter = scoreType.substr(0,1);
		remainder = scoreType.substr(1);
		var varString;
		var catString;
		var fcstTypeString;
		var leadTime = settings['leadTime'];
		var fcstSource = settings['fcstSources'];
		var datesValidType = settings['datesValidType'];
		var datesValid = settings['datesValid'];
		var dateString;
		if (scoreType === "rpss") {
			scoreString = "Ranked Probability";
		}
		else {
			firstLetter = scoreType.substr(0,1);
			remainder = scoreType.substr(1);
			scoreString = firstLetter.toUpperCase() + remainder;
		}
		if (variable === "temp") {
			varString = "Temperature ";
		}
		else if (variable === "precip") {
			varString = "Precipitation ";
		}
		if (categoryType === "total") {
			catString = "";
		}
		else {
			catString = " (category " + categoryType + ") ";
		}
        if (fcstType === "6-10day") {
			fcstTypeString = "6-10 Day ";
	    }
	    else if (fcstType === "8-14day") {
	    	fcstTypeString = "8-14 Day ";
        }	
		else if (fcstType ==="monthly") {
			if (leadTime === "0pt5m") {
				fcstTypeString = "Revised Monthly (Lead 0) ";
			}
			else if (leadTime === "01m") {
				fcstTypeString = "Monthly (Lead 0.5) ";
			}
		}
		else if (fcstType ==="seasonal") {
			if (leadTime === "02m") {
				fcstTypeString = "Seasonal (Lead 0.5) ";
			}
			else if (leadTime === "03m") {
				fcstTypeString = "Seasonal (Lead 1.5) ";
			}
			else if (leadTime === "04m") {
				fcstTypeString = "Seasonal (Lead 2.5) ";
			}
        	else if (leadTime === "05m") {
        		fcstTypeString = "Seasonal (Lead 3.5) ";
			}
			else if (leadTime === "06m") {
				fcstTypeString = "Seasonal (Lead 4.5) ";
			}
			else if (leadTime === "07m") {
				fcstTypeString = "Seasonal (Lead 5.5) ";
			}
			else if (leadTime === "08m") {
				fcstTypeString = "Seasonal (Lead 6.5) ";
			}
			else if (leadTime === "09m") {
				fcstTypeString = "Seasonal (Lead 7.5) ";
			}
			else if (leadTime === "10m") {
				fcstTypeString = "Seasonal (Lead 8.5) ";
			}
			else if (leadTime === "11m") {
				fcstTypeString = "Seasonal (Lead 9.5) ";
			}
			else if (leadTime === "12m") {
				fcstTypeString = "Seasonal (Lead 10.5) ";
			}
			else if (leadTime === "13m") {
				fcstTypeString = "Seasonal (Lead 11.5) ";
			}
			else if (leadTime === "14m") {
				fcstTypeString = "Seasonal (Lead 12.5) ";
			}
		}
		if (fcstSource === "smlr") {
			fcstSource = "SMLR";
		}
		else if (fcstSource === "cca") {
			fcstSource = "CCA";
		}
		else if (fcstSource === "ocn") {
			fcstSource = "OCN";
		}
		else if (fcstSource === "cfs") {
			fcstSource = "CFS";
		}
		else if (fcstSource === "con") {
			fcstSource = "CON";
		}
		if (datesValidType === "dateRange") {
			if (fcstType === "6-10day" || fcstType === "8-14day") {
				dateString = " from " + datesValid.substr(0,8) + "-" + datesValid.substr(9,8);
			}
			else {
				dateString = " from " + datesValid.substr(0,6) + "-" + datesValid.substr(7,6);
			}
		}
		else if (datesValidType === "selectMonths") {
			if (fcstType === "6-10day" || fcstType === "8-14day" || fcstType === "monthly") {
				dateString = " for months " + datesValid + " all years";
			}
			else if (fcstType ==="seasonal") {
				dateString = " for seasons " + datesValid + " all years";
			}
		}
		else if (datesValidType === "selectMonthsYears") {
			if (fcstType === "6-10day" || fcstType === "8-14day" || fcstType === "monthly") {
				dateString = " for months and years " + datesValid;
			}
			else if (fcstType ==="seasonal") {
				dateString = " for seasons and years " + datesValid;
			}
		}
		else if (datesValidType === "selectSeasonalSignal") {
			dateString = " for ENSO " + datesValid.substr(5);
		}
		// Create title string (should match static plot titles)
		$("#resultsPanel > h2").html(fcstTypeString + varString + scoreString + " Skill Scores for " + fcstSource + catString + dateString);
	},

	/**
	Initializes an empty Google Map.
	*/
	initializeGoogleEarth: function(outputType) {
		// Only initialize a map for the spaital page
		if (outputType === "map") {
			map=new google.maps.Map(document.getElementById("GoogleEarthMap"),mapOptions);
		}
	},

	/**
	Pop-up a description bubble on the Google Map.

	@param {google.maps.Marker} gmark  Google Marker that the pop-up will apply to
	@param {String}             label  Content to display in the pop-up
	*/
	describe: function(gmark,label){
		var info=new google.maps.InfoWindow({content:label});
		google.maps.event.addListener(gmark,'click',function(){info.open(map,gmark)});
	},

	/**
	Creates a legend where the element (Div ID) is "GoogleEarthLegend" in the HTML page.

	@param {String} legendInfo  String containing icon information (ie. .pngs used to display
	values on the Google Map, and associated threshold/range information. The icon and threshold
	info is separatated by a semi-colon, the individual elements comma delimited. It must be
	formatted this way because of the way that the information is parsed in here.
	*/
	createGoogleEarthLegend: function(legendInfo) {
		document.getElementById("GoogleEarthLegend").innerHTML = '<br><b>Legend</b><br><br>';
		var rows=legendInfo.split(";");
		var final = new Array(2);
		var stringToSplit;
		for(i=0; i<2; i++) {
			stringToSplit = rows[i];
			splitValue = stringToSplit.split(",");
			final[i] = splitValue;
		}
 		// Create and populate arrays with the icons and thresholds
		var iconArray = final[0];
		var thresholdArray = final[1];
		// Create the table DOM element
		this.createTable(iconArray,thresholdArray);
		// Replace the contents of the Google Earth legend <div> with the new table (uses jQuery)
		$('#GoogleEarthLegend').empty().append(tableEle);
	},
	
	/**
	Removes the existing Google Earth legend.
	*/
	removeGoogleEarthLegend: function() {
		// Use jQuery to remove the legend by emptying the DIV of all HTML
		$('#GoogleEarthLegend').empty();
	},

	/**
	Creates the table element for the legend and formats the legend information.

	@param {String[]} iconArray       PNG icons used to plot (eg. ['./images/dot01.png', './images/dot02.png'])
	@param {String[]} thresholdArray  Threshold ranges to display (eg. ['10 to \n15', '16 to \n20'])
	*/
	createTable: function(iconArray,thresholdArray) {
		// Location of images are relative to the location of the PHP/HTML
		// page that is displayed
		//numIcons = 2;
		var currentCell;
		var currentText;
		tableEle=document.createElement("table");
		tableEle.setAttribute('id','legend');
		var tableBody = document.createElement("tbody");
		var row1 = document.createElement("tr");
		// Put an icon in each cell for top row
		for (i=0;i<iconArray.length;i++) {
			currentCell = document.createElement("td");
			imgSrc = document.createElement("IMG");
			imgSrc.setAttribute('SRC',iconArray[i]);
			imgSrc.setAttribute('ALT',thresholdArray[i]);
			currentCell.appendChild(imgSrc);
			row1.appendChild(currentCell);
		}
		tableBody.appendChild(row1);
		// Put a range of values in each cell for top row
		var row2 = document.createElement("tr");
		for (i=0;i<thresholdArray.length;i++) {
			currentCell = document.createElement("td");
			currentText = document.createTextNode(thresholdArray[i]);
			currentCell.appendChild(currentText);
			row2.appendChild(currentCell);
		}
		tableBody.appendChild(row2);
		tableEle.appendChild(tableBody);
	},
}
