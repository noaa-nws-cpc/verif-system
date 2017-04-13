<?php
	// Turn on error reporting
// 	error_reporting(E_ALL);
// 	ini_set("display_errors", 1);
 	// Start the session if it's not already started
// 	if (! isset($_SESSION)) {
// 	 	session_start();
// 	}
	// Get the page
	if (! empty($_GET['page'])) {
		$page = filter_var($_GET['page'], FILTER_SANITIZE_STRING);
	} else {
		// Default to chart
		$page = "chart";
	}
	// Get the output type (set it to page, unless page is "help"
	if ($page === "help") {
		$outputType = "none";
	} else {
		$outputType = $page;
	}
	// Set the session outputType variable
	$_SESSION['page'] = $page;
	// Construct URL
	$thisPage = $_SERVER['PHP_SELF'];

	//-------------------------------------------------------------------------
	// Get any messages for the user
	//
	// Parse the Verification System config file and get the MySQL settings
//	$settings = parse_ini_file("../input/verif_server.conf",true);
//	$mysqlSettings = $settings['mysql'];

//	// Connect to MySQL
//	mysql_connect($mysqlSettings['host'], $mysqlSettings['admin_user'], $mysqlSettings['admin_password']) or die("Couldn't connect to the MySQL database: " . mysql_error());
//	mysql_select_db($mysqlSettings['db_vwt']) or die("Couldn't select the database: " . mysql_error());
//
//	// Generate MySQL query for note
//	$sqlQuery = "SELECT * FROM news WHERE type='note' ORDER BY id DESC LIMIT 1";
//	$results = mysql_query($sqlQuery) or die(mysql_error());
//	while ($row = mysql_fetch_assoc($results)) {
//		$message_note = mysql_real_escape_string($row['message']);
//		break;
//	}
//
//	// Generate MySQL query for warning
//	$sqlQuery = "SELECT * FROM news WHERE type='warning' ORDER BY id DESC LIMIT 1";
//	$results = mysql_query($sqlQuery) or die(mysql_error());
//	while ($row = mysql_fetch_assoc($results)) {
//		$message_warning = mysql_real_escape_string($row['message']);
//		break;
//	}
//	// Close the MySQL connection
//	mysql_close();

    // Read settings from a config file
    require('library/web_settings.php');
