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
    $sqlQuery = "TRUNCATE TABLE news";
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
				<h2>Remove all news items</h2>
				<!-- Print the following if the form hasn't been submitted yet -->
				<?php
				if (!isset($_POST['submit'])) { echo "
			<p>Clicking the button below will remove all existing news items from the VWT. You will <b>not</b> be able to recover them.</p>
				<form id='adminForm' action='$self' method='post'>
			<input name='submit' type='submit' value='Remove all news items' onclick='return confirm(\"Are you sure you want to remove all existing news items?\")'/>
				</form>";
				} else { echo "
				<p>All news items have been removed.</p>
				";}
				?>
			</section>
		</div><!-- id="innerContainer" -->
	</div> <!-- id="outerContainer" -->
</body>

</html>
