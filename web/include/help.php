<section id="help" class="panel">
<h2>	How to use the Verification Web Tool </h2>
<p><b>
What is verification?
</b></p>
<p>
Verification of forecasts involves comparing the skill of previously made forecasts to what was actually observed. Skill is a relative measure of forecast performance. This tool enables users to select sub-sets of (aggregate) forecasts and perform various statistical calculations to provide objective metrics on the skill of the forecasts.
</p>
<p>
By allowing users to investigate the skill of forecasts by various aspects, users can have more specific assessments that can help them decide how to use real-time forecasts. For example, decision makers can inspect the skill score results for various situations that can help them assess their confidence in using real-time forecasts in similar situations.
</p>
<h4>The web tool allows users to calculate 4 different verification skill scores:</h4>
<ul>
<li><b>heidke</b> - This criteria compares how often the forecasts correctly match the category actually observed, over and above the number of correct "hits" expected by chance alone.
<li><b>brier</b> - This criteria considers the strength of the probability given to a specific category (e.g., warmer or cooler). Forecasts made with higher probabilities are penalized heavily if they are wrong, and forecasts made with lower low probabilites are penalized less severely if they are wrong, since they aren't expected to be correct as often. Conversely, forecasts made wither high probabilities are rewarded more heavily if they are correct, and forecasts made with lower probabilities are rewarded less heavily if they are correct.
<li><b>rank probability skill score (RPSS)</b> - This criteria is similar to the Brier Skill Score, but it takes into account all categories at once. 
<li><b>reliability</b> - This criteria indicates how often the forecast probabilities match observations. This is expressed as a diagram chart. A diagonal reference line is usually plotted on the chart representing perfect forecasts. The closer the plotted values are to the reference line, the more reliable the forecast.
</ul>
<p>
All scores can be displayed on both the chart and map, except for the reliability score. The reliability score is only plotted on a chart due to the nature of the skill score.
</p>
<h3>Advanced features of the tool</h3>
After results are displayed there are features that users can use to further analyze results:
<p>
<b>On the chart page:</b>
</p>
<ul>
<li> A button will be displayed on the bottom of the chart that allows you to save the results as an image to your desktop.
<li>Right-clicking on the chart will pop-up a box that allows you to change the format and look and feel of the chart, such as where the legend is located, the type of chart display (scatter plot, area fill in, etc.), axes settings, saving data to desktop, etc. For more details on how to customize the chart, click the "Customizing the chart" link on the top left of the chart. 
<li>You can select multiple forecast sources (up to 4). Depending on the selected forecast type, you may be able to select different forecast sources. For example, if you select "seasonal" for "Forecast", you will be able to select the official CPC forecast and/or other forecast models to verify.
</ul>
<b>On the map page: </b>
<ul>
<li>Click on any of the colored dots to pop up the score value and more information about that point.
<li>On the top right of the map display, you can select "Satellite" to show the satellite view in the map.
<li>You can use your cursor to drag the map and zoom-in and out by clicking on the zoom scale on the left of the map.
</ul>
<h3>About select options</h3>
<p>
To learn about what each of the options, you can click on the question mark next to each option label to pop-out more information about each. The more complex options are explained below in more detail. The verification example at the bottom of this page helps understand how the options lead to the results.
</p>
<p>
In general, the difference between the "Chart" and "Map" tabs is that the chart enables you to aggregate (combine a subset) of spatial geographical areas to verify and will produce results in the time dimension and the map enables you to aggregate forecasts by time to produce results in the space dimension. The reliability skill score under "Chart" is aggregated by spatial geographical area and time together.
Below are some details about some of the web tool options:
</p>
<p class="collapsible-heading">[+] Click to learn more about selecting options</p>
<div class="collapsible-content">
	<b>Selecting regions</b>
	<p>
	When the "Chart" tab is selected, you can select different types of boundaries to select some or all regions by clicking on them. To unselect regions, you must clear all selected areas by clicking the "Revert to all regions" button and selecting regions again. You can leave any of the region maps unselected; this will calculate scores for the entire continental US (CONUS) by default. Some types of boundary maps will not be available depending on the type of forecast you select. You should see a pop-up window when unavailable combinations of options are selected.
	</p>
	<p>
	The "Chart" options box contains an option labeled "Region(s)". This field gets filled in with the values you select on the "Select regions" map. This gives you the option of listing locations manually (comma separated list) or by map selection. "All" is listed by default when no regions are selected which verifies all locations in the continental US (CONUS).
	</p>
	<b>Selecting time options</b>
	<p>
	When the "Map" tab is selected, you can select different types of date selection options to calculate skill scores for - date range, months, seasons, and years, and climate phenomena.
	</p>
	<p>
	<b>Date range</b> - The range of time to calculate skill scores for. This should be formatted in "YYYYMMDD" for either the 6-10 day or 8-14 day forecast. For the monthly and seasonal, the date entered should be in "YYYYMM" of the last forecast valid month.
	</p>
	<p>
	<b>Months/Seasons & Years </b>  - You can select multiple months or seasons for either all years or select years.
	Select months/seasons by clicking on each month, unselect by clicking on each.
	To select for all years, select the radio button for "All years".
	To select years, hold down the Command button while making selections (Ctrl on Windows and Linux, Apple button on Mac).
	To select a range of years, hold down the Shift button to select a range of years.
	</p>
	<b>Climate Phenomena</b> - You can evaluate the skill of forecasts occur during different events of climate phenomena. Select a climate phenomena, then select which event/phase of the phenomena you would like to verify forecasts i.e., selecting "ENSO", "warm events" will verify all the available forecasts that occurred during seasons that ENSO was a warm event.
	</p>
	<p>
	<b>Lead time</b> - This is the amount of time from when a forecast is made (date issued) to the start of the period for which the forecast is valid. This is the amount of time from the date the forecast was issued (released) to the start of the valid period. For example, to calculate the scores for an official CPC Monthly forecast valid for June 2011, issued in the middle of May 2011, the lead time would be 0.5 month (middle of May to beginning of June) and the month and year you select (under "Map" page > "Time Options" > "Months & Years") would be June 2011.
	</p>
	<p>
	Another example: To verify a seasonal forecast valid for June-July-August 2011 issued 1.5 months in advance (April 2011), the lead time would be 1.5 month, from middle of April 2011 to the first month, June 2011.
	</p>
	<p>
	<b>Forecast data format </b> - The data of different forecasts and associated observations are stored in different possible spatial formats, such as climate divisions, gridded data, and stations. Different forecasts allow users to select different options of the format of data used in the skill score calculation.
	</p>
	<p>
	Some of the available forecast and observation datasets have been interpolated or interpreted on different types of spatial points (i.e. a grid of forecast values for evenly spaced points (gridded), or forecast values at each station (station)). The way that the data is formatted can affect the number of points of data included in the skill score calculation because some formats would contain more data points that fall under selected areas than others.
	</p>
	<p>
	The data format can be different than the types of available boundaries on the region selection map (climate regions, states, climate divisions). The tool uses reference information to convert the areas you select on the region selection maps to the points of data that which may be stored in a different spatial format.  Read the "Verification Example" further below for more explanation.
	</p>
	<p>
	<b>Forecasts</b> - This is the forecast type for which to calculate scores. Different forecast time scales will enable different forecasts to be selected. You will typically be able to select from official CPC forecasts as well as forecast models. Forecasters typically usually use these models as guidance to create the manual official forecasts. Models include dynamic models, statistical models, or a combination of both.
	</p>
	<p>
	In the case of the 6-10 day/8-14 day forecasts, clicking on the "Select forecast models" will pop out a table of models you can verify. This table contains model forecasts that are produced by applying statistical models to the forecasts of dynamical models (which use physics to make forecasts). The columns represent the various statistical models that apply the statistics, and the rows represent the dynamical (numerical) models that are combined to create the combined model forecasts.
	</p>
	<p>
	In the case of seasonal forecasts, the models are listed as checkboxes. The seasonal models use statistical methods to create the forecast, except for the CFS (Climate Forecast System), which is considered a dynamical model.
	</p>
	<p>
	<b>Forecast Category</b>
	This allows you to select how the forecast categories are evaluated in the score calculation. All forecasts used in the VWT are based on categories - below normal, near normal, and above normal temperature and precipitation. You can either include all of these categories in the calculated skill score or calculate the skill score for each of these categories separately. Depending on the skill score or whether the chart or map is selected, you may see different options or no options for this at all. If you choose "separate categories", the chart view will allow you to view the scores of all 3 categories separately on one chart, whereas the map view will allow you to select one of the three forecast categories.
	</p>
