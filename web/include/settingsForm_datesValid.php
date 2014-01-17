<!-- Settings -->
<?php
	$firstYear['6-10day'] = 2008;
	$firstYear['8-14day'] = 2008;
	$firstYear['monthly'] = 2001;
	$firstYear['seasonal'] = 1995;
?>
<!-- Import the PHP file with date functions -->
<?php require("dateFunctions.php")?>
<!-- Div for datesValidType=dateRange -->
<div data-datesvalidtype="dateRange">
	<p>Dates represent the center of the valid period of the forecast(s) to verify.</p>
	<ul>
		<!-- Start date -->
		<li data-setting="startdate">
			<div data-fcsttype="6-10day, 8-14day">
				<span class="settingLabel">Start date [<span data-label="Start date" data-tooltip="This is the first date of forecasts to verify for. It is the center date of the 5 or 7 day valid period of the forecast."> ? </span>]</span>
				<input date="text" name="startDate" size="8" maxlength="8" placeholder='YYYYMMDD'/>
			</div>
			<div data-fcsttype="monthly, seasonal" style="display: none">
				<span class="settingLabel">Start date [<span data-label="Start date" data-tooltip="This is the first date of forecasts to verify for. It is the center month of the valid season of a forecast."> ? </span>]</span>
				<input date="text" name="startDate" size="6" maxlength="6" placeholder='YYYYMM'/>
			</div>
		</li>
		<!-- End date -->
		<li data-setting="enddate">
			<div data-fcsttype="6-10day, 8-14day">
				<span class="settingLabel">End date [<span data-label="End date" data-tooltip="This is the last date of forecasts to verify for. It is the center date of the 5 or 7 day valid period of the forecast."> ? </span>]</span>
				<input date="text" name="endDate" size="8" maxlength="8" placeholder='YYYYMMDD'/>
			</div>
			<div data-fcsttype="monthly, seasonal" style="display: none">
				<span class="settingLabel">End date [<span data-label="End date" data-tooltip="This is the last date of forecasts to verify for. It is the center month of the valid season of a forecast."> ? </span>]</span>
				<input date="text" name="endDate" size="6" maxlength="6" placeholder='YYYYMM'/>
			</div>
		</li>
	</ul>
</div>
<!-- Div for datesValidType=selectMonths -->
<div data-datesvalidtype="selectMonths" style="display:none">
	<p>You can select multiple months/seasons for either all years or select years. Your "Forecast" selection will show either "Months" or "Seasons" as options.</p>
	<ul>
		<li>Select months: Click on each, unselect by clicking again.</li>
		<li>Select years: Hold down the Command button while making selections (Ctrl on Windows/Linux, Apple on Mac OS X).</li>
		<li>Range of years: Hold down the Shift button and select the first and last years.</li>
	</ul>
	<!-- Months block -->
	<div data-type="months">
		<h2>Months</h2>
		<!-- Table displayed when fcstType is extendedRange -->
		<table data-fcsttype="6-10day">
			<tr>
				<td>Jan</td><td>Feb</td><td>Mar</td><td>Apr</td>
			</tr>
			<tr>
				<td>May</td><td>Jun</td><td>Jul</td><td>Aug</td>
			</tr>
			<tr>
				<td>Sep</td><td>Oct</td><td>Nov</td><td>Dec</td>
			</tr>
		</table>
		<table data-fcsttype="8-14day" style="display:none">
			<tr>
				<td>Jan</td><td>Feb</td><td>Mar</td><td>Apr</td>
			</tr>
			<tr>
				<td>May</td><td>Jun</td><td>Jul</td><td>Aug</td>
			</tr>
			<tr>
				<td>Sep</td><td>Oct</td><td>Nov</td><td>Dec</td>
			</tr>
		</table>
		<!-- Table displayed when fcstType is monthly (currently the same for extendedRange) -->
		<table data-fcsttype="monthly" style="display:none">
			<tr>
				<td>Jan</td><td>Feb</td><td>Mar</td><td>Apr</td>
			</tr>
			<tr>
				<td>May</td><td>Jun</td><td>Jul</td><td>Aug</td>
			</tr>
			<tr>
				<td>Sep</td><td>Oct</td><td>Nov</td><td>Dec</td>
			</tr>
		</table>
		<!-- Table displayed when fcstType is seasonal -->
		<table name="months" data-fcsttype="seasonal" style="display:none">
			<tr>
				<td>Dec-Feb</td><td>Jan-Mar</td><td>Feb-Apr</td><td>Mar-May</td>
			</tr>
			<tr>
				<td>Apr-Jun</td><td>May-Jul</td><td>Jun-Aug</td><td>Jul-Sep</td>
			</tr>
			<tr>
				<td>Aug-Oct</td><td>Sep-Nov</td><td>Oct-Dec</td><td>Nov-Jan</td>
			</tr>
		</table>
	</div>
	<!-- Years block -->
	<div data-type="years">
		<h2>Years</h2>
		<table>
			<tr>
				<td><input type="radio" name="datesValidType" value="selectMonths" checked> All years</td>
				<td></td>
			</tr>
			<tr>
				<td><input type="radio" name="datesValidType" value="selectMonthsYears"> Select years</td>
				<td name="years">
					<!-- List of years for 6-10day -->
					<select data-fcsttype="6-10day" multiple="multiple" size="2" disabled>
						<?php
							$yearArray = getArrayOfYears($firstYear['6-10day']);
							foreach ($yearArray as $year) {
								print "<option value=$year>$year</option>";
							}
						?>
					</select>
					<!-- List of years for 8-14day -->
					<select data-fcsttype="8-14day" multiple="multiple" size="2" disabled style="display:none">
						<?php
							$yearArray = getArrayOfYears($firstYear['8-14day']);
							foreach ($yearArray as $year) {
								print "<option value=$year>$year</option>";
							}
						?>
					</select>
					<!-- List of years for monthly -->
					<select data-fcsttype="monthly" multiple="multiple" size="2" disabled style="display:none">
						<?php
							$yearArray = getArrayOfYears($firstYear['monthly']);
							foreach ($yearArray as $year) {
								print "<option value=$year>$year</option>";
							}
						?>
					</select>
					<!-- List of years for seasonal -->
					<select data-fcsttype="seasonal" multiple="multiple" size="2" disabled style="display:none">
						<?php
							$yearArray = getArrayOfYears($firstYear['seasonal']);
							foreach ($yearArray as $year) {
								print "<option value=$year>$year</option>";
							}
						?>
					</select>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- Div for datesValidType=selectSeasonalSignal -->
<div data-datesvalidtype="selectSeasonalSignal" style="display:none">
	<p>
		Select a climate phenomena, then select which event/phase of the phenomena for which you would like to verify. Jan 2001 is the earliest forecast used in the results even though climate phenomena events may start earlier.
	</p>
	<table>
		<tr>
			<td><input type="radio" name="seasonalSignalType" value="ENSO" checked></td>
			<td><span>Seasonal ENSO [<span data-label="ENSO" data-tooltip="Type of El Ni&ntilde;o - Southern Oscillation (ENSO) event"> ? </span>]</span></td>
			<td>
				<select name="ENSO">
					<option value="warm">Warm events</option>
					<option value="neutral">Neutral events</option>
					<option value="cold">Cold events</option>
				</select>
			</td>
			<td>
			<a href="http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ensoyears.shtml" target="_blank">ENSO events</a>
			</td>
		</tr>
	</table>
</div>
