<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<!-- HTML Header -->
<head>
<!-- <meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> -->
	<!-- Set the title -->
	<title>CPC Verification Web Tool (VWT)</title>
	<!-- Import CSS style sheets -->
	<link rel="stylesheet" href="../styles/index.css" type="text/css" />
</head>
<body>
<!-- Table of Contents -->
<div id="chartCustomizer">
<section class="tableOfContents">
	<h3>Table of Contents</h3>
	<ul>
		<li><a href="#intro">How to use the chart customizer</a></li>
		<li><a href="#chartType">Change chart type</a></li>
		<li><a href="#showHide">Show and hide plot results</a></li>
		<li><a href="#lineStyles"> Line style options</a></li>
		<li><a href="#axes">Axes options (including bounds) </a></li>
		<li><a href="#grid">Grid options</a></li>
		<li><a href="#chartArea"> Chart Area Options</a></li>
		<li><a href="#markers">Marker Options</a></li>
		<li><a href="#legend">Legend Options</a></li>
		<li><a href="#title">Title Options</a></li>
		<li><a href="#footer">Add footer text</a></li>
		<li><a href="#dataDownload">Download data results</a></li>
	</ul>
</section>
<!-- End of Table of Contents -->

<h3 id="intro">How to customize the chart</h3>
<ul>
<li> 
<p>Open the customizer by right-clicking anywhere inside the chart area once a chart is created. A window will pop-out which allows you to customize the chart :
</p>
<img src="../images/chartCustomizerScreenShot.png" alt="chart color selector button" width="400" height="300"/>
</li>
<li> The instructions below use the &#8594; symbol to show the order of tabs to select in the customizer.
</li>
<li> Some options change upon selection in the customizer (ie. Drop-down menu selections). Others require hitting the "Enter" keyboard button after selection (text fields), others require clicking an "Apply" button.
</li>
<li> The color-selector button
<img src="../images/colorSelectorButton.png" alt="chart color selector button"/> is a button labeled with 3 colors and allows you to pick optional colors for various settings from a color palette.
</li>
</ul>
<b> Caution:</b> Usually the options you change using the customizer will persist through various runs of the tool. These settings can cause errors in displaying different runs of the tool depending on the types of settings you changed. If you want to start fresh with the normal defaults, close the customizer pop-out, and refresh the tool webpage.

<h3 id="chartType">Change chart type</h3>
Click <p class="tabToClick">Data View &#8594; General</p> 
<p>
Drop down for different chart types such as area. pie, scatter plot, etc. Chart changes automatically after selection. There are other tabs within this selection that enables you to set options based on the type of chart format you selected.
</p>

<h3 id="showHide">Show and hide plot results</h3>
Click <p class="tabToClick">Data View &#8594; Data</p> 
<p>
Select a series listed in the left panel listing the Series and can select "Visible" or unselect "Visible"
</p>

<h3 id="lineStyles"> Change line styles in chart </h3>
Click <p class="tabToClick"> Data View &#8594; Chart Styles </p> 
<p>
Select one of the forecast names in the column labeled "Styles"
You will see various tabs, such as "Fill Style", "Line Style", and "Symbol Style".
"Fill Style" has options you can set if you have a chart type that requires coloring to fill in areas. 
There is a tab for "Line Style" which has options if you have a line plot (usually the default), and "Symbol Style" which contains options regarding the symbols used in the line plot representing each data point.  Click the color-selector button to select optional colors for various settings.
</p>


<h3 id="axes">Change axes properties (including bounds) </h3>
<p>
Select an axis listed in the let panel (ie. x-axis or y-axis). Then you can change various aspects of each of these axis.
</p>
<ul>
<li>Change min and maximum of axes:
Select either the x or y-axis, then
click <p class="tabToClick">Axes &#8594; Scale</p> 
<p>
You can change the values in the boxes with the Axis min and max values. After entering a value in a box, hit the "Enter" button to show changes.
</p> 
</li>
<li>Change axis direction :
click<p class="tabToClick"> Data View &#8594; Axes </p> 
<p>
Select one of the axis directions, can also select "Inverted" to invert.
</p>
</li>
<li>Change the axis title:
click<p class="tabToClick"> Axes &#8594;Title</p> 
<p>
Enter new text and hit the "Enter" button to show changes.
</p>
</li>
<li>You can also rotate the axis title, select a placement for the title, and the font styles of the axis title. 
</li>
<li>Change the spacing between axis points :
click<p class="tabToClick"> Axes &#8594; Labels &#8594; Value </p> 
<p>
Change the value for "Num Spacing".
</p>
</li>
<li>Change the spacing between tick marks  :
click<p class="tabToClick"> Axes &#8594; Labels &#8594; Value </p> 
<p>
Change the value for "Tick Spacing".
</p>
</li>
<li>Change the labels associated with each of the axes points  :
click<p class="tabToClick"> Axes &#8594; Labels &#8594; Value Labels </p> 
<p>
Click on a value or label  box and edit the entry. Then hit "Apply". You can also add and remove axes points and what label is displayed associated with the axis point.
</p>
</li>
</ul>

