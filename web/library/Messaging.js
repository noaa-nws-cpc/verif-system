/**
@fileOverview A collection of functions associated with sending a message to the user.
*/

/**
@namespace A collection of functions associated with sending a message to the user.
*/
Messaging = {
	/**
	Appends an html formatted error to a given panel (div) which is obtained by a formatted passed argument object appendInfo. appendInfo should be a semi-colon 
	delimited String where the first part of the string (before the semi-colon) contains
	the HTML formatted String to display on the panel, and the second part of the string 
	(after the semi-colon) contains the name of the div tag to append/display to.
	@param {String} appendInfo  Formatted as "$error ; $divName" where $error is the HTML formatted string to append and $divName is the DIV id to which the HTML should be appended.
	*/
	appendToPageElement: function(appendInfo) {
		var infoArray = appendInfo.split(";");
		html = infoArray[0];
		cssSelector = infoArray[1];
		// Convert from HTML object to string
		html = '' + html;
		$(cssSelector).append(html);
	},

	/**
	Displays an HTML message in a popup window. The popup is done with jQuery UI.
	@param {String} html  HTML string to display
	*/
	popup: function(html) {
		// Create a temporary div to store the popup's HTML
		$('body').append("<div id='popup'></div>");
		// Convert from HTML object to string
		html = '' + html;
		// Append the given HTML to the temporary div
		$('#popup').html(html);
		// Set up jQuery dialog box
		$('#popup').dialog({
			autoOpen: false,
			width: 'auto',
			position: 'top',
			modal: true,
			title: "Error",
			buttons: {
				"Ok": function() {
					$(this).dialog("close");
				}
			}
		});
		$('#popup').dialog('open');
	},

	/**
	Clears a page element of text. This is done/called by the Java Log.java so that errors are
	cleaned for each run of the applet. The applet needs to call the Log.java empty(String cssSelector)
	method in the init() and update() methods to call this method.
	@param {String} cssSelector tag to empty.
	*/
	clearPageElement: function(cssSelector) {
		$(cssSelector).empty();
	}
}

