	<!-- Line telling the user to scroll down for more info -->
	<p style="margin-top: 10px;  margin-bottom: 25px; font-weight: bold;">Scroll down the page to see the results, error messages, and information panel.</p>

	<!-- Form - must surround the datesValid panel and the settings panel, since they both have form elements -->
	<form id="settingsForm">

		<!-- Settings Panel -->
		<section id="settingsPanel" class="panel">
			<p class="panelNumber">1</p>
			<h2>Options</h2>
			<?php include('include/settingsForm.php'); ?>
		</section>

		<!-- Select Time Options -->
		<ul id="tabs_datesValidType" class="tabs datesValidTypeTabs">
			<li class="tab selected"><a href="javascript:Verification.selectTab('#tabs_datesValidType',0);Verification.changeDatesValidType('dateRange')">Date range</a></li>
			<li class="tabSeparator">OR</li>
			<li class="tab"><a href="javascript:Verification.selectTab('#tabs_datesValidType',1);Verification.changeDatesValidType('selectMonths')">Months/Seasons & Years</a></li>
			<li class="tabSeparator">OR</li>
			<li class="tab" id="tabs_datesValidType_climatePhenomena"><a href="javascript:Verification.selectTab('#tabs_datesValidType',2);Verification.changeDatesValidType('selectSeasonalSignal')">Climate Phenomena</a></li>
		</ul>
		<!-- DatesValid Panel -->
		<section id="datesValidPanel" class="panel">
			<p class="panelNumber">2</p>
			<h2>Valid Dates</h2>
			<?php require("include/settingsForm_datesValid.php"); ?>
		</section> <!-- id="datesValidPanel" -->

		<!-- Results Panel -->
		<section id="resultsPanel" class="panel">
			<p class="panelNumber">3</p>
			<h2>Please select options from the form</h2>
			<div id="resultsInteractionPanel" style="display:none">
				<h3>Interacting With the Map</h3>
				<ul>
					<li>Click on any colored circle for the position of that point and the score</li>
				</ul>
			</div>
			<div id="GoogleEarthMap">
			</div>
			<div id='GoogleEarthLegend'>
			</div>
		</section>
	</form>

	<!-- Error Panel -->
	<section id="errorPanel" class="panel">
		<p class="panelNumber">4</p>
		<h2>Warnings and Errors</h2>
		<p class="content" id="errorPanelText"></p>
	</section>
	<!-- Information Panel -->
	<section id="infoPanel" class="panel">
		<p class="panelNumber">5</p>
		<h2>Information</h2>
		<p class="content" id="infoPanelText"></p>
	</section>
	<!-- Settings Panel (USER-TESTING ONLY) -->
	<section id="printSettingsPanel" class="panel">
		<h2>Settings Used</h2>
		<p class="content" id="printSettingsPanelText"></p>
	</section>