<h3 id="grid"> Grid properties</h3>
<p>
To change options associated with the grid displayed on the chart :
</p>
<p class="tabToClick"> Axes &#8594; Grid</p>
<p>
 To make the changes to the grid, after selecting your changes, select and then unselect the "Show Grid" option. Only after doing this will your changes take place.
</p>
<ul>
<li>You can choose to show either the x-axis or y-axis grid lines by selecting one of the axes and checking or unchecking the "Show Grid" option. 
</li>
<li>Change grid Spacing by entering a different value and hitting the "Enter" button.
</li>
<li>Change the grid line colors by clicking the color-selector button and selecting a color.
</li>
</ul>


<h3 id="chartArea">Chart area options</h3>
<p>
 To make the changes to the grid, after selecting your changes, select and then 
</p>
<ul>

<li>Change the fonts associated with the axes, as well as any labels that may be on the chart itself :
click <p class="tabToClick"> Chart Area &#8594; General </p>
<p>
Select options for the font style and click "Use this Font" button.
</p>
</li>
<li>Change the size and location of the chart area :
click <p class="tabToClick"> Chart Area &#8594; Location </p>
<p>
To change the location of the chart , uncheck the box labeled "isDefault" for either theX or Y direction, then change the value. To change the width or height of the chart, uncheck the box labeled "isDefault" and change the values.
</p>
</li>
<li>Change the entire chart color (background color including the chart, legend, axes, and title)
click <p class="tabToClick"> Chart &#8594; Colors </p>
<p>
Make sure that the "Opaque" option is selected. Use the color-selector button to pick colors for the background and foreground (font color used for axes labels and legend text).
</p>
</li>
<li>Change the background color including the axes labels and chart:
click <p class="tabToClick"> Chart Area &#8594; Colors </p>
<p>
Check the "Opaque" option. Click the color-selector button to change the colors for "Background".
</p>
</li>
<li>Change the background color of only inside the chart area:
click <p class="tabToClick">Chart Area&#8594; Colors </p>
<p>Check the "Opaque" option. Then go to </p>
click <p class="tabToClick">Chart Area &#8594; Plot Area &#8594; Colors </p>
<p>
Then click the color-selector button for "Background".
</p>
</li>
<li>Change margins of chart area:
click <p class="tabToClick"> Chart Area &#8594; Plot Area &#8594; Margins </p>
</li>

</ul>

<h3 id="markers">Edit/add/remove markers</h3>
<p>
Some reference information is displayed on the charts by default, such as lines representing values at zero, average scores, etc. You can alter and remove these markers  as well as add new markers to the chart.
To see marker options
</p>
click <p class="tabToClick">Data View &#8594; Markers</p>
<ul>
<li>To <b>edit</b> a marker :
<p>
Select one of the markers in the list on the left panel in the customizer. Change the value of the marker, by changing the "Value" field.
You can change the color and style of the markers, including the width, and style of the marker.
</p>
</li>
<li>To <b>remove</b> a marker :
<p>
Select one of the markers in the list on the left panel. Click the "Remove" button below the list.
</p>
</li>
<li>To <b>add</b> a marker :
<p>
You can draw vertical and horizontal lines on the plot. Click "Add" under the marker list panel.
</p>
</li>
<li>To add a horizontal line, select the "Associated with Y Axis" option. Enter a y-axis value to draw the line at.
</li>
<li>
To add a vertical line, unselect the "Associated with Y Axis" option. Enter an integer representing the index of the x-axis point to draw the line, with a value of "1" resulting in a line drawn at the first x-axis point. 
</li>
<li>Options for the color and style of lines can be selected.
</li>
<li>You can select to either draw the line before or after the data by selecting/unselecting the "Drawn Before Data" option. By selecting this, the added line will be drawn underneath the data values on the chart. By unselecting this option, the marker will be drawn on top of the data points already on the chart.
</li>
</ul>

