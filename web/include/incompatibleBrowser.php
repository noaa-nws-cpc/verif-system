<?
$browser = $_GET['browser'];
$requiredVersion = $_GET['requiredVersion'];
?>
<!DOCTYPE HTML>
<html>
<head>
	<style>
		span {
			font-weight: bold;
		}
	</style>
</head>
<body>
<div>
<p>
Your version of <span><?echo $browser?></span> is too old for this web tool.

Please update your version of <span><?echo $browser?></span> to at least version <span><?echo $requiredVersion?></span>, or try another browser.
</p>
</div>
</body>
</html>