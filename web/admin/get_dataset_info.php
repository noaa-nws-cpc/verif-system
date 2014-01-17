<?php
// Specify config file (once running operationally, the config file should
// be OUTSIDE of the Document Root, which is the top-level directory under
// which all web files are stored. The config file has sensitive information
// which should be hidden from the world by placing it outside the Document
// Root. The default value is "../../input/verif_server.conf" and should be
// left as is only in developmental sandboxes. The version that gets placed
// on the server for outside use should be changed.
$config_file = "../../input/verif_server.conf";

// Report all errors to screen (remove this after development!)
ini_set('error_reporting', E_ALL);
error_reporting(E_ALL);

// Create variables
$self = $_SERVER['PHP_SELF'];
$dataSettings_table = "cpc_reference.dataSettings";

// Parse the Verification System config file and get the MySQL settings
$settings = parse_ini_file($config_file,true);
$mysqlSettings = $settings['mysql'];

// Connect to MySQL
mysql_connect($mysqlSettings['host'], $mysqlSettings['admin_user'], $mysqlSettings['admin_password']) or die("Couldn't connect to the MySQL database: " . mysql_error());
mysql_select_db($mysqlSettings['db_vwt']) or die("Couldn't select the database: " . mysql_error());

// Define a global variable to store the data_settings
$data_columns  = array();
$data_settings = null;

// Do this only after the form is submitted
if (isset($_GET['submit'])) {
	// Get POST variables from form
	$data_type         = $_GET['data_type'] ?: NULL;
	$observation_table = $_GET['observation_table'] ?: NULL;
	$forecast_table    = $_GET['forecast_table'] ?: NULL;

	// Get a list of the column names from the dataSettings table
	$results = mysql_query("DESC $dataSettings_table");
	while($row = mysql_fetch_array($results)) {
		array_push($data_columns,$row[0]);
	}

	// If forecast
	if (strcmp($data_type,"forecast") == 0) {
		// Extract data properties from the table name (note that some datasets have
		// a tool, model, and/or cycle, so the number of items after exploding the
		// array are variable)
		$data_props   = explode("_",$forecast_table);
		if (count($data_props) == 5) {
			$variable     = $data_props[0];
			$fcst_source  = $data_props[1];
			$lead_time    = $data_props[2];
			$ave_window   = $data_props[3];
			$spatial_type = $data_props[4];
			// Get the row of data from the dataSettings table corresponding to
			// the properties extracted from the table name
			$results = mysql_query("SELECT * FROM $dataSettings_table WHERE dataType='forecast' AND variable='$variable' AND fcstSource='$fcst_source' AND spatialType='$spatial_type'") or die(mysql_error());
		} elseif (count($data_props) == 6) {
			$variable     = $data_props[0];
			$fcst_source  = "tool";
			$tool         = $data_props[1];
			$model        = $data_props[2];
			$lead_time    = $data_props[3];
			$ave_window   = $data_props[4];
			$spatial_type = $data_props[5];
			// Get the row of data from the dataSettings table corresponding to
			// the properties extracted from the table name
			$results = mysql_query("SELECT * FROM $dataSettings_table WHERE dataType='forecast' AND variable='$variable' AND fcstSource='$fcst_source' AND tool='$tool' AND model='$model' AND spatialType='$spatial_type'") or die(mysql_error());
		} elseif (count($data_props) == 7) {
			$variable     = $data_props[0];
			$fcst_source  = "tool";
			$tool         = $data_props[1];
			$model        = $data_props[2];
			$cycle        = $data_props[3];
			$lead_time    = $data_props[4];
			$ave_window   = $data_props[5];
			$spatial_type = $data_props[6];
			// Get the row of data from the dataSettings table corresponding to
			// the properties extracted from the table name
			$results = mysql_query("SELECT * FROM $dataSettings_table WHERE dataType='forecast' AND variable='$variable' AND fcstSource='$fcst_source' AND tool='$tool' AND model='$model' AND spatialType='$spatial_type'") or die(mysql_error());
		}
	} elseif (strcmp($data_type,"observation") == 0) {
		// Extract data properties from the table name
		$data_props   = explode("_",$observation_table);
		$variable     = $data_props[0];
		$ave_window   = $data_props[1];
		$spatial_type = $data_props[2];
		// Get the row of data from the dataSettings table corresponding to
		// the properties extracted from the table name
		$results = mysql_query("SELECT * FROM $dataSettings_table WHERE dataType='observation' AND variable='$variable' AND spatialType='$spatial_type'") or die(mysql_error());
	}
	$data_settings = mysql_fetch_row($results);
}
?>
<!DOCTYPE HTML>
<html>
<!-- HTML Header -->
<head>
	<!-- ======================================================== -->
	<!--           Import JQuery and related libraries            -->
	<!-- ======================================================== -->
	<!-- jQuery itself -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"> </script>
	<!-- jQuery regex selector -->
	<script type="text/javascript" src="library/jquery.regex.js"> </script>
	<!-- jQuery-based form validation -->
	<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"> </script>

	<!-- Set the title -->
	<title>CPC VWT Admin Page - Dataset Information</title>
	<!-- Import CSS style sheets -->
	<link rel=StyleSheet href="../styles/index.css" type="text/css" />

	<!-- jQuery -->
	<script>
		$(document).ready(function() {
			//-----------------------------------------------------------------
			// Change to the appropriate select tag when the user changes the
			// data type
			//
			// Wait for the data_type input to be changed
			$(':input[name=data_type]').change(function() {
				// Hide all <td>'s containing a <select> with a name ending
				// in "_table"
				$(':input[name$=_table]').closest('td').hide();
				// Show the appropriate select tag td
				data_type=$(this).val();
				$(':input[name='+data_type+'_table]').closest('td').show();
			});
		});
	</script>