</div>
<p class="collapsible-heading">[+] Click to learn more about the forecasts</p>
<div class="collapsible-content">
	<p>
	<b>6-10 Day and 8-14 Day Forecasts:</b>
	These forecasts represent the period of 6 - 10 days and 8 - 14 days after the date issued. The dates that you select to verify will calculate scores for the forecasts where the date is the center of those periods.
	</p>
	<p>
	The "CPC Official (Manual)" forecast refers to forecasts that were manually created by forecasters. These are updated daily by CPC. The forecasts from models (which forecasters often use as guidance tools to create their forecasts) are available to verify as well.  The "CPC Official (Auto)" forecast refers to forecasts that are not created manually by forecasters. These forecasts are created by an automated process, which combines other model forecasts. During the weekend, these forecasts are quality controlled by a forecaster and issued as the official forecast.
	</p>
	<p>
	<b>Monthly Forecasts:</b>
	The CPC official forecasts are manually created by a forecaster and updated the middle of every month and are valid the next month. The 0.5 month lead time forecast refers to what is considered the "official" forecast, and the 0 month lead time forecast refers to the "revised" forecast, which is a manually created forecast issued the last day of the month for the following month.
	</p>
	<p>
	<b>Seasonal Forecasts:</b>
	The CPC official forecasts are manually created by a forecaster and updated the middle of every month and are valid for various 3-month periods after the month issued. The below models are considered forecast tools used by forecasters as guidance to create the official forecast. The definitions can be found at:
	http://www.cpc.ncep.noaa.gov/products/predictions/90day/tools.html
	</p>
