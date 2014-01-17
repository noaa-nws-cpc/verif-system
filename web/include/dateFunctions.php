<?php
date_default_timezone_set('UTC');
// Returns an array of years
//
// $firstYear is year to begin at
// $lastYear(optional) is the year to end at
function getArrayOfYears($firstYear, $lastYear=null) {
	# If the last year is not supplied, use the current year
	if ($lastYear === null) {
		$lastYear = date('Y');
	}
	# Loop over all years and place in an array
	$yearArray = array();
	for ($year = $firstYear; $year <= $lastYear; $year++) {
		array_push($yearArray,$year);
	}
	return $yearArray;
}
?>
