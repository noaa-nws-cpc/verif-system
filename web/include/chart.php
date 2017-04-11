	<!-- Import image maps -->
		<!-- Line telling the user to scroll down for more info -->
		<p style="margin-top: 10px; margin-bottom: 25px;"><b>Scroll down the page to see the results, error messages, and information panel.</b></p>

        <!-- Form - must surround the datesValid panel and the settings panel, since they both have form elements -->
        <form id="settingsForm">
			<!-- Settings Panel -->
			<section id="settingsPanel" class="panel">
	 			<p class="panelNumber">1</p>
				<h2>Options</h2>
				<?php include('include/settingsForm.php'); ?>
			</section>
			<!-- Regions Panel Tabs -->
			<ul id="tabs_regionType" class="tabs regionsPanelTabs">
				<li class="tab selected">  <a data-regionType="climateRegions" href="javascript:Verification.selectTab('#tabs_regionType',0);RegionSelector.makeRegionSelector('library/climate-regions.geojson');">Climate Regions</a></li>
				<li class="tab"><a data-regionType="states" href="javascript:Verification.selectTab('#tabs_regionType',1);RegionSelector.makeRegionSelector('library/states.geojson');">States</a></li>
				<li class="tab"><a data-regionType="climateDivisions" href="javascript:Verification.selectTab('#tabs_regionType',2);RegionSelector.makeRegionSelector('library/climate-divisions.geojson');">Climate Divisions</a></li>
			</ul>
			<!-- Regions Panel -->
			<section id="regionsPanel" class="panel">
				<p class="panelNumber">2</p>
				<h2>Select region(s) to verify</h2>
				<p>You can click on any region to select/unselect it for verification. To just verify the default regions (CONUS) click "Revert to CONUS".</p>
				<div id="region-selector-canvas"></div>
				<button onClick="resetSelectedRegions(); return false">Revert to CONUS</button>
			</section>
		</form>
		<!-- Results Panel -->
		<section id="resultsPanel" class="panel">
			<p class="panelNumber">3</p>
			<h2>Please select options from the form</h2>
            <div id='plotly'>
            </div>
		</section>
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