?>
<!DOCTYPE HTML>
<html>
<!-- HTML Header -->
<head>
    <script type='text/javascript'>
        /**
        Format function similar to Python's

        Example: 'My name is {}'.format('Mike')
        */
        String.prototype.format = function () {
          var i = 0, args = arguments;
          return this.replace(/{}/g, function () {
            return typeof args[i] != 'undefined' ? args[i++] : '';
          });
        };
    </script>
    <!-- Pass some variables from PHP to Javascript -->
	<script type="text/javascript">
		var settings = [];
		settings['outputType'] = "<?php echo $outputType?>";
		settings['page'] = "<?php echo $page?>";
        settings['servlet_url'] = "<?php echo $settings['servlet_url']?>";
        settings['servlet_function'] = "<?php echo $settings['servlet_function']?>";
	</script>

    <!-- Import CSS style sheets -->
    <link rel=StyleSheet href="styles/index.css" type="text/css" />
    <link type="text/css" href="library/jquery-ui/css/custom/jquery-ui-1.8.15.custom.css" rel="Stylesheet" />
    <link type="text/css" href="styles/jquery.qtip.css" rel="Stylesheet" />
    <link type="text/css" href="styles/jquery.feedback_me.css" rel="Stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>

	<!-- ======================================================== -->
	<!--           Import JQuery and related libraries            -->
	<!-- ======================================================== -->
	<!-- jQuery itself -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"> </script>
	<!-- jQuery regex selector -->
	<script type="text/javascript" src="library/jquery.regex.js"> </script>
	<!-- jQuery tooltips -->
	<script type="text/javascript" src="library/jquery.qtip.min.js"> </script>
	<!-- jQuery-based HTML5-like input placeholders -->
	<script type="text/javascript" src="library/jquery.placeholder.js"> </script>
	<!-- jQuery UI (used by popup calendars, dialogs, etc.) -->
	<script type="text/javascript" src="library/jquery-ui/js/jquery-ui-1.8.15.custom.min.js"></script>
	<!-- Custom messaging (using jQuery) -->
	<script type="text/javascript" src="library/jquery.message.js"></script>
	<!-- jQuery plugin to display a feedback form -->
	<script type="text/javascript" src="library/jquery.feedback_me.js"></script>
	<script type="text/javascript" src="library/jquery.blockUI.js"></script>
    <!-- Ploting -->
    <script src="library/plotly-latest.min.js"></script>
    <script src="library/plotting.js"></script>
    <!-- XML to JSON converter -->
    <script type="text/javascript" src="library/xml-to-json.js"></script>

	<!-- ======================================================== -->
	<!--                  Import custom libraries                 -->
	<!-- ======================================================== -->
    <!-- Functions related to the servlet -->
    <script type="text/javascript" src="library/servlet.js"></script>
    <script type="text/javascript" src="library/soap.js"></script>
	<!-- Main VWT library (form validation, applet-calling, etc.) -->
	<script type="text/javascript" src="library/Verification.js"> </script>
	<script type="text/javascript" src="library/Messaging.js"> </script>
	<!-- Tool Selector library -->
	<script type="text/javascript" src="library/ToolSelector.js"></script>
	<!-- List of existing forecast sources (used to generate the tool selector) -->
	<script type="text/javascript" src="library/existingFcstSources.js"> </script>
	<!-- Date-related functions -->
	<script type="text/javascript" src="library/Dates.js"> </script>
	<!-- ======================================================== -->
	<!--             Import mapping-related libraries             -->
	<!-- ======================================================== -->
    <!-- GeoJSON2SVG -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/geojson2svg/1.0.2/geojson2svg.min.js"></script>
    <!-- amCharts includes -->
    <script src="//www.amcharts.com/lib/3/ammap.js"></script>
    <script src="//www.amcharts.com/lib/3/maps/js/worldLow.js"></script>
    <script src="//www.amcharts.com/lib/3/themes/light.js"></script>
    <!-- Region selector -->
    <script src="library/regionSelector.js"></script>
	<!-- ======================================================== -->
	<!--    Import libraries that set up certain page elements    -->
	<!-- ======================================================== -->
	<!-- Set up the jQuery tooltips -->
	<script type="text/javascript" src="library/setup_tooltips.js"> </script>


	<!-- Set the title -->
	<title>CPC Verification Web Tool (VWT)</title>

	<!-- jQuery -->
	<script>
        function updateForm(e) {
            //-------------------------------------------------------------------------------
            // Figure out what was changed
            //
            // Get the name of the setting that was changed
            var setting = e.closest('li').attr('data-setting');
            // Get the new value of the setting
            var value   = e.val();

            //-------------------------------------------------------------------------------
            // Adjust each form setting accordingly, one at a time
            //
            // Get all <li> blocks (one per setting), ignoring the <li> block for the
            // setting that was actually changed (!=), and loop over them (.each())
            $('#settingsForm li[data-setting][data-setting!='+setting+']').each(function(index_settingBlock, settingBlock) {
                // Get the name of the current setting in the loop
                var settingInLoop = $(settingBlock).attr('data-setting');
                // Get all <div> tags, children of the settingBlock, that are affected by the changed setting
                var settingDivArray = $(settingBlock).children('div:regex(data-'+setting+',\\b'+value+'\\b)');
                // Get the number of children <div>s
                var settingDivArraySize = settingDivArray.size();
                // If there are no <div> tags under the settingBlock, it doesn't change, so go to the next one
                if (settingDivArraySize < 1) {
                    return 1; // jQuery equivalent of "continue" statement
                }
                // Get a list of all "data-" attributes (just get it from the first div,
                // assuming all the divs have the same amount of conditional settings)
                var attributeArray = $(settingDivArray[0]).data();

                //-------------------------------------------------------------------------------
                // Create a string that can be used by jQuery to select the correct setting <div>
                //
                // Initialize empty string
                var selector = '';
                // Loop over all the data- attributes
                $.each(attributeArray, function(key) {
                    // Get the value of this setting from the form
                    var value = $('#settingsForm li[data-setting='+key+'] > div:visible :input').val();
                    // Only append this attribute if it's not a builtin jQuery attribute (apparently
                    // when you call .hide() on an element, it gains a data attribute that begins
                    // with "jQuery")
                    if (! key.match(/^jQuery/)) {
                        // Use the jQuery regex selector (jquery.regex.js)
                        selector += ':regex(data-'+key+',\\b'+value+'\\b)';
                    }
                });
                // Hide all <div>s for this setting
                $('#settingsForm li[data-setting='+settingInLoop+'] > div').hide();

                // See if the winning <div> is empty
                if (! $.trim($('#settingsForm li[data-setting='+settingInLoop+'] > div'+selector).html()) ) {
                    // Hide the entire row
                    $('#settingsForm li[data-setting='+settingInLoop+'] > div'+selector).parent().hide();
                } else {
                    // Show the entire row
                    $('#settingsForm li[data-setting='+settingInLoop+'] > div'+selector).parent().show();
                    // show the appropriate <div>
                    $('#settingsForm li[data-setting='+settingInLoop+'] > div'+selector).show();
                }
            });
        };
        function changeRegionTypeTabs(e) {
            // If climate divisions are selected, change to climate divisions regionType tab,
            // and disable all other regionType tabs
            if (e === "climateDivision") {
                // Select the climate division tab
                RegionSelector.resetSelectedRegions();
                Verification.selectTab('#tabs_regionType',2);
                RegionSelector.makeRegionSelector('climateDivisions');
                // Disable clicks on the other regionType tabs
                Verification.disableClick('#tabs_regionType li:not(.selected)','Only climate divisions can be selected when the data format is set to "climate division"');
            // Else enable clicks
            } else {
                Verification.enableClick('#tabs_regionType li:not(.selected)');
            }
        };
		$(document).ready(function() {

			//-------------------------------------------------------------------------------
			// Display the feedback form
			//
			fm_options = {
				position                   : "right-bottom",
				trigger_label              : "Feedback",
				title_label                : "Questions, comments, or issues?",
				show_email                 : true,
				show_message               : true,
				message_required           : true,
				show_asterisk_for_required : true,
				close_on_click_outisde     : false,
				message_placeholder        : "If you are having an issue, please copy and paste the contents of the 'Settings Used' panel (at the bottom of the page) into this box, along with a description of your issue",
				feedback_url               : "include/send_feedback.php"
			};

			fm.init(fm_options);

			//-------------------------------------------------------------------------------
			// Always check manual when the page loads
			//
			$('input[name=fcstSource]:visible[value=manual]').attr('checked','checked');

			//-------------------------------------------------------------------------------
			// Variables and constants
			//
			var MIN_DATE = [];
			MIN_DATE['6-10day']  = '20080101';
			MIN_DATE['8-14day']  = '20080101';
			MIN_DATE['monthly']  = '199501';
			MIN_DATE['seasonal'] = '199501';
			MIN_DATE['default']  = MIN_DATE['6-10day'];

			//-------------------------------------------------------------------------------
			// Code to collapse/uncollapse sections
			//
			// Hide collapsible content by default
			$('div.collapsible-content').hide();
			// Collapse or uncollapse section
			$('p.collapsible-heading').click(function() {
				$(this).next('div.collapsible-content').slideToggle(500);
				$(this).toggleClass('expanded');
			});

			//-------------------------------------------------------------------------------
			// Set up clickable months table
			//
			$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table td').click(function(event) {
				// Change class to 'selected'
				if ($(this).hasClass('selected')) {
					$(this).removeClass('selected');
				} else {
					$(this).addClass('selected');
				}
			});

			//-------------------------------------------------------------------------------
			// Make the tooltip popup on the right side
			//
			$('#overviewPanel span[data-tooltip]').qtip('option', { 'position.my': 'left center', 'position.at': 'right center', 'target': $(this) });

			//-------------------------------------------------------------------------------
			// Set up listeners on the years radio buttons on the datesValid panel
			//
			$('input[name="datesValidType"]').change(function(){
				var datesValidType = $(this).val();
				// If they chose all years (which means datesValidType is 'selectMonths')
				if (datesValidType === "selectMonths") {
					// Disable the years dropdown
					$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select').attr('disabled','disabled');
					// Clear all previously selected years
					$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select option').removeAttr('selected');
					// Set the size back to 2
					$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select').attr('size',2);
					// Set settings['datesValidType']
					settings['datesValidType'] = "selectMonths";
				// If they chose select years (which means datesValidType is 'selectMonthsYears')
				} else if (datesValidType === "selectMonthsYears") {
					// Enable the years dropdown
					$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select').removeAttr('disabled');
					// Set the size to 10
					$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select').attr('size',8);
					// Set settings['datesValidType']
					settings['datesValidType'] = "selectMonthsYears";
				}
			});

			//-------------------------------------------------------------------------------
			// Create popup calendars
			//
			// 6-10day, 8-14day
			$('div[data-fcsttype="6-10day, 8-14day"] input[name=startDate], div[data-fcsttype="6-10day, 8-14day"] input[name=endDate]').datepicker({
				dateFormat: 'yymmdd',
				minDate: MIN_DATE['default'],
				maxDate: 'today',
				changeMonth: true,
				changeYear: true,
				monthNamesShort: ['01 - Jan','02 - Feb','03 - Mar','04 - Apr',
								  '05 - May','06 - Jun','07 - Jul','08 - Aug',
								  '09 - Sep','10 - Oct','11 - Nov','12 - Dec'],
				buttonText: "Choose the date using a popup calendar",
				showOn: "button",
				buttonImage: "images/scw.gif",
				buttonImageOnly: true,
                onSelect: function() { $(this).removeClass('placeholder') }
			});
			// monthly, seasonal
			$('div[data-fcsttype="monthly, seasonal"] input[name=startDate], div[data-fcsttype="monthly, seasonal"] input[name=endDate]').datepicker({
				dateFormat: 'yymm',
				minDate: new Date(MIN_DATE['seasonal'].substring(0,4), MIN_DATE['seasonal'].substring(4,6)-1, 01),
				maxDate: 'today',
				changeMonth: true,
				changeYear: true,
				showMonthAfterYear: true,
				monthNamesShort: ['01 - Jan','02 - Feb','03 - Mar','04 - Apr',
								  '05 - May','06 - Jun','07 - Jul','08 - Aug',
								  '09 - Sep','10 - Oct','11 - Nov','12 - Dec'],
				buttonText: "Choose the date using a popup calendar",
				showOn: "button",
				buttonImage: "images/scw.gif",
				buttonImageOnly: true,
				showButtonPanel: true,
				// Set the date in the textbox when the user changes the month or year
				onChangeMonthYear: function() {
					// Get month and year
					var month = $('#ui-datepicker-div .ui-datepicker-month :selected').val();
					var year = $('#ui-datepicker-div .ui-datepicker-year :selected').val();
					// Set the date in the text box
					$(this).val($.datepicker.formatDate('yymm', new Date(year, month, 1)));
					// Remove the 'placeholder' class from the textbox text
					$(this).removeClass('placeholder');
				},
				// Set the date in the textbox when the user exits the calendar
				onClose: function() {
					// Get month and year
					var month = $('#ui-datepicker-div .ui-datepicker-month :selected').val();
					var year = $('#ui-datepicker-div .ui-datepicker-year :selected').val();
					// Set the date in the text box
					$(this).val($.datepicker.formatDate('yymm', new Date(year, month, 1)));
					// Remove the 'placeholder' class from the textbox text
					$(this).removeClass('placeholder');
				},
				// Make sure when the calendar is opened, the date is set to what is in the textbox
				beforeShow: function(input, inst) {
					datestr = $(this).val();
					if (datestr === $(this).attr('placeholder')) {
						// Do nothing
					} else if (datestr.length > 0) {
						year  = datestr.substring(0,4);
						month = datestr.substring(4,6)-1;
						$(this).datepicker('option', 'defaultDate', new Date(year, month, 1));
						$(this).datepicker('setDate', new Date(year, month, 1));
					}
				}
            });
			// Hide the days portion of the date picker
			$('div[data-fcsttype="monthly, seasonal"] input[name=startDate], div[data-fcsttype="monthly, seasonal"] input[name=endDate]').focus(function () {
				$(".ui-datepicker-calendar").hide();
				$("#ui-datepicker-div").position({
					my: "center top",
					at: "center bottom",
					of: $(this)
				});
			});

			//-------------------------------------------------------------------------------
			// Setup input placeholder text on all <inputs>/<textarea>s
			// (using HTML5-style "placeholder" attribute)
			//
            $('input[placeholder], textarea[placeholder]').placeholder();

			//-------------------------------------------------------------------------------
			// Tool Selector clear button
			//
			// Hover style
			$('#toolSelector button.clearButton').hover(function() {
				$(this).children(":first").toggleClass("clearButtonHover");
			});
			// Unselect all tools
			$('#toolSelector button.clearButton').click(function() {
				ToolSelector.unselectAllTools();
			});

			//---------------------------------------------------------------------------
			// Disable clicking the climate phenomena tab (since it's not allowed for ERF
			// and the page starts with ERF selected)
			//
			Verification.disableClick('#tabs_datesValidType_climatePhenomena','Selecting dates by climate phenomena is only available for monthly and seasonal forecasts');

			//-------------------------------------------------------------------------------
			// Listen for a change to any form element
			//
			$('#settingsForm :input').change(function(){
                updateForm($(this));
            });

			//-------------------------------------------------------------------------------
			// Listen for changes to other page elements
			//
			// When fcstType is changed to monthly or seasonal, change the spatial type and region
			// type tabs
            $('#settingsForm select[name=fcstType]').change(function() {
                // For maps, just update the form
                if (settings['outputType'] == "chart") {
                    // fcstType set to monthly or seasonal
                    if ($(this).val() === "monthly" || $(this).val() === "seasonal") {
                    $('#settingsForm select[name=spatialType]').val('climateDivision');
                    changeRegionTypeTabs('climateDivision');
                    }
                    // fcstType set to anything else (ERF)
                    else {
                        $('#settingsForm select[name=spatialType]').val('station');
                        changeRegionTypeTabs('station');
                    }
                }
                updateForm($(this));
            });
			// When fcstType is changed to monthly or seasonal, enable clicking the climate
			// phenomena datesValidType tab, if it's set to ERF, disable clicks
			$('#settingsForm select[name=fcstType]').change(function() {
				// fcstType set to monthly or seasonal
				if ($(this).val() === "monthly" || $(this).val() === "seasonal") {
					Verification.enableClick('#tabs_datesValidType_climatePhenomena');
				}
				// fcstType set to anything else (ERF)
				else {
					// Switch to the dateRange datesValidType tab
					Verification.selectTab('#tabs_datesValidType',0);
					// Disable clicking on the climatePhenomena tab
					Verification.disableClick('#tabs_datesValidType_climatePhenomena','Selecting dates by climate phenomena is only available for monthly and seasonal forecasts');
				}
			});
			// Changing fcstType to months/years changes the "months" table in the datesValid panel
			$('#settingsForm select[name=fcstType]').change(function() {
				// This should only be done on the Map page
				if (settings['outputType'] != "map") {
					return;
				}
				// Clear all selected months/seasons
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype] td.selected').removeClass();
				// Hide all months tables
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype]').hide();
				// Show the correct months table
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype='+$(this).val()+']').show();
				// Hide all years <select> tags
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] table select').hide();
				// Select the appropriate list of years in the selectMonthsYears datesValid tab
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] table select[data-fcsttype='+$(this).val()+']').show();
			});
			// When fcstType is changed, update the monthNames in the popup calendar
			$('#settingsForm select[name=fcstType]').change(function() {
				if ($(this).val() === "seasonal") {
					$('div[data-fcsttype="monthly, seasonal"] input[name=startDate], div[data-fcsttype="monthly, seasonal"] input[name=endDate]').datepicker('option','monthNamesShort', ['01 - DJF','02 - JFM','03 - FMA','04 - MAM','05 - AMJ','06 - MJJ','07 - JJA','08 - JAS','09 - ASO','10 - SON','11 - OND','12 - NDJ']);
				} else if ($(this).val() === "monthly") {
					$('div[data-fcsttype="monthly, seasonal"] input[name=startDate], div[data-fcsttype="monthly, seasonal"] input[name=endDate]').datepicker('option','monthNamesShort', ['01 - Jan','02 - Feb','03 - Mar','04 - Apr','05 - May','06 - Jun','07 - Jul','08 - Aug','09 - Sep','10 - Oct','11 - Nov','12 - Dec']);
				} else {
					$('div[data-fcsttype="monthly, seasonal"] input[name=startDate], div[data-fcsttype="monthly, seasonal"] input[name=endDate]').datepicker('option','monthNamesShort', ['01 - Jan','02 - Feb','03 - Mar','04 - Apr','05 - May','06 - Jun','07 - Jul','08 - Aug','09 - Sep','10 - Oct','11 - Nov','12 - Dec']);
				}
			});
			// When fcstType is changed, refresh the date text boxes and placeholder attributes
			$('#settingsForm select[name=fcstType]').change(function() {
				// Empty the current text in the input fields
				$('#settingsForm input[name=startDate], #settingsForm input[name=endDate]').val('');
				// Rerun the jQuery to create placeholder text
				$('#settingsForm input[name=startDate], #settingsForm input[name=endDate]').placeholder();
			});
			// When fcstType is changed, unselect all the tools and just select manual
			$('#settingsForm select[name=fcstType]').change(function() {
				// Uncheck all settingsForm checkboxes
				$('input[name=fcstSource]:checkbox').removeAttr('checked');
				$('input[name=fcstSource]:radio').removeAttr('checked');
				// Check the manual forecast checkbox
				$('input[name=fcstSource]:visible[value=manual]').attr('checked','checked');
			});
			// When fcstType is changed, unselect all months/seasons in the datesValid box
			$('#settingsForm select[name=fcstType]').change(function() {
				// Clear all selected months/seasons
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype] td.selected').removeClass();
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select option').attr('selected',false);
			});
			// When spatialType is changed, enable/disable appropriate forecasts and update the
			// region type tabs
			$('#settingsForm select[name=spatialType]').change(function() {
				// Uncheck all settingsForm checkboxes
				$('input[name=fcstSource]:checkbox').removeAttr('checked');
				// Check the manual forecast checkbox
				$('input[name=fcstSource]:visible[value=manual]').attr('checked','checked');
				// If changed to gridded
				if ($(this).val() === "gridded") {
					// ERF
					if ($('#settingsForm select[name=fcstType]').val().match(/6-10day|8-14day/)) {
						// Disable all Tool Selector models
						ToolSelector.disableCheckboxes();
						// Unselect autoblend
						$('#settingsForm input[name=fcstSource][value=auto]').removeAttr('checked');
						// Disable autoblend
						$('#settingsForm input[name=fcstSource][value=auto]').attr('disabled',"disabled");
						// Disabled the Tool Selector link
						//$('a[name=toolSelectorLink]').data('enabled',false);
					}
				// If changed to anything else
				} else {
					// ERF
					if ($('#settingsForm select[name=fcstType]').val().match(/6-10day|8-14day/)) {
						// Unselect all tools
						ToolSelector.unselectAllTools();
						// Enable all Tool Selector models
						ToolSelector.enableCheckboxes();
						// Unselect autoblend
						$('#settingsForm input[name=fcstSource][value=auto]').removeAttr('checked');
						// Enable autoblend
						$('#settingsForm input[name=fcstSource][value=auto]').removeAttr('disabled');
						// Enable the Tool Selector link
						$('a[name=toolSelectorLink]').data('enabled',true);
					}
				}
				// Clear all selected months/seasons
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype] td.selected').removeClass();
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] select option').attr('selected',false);
				// Hide all months tables
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype]').hide();
				// Show the correct months table
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=months] table[data-fcsttype='+$('#settingsForm select[name=fcstType]').val()+']').show();
				// Hide all years <select> tags
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] table select').hide();
				// Select the appropriate list of years in the selectMonthsYears datesValid tab
				$('#datesValidPanel div[data-datesvalidtype=selectMonths] div[data-type=years] table select[data-fcsttype='+$('#settingsForm select[name=fcstType]').val()+']').show();
				// Update the region type tabs
				changeRegionTypeTabs($(this).val());
			});
			// When scoreType is changed, enable/disable appropriate Forecast Categories
			$('#settingsForm select[name=scoreType]').change(function() {
				// If Ranked Probability is selected, set categoryType to "total"
				if ($(this).val() === "rpss") {
					$('#settingsForm select[name=categoryType]').val("total");
				}
			});

			//-------------------------------------------------------------------------------
			// Display messages at the top if there are any notes/warnings
			//
			// The notes and warnings are stored in a MySQL database on the server
			//
			<?php
			if ($message_note) {
				echo "$('#newsPanel').message('$message_note','note');\n";
			}
			if ($message_warning) {
				echo "$('#newsPanel').message('$message_warning','warning');\n";
			}
			?>

			//-------------------------------------------------------------------------------
			// Set autocomplete to off for all form elements. This way when the page is
			// reloaded, none of the elements "stick". This is because when some of the form
			// elements stick and others don't, there are inconsistencies between the form
			// elements that we weren't expecting and don't make sense.
			//
			$('input,textarea,:input').attr('autocomplete', 'off');

            // Create a region selector default map with Climate Regions
            RegionSelector.makeRegionSelector('climateRegions');
		});
	</script>
	<!-- CSRF fix -->
	<?php require_once($_SERVER['DOCUMENT_ROOT'].'/ncep_common/csrf-magic.php');?>
