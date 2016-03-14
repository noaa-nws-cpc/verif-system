	<!-- Import image maps -->
	<?php include('include/imgMap_climateRegions.php');?>
	<?php include('include/imgMap_states.php');?>
	<?php include('include/imgMap_climateDivisions.php');?>
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
				<li class="tab selected">  <a data-regionType="climateRegions" href="javascript:Verification.clearMapper();Verification.selectTab('#tabs_regionType',0);Verification.changeMap('climateRegions');">Climate Regions</a></li>
				<li class="tab"><a data-regionType="states" href="javascript:Verification.clearMapper();Verification.selectTab('#tabs_regionType',1);Verification.changeMap('states');">States</a></li>
				<li class="tab"><a data-regionType="climateDivisions" href="javascript:Verification.clearMapper();Verification.selectTab('#tabs_regionType',2);Verification.changeMap('climateDivisions');">Climate Divisions</a></li>
			</ul>
			<!-- Regions Panel -->
			<section id="regionsPanel" class="panel">
				<p class="panelNumber">2</p>
				<h2>Select region(s) to verify</h2>
				<p>To unselect, you must clear all regions by clicking "Revert to CONUS".  All regions within the CONUS are verified by default.</p>
				<div id="canvas">
					<img id="regionMapImage" class="highlightedMap" alt="Map of U.S." src="images/map_climateRegions.jpg" usemap="#imageMap_climateRegions" />
				</div>
				<button onClick="Verification.clearRegions(); return false">Revert to CONUS</button>
			</section>
		</form>
		<!-- Results Panel -->
		<section id="resultsPanel" class="panel">
			<p class="panelNumber">3</p>
			<h2>Please select options from the form</h2>
			<div id="resultsInteractionPanel" style="display:none">
				<h3>Interacting With the Chart</h3>
				<ul>
					<li>Click on chart and then hover over points for values</li>
					<li>
						<a href="include/chartCustomizer.php" target="popup" onClick="open('include/chartCustomizer.php', 'popup', 'width=800, height=600, scrollbars=yes'); return false;">Customizing the chart</a>
					</li>
				</ul>
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
