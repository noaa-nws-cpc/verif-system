				<!-- Set input type (on the Map page you only want a single fcstSource chosen...so a radio button) -->
				<?php if ($page === "chart") {$inputType = "checkbox";} else {$inputType = "radio";} ?>
				<fieldset>
					<legend><b>Forecast options</b></legend>
					<ul>
						<!-- Variable -->
						<li data-setting="variable">
							<span class="settingLabel">Field [<span data-label="Field" data-tooltip="Forecast field to calculate skill score for."> ? </span>]</span>
							<div>
								<select name="variable">
									<option value="temp">temperature</option>
									<option value="precip">precipitation</option>
								</select>
							</div>
						</li>
						<!-- Forecast type -->
						<li data-setting="fcsttype">
							<span class="settingLabel">Period [<span data-label="Period" data-tooltip="Range of time that the forecast covers."> ? </span>]</span>
							<div>
								<select name="fcstType">
									<option value="6-10day">6-10 Day Period</option>
									<option value="8-14day">8-14 Day Period</option>
									<option value="monthly">Monthly</option>
									<option value="seasonal">Seasonal</option>
								</select>
							</div>
						</li>
						<!-- Lead time -->
						<li data-setting="leadtime">
							<div data-fcsttype="6-10day" data-spatialtype="station, gridded" >
								<span class="settingLabel">Lead time [<span data-label="Lead time" data-tooltip="Time to the start of the valid period."> ? </span>]</span>
								<input type="radio" name="leadTime_6-10day" value="08d" checked/><span class="inputLabel">8 days</span>
							</div>
							<div data-fcsttype="8-14day" data-spatialtype="station, gridded" style="display:none">
								<span class="settingLabel">Lead time [<span data-label="Lead time" data-tooltip="Time to the start of the valid period."> ? </span>]</span>
								<input type="radio" name="leadTime_8-14day" value="11d" checked/><span class="inputLabel">11 days</span>
							</div>
							<div data-fcsttype="monthly" data-spatialtype="climateDivision, gridded" style="display:none">
								<span class="settingLabel">Lead time [<span data-label="Lead time" data-tooltip="Time to the start of the valid period."> ? </span>]</span>
								<div>
									<input type="radio" name="leadTime_monthly" value="01m" checked/><span class="inputLabel">0.5 Month (Official)</span><br>
									<input type="radio" name="leadTime_monthly" value="0pt5m"/><span class="inputLabel">0 Month (Revised)</span>
								</div>
							</div>
							<div data-fcsttype="seasonal" data-spatialtype="climateDivision, gridded" style="display:none">
								<span class="settingLabel">Lead time [<span data-label="Lead time" data-tooltip="Time to the start of the valid period."> ? </span>]</span>
								<select name="leadTime_seasonal">
									<option value="02m">0.5 Month</option>
									<option value="03m">1.5 Month</option>
									<option value="04m">2.5 Month</option>
									<option value="05m">3.5 Month</option>
									<option value="06m">4.5 Month</option>
									<option value="07m">5.5 Month</option>
									<option value="08m">6.5 Month</option>
									<option value="09m">7.5 Month</option>
									<option value="10m">8.5 Month</option>
									<option value="11m">9.5 Month</option>
									<option value="12m">10.5 Month</option>
									<option value="13m">11.5 Month</option>
									<option value="14m">12.5 Month</option>
								</select>
							</div>
							<div data-fcsttype="seasonal" data-spatialtype="gridded" style="display:none">
								<span class="settingLabel">Lead time [<span data-label="Lead time" data-tooltip="Time to the start of the valid period."> ? </span>]</span>
								<select name="leadTime_seasonal">
									<option value="02m">0.5 Month</option>
								</select>
							</div>
						</li>
						<!-- Spatial type -->
						<li data-setting="spatialtype">
							<div data-fcsttype="6-10day, 8-14day">
								<span class="settingLabel">Data format [<span data-label="Data format" data-tooltip="How the forecast and observation data is formatted that is used to calculate the skill score. See the 'About' tab for more explanation."> ? </span>]</span>
								<select name="spatialType">
									<option value="station">station</option>
									<option value="gridded">gridded</option>
								</select>
							</div>
							<div data-fcsttype="monthly, seasonal" style="display:none">
								<span class="settingLabel">Data format [<span data-label="Data format" data-tooltip="How the forecast and observation data is formatted that is used to calculate the skill score. See the 'About' tab for more explanation."> ? </span>]</span>
								<select name="spatialType">
									<option value="climateDivision">climate division</option>
									<option value="gridded">gridded</option>
								</select>
							</div>
						</li>
						<!-- Forecast sources -->
						<?php
							if ($page === "map") {
								$numForecasts = "select one forecast";
								$fcstSourceNote = "(Select one)";
							}
							else {
								$numForecasts = "select up to 4 forecasts at a time";
								$fcstSourceNote = "(Select up to 4)";
							}
						?>
						<li data-setting="fcstsource">
							<div data-fcsttype="6-10day, 8-14day" data-spatialtype="station, gridded">
								<span class="settingLabel">Forecast(s) <br> <?php print $fcstSourceNote; ?> [<span data-label="Forecast(s)" data-tooltip="Forecast(s) to verify. You can <?php print $numForecasts; ?> to calculate the skill score for. 'Manual' refers to a forecast that a forecaster has manually created. 'Auto' refers to an automated forecast that is not manually created."> ? </span>]</span>
								<div>
									<input type=<?php print "\"$inputType\""?> name="fcstSource" value="manual" title="CPC Official (Manual)" checked/><span>CPC Official (Manual)</span><br>
									<input type=<?php print "\"$inputType\""?> name="fcstSource" value="auto" title="CPC Official (Auto)" /><span>CPC Official (Auto)</span><br>
									<a href="javascript:void(0)" name="toolSelectorLink" data-enabled=true>Select forecast models</a>
								</div>
							</div>
							<div data-fcsttype="monthly" data-spatialtype="climateDivision, gridded" style="display:none">
								<span class="settingLabel">Forecast(s) <br> <?php print $fcstSourceNote; ?> [<span data-label="Forecast(s)" data-tooltip="Forecast(s) to verify. You can <?php print $numForecasts; ?> to calculate the skill score for. 'Manual' refers to a forecast that a forecaster has manually created. 'Auto' refers to an automated forecast that is not manually created."> ? </span>]</span>
								<input type=<?php print "\"$inputType\""?> name="fcstSource" value="manual" title="CPC Official (Manual)" checked/><span>CPC Official (Manual)</span>
							</div>
							<div data-fcsttype="seasonal" data-spatialtype="climateDivision" style="display:none">
								<span class="settingLabel">Forecast(s) <br> <?php print $fcstSourceNote; ?>  [<span data-label="Forecast(s)" data-tooltip="Forecast(s) to verify. You can <?php print $numForecasts; ?> to calculate the skill score for. 'Manual' refers to a forecast that a forecaster has manually created. 'Auto' refers to an automated forecast that is not manually created."> ? </span>]</span>
								<table>
									<tr>
										<td colspan="2"><input type=<?php print "\"$inputType\""?> name="fcstSource" value="manual" title="CPC Official (Manual)" checked/><span>CPC Official (Manual)</span></td>
									</tr>
									<tr>
										<td colspan="2" align="center"><span style="font-size:0.8em; font-weight:bold; text-decoration:underline">Forecast Models</span></td>
									</tr>
									<tr>
										<td><input type=<?php print "\"$inputType\""?> name="fcstSource" value="smlr" title="SMLR forecast"/><span>SMLR</span></td>
										<td><input type=<?php print "\"$inputType\""?> name="fcstSource" value="ocn" title="OCN forecast"/><span>OCN</span></td>
									</tr>
									<tr>
										<td><input type=<?php print "\"$inputType\""?> name="fcstSource" value="cca" title="CCA forecast"/><span>CCA</span></td>
										<td><input type=<?php print "\"$inputType\""?> name="fcstSource" value="cfs" title="CFS forecast"/><span>CFS</span></td>
									</tr>
								</table>
							</div>
							<div data-fcsttype="seasonal" data-spatialtype="gridded" style="display:none">
								<span class="settingLabel">Forecast(s) <br> <?php print $fcstSourceNote; ?>  [<span data-label="Forecast(s)" data-tooltip="Forecast(s) to verify. You can <?php print $numForecasts; ?> to calculate the skill score for. 'Manual' refers to a forecast that a forecaster has manually created. 'Auto' refers to an automated forecast that is not manually created."> ? </span>]</span>
								<input type=<?php print "\"$inputType\""?> name="fcstSource" value="manual" title="CPC Official (Manual)" checked/><span>CPC Official (Manual)</span>
							</div>
						</li>
					</ul>
				</fieldset>
				<fieldset>
					<legend><b>Verification options</b></legend>
					<ul>
						<!-- If on the chart page, display the date range setting -->
						<?php if ($page === "chart") {
							print "
						<!-- Start date -->
						<li data-setting=\"startdate\">
							<div data-fcsttype=\"6-10day, 8-14day\">
								<span class=\"settingLabel\">Start date [<span data-label=\"Start date\" data-tooltip=\"This is the first date of forecasts to verify for. It is the center date of the 5 or 7 day valid period of the forecast.\"> ? </span>]</span>
								<input date=\"text\" name=\"startDate\" size=\"8\" maxlength=\"8\" placeholder='YYYYMMDD'/>
							</div>
							<div data-fcsttype=\"monthly, seasonal\" style=\"display: none\">
								<span class=\"settingLabel\">Start date [<span data-label=\"Start date\" data-tooltip=\"This is the first date of forecasts to verify for. It is the center month of the valid season of a forecast.\"> ? </span>]</span>
								<input date=\"text\" name=\"startDate\" size=\"6\" maxlength=\"6\" placeholder='YYYYMM'/>
							</div>
						</li>
						<!-- End date -->
						<li data-setting=\"enddate\">
							<div data-fcsttype=\"6-10day, 8-14day\">
								<span class=\"settingLabel\">End date [<span data-label=\"End date\" data-tooltip=\"This is the last date of forecasts to verify for. It is the center date of the 5 or 7 day valid period of the forecast.\"> ? </span>]</span>
								<input date=\"text\" name=\"endDate\" size=\"8\" maxlength=\"8\" placeholder='YYYYMMDD'/>
							</div>
							<div data-fcsttype=\"monthly, seasonal\" style=\"display: none\">
								<span class=\"settingLabel\">End date [<span data-label=\"End date\" data-tooltip=\"This is the last date of forecasts to verify for. It is the center month of the valid season of a forecast.\"> ? </span>]</span>
								<input date=\"text\" name=\"endDate\" size=\"6\" maxlength=\"6\" placeholder='YYYYMM'/>
							</div>
						</li>";
						}?>
						<!-- Only display this section for chart page -->
						<?php if ($page === "chart") {
//         					require("datesValid_dateRange.php");
						// Region
						print "
						<li data-setting=\"regions\" class=\"setting\">
							<span class=\"settingLabel\">Region(s) [<span data-label=\"Region(s)\" data-tooltip=\"This field will be filled in when you select regions on the map. You can also list regions separated by commas or enter 'All' to verify all regions.\"> ? </span>]</span>
							<div>
								<input type=\"text\" name=\"region\" id=\"regionSelect\" value=\"CONUS\" size=\"10\"/>
							</div>
						</li>
						";
						};
						?>
						<!-- Score Type -->
						<li data-setting="scoretype">
							<span class="settingLabel">Skill Score [<span data-label="Score type" data-tooltip="Skill score to calculate for verification."> ? </span>]</span>
							<div>
								<select name="scoreType">
									<option value="heidke">heidke</option>
									<option value="rpss">ranked probability</option>
									<option value="brier">brier</option>
									<?php if ($page === "chart") {print "<option value=\"reliability\">reliability</option>";} ?>
								</select>
							</div>
						</li>
						<!-- Category Type -->
						<!--
						Only show this for scoreType=brier
						-->
						<li data-setting="categorytype">
							<div data-scoretype="heidke, brier, reliability">
								<span class="settingLabel">Forecast categories <br>[<span data-label="Forecast categories" data-tooltip="How to treat forecast categories (above normal, normal, below normal) when calculating the skill score. You can calculate the skill score for all the categories combined or calculate the score for each category separately."> ? </span>] (<i>available soon</i>)</span>
								<select name="categoryType">
									<option value="total">include all</option>
									<?php if ($page === "chart") {print "<option value=\"separate\">all separately</option> <option value=\"B\">Below normal</option> <option value=\"N\">Normal</option> <option value=\"A\">Above normal</option>";} ?>
									<?php if ($page === "map") {print "<option value=\"B\">Below normal</option> <option value=\"N\">Normal</option> <option value=\"A\">Above normal</option>";} ?>
								</select>
							</div>
							<div data-scoretype="rpss" style="display:none"></div>
						</li>
						<!-- Submit button -->
						<li>
							<input id='submit-button' type=button value='Get scores' onClick='Verification.processForm();'>
							<!-- Reminder to scroll down for results -->
							<span class="runStatus"></span>
						</li>
					</ul>
				</fieldset>
			<!-- Insert the toolSelector -->
			<?php include("include/toolSelector.php");?>