</head>
<body class="center">
	<div id="outerContainer">
		<header id="banner">
			<h1>CPC Verification Web Tool (VWT)</h1>
		</header>
		<section id="newsPanel">
		</section>
		<div id="overviewContainer">
			<section id="overviewPanel" class="panel">
				<div class="content">
					<!-- Get contents of the overviewPanel -->
					<?php include('include/content_overviewPanel.php');?>
				</div>
			</section>
		</div>
		<!-- Tabs to switch between chart and map verification and the help page -->
		<ul id="pageTabs" class="tabs pageTabs">
			<li class="<?php if ($page === "chart") {print "selected";} else {print "unselected";}?>"><a href="<?php print "$thisPage?page=chart"?>">Chart</a></li>
			<li class="<?php if ($page === "map") {print "selected";} else {print "unselected";}?>"><a href="<?php print "$thisPage?page=map"?>">Map</a></li>
			<li class="<?php if ($page === "help") {print "selected";} else {print "unselected";}?>"><a href="<?php print "$thisPage?page=help"?>">Tutorial</a></li>
		</ul>
		<div id="innerContainer">
			<!-- Insert the inner page, either chart.php or map.php -->
			<?php
				if ($page === "chart") {
					include("include/chart.php");
				} else if ($page === "map") {
					include("include/map.php");
				} else if ($page === "help") {
					include("include/help.php");
				}
			?>
		</div> <!-- id="innerContainer" -->
	</div> <!-- id="outerContainer" -->
</body>
</html>
