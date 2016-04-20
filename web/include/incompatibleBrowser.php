<?
$browser = filter_var($_GET['browser'], FILTER_SANITIZE_STRING);
$requiredVersion = filter_var($_GET['requiredVersion'], FILTER_SANITIZE_STRING);
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