</div>
<p>
<h3>Understanding Verification Results</h3>
All chart results that have values for dates in a time series are labeled on the chart axis by the center date of the valid period. The term valid period refers to the period that the forecast was made to represent. The best way to think of this is to think of the chart results in terms of "how well the forecast of a range of time (which is represented by the center date) compared to what was actually observed".
</p>
<p>
Even though the date in the time series chart results may be labeled as a single day, it does not mean that it represents a daily forecast. The 6-10 day and 8-14 day forecasts represent a range of time across 5 days and 7 days, respectively. Each day, the Climate Prediction Center releases updated forecast maps that represent these time periods. In the verification results, 6-10 day and 8-14 day forecasts are labeled as "YYYYMMDD", which is the center day in the time range the forecast is for.
</p>
<p>
For example, a score value on the resulting time series chart with the date 7/30/2011 for a 6-10 day forecast (which spans across 5 days), represents the skill of the forecast that was made for the period July 28, 2011 - August 1, 2011. If this date is shown for an 8-14 day forecast (which spans across 7 days), the skill score represents the skill of the forecast made for July 27, 2011 - August 2, 2011. In both cases, July 30, 2011 is the middle date of those periods.
</p>
<p>
Additionally, a chart date can have the format "YYYYMM". If this applies to a monthly forecast skill score, the value is for that month and year. However, if it is a seasonal forecast score, the date on the results represents the middle month and year of the 3-month period that the forecast is valid for. For example, a score value for 7/2011 represents a seasonal forecast valid for June-July-August 2011.
</p>
<p class="collapsible-heading">
<b>[+] Click to see a verification example</b>
</p>
<div class="collapsible-content">
	<h3>Verification Example </h3>
	This example will help explain how selections lead to the resulting skill scores. You can select the following options, get results and read the below explanation.

	<p>
	For example, you select:
	The "Chart" tab.
	The "States tab" to select regions. You select New York, and California.
	Field: Temperature,
	Timescale: 6-10 day period,
	Lead time: 8 days,
	Spatial type: station,
	Forecast(s) : Manual and auto,
	Start date: 20090101,
	End date: 20090120,
	Region: (NY, CA) is filled in after selecting the regions on the map,
	Skill score: heidke,
	Category type: include all categories.
	</p>
	<p>
	<b>Chart display results explanation:</b>
	You should see a time series chart displayed with 2 solid lines and 2 dashed lines. The legend would indicate that different color lines represent different forecasts (manual and auto in this case). The dots and solid lines represent the Heidke Skill Score values of the forecasts. The dashed lines represent the average value of the score values across all the dates shown of the associated color forecast values.
	</p>
	<p>
	The x-axis is the valid dates representing the center date of the period of each forecast. The y-axis is the values of the skill score. The first date on the x-axis is 01/01/2009. This represents the skill score of the 6-10 day forecast that was valid (represents) December 30, 2008 - January 3, 2009. This score takes into account all 3 categories of the forecast. Each subsequent date represents scores for each 6-10 day forecast valid period that is shifted by one day later.
	</p>
	<p>
	<b>How the Heidke Skill Score results were calculated:</b>
	</p>
	<p>
	1) Calculate the Heidke skill score for the manual official forecast:
	</p>
	<p>
	a) For each forecast valid in the period represented by the center date (x-axis values), the number of station locations (in NY or CA) where the forecast were correct ("hits") are counted.  This value and the total number of station locations (in NY or CA) are used in the equation for the Heidke skill score calculation. The details of the equation are explained more in the resulting information panel after the scores are displayed.
	</p>
	<p>
	b) Since "include all categories" were selected, the number of "hits" include the correct number of forecasts amongst all 3 forecast categories. If separate categories were selected, then there would be 6 lines of values displayed in the results in total. For each of the forecasts (manual and auto), there would be a line of score values on the chart for each of the 3 categories - below normal, near normal, above normal categories. This evaluates how well the forecast of each of the categories performed over time.
	</p>
	<p>
	2) Calculate the score for the auto forecast the same way as the manual official in section 1a above.
	</p>