<h3 id="legend">Legend options</h3>
<p>
General options are available at : 
</p>
click <p class="tabToClick"> Legend &#8594; General. </p>
<p>
Below are some options under this section:
</p>
<ul>
<li>Show/hide the legend by selecting/unselecting the "Visible" option.
</li>
<li>Change the location of the legend with respect to the chart by selecting a drop-down option from the "Anchor" option.
</li>
<li>Change the orientation of the way that the legend items are listed by selecting a drop-down option from the "Orientation" option.
</li>
<li>Change the way that the symbols are displayed in the legend by selecting a drop-down option from the "Symbol Render Mode".
Change the font styles used in the legend by making selections and clicking "Use this Font".
</li>
<li>Change the location of the legend using specific values by :
click <p class="tabToClick"> Legend &#8594; Locations</p>
</li>
<li>Change the background legend color by : 
click <p class="tabToClick"> Legend &#8594; Colors</p>
<p>
Select "Opaque". Then use the color-selector button to set the background and foreground color (font color).
</p>
</li>
<li>Change legend border properties such as the border style and colors by:
click <p class="tabToClick">Legend &#8594; Border</p>
</li>
</ul>


<h3 id="title">Title options</h3>
<ul>
<li>Change the title of the chart by:
click <p class="tabToClick"> Titles &#8594; Header &#8594; General </p>
<p>
Edit the text for the title in the "Text" field and click "Update Text". You can also remove the title by un-selecting "Visible". There are options for the alignment and font style for the title as well.
</p>
</li>
<li>
 Change the location of the title of the chart by:
click <p class="tabToClick">  Titles &#8594; Header &#8594; Location </p>
<p>
Unselect the "isDefault" option(s) and change values.
</p>
</li>
<li>
Change the background and foreground colors of the title by:
click <p class="tabToClick">  Titles &#8594; Header &#8594; Colors </p>
<p>
Select the "Opaque" option and use the color-selector button to change the colors.
</p>
</li>
<li>
Add a border around the title:
click <p class="tabToClick"> Titles &#8594; Header &#8594; Border </p>
<p>Select a line style for the border using the drop-down options. Choose a line color, then enter a value in the "Line Thickness" field representing the border line-width you want, then hitting the "Enter" button.
</p>
</li>
</ul>

<h3 id="footer"> Add footer text</h3>
<p>
Footer text can be added below the chart by :
</p>
click <p class="tabToClick"> Titles &#8594; Footer &#8594; General </p>
<ul>
<li>
Select the "Visible" option and enter content in the "Text" field, and click "Update Text". There are alignment and font style options as well.
</li>
<li>
Change the location of the footer by :
click <p class="tabToClick">  Titles &#8594; Footer &#8594; Location </p> 
</li>
<li>
Change the background and foreground (font) color of the footer by:
click <p class="tabToClick">  Titles &#8594; Footer &#8594; Colors </p>
<p>Select the "Opaque" option and using the color-selector button to choose colors.</p>
</li>
<li>
Change the border of the legend by:
click <p class="tabToClick">  Titles &#8594; Footer &#8594; Border </p>
<p>Select a style from the drop-down, select a color by clicking the color-selector  button, and then entering a line thickness, and hitting the "Enter" button.</p>
</li>
</ul>

<h3 id="dataDownload">Download data results</h3>
<p>
You can save the chart results as a text data file to your desktop (you cannot save the map results as text data). The data file is formatted as single space delimited. Note that missing values are labeled as 'hole' in the text file. 
To download the data :
</p>
click <p class="tabToClick">  Data View &#8594; General </p>
<p>
Click the "Save" button at the bottom of the customizer window. You will see a window pop-up labeled "Save data". Select the area on your local desktop to save the file to. Then enter the file name in the text field labeled "Enter file name:". Click the "Save" button to save the file to your desktop in the specified location. 

</p>

</div>
</body>
</html>


