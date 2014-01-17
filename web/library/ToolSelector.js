/**
@fileOverview A collection of functions related to the VWT Tool Selector
*/

// Set maxFcstSources based on outputType
if (settings['page'] === 'chart') {
	var maxFcstSources = 4;
} else if (settings['page'] === 'map') {
	var maxFcstSources = 1;
}
var settingChanged = 0;

/**
@namespace A collection of functions related to the VWT Tool Selector
*/
ToolSelector = {

	/**
	Disables all unselected checkboxes if the number of checked
	checkboxes equals or exceeds the maximum allowed checked
	checkboxes.

	Makes a call to {@link ToolSelector.disableCheckboxes}
	*/
	initialCheckboxDisable: function() {
		if (this.countChecked() >= maxFcstSources) {
			// Disable all remaining checkboxes
			this.disableCheckboxes();
		}
	},

	/**
	Function to search for a string element inside of an array.

	@param {string}   needle     String to search for
	@param {string[]} haystack   String array to search within
	@param {boolean}  argStrict  Whether to use strict string matching
	*/
	inArray: function(needle, haystack, argStrict) {
		// +   original by: Kevin van Zonneveld
		// +   improved by: vlado houba
		// +   input by: Billy
		// +   bugfixed by: Brett Zamir
		var key = '', strict = !!argStrict;
		if (strict) {
			for (key in haystack) {
				if (haystack[key] === needle) {
					return true;
				}
			}
		} else {
			for (key in haystack) {
				if (haystack[key] == needle) {
					return true;
				}
			}
		}
		return false;
	},

	countChecked: function() {
		// Only count boxes that apply to the currently selected fcstType (extendedRange, monthly, or seasonal)
		return $('#toolSelector td input[name=fcstSource]:checked').length + $('div:regex(data-fcsttype,\\b'+$('select[name=fcstType]').val()+'\\b) input[name=fcstSource]:checked').length;
	},

	printNumChecked: function() {
		var numFcstSources = this.countChecked();
		$("#numChecked").text(numFcstSources + " out of " + maxFcstSources + " forecast sources are checked");
	},

	unselectAllTools: function() {
		$("#toolSelector input:checked").removeAttr('checked');
		if (this.countChecked() < maxFcstSources) {
			this.enableCheckboxes();
		}
		this.printNumChecked();
	},

	hideTools: function() {
		// Get the variable
		var variable = $('select[name=variable]').val();
		// Get the forecast type
		var fcstType = $('select[name=fcstType]').val();
		// Get the lead time/averaging window
		if (fcstType === "6-10day") {
			leadTime = $("#settingsForm input[name='leadTime_6-10day']:checked").val();
			aveWindow = "05d";
		} else if (fcstType === "8-14day") {
			leadTime = $("#settingsForm input[name='leadTime_8-14day']:checked").val();
			aveWindow = "07d";
		} else if (fcstType === "monthly") {
			leadTime  = $("#settingsForm input[name='leadTime_monthly']:checked").val();
			aveWindow = "01m";
		} else if (fcstType === "seasonal") {
			leadTime  = leadTime = $("#settingsForm select[name='leadTime_seasonal']:checked").val();
			aveWindow = "03m";
		}
		// Loop over each checkbox for the appropriate fcstType, and determine if it should be hidden
		$('#toolSelector td input[name=fcstSource]').each(
			function (){
				var fcstSource = variable + "_" + $(this).val() + "_" + leadTime + "_" + aveWindow + "_stn";
				if (! ToolSelector.inArray(fcstSource,existingFcstSources)) {
					$(this).removeAttr('checked');
					$(this).hide();
				} else {
					$(this).show();
				}
			}
		);
		settingChanged = 0;
	},

	disableCheckboxes: function() {
		// jQuery: add the "disabled" class to all <input> tags that have a name of fcstSource and are not checked
		$('input[name=fcstSource]:not(:checked)').attr('disabled','disabled').addClass('disabled');
	},

	enableCheckboxes: function() {
		$('input[name=fcstSource]:checkbox').removeAttr('disabled').removeClass('disabled');
	}
}

$(function() {
	// If needed, disable all unchecked checkboxes (happens when maxFcstSources = 1, since
	// on page load, manual is always checked). Do this only on the Chart page
	if (settings['page'] == "chart") {
		ToolSelector.initialCheckboxDisable();
	}
	// Tool selector
	$('#toolSelector').dialog({
		autoOpen: false,
		width: 'auto',
		position: 'top',
		modal: true,
		buttons: {
			"Ok": function() {
				$(this).dialog("close");
			}
		}
	});
	// Link to open the Tool Selector
	$('a[name=toolSelectorLink]').click(function(){
		if ($(this).data('enabled')) {
			$('#toolSelector').dialog('open');
			// Hide unnecessary tools
			ToolSelector.hideTools();
			ToolSelector.printNumChecked();
			return false;
		} else {
			alert('There are currently no tools available in gridded format');
		}
	});
	// When a fcstSource checkbox is checked... (do this only on the Chart Page)
	$("input[name=fcstSource]").click(function(){
		if (settings['page'] == "chart") {
			// Count the number of checked checkboxes
			var numFcstSources = ToolSelector.countChecked();
			// Dont allow more than $maxFcstSources checkboxes to be checked at one time
			// This should only be done when maxFcstSources > 1, otherwise they're radio
			// buttons and they should always be able to select other ones
			if (maxFcstSources > 1 && numFcstSources >= maxFcstSources) {
				// Disable all remaining checkboxes
				ToolSelector.disableCheckboxes();
			} else {
				ToolSelector.enableCheckboxes();
			}
			// Print the number of checked checkboxes
			ToolSelector.printNumChecked();
		} else {
			// Clear all other buttons besides the one you clicked
			$('input[name=fcstSource][value!='+$(this).val()+']').removeAttr('checked');
		}
	});
	// When someone changes the variable, leadTime, or fcstType unselect all the tools (or just set "manual"
	// as selected if we're on the Map Page).
	$('select[name=variable], (input, select)[name ^= leadTime], select[name=fcstType]').change(function() {
		settingChanged = 1;
		if (settings['page'] == "chart") {
			ToolSelector.unselectAllTools();
		} else {
			$("input[name=fcstSource][value=manual]").attr('selected','selected');
		}
	});
});
