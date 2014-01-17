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

// Create variables
$self = $_SERVER['PHP_SELF'];
$user = $_SERVER['REMOTE_USER'];

// Do this only after the form is submitted
if (isset($_POST['submit'])) {
	// Get POST variables from form
	$type = $_POST['type'] ?: NULL;
	$message = $_POST['message'] ?: NULL;

	// Parse the Verification System config file and get the MySQL settings
	$settings = parse_ini_file($config_file,true);
	$mysqlSettings = $settings['mysql'];

	// Connect to MySQL
	mysql_connect($mysqlSettings['host'], $mysqlSettings['admin_user'], $mysqlSettings['admin_password']) or die("Couldn't connect to the MySQL database: " . mysql_error());
	mysql_select_db($mysqlSettings['db_vwt']) or die("Couldn't select the database: " . mysql_error());

    // Generate MySQL query
    $sqlQuery = "INSERT INTO news(id, type, message, user, time) VALUES(NULL, '" . mysql_real_escape_string($type) . "', '" . mysql_real_escape_string($message) . "', '" . mysql_real_escape_string($user) . "', NOW())";
    $result = mysql_query($sqlQuery) or die(mysql_error());
    // Close the MySQL connection
    mysql_close();
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
	<script type="text/javascript" src="library/jquery-1.7.1.min.js"> </script>
	<!-- jQuery regex selector -->
	<script type="text/javascript" src="library/jquery.regex.js"> </script>
	<!-- jQuery-based form validation -->
	<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"> </script>

	<!-- Set the title -->
	<title>CPC VWT Admin Page</title>
	<!-- Import CSS style sheets -->
	<link rel=StyleSheet href="../styles/index.css" type="text/css" />

	<!-- jQuery -->
	<script>
		$(document).ready(function() {

		});
	</script>
</head>

<!-- Body -->
<body class="center">
	<div id="outerContainer">
		<header id="banner">
			<h1>CPC VWT Admin - Add News Item</h1>
		</header>
		<div id="innerContainer">
			<section id="adminFormPanel" class="panel">
				<h2>Add a news item</h2>
				<!-- Print the following if the form hasn't been submitted yet -->
				<?php
				if (!isset($_POST['submit'])) { echo "
				<p>Fill in the form below to submit a news item, which will be displayed at the top of the VWT and static verification pages.</p>
				<form id='adminForm' action='$self' method='post'>
					<table>
						<tr>
							<td><b>Type of message to add:</b></td>
							<td>
								<input name='type' type='radio' value='note' required /> Note
								<input name='type' type='radio' value='warning' required /> Warning
							</td>
						</tr>
						<tr>
							<td style='vertical-align: top'><b>Message:</b></td>
							<td><textarea cols='30' rows='5' name='message' required></textarea></td>
						</tr>
						<tr>
							<td colspan='2'>
			<input name='submit' type='submit' value='Add news item' onclick='return confirm(\"Are you sure you want to submit this news item?\")'/>
							</td>
						</tr>
					</table>
				</form>";
				} else { echo "
				<p>You've submitted the following <b>$type</b>:</p>
				<div style='border:1px solid black;padding:10px;text-align:center'>$message</div>
				<p>This will be displayed at the top of the VWT and static verification pages.</p>
				";}
				?>
			</section>
		</div><!-- id="innerContainer" -->
	</div> <!-- id="outerContainer" -->
</body>

</html>