</div>
<h3>About the data used</h3>
Details about the various official forecasts and forecast models are listed below according to the different forecast time scales. As explained in the "About Selection Options", the forecast and observation data is stored in various ways, depending on the dataset. Data is usually stored as station, gridded, or climate division data. Gridded datasets are stored on a 2 x 2 degree grid.
<p>
The categories of observations are used in the skill scores along with the forecast categories. The observation categories are determined by using the climatology data from 1981-2010 as the reference period.
</p>
<h3>Warnings and Errors</h3>
You may experience some issues during run-time. The section below describes some possible problems and solutions. If the suggestions below do not work or the messages displayed in the warning and error panel seem unrelated to your submitted selections, please report the problem in an email to:
Melissa.Ou@noaa.gov or Sarah.Marquardt@noaa.gov. Please try to include all the options you selected and any error messages or warnings in your email.
<ul>
<li>Processing takes a long time or crashes browser:
- Try selecting a shorter date range or fewer dates in the time options. Also selecting less forecast sources may help run-time. You may have to restart your browser if it crashes. Then try selecting different options that may contain less data.
<li>Pop-ups display showing errors during selection of options:
- The web tool was designed to display pop-ups showing information about unavailable combinations of option selections. These typically provide information about what options are available based on previous selected options.
</ul>
</section>
