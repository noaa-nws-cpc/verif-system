<?php
#--------------------------------------------------------------------
# Define all possible models
#
$models = array(
	"gfs_00z","gfs_06z",
	"gfsensm_00z","gfsensm_06z","gfsensm_al",
	"canm_00z",
	"ecm_00z",
	"ecmensm_00z",
	"manual",
	"auto",
	"naefs_00z","naefs_06z"
);
#--------------------------------------------------------------------
# Define all possible tools
#
$tools = array(
	"kleinCat",
	"kleinProb",
	"analog",
	"calibratedProb",
	"reforecastCalibratedProb",
	"uncalibratedProb",
);
?>

					<div id="toolSelector" title="Tool Selector" style="display:none">
						<table border=1>
<?php
#--------------------------------------------------------------------
# Set input type (on the Map page you only want a single fcstSource
# chosen...so a radio button)
#
if ($page === "chart") {$inputType = "checkbox";} else {$inputType = "radio";}

#--------------------------------------------------------------------
# Print the header row
#
# Opening <tr>
print "							<tr>\n";
# Empty <td> (on top of header column)
print "								<td></td>\n";
# Loop over each column (tool)
foreach ($tools as $tool) {
	print "								<td class=\"rowHeader\">$tool</td>\n";
}
# Print the closing </tr>
print "							</tr>\n";

#--------------------------------------------------------------------
# Print all remaining rows
#
# Loop over each row (model/cycle)
foreach ($models as $model) {
	#----- 6-10 day -----#
	print "							<tr>\n"; # Initial <tr>
	print "								<td class=\"columnHeader\">$model</td>\n"; # header column <td>
	foreach ($tools as $tool) { # Loop over each column (tool)
		$input = "<input style=\"width:40px\" type=\"$inputType\" name=\"fcstSource\" value=\"${tool}_${model}\">";
		print "								<td>$input</td>\n"; // toolSelector only for extendedRange
	}
	print "							</tr>\n"; # Ending <tr>
}
?>
						</table>
						<?php
							// Print the "Clear All" button only on the Chart Page
							if ($page === "chart") {
								print "
								<button type=\"button\" class=\"clearButton ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\">
									<span class=\"ui-button-text\">Clear all</span>
								</button>
								";
							}
						?>
						<span id="numChecked"></span>
					</div>