</head>

<!-- Body -->
<body class="center">
	<div id="outerContainer">
		<header id="banner">
			<h1>CPC VWT Admin - Dataset Information</h1>
		</header>
		<div id="innerContainer">
			<section id="adminFormPanel" class="panel">
				<h2>Add a news item</h2>
				<!-- Print the following if the form hasn't been submitted yet -->
				<p>Fill in the form below to get information about a certain dataset.</p>
				<form id='adminForm' action='<?php echo $self?>' method='get'>
					<table>
						<tr>
							<td><b>Type of data:</b></td>
							<td>
								<!-- See which radio button was previously checked -->
								<?php
									if (isset($_GET['submit'])) {
										if (strcmp($data_type,"observation") == 0) {
											$checked['observation'] = "checked";
											$checked['forecast']    = "";
										} elseif (strcmp($data_type,"forecast") == 0) {
											$checked['observation'] = "";
											$checked['forecast']    = "checked";
										}
									} else {
										// Default
										$checked['observation'] = "checked";
										$checked['forecast']    = "";
									}
								?>
								<label><input name='data_type' type='radio' value='observation' required <?php echo $checked['observation'] ?> />Observation</label>
								<label><input name='data_type' type='radio' value='forecast' required <?php echo $checked['forecast'] ?> /> Forecast</label>
							</td>
						</tr>
						<tr>
							<td><b>Table:</b></td>
							<!-- See which select tag should be displayed -->
							<?php
								if (isset($_GET['submit'])) {
									if (strcmp($data_type,"observation") == 0) {
										$style['observation'] = "";
										$style['forecast']    = "display:none";
									} elseif (strcmp($data_type,"forecast") == 0) {
										$style['observation'] = "display:none";
										$style['forecast']    = "";
									}
								} else {
									// Default
									$style['observation'] = "";
									$style['forecast']    = "display:none";
								}
							?>
							<td style='<?php echo $style['observation']?>'><?php echo create_obs_table_select_tag(); ?></td>
							<td style='<?php echo $style['forecast']?>'><?php echo create_fcst_table_select_tag(); ?></td>
						</tr>
						<tr>
							<td colspan='2'>
								<input name='submit' type='submit' value='Get info' />
							</td>
						</tr>
					</table>
				</form>
			</section>
			<section id="adminDataSettingsPanel" class="panel">
				<?php if (isset($_GET['submit'])) { echo print_data_settings_table();} ?>
			</section>
		</div><!-- id="innerContainer" -->
	</div> <!-- id="outerContainer" -->
</body>

</html>

<?php

//-----------------------------------------------------------------------------
// create_fcst_table_select_tag
//
// Creates a <select> tag with all existing forecast tables in it
//
function create_fcst_table_select_tag() {
	// Get out-of-scope vars
	global $forecast_table;
	// Get the previously selected option
	if (isset($_GET['submit'])) {
		$selected_table = $forecast_table;
	} else {
		$selected_table = "";
	}
	// Get an array of all tables
	$results = mysql_query("SHOW TABLES FROM cpc_forecasts") or die(mysql_error());
	// Generate <option> tags for each table
	$select_tag = "<select name='forecast_table'>\n"; // Add the starting <select> tag
	while($row = mysql_fetch_array($results)) { // Loop over mysql results
		$table = $row[0]; // There's only one column of data, and that's the table
		// If this is the table that was selected before submission, then
		// make it selected again
		if (strcmp($table,$selected_table) == 0) {
			$selected = "selected";
		} else {
			$selected = "";
		}
		$select_tag .= "<option value=\"$table\" $selected>$table</option>\n"; // Add a new <option> tag
	}
	$select_tag .= "</select>\n"; // Add the ending </select> tag
	return $select_tag;
}

//-----------------------------------------------------------------------------
// create_obs_table_select_tag
//
// Creates a <select> tag with all existing observation tables in it
//
function create_obs_table_select_tag() {
	// Get out-of-scope vars
	global $observation_table;
	// Get the previously selected option
	if (isset($_GET['submit'])) {
		$selected_table = $observation_table;
	} else {
		$selected_table = "";
	}
	// Get an array of all tables
	$results = mysql_query("SHOW TABLES FROM cpc_observations") or die(mysql_error());
	// Generate <option> tags for each table
	$select_tag = "<select name='observation_table'>\n"; // Add the starting <select> tag
	while($row = mysql_fetch_array($results)) { // Loop over mysql results
		$table = $row[0]; // There's only one column of data, and that's the table
		// If this is the table that was selected before submission, then
		// make it selected again
		if (strcmp($table,$selected_table) == 0) {
			$selected = "selected";
		} else {
			$selected = "";
		}
		$select_tag .= "<option value=\"$table\" $selected>$table</option>\n"; // Add a new <option> tag
	}
	$select_tag .= "</select>\n"; // Add the ending </select> tag
	return $select_tag;
}

//-----------------------------------------------------------------------------
// print_data_settings_table
//
// Prints all the properties of a given dataset based on the dataSettings table
// into an HTML table
//
function print_data_settings_table() {
	// Retrieve the data_settings and data_columns arrays
	global $data_settings, $data_columns;
	// Start an HTML table
	$table = "<table>\n";
	// Loop over data_settings and create <li>'s
	for ($i=0; $i<count($data_settings); $i++) {
		$table .= "    <tr>\n";
		$table .= "        <th>$data_columns[$i]</th><td>$data_settings[$i]</td>\n";
		$table .= "    </tr>\n";
	}
	// Close the table
	$table .= "</table>\n";
	return $table;
}

?>

