// Display package
package gov.noaa.ncep.cpc.display;

// Import all needed verification software specific packages
import gov.noaa.ncep.cpc.applets.ChartApplet;
import gov.noaa.ncep.cpc.format.FormatLibrary;
import gov.noaa.ncep.cpc.qc.Log;
import gov.noaa.ncep.cpc.services.Results;
import gov.noaa.ncep.cpc.settings.Settings;

import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Event;
import java.awt.Font;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.Window;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.Arrays;
import java.util.Iterator;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;
import javax.swing.border.Border;

import org.apache.log4j.Logger;

import com.klg.jclass.chart.Changeable;
import com.klg.jclass.chart.ChartDataModel;
import com.klg.jclass.chart.ChartDataView;
import com.klg.jclass.chart.ChartText;
import com.klg.jclass.chart.EventTrigger;
import com.klg.jclass.chart.JCAxis;
import com.klg.jclass.chart.JCAxisTitle;
import com.klg.jclass.chart.JCChart;
import com.klg.jclass.chart.JCChartFactory;
import com.klg.jclass.chart.JCChartLabel;
import com.klg.jclass.chart.JCChartLabelManager;
import com.klg.jclass.chart.JCChartUtil;
import com.klg.jclass.chart.JCDataIndex;
import com.klg.jclass.chart.JCLineStyle;
import com.klg.jclass.chart.JCMarker;
import com.klg.jclass.chart.JCSymbolStyle;
import com.klg.jclass.chart.JCValueLabel;
import com.klg.jclass.chart.LabelledChartDataModel;
import com.klg.jclass.chart.data.JCStringDataSource;
import com.klg.jclass.chart.data.JCXMLDataInterpreter;
import com.klg.jclass.util.io.OutputDataProperties;
import com.klg.jclass.util.legend.JCLegend;
import com.klg.jclass.util.legend.JCMultiColLegend;
import com.klg.jclass.util.swing.JCExitFrame;
import com.klg.jclass.util.swing.encode.JCEncodeComponent;

/**
Provides methods to create, display, and save charts made using JClass DesktopViews. Update methods can be called to update the chart without reloading the chart object.
<p>
Currently this code can plot :
<li> time series : display text along x-axis, title, legend
*/
public class PlotChart extends JPanel {
	//-----------------------------------------------------
	// Initialize all variables
	//-----------------------------------------------------
	JFileChooser _fileChooser = new JFileChooser();
	// Objects
	protected static Results resultsObj;
	protected static Settings settingsObj; // Settings object
	// JClass
	public JCChart chart; // Chart instance
	protected JLabel labelTitle;
	protected Color textBg = Color.WHITE; // Background color for initial message
	protected Color initTextColor = Color.black; // Font color for initial message
	protected JCChartLabelManager cl_man;
	protected JCChartLabel cl;
	//protected JCLegend legend;
	protected JCMultiColLegend legend = new JCMultiColLegend();
	protected JLabel header;
	protected static Container contentPane;
	protected static Connection dbConnection = null;
	protected static String fileName = "/export/lnx369/mou/chart.png";
	protected static String errorMsg = "<html><center><H2>Applet could not be" +
			" loaded!</H2></CENTER><p>" +
			"The necessary classes to load the applet could not be found.<P>" +
			"Some troubleshooting notes:<UL>" +
			"<LI>In JDK 1.2 or later, the appletviewer does not honor your CLASSPATH." +
			"<LI> Some browsers do not support Java 2.  For others you will need to " +
			"install the Java Plug-in." +
			"</UL>";
	// Other
	protected static int processFlag = 1; // Flag for process type (1 - Applet run, 0 - static run)
	protected static String staticXmlString ;
	protected static String pLabels[];
	protected static ChartDataModel cdm; // chart data
	protected static String chartFont = "Nimbus Sans L";
	protected JButton saveButton; // Button to save chart as a PNG
	JFrame frame;
	Font font;
	static Logger logger = Logger.getLogger(gov.noaa.ncep.cpc.display.PlotChart.class);
	int numColsInt;
	// Size of the chart
	static int chartWidth  = 0;
	static int chartHeight = 0;
	/**
	Default constructor for this class. Sets the background and background color (to white currently).
	*/
	public PlotChart()
	{	  
		// Specify font
		font = new Font(chartFont, Font.BOLD, 12);
		// Make a new Box Layout
		this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		// Panel background color
		setBackground(Color.white);
		// Recursively set fonts so that the file chooser boxes display with a different font than default
		recursivelySetFonts(_fileChooser, font);
	} // End default constructor PlotChart
	
	/**
	Method to inform the PlotChart of the size of the applet.

	@param  width   Width of the applet
	@param  height  Height of the applet
	*/
	public void setChartSize(int width, int height) {
		chartWidth  = width;
		chartHeight = height;
	}

	/**
	Creates initial chart object attributes. Creates a new JCChart chart object and sets initial attributes for the chart object.
	*/
	public void makeChart () {
		//-------------------------------------------------
		// Initialize and set up the chart
		//-------------------------------------------------
		// Create new chart instance
		chart = new JCChart();
		// Set the background color
		setBackground(Color.white);
 		chart.setBackground(Color.white);
		// Enable JClass chart builder GUI for settings
		chart.setAllowUserChanges(true);
		chart.setTrigger(0, new EventTrigger(Event.META_MASK,EventTrigger.CUSTOMIZE));
		// Turn on AntiAliasing for plot smoothing
		chart.setAntiAliasing(JCChart.ANTI_ALIASING_ON);

		//-------------------------------------------------
		// Label plot
		//
		// The below properties are set after getting the XML data to plot
		// so that specifications for labelling and plotting are obtained by running
		// the back-end driver.
		//-------------------------------------------------
		// Get the ChartDataView
		ChartDataView dataView = chart.getDataView(0);
// 		// Set hole value
// 		dataView.setHoleValue(Float.NaN);
		// Create Y-axis label
		JCAxis yaxis = dataView.getYAxis();
		yaxis.setVisible(false);
		// Create X-axis label
		JCAxis xaxis = dataView.getXAxis();
		JCAxisTitle axisTitleX = new JCAxisTitle("");
    		axisTitleX.setPlacement(JCLegend.SOUTH);
 	  	xaxis.setTitle(axisTitleX);
		// Set rotation of x-axis labels
		// Must set this before the setAnnotationRotationAngle
		xaxis.setAnnotationRotation(JCAxis.ROTATE_OTHER);
		// Below can also be set as degrees by setting JCChartUtil.DEGREES
		xaxis.setAnnotationRotationAngle(JCChartUtil.RADIANS, -0.8);
		xaxis.setAnnotationMethod(JCAxis.VALUE_LABELS);
		// Set to false initially because no actual data loaded yet into chart
		// This is set visible later on when the chart data is updated
		xaxis.setVisible(false); 
		// ** legend = chart.getLegend();
		chart.setLegend(legend);
		// Set legend size to be dynamic, but sets legend location (X,Y)
		chart.setLayoutHints(legend, new Rectangle(0, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE));
		// Make legend horizontal
		legend.setOrientation(JCLegend.HORIZONTAL);
		// Set the legend to sit at a specific side of the anchor point
		legend.setAnchor(JCLegend.SOUTH); // SOUTHWEST - doesnt put legend under chart on Windows Firefox
		// Note : BorderFactory is a Javax Swing Class
		legend.setBorder(BorderFactory.createLineBorder(Color.black,1));
		// Below setVisible allows the saved graphic in "static" mode (non-applet run)
		// to properly save the legend in the graphic
		logger.debug("In makeChart() processFlag is : " + processFlag);
		if (processFlag == 0) {
			legend.setVisible(true);
		}
		// Set legend features
		JComponent legendFeature = chart.getLegend();
		// Legend font settings
		Font flegend = new Font(null, Font.PLAIN, 12); // Font settings
		legendFeature.setFont(flegend);

		//-------------------------------------------------
		// Set chart properties
		//-------------------------------------------------
		// Set title
		header = (JLabel)chart.getHeader();
		header.setText("");
		Font f = new Font(chartFont, Font.BOLD, 16); // Font settings
		header.setFont(f);
		// If the processFlag is set to 1, run the below to display
		// the initial text for an Applet.
		logger.debug("ProcessFlag is : " + processFlag);
		if (processFlag == 1) {
			// Get ChartLabelManager
			cl_man = chart.getChartLabelManager();
			// Create a label, **this is the default text before user submission of form
			// Uncomment the line below to actually have something print before options are selected
			// String labelTitle = "Please select options from the form";
			String labelTitle = "";
			cl = createChartLabel(labelTitle, BorderFactory.createLineBorder(Color.white));
			// Attach to a pixel location
			cl.setAttachMethod(JCChartLabel.ATTACH_COORD);
			cl.setCoord(new Point((chartWidth/2), (chartHeight/2)));
			logger.info("Centering the label at (" + chartWidth/2 + "," + chartHeight/2 + ")");
			// Attach using the label's center
			cl.setAnchor(JCChartLabel.CENTER);
			cl_man.addChartLabel(cl);
		}
		try {
			// Add chart
			add(chart);
		}
		catch (Exception e) {
			logger.fatal("Could not add the chart");
			Log.fatal("Cannot add chart to display. Report chart initialization error.", "#errorPanelText");
		}
		// Create the button to save the chart as a PNG
		initSaveButton();
	} // end update method

	/**
	Updates the chart data with a passed XML formatted String of data. This updates the chart data points as well as retrieve new point labels (x-axis data points for marking and displaying on the chart). This method re-assesses the necessary labels for tick marks on the x-axis and uses logic to only plot tick marks at the points on the x-axis that JClass software figures out where and at what x-axis data points to display ticks. Previously without this solution, tick marks always are used at an interval of 1, which could result in overplotting of tick marks along the x-axis,especially when there are a lot of x-axis labels (ie. dates).
	<p>
	@param xmlDataString XML formatted String of data to plot.
	*/
	public void updateChartData(String xmlDataString) {
		logger.debug("In updateChartData");
		if(resultsObj == null) {
			logger.fatal("Results object has not properly been set in the PlotChart object.");
			Log.fatal("Report a results object null issue in plotting the chart. This could result in a blank chart due to inability to set the max properly.", "#errorPanelText");
			System.exit(0);
		}
		//-------------------------------------------------
		// Plot the data
		//-------------------------------------------------
// 		// Load data for chart
// 		ChartDataModel cdm;
		try {
			//out.write(xmlString);
			cdm = new JCStringDataSource(xmlDataString, new JCXMLDataInterpreter());
		} // End try
		catch (Exception e) {
			logger.fatal("Error: " + e.getMessage());
			e.printStackTrace(System.out);
			Log.fatal("Cannot update chart. Report problem updating the chart data", "#errorPanelText");
			return;
		}

		ChartDataView dv = chart.getDataView(0);
		int numOldMarkers = dv.getNumMarkers();
		logger.debug("Number of old markers is " + numOldMarkers);
		// Before data is updated, remove markers associated with old data
		int j = 0;
		for (Iterator i = dv.getMarkers().listIterator();i.hasNext();) {
			logger.trace("Found a marker to remove " + j);
			dv.removeMarker(0);
			j++;
		}
		logger.debug("Before set data source");
		// Set updated data source
		dv.setDataSource(cdm);
		logger.debug("After set data source");	

	//	dv.setAutoLabel(true);
		dv.setVisible(true);
		// Change the point labels to value labels, so we can query them later in
		// updateLabels below.
		LabelledChartDataModel lcdm = (LabelledChartDataModel)cdm;
		double xVals[] = cdm.getXSeries(0);
		pLabels = lcdm.getPointLabels();
		int length = Math.min(xVals.length, pLabels.length);
		JCAxis xAxis = dv.getXAxis();
		JCValueLabel labels[] =  new JCValueLabel[length];
		for (int i = 0; i < length; i++) {
			labels[i] = new JCValueLabel(xVals[i], pLabels[i]);
		}
		logger.trace("Labels are " + Arrays.toString(labels));
		xAxis.setValueLabels(labels);
		xAxis.setVisible(true);
		// Check to see if the settings object was set by the initiation code.
		if(settingsObj == null) {
			logger.warn("Settings object has not properly been set in the PlotChart object. Call PlotChart.setSettingsObj(settingsObj) from the initiation code  after the object is properly loaded .");
		}
		// Set the X-axis limit for non-reliability plots
		if (!settingsObj.getScoreType().equals("reliability")) {
			try {
				xAxis.setMax(resultsObj.getNumUniqueFcstDates());
			} catch (Exception e) {
				logger.fatal("Could not retrieve numDates for plotting the chart");
			}
		}
		else {
			// Must specify the max reliability x axis here (even though it is already set
			// for reliability diagrams in the chart object) because in the applet
			// it may get reset by above if statement when a non-reliability plot
			// is created prior to a reliability plot.
			// The max x axis value is the last value of the x axis label
			float[] AxisLabels = resultsObj.getStats().getProbabilityBinAxisLabels();
			int lastLabel = AxisLabels.length;
			xAxis.setMax(AxisLabels[lastLabel-1]);
		}
		JCAxis yAxis = dv.getYAxis();
		if (settingsObj.getScoreType().equals("reliability")) {
			yAxis.setValueLabels(labels);
			yAxis.setVisible(true);
		}
	} // End updateChartData

	/**
	Updates the labels on the chart, typically associated with updated data for the chart. Replots the header, x-axis, and y-axis titles and tick mark labels, title label, and legend.
	*/
	public void updateLabels() {
		// Remove ALL chart labels before updating them
		chart.getChartLabelManager().removeAllChartLabels();
		setSize(chartWidth,chartHeight);
		chart.setPreferredSize(new Dimension(chartWidth,chartHeight));
		String scoreType = settingsObj.getScoreType();
		// Get chart labels
		String[] chartLabelArray = getDisplayLabels();
		// Assign variables to chart labels returned
		String xAxisLabel = chartLabelArray[0];
		String yAxisLabel = chartLabelArray[1];
		String titleLabel = chartLabelArray[2];
		int firstSeriesIndex; // First index to use for creating hover labels
		// Set offset pixel values for dwell labels. This offsets the label from the data point where the label would be located.
		Point offsetVal = new Point(0,-30);
		// Create borders for labels (used for dwell labels)
		Border paddingBorder = BorderFactory.createEmptyBorder(4,4,4,4);
		Border labelBorder = BorderFactory.createLineBorder(Color.gray,1);
		// Set title text
		header = (JLabel)chart.getHeader();
		header.setText(titleLabel);
		Font f = new Font(chartFont, Font.BOLD, 16); // Font settings
		header.setFont(f);
		header.setVisible(true);
		// Symbol size settings
		// Smallest symbol size to use. If there are more series than unique symbol sizes
		// that fall between the max and min symbol sizes, this size is used for the rest of the series.
		int minSymbolSize = 4;
		int maxSymbolSize = 10; // Largest symbol size to use
		//Default symbol size. This is a variable that gets reset for each series plotted.
		int symbolSize = 6;
		// Get the ChartDataView
		ChartDataView dataView = chart.getDataView(0);
		int numSeries;
		numSeries = dataView.getNumSeries();
		JCMarker markers[] = new JCMarker[numSeries];
		JCMarker markerZeroValue = new JCMarker();

		// Handle axes//
		// If reliability score type selected, set x and y axis to same lengths to make chart plot symmetrical
		JCAxis yaxis = dataView.getYAxis();
		JCAxis xaxis = dataView.getXAxis();
		// Get size of y axis
		logger.trace("original xaxis size is " + dataView.getXAxis().getSize());
		// Set x-axis size to y-axis
		xaxis.setSize(502,26);
		logger.trace("new xaxis size is " + dataView.getXAxis().getSize());
		logger.trace("yaxis size is " + dataView.getYAxis().getSize());
		logger.trace("yaxis gap is " + dataView.getYAxis().getGap());
		logger.trace("xaxis gap is " + dataView.getXAxis().getGap());
		xaxis.setBounds(0, 400,502,26);
		// End Handle axes//

		// Set sizes of symbols so that each of the series have a different size symbol
		// to prevent overlapping. Have the last series have the smallest symbol size
		for (int i=0;i<numSeries;i++) {
			// Calculate a size for the symbol
			// The min and max symbol sizes to use are set at the top of this method.
			// Below logic allows for the case that there are more series to plot than
			// available unique symbol sizes for each series. If there are too many
			// series, the rest of the series are plot with the minimum symbol size.
			if (i>maxSymbolSize-minSymbolSize) {
				symbolSize = minSymbolSize;
			}
			else {
				symbolSize = maxSymbolSize-i;
			}
			logger.trace("Series # : " + i + " Symbol Size : " + symbolSize);
			// Set symbol size
			dataView.getChartStyle(i).setSymbolSize(symbolSize);
			int colorIndex;
			// Set line and symbol colors for line plots
			// For reliability, a black reference line is the first xml data set and
			// is plotted last underneath other lines
			if (scoreType.compareToIgnoreCase("reliability") == 0) {
				colorIndex = i+1;
			}
			else {
				colorIndex = i+2;
			}
			// Blues correspond to Below, yellows and black to Normal, red and pinks to Above
			// For fourth model ran out of good colors and had to use shades of gray
				switch (colorIndex) {
					case 1:
						dataView.getChartStyle(i).setLineColor(Color.black);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.NONE); break;
					case 2:
						dataView.getChartStyle(i).setLineColor(Color.blue);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.DOT);
						dataView.getChartStyle(i).setSymbolColor(Color.blue); break;
					case 3:
						dataView.getChartStyle(i).setLineColor(Color.orange);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.BOX);
						dataView.getChartStyle(i).setSymbolColor(Color.orange); break;
					case 4:
						dataView.getChartStyle(i).setLineColor(Color.red);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.TRIANGLE);
						dataView.getChartStyle(i).setSymbolColor(Color.red); break;
					case 5:
						dataView.getChartStyle(i).setLineColor(Color.cyan);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.DIAMOND);
						dataView.getChartStyle(i).setSymbolColor(Color.cyan); break;
					case 6:
						dataView.getChartStyle(i).setLineColor(Color.yellow);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.STAR);
						dataView.getChartStyle(i).setSymbolColor(Color.yellow); break;
					case 7:
						dataView.getChartStyle(i).setLineColor(Color.magenta);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.VERT_LINE);
						dataView.getChartStyle(i).setSymbolColor(Color.magenta); break;
					case 8:
						dataView.getChartStyle(i).setLineColor(Color.green);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.HORIZ_LINE);
						dataView.getChartStyle(i).setSymbolColor(Color.green); break;
					case 9:
						dataView.getChartStyle(i).setLineColor(Color.gray);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.CROSS);
						dataView.getChartStyle(i).setSymbolColor(Color.gray); break;
					case 10:
						dataView.getChartStyle(i).setLineColor(Color.pink);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.CIRCLE);
						dataView.getChartStyle(i).setSymbolColor(Color.pink); break;
					case 11:
						dataView.getChartStyle(i).setLineColor(Color.darkGray);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.SQUARE);
						dataView.getChartStyle(i).setSymbolColor(Color.darkGray); break;
					case 12:
						dataView.getChartStyle(i).setLineColor(Color.black);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.TRIANGLE);
						dataView.getChartStyle(i).setSymbolColor(Color.black); break;
					case 13:
						dataView.getChartStyle(i).setLineColor(Color.lightGray);
						dataView.getChartStyle(i).setSymbolShape(JCSymbolStyle.DIAMOND);
						dataView.getChartStyle(i).setSymbolColor(Color.lightGray); break;
					default: logger.warn("Not enough colors specified for the data series!");
				} // end switch
		} // end for

		// For scores other than reliability and "total" categories, plot an average line
		// Do not plot average lines for separate categories, only all cats together
		if (settingsObj.getCategoryType().compareToIgnoreCase("total") == 0 && !(settingsObj.getScoreType().equals("reliability")) ) {
			// Number of columns in legend
			numColsInt = numSeries; // (1-4 depending on # of models)
			// Get averages
			float[][][] aveArray = resultsObj.getStats().getAveFloatArray(); // TODO: assuming statsObj is not null
			Color lineColor[] = new Color[numSeries];			
			// For each data series get color of plotted lines and draw average lines to match
			for (int i=0;i<numSeries;i++) {
				// Save line colors to array
				lineColor[i] = dataView.getChartStyle(i).getLineColor();
				logger.trace("Color for the marker for fcst source " + settingsObj.getFcstSourceArray()[i] + " is " + lineColor[i]);
				markers[i] = new JCMarker();
				markers[i].setValue(aveArray[i][0][0]);
				// Set the line color to the same that was found for the plotted score line
				markers[i].getLineStyle().setColor(lineColor[i]);
				// Set the style of the line drawn
				markers[i].getLineStyle().setPattern(JCLineStyle.LONG_DASH);
				markers[i].setAssociatedWithYAxis(true);
				// Set so the lines are drawn before the data, this will allow the lines
				// of scores to take priority when displayed.
				markers[i].setDrawnBeforeData(true);
				// Set the labels to forecast source names
				// These will display in the legend if the markers are set to visible in legend
				markers[i].setLabel("ave " + settingsObj.getFcstSourceArray()[i]);
				// Set whether the markers are visible in the legend
				markers[i].setVisibleInLegend(true);
				// Add the marker to the plot
				try {
					dataView.addMarker(markers[i]);
				}
				catch (Exception e) {
					logger.warn("Could not add marker number " + i + "to dataView.");
					Log.error("Could not display the line of the average for " + settingsObj.getFcstSourceArray()[i] + ".","#errorPanelText");
				}
			}
		}
		// If non reliability score but SEPARATE categories selected, no average lines so set cols appropriately
		else if (settingsObj.getCategoryType().compareToIgnoreCase("separate") == 0 && !(settingsObj.getScoreType().compareToIgnoreCase("reliability")  == 0) ) {
			logger.debug("Its separate and NOT reliability!");
			numColsInt = 3;
		}
		// For all other situations, just set the number of columns to 4 by default
		else {
			numColsInt = 4; // The max is 4, but for fewer than 3 models and total, there will
							// be only 2-3 columns including the reference line.
		}
		// draw a line at 0
		if ( !(scoreType.equals("reliability")) ) {
			markerZeroValue.setValue(0); // Set value of line to y=0. The below "setAssociatedWithYAxis" means that the value is of the y-axis, therefore creating a horizontal line. 
			markerZeroValue.setAssociatedWithYAxis(true);
			// These will display in the legend if the markers are set to visible in legend
			markerZeroValue.setLabel("Zero skill");
			// Set whether the markers are visible in the legend
			markerZeroValue.setVisibleInLegend(true);
			markerZeroValue.getLineStyle().setColor(Color.BLACK); // Set color of line
			markerZeroValue.getLineStyle().setWidth(2); // Set width of line 
			// Add the marker to the plot
			try {
				// Set so the lines are drawn before the data, this will allow the lines
				// of scores to take priority when displayed.
				markerZeroValue.setDrawnBeforeData(true);
				dataView.addMarker(markerZeroValue);
			}
			catch (Exception e) {
				logger.warn("Could not display marker at y=0 to dataView.");
				Log.error("Could not display the line at y=0. " ,"#errorPanelText");
			}
		}
		// Update X-Axis
		JCAxis xAxis = chart.getDataView(0).getXAxis();
		JCAxisTitle xAxisTitle = new JCAxisTitle(xAxisLabel);
		xAxis.setTitle(xAxisTitle);
		xAxisTitle.setPlacement(JCLegend.SOUTH);  
		xAxisTitle.setFont(new Font(chartFont, Font.BOLD, 14));
		// Convert point labels to value labels
		// so that ticks are only plotted on the labels that JClass displays
		// This was a trick done by Milton Villegas (Case ID: 801933)
		// to get around the inability to do this with point labels
		JCValueLabel vLabels[] = xAxis.getValueLabels();
		JCValueLabel labels[] = xAxis.getGeneratedValueLabels();
		for (int i = 0; i < labels.length; i++) {
			JCValueLabel label = labels[i];
			if (label != null && !label.getChartText().isVisible()) {
				vLabels[i].setDrawTick(false);
				vLabels[i].setDrawGrid(false);
			}
		}
		xAxis.setChanged(true, Changeable.RECALC);
		xAxis.setVisible(true); // Show the x-axis

		// Update Y-AXIS
		// Create Y-axis label
		JCAxis yAxis = chart.getDataView(0).getYAxis();
		JCAxisTitle yAxisTitle = new JCAxisTitle(yAxisLabel);
		yAxis.setTitle(yAxisTitle);
		yAxisTitle.setPlacement(JCLegend.WEST);
		yAxisTitle.setRotation(ChartText.DEG_270);
		yAxis.setChanged(true, Changeable.RECALC);
		yAxisTitle.setFont(new Font(chartFont, Font.BOLD, 14));
		// **NOTE: Make sure to Set min and max y-axis values based on the score type
		// This is because it will not be set to JClass default unless you use the
		// setMaxIsDefault(true) explicitly in each if statement
		if (scoreType.compareToIgnoreCase("heidke") == 0) {
			// Set method of annotating for y-Axis to use the values
			yAxis.setAnnotationMethod(JCAxis.VALUE);
			yaxis.setNumSpacingIsDefault(true);
			yAxis.setMax(110.0);
			yAxis.setMin(-60.0);
		}
		// Set num spacing of interval if rpss
		else if (scoreType.compareToIgnoreCase("rpss") == 0) {
			// Set method of annotating for y-Axis to use the values
			yAxis.setAnnotationMethod(JCAxis.VALUE);
			yAxis.setNumSpacing(0.2);
			yAxis.setMaxIsDefault(true);
			yAxis.setMinIsDefault(true);
		}
		else if (scoreType.compareToIgnoreCase("reliability") == 0) {
			// Set method of annotating for y-Axis to use the labels attributed to axis values
			yAxis.setAnnotationMethod(JCAxis.VALUE_LABELS);
			yAxis.setMin(0.0);
			// Set size of labels array
			JCValueLabel yNewLabels[] =  new JCValueLabel[pLabels.length];
			JCValueLabel xNewLabels[] =  new JCValueLabel[pLabels.length];
			double pLabelsDouble[] = new double[pLabels.length];
			// Get an array of double values to match the axes labels
			try {
				logger.trace("pLabelsDouble : ");
				for (int i=0;i<pLabels.length;i++) {
					pLabelsDouble[i] = Double.valueOf(pLabels[i].trim()).doubleValue();
				}
				logger.trace(Arrays.toString(pLabelsDouble));
			}
			catch (NumberFormatException nfe) {
				logger.warn("NumberFormatException: " + nfe.getMessage());
			}
			logger.debug("new Y labels are ");
			logger.debug("Size probabLabels : " + pLabelsDouble.length + " size pLabels" + pLabels.length);
			for(int i=0;i<pLabelsDouble.length;i++) {
				// At the axis value pLabelsDouble[i], put the pLabel
				yNewLabels[i] = new JCValueLabel(pLabelsDouble[i], pLabels[i]);
				logger.trace("i = " + i + " label : " + yNewLabels[i] + " pLabel " + pLabels[i]);
			}
			yAxis.setMax(pLabelsDouble[pLabelsDouble.length-1]);
			logger.trace("yaxis Max is set to " + pLabelsDouble[pLabelsDouble.length-1]);
			yAxis.setValueLabels(yNewLabels);
			//x-axis
			xAxis.setAnnotationMethod(JCAxis.VALUE_LABELS);
			for(int i=0;i<pLabelsDouble.length;i++) {
				// At the axis value pLabelsDouble[i], put the pLabel
				xNewLabels[i] = new JCValueLabel(pLabelsDouble[i], pLabels[i]);
				logger.debug("i = " + i + " label : " + xNewLabels[i] + "pLabel " + pLabels[i]);
			}
			yAxis.setMax(pLabelsDouble[pLabelsDouble.length-1]);
			xAxis.setValueLabels(xNewLabels);
			xAxis.setVisible(true);
		}
		else {
			yAxis.setAnnotationMethod(JCAxis.VALUE); // need this in case a previous run sets the annotation method to VALUE_LABELS, the y-axis max and min won't be calculated again correctly
			yaxis.setNumSpacingIsDefault(true); // If this is not set to default, and another run prior to this has a numSpacing set, it will use the previous run's num spacing setting
			yAxis.setMaxIsDefault(true);
			yAxis.setMinIsDefault(true);
		}
		yAxis.setVisible(true); // Show the y-axis

		// LEGEND
		// Set the number of columns of the legend (rows are set automatically by JClass)
		legend.setNumColumns(numColsInt);
		// Set legend size to be dynamic, but sets legend location (X,Y)
		chart.setLayoutHints(legend, new Rectangle(Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE));
		
		// If there is only one column, set orientation to vertical. This solves issue of legend
		// incorrectly being placed next to the chart
		if (numColsInt == 1) {
			legend.setOrientation(JCLegend.VERTICAL);
		}
		else {
			// Make legend horizontal
			legend.setOrientation(JCLegend.HORIZONTAL);
		}
		// Put legend south relative to the chart
		legend.setAnchor(JCLegend.SOUTH);  // SOUTHWEST - doesnt put legend under chart on Windows Firefox
		// Note : BorderFactory is a Javax Swing Class
		legend.setBorder(BorderFactory.createLineBorder(Color.black, 1));
		// Recalculate legend
		legend.recalc();
		int getNumCols = legend.getNumColumns();
		int getNumRows = legend.getNumRows();
		logger.debug("Returned # cols is : " + getNumCols + " Calculated # rows are : " + getNumRows);
		// Set legend features
		JComponent legendFeature = chart.getLegend();
		// Legend font settings
		Font flegend = new Font(chartFont, Font.PLAIN, 12); // Font settings
		legendFeature.setFont(flegend);
		chart.getLegend().setVisible(true);
		// Set grid settings
		xaxis.getGridStyle().setLinePattern(JCLineStyle.SHORT_DASH);
		xaxis.getGridStyle().setLineColor(Color.LIGHT_GRAY);
		yaxis.getGridStyle().setLinePattern(JCLineStyle.SHORT_DASH);
		yaxis.getGridStyle().setLineColor(Color.LIGHT_GRAY);		
		// Display grid
		xaxis.setGridVisible(true);
		yaxis.setGridVisible(true);

		// Create data for Dwell labels - allows users to hover over values on the chart to get more data in a pop-up box
		LabelledChartDataModel lcdm = (LabelledChartDataModel)cdm;
		// Set the first index to create labels for
		// For reliability, must start at index 1, not 0 because the reference line is the
		// first series. For all other score types, use 0.
			int numDataSeries;
		if (scoreType.compareToIgnoreCase("reliability") == 0) {
			firstSeriesIndex = 1;
			numDataSeries = numSeries-1;
		}
		else {
			firstSeriesIndex = 0;
			numDataSeries = numSeries;
		}
		// Initialize arrays of x-data and y-data, one or two of these arrays of data may be used for the hover
		// labels depending on the information used
		//The actual number of values in arrays yValues and xValues may differ in the pLabels.length dimension
		// ie. if scoreType is reliability (reference line has more values than the actual data points).
		// This is accounted for in the loop used to make hover labels. Therefore the last values
		// in xValues and yValues arrays may not exist or set to null
		double[][] yValues= new double[numDataSeries][pLabels.length];
		double[][] xValues= new double[numDataSeries][pLabels.length]; 
		String[] seriesLabels = new String[numDataSeries]; //Array of names of data series (typically of forecast source)
		int seriesIndex;
		for(int i=0;i<numDataSeries;i++) {
			seriesIndex = i+firstSeriesIndex;
			// Get y data (series)
			yValues[i] = cdm.getYSeries(seriesIndex);
			// Get x-data values - probably only used for hover label usage if reliability is the score type
			xValues[i] = cdm.getXSeries(seriesIndex); 
			// Get labels associated with data
			seriesLabels[i] = dataView.getSeries(seriesIndex).getLabel();
		}		
		// If the score type is reliability, set dimension based on the x-data values	
		int numXValueLabels;
		if (scoreType.compareToIgnoreCase("reliability") == 0) {
			numXValueLabels = xValues[0].length;
		}
		// else if score type is not reliability, use pLabels for dimension
		else {	
			numXValueLabels = pLabels.length;
		}
		JCChartLabel hoverLabels[][] = new JCChartLabel[numSeries-firstSeriesIndex][numXValueLabels];
		logger.debug("Creating hover labels now...");
		logger.trace("Firstseriesindex = " + firstSeriesIndex + " number of Series(numDataSeries) " + numDataSeries);
		// Create Dwell labels - allows users to hover over values on the chart to get more data in a pop-up box
			// IF SCORE TYPE IS NOT REALIABILITY - make hover labels using point labels
			seriesIndex = 0;
			for (int i=0;i<numDataSeries;i++) {
				seriesIndex = i + firstSeriesIndex; 
				for (int j=0;j<numXValueLabels;j++)  {
					logger.trace("i = " + i + " point labels : " + pLabels[j] + " yValues : " + yValues[i][j] + " For series : " + seriesLabels[i]);
					// If the score type is reliability use the xValues for hover labels
					if (scoreType.compareToIgnoreCase("reliability") == 0) {
						logger.trace("Hover label [" + i  + "][" + j + "] is " + xValues[i][j] + ", " + yValues[i][j] + ", " + seriesLabels[i]);
						hoverLabels[i][j]= new JCChartLabel(xValues[i][j] + ", " + yValues[i][j] + ", " + seriesLabels[i]);
					}
					else {
						// Else Create new JCChartLabel for each data point. Use point labels.
						logger.trace("Hover label [" + i  + "][" + j + "] is " + pLabels[j] + ", " + yValues[i][j] + ", " + seriesLabels[i]);
						hoverLabels[i][j]= new JCChartLabel(pLabels[j] + ", " + yValues[i][j] + ", " + seriesLabels[i]);
					}
					// Set styles of dwell labels, these are all methods of JComponent
					hoverLabels[i][j].getComponent().setBorder(BorderFactory.createCompoundBorder(labelBorder,paddingBorder));
					hoverLabels[i][j].getComponent().setOpaque(true);
					hoverLabels[i][j].getComponent().setBackground(textBg);
					hoverLabels[i][j].getComponent().setFont(new Font(chartFont, Font.PLAIN, 16));
					// Attach to a data index
					hoverLabels[i][j].setAttachMethod(JCChartLabel.ATTACH_DATAINDEX);		
					hoverLabels[i][j].setOffset(offsetVal); // Offset label from data point
					// Enable 'dwell labels', which allows users to hover over values and values pop-up
					// **NOTE: Dwell labels can ONLY be used with attach method ATTACH_DATAINDEX** (see jcchart.pdf)
					hoverLabels[i][j].setDwellLabel(true);
					hoverLabels[i][j].setAnchor(JCChartLabel.AUTO);
					hoverLabels[i][j].setDataIndex(new JCDataIndex(j,dataView.getSeries(seriesIndex)));
					chart.getChartLabelManager().addChartLabel(hoverLabels[i][j]);
				}
			}
		logger.debug("Finished creating hover labels.");
	} // End updateLabels()

	/**
	Overloaded method that returns chart labels that uses internal settings get method to get scoreType.
	<p>
	@return 2-d array with : x-axis title label, y-axis title label, and title label (in the specified order).
	*/
	public String[] getDisplayLabels() {
		// Initialize returned array
		String[] displayLabels= new String[3];
		String scoreType = settingsObj.getScoreType();
		String firstLetter = scoreType.substring(0,1); // Get first letter
		String remainder = scoreType.substring(1); // Get remainder of word
		// y-axis label
		String yAxisLabel;
		String xAxisArray[] = null;
		if ( !(settingsObj.getScoreType().equals("reliability")) ) {
			if (settingsObj.getScoreType().equals("rpss")) {
				yAxisLabel = "Ranked Probability Skill Scores";
			}
			else {
				yAxisLabel = firstLetter.toUpperCase() + remainder + " Skill Scores";
			}
		}
		else {
			yAxisLabel = "Observed Frequency";
		}
		// x-axis label
		String xAxisLabel;
		logger.debug("Before reference dates array");
		if(resultsObj == null) {
			logger.warn("Results object has not properly been set in the PlotChart object.");
		}
		try {
			xAxisArray = resultsObj.getFormattedReferenceDatesArray();
		} catch (Exception e) {
			logger.fatal("Could not get the referenceDatesArray for plotting");
		}
		logger.debug("After reference dates array");
		if ( !(settingsObj.getScoreType().equals("reliability")) ) {
			xAxisLabel = "Date";
		}
		else {
			xAxisLabel = "Forecast Probability";
		}
		logger.debug("xAxisLabel: " + xAxisLabel);
		// title
        	String variable = settingsObj.getVariable();
		String categoryType = settingsObj.getCategoryType();
		String leadTime = settingsObj.getLeadTime();
		String varString = null;
		if (variable.equals("temp")) {
			varString = "Temperature ";
		}
		else if (variable.equals("precip")) {
			varString = "Precipitation ";
		}
		String fcstTypeString = null;
		if (leadTime.equals("08d")) {
			fcstTypeString = "6-10 Day ";
		}
		else if (leadTime.equals("11d")) {
			fcstTypeString = "8-14 Day ";
		}
		else if (leadTime.equals("0pt5m")) {
			fcstTypeString = "Revised Monthly (Lead 0) ";
		}
        else if (leadTime.equals("01m")) {
			fcstTypeString = "Monthly (Lead 0.5) ";
        }	
        else if (leadTime.equals("02m")) {
			fcstTypeString = "Seasonal (Lead 0.5) ";
		}
        else if (leadTime.equals("03m")) {
		    fcstTypeString = "Seasonal (Lead 1.5) ";
		}
        else if (leadTime.equals("04m")) {
		    fcstTypeString = "Seasonal (Lead 2.5) ";
		}
		else if (leadTime.equals("05m")) {
		    fcstTypeString = "Seasonal (Lead 3.5) ";
		}
        else if (leadTime.equals("06m")) {
		    fcstTypeString = "Seasonal (Lead 4.5) ";
		}
		else if (leadTime.equals("07m")) {
		    fcstTypeString = "Seasonal (Lead 5.5) ";
		}
        else if (leadTime.equals("08m")) {
		    fcstTypeString = "Seasonal (Lead 6.5) ";
		}
		else if (leadTime.equals("09m")) {
		    fcstTypeString = "Seasonal (Lead 7.5) ";
		}
        else if (leadTime.equals("10m")) {
			fcstTypeString = "Seasonal (Lead 8.5) ";
		}
		else if (leadTime.equals("11m")) {
	        fcstTypeString = "Seasonal (Lead 9.5) ";
	    }
        else if (leadTime.equals("12m")) {
	        fcstTypeString = "Seasonal (Lead 10.5) ";
	    }
	    else if (leadTime.equals("13m")) {
	        fcstTypeString = "Seasonal (Lead 11.5) ";
	    }
		else if (leadTime.equals("14m")) {
			fcstTypeString = "Seasonal (Lead 12.5) ";
		}
		String catString = null;
		if (categoryType.equals("total")) {
			catString = "";
		}
		else if (categoryType.equals("B")) {
			catString = "(category B)";
		}
        else if (categoryType.equals("N")) {
            catString = "(category N)";
        }
        else if (categoryType.equals("A")) {
            catString = "(category A)";
        }
		else {
			catString = "(separate categories)";
		}
		int numDates = xAxisArray.length;
		String labelTitle;
		String scoreString = null;
		if ( !(settingsObj.getScoreType().equals("reliability")) ) {
			scoreString = yAxisLabel;
		}
		else {
			scoreString = "Reliability Scores";
		}
		// Create title string
		labelTitle = fcstTypeString + varString + scoreString + " " + catString;

		// Fill in the displayLabels array with labels
		displayLabels[0] = xAxisLabel; // x-axis label
		displayLabels[1] = yAxisLabel; // y-axis label
		displayLabels[2] = labelTitle; // label title

		return displayLabels;
	} // End getDisplayLabels

	/**
	Overloaded method tthat returns chart label information that accepts a String specifying the score type.
	This is method is incomplete since it's missing the valid dates.
	<p>
	@return 2-d array with : x-axis title label, y-axis title label, and title label (in the specified order)
	*/
	public String[] getDisplayLabels(String scoreType) {
		// Initialize returned array
		String[] displayLabels= new String[3];
		String firstLetter = scoreType.substring(0,1); // Get first letter
		String remainder = scoreType.substring(1); // Get remainder of word
		// y-axis label
		String yAxisLabel;
		if ( !(scoreType.equals("reliability")) ) {
				yAxisLabel = firstLetter.toUpperCase() + remainder + " Skill Score";
		}
		else {
				yAxisLabel = "Observed Probability";
		}
		// x-axis label
		String xAxisLabel;
		if ( !(scoreType.equals("reliability")) ) {
				xAxisLabel = "Date";
		}
		else {
				xAxisLabel = "Forecast Probability";
		}
		// title
		String labelTitle;
		if ( !(settingsObj.getScoreType().equals("reliability")) ) {
				labelTitle =  yAxisLabel + "s" + " Valid Dates : ";
		}
		else {
				labelTitle = "Reliability Diagram Valid Dates : ";
		}
		// Fill in the displayLabels array with labels
		displayLabels[0] = xAxisLabel; // x-axis label
		displayLabels[1] = yAxisLabel; // y-axis label
		displayLabels[2] = labelTitle; // label title
		return displayLabels;
	} // End getDisplayLabels

	/**
	Saves the chart as a graphic file.
	<p>
	@param saveChartfileName Name of file to save the XML properties file to (ie. after using JCChart Builder). This is only applicable when the verification web tool is ran on as a desktop application.
	<p>
	A button on the bottom of the display will allow the user to save changes made to the graphic using the JCChart builder. To use the JCChart builder to dynamically change aspects of the graphic, the user can right-click on the panel with the chart and a pop-up box will display with options. This method enables the properties to be saved in an XML file without the embedded data.
	*/
	public void saveChart(String saveChartfileName) {
		// Saves chart properties without embedded data.
		ChartDataView dataView = chart.getDataView(0);
		OutputDataProperties odp = new OutputDataProperties();
		odp.setSaveType(OutputDataProperties.NO_DATA);
		dataView.setOutputDataProperties(odp);

		JCAxis xAxis = dataView.getXAxis();
		JCValueLabel vLabels[] = xAxis.getValueLabels();
		logger.debug("Vlabels : " + Arrays.toString(vLabels));
		// Set the value labels null for saving, so all those value labels aren't
		// stored in the XML file.
		xAxis.setValueLabels(null);
		try {
			JCChartFactory.saveChartToFile(chart, saveChartfileName, JCChartFactory.XML);
		}
		catch (IOException e) {
			Log.fatal("Cannot save chart to file. Report problem saving chart to file.", "#errorPanelText");
			e.printStackTrace();
		}
		xAxis.setValueLabels(vLabels);
	}

	/**
	Updates chart using event dispatcher methods/applications, including Applet usage of PlotChart. The web application version of the verification web tool accesses this method to update the chart dynamically. This optimizes updating of the chart without recreating the entire chart object each time selections are changed by the user in the web tool. This method calls other methods to recalculate and redisplay parts of the chart with updated information and data.
	*/
	public static class UpdateChart implements Runnable {

		protected static PlotChart plotChart;

		UpdateChart(PlotChart plotChart) {
			this.plotChart = plotChart;
		}

		public void run() {
			plotChart.updateChartData(ChartApplet.xmlString);
			plotChart.chart.recalc();
			// Pass labels?
			plotChart.updateLabels();
			plotChart.chart.recalc();
			plotChart.chart.revalidate();
		}
	}

	/**
	Create chart labels in terms of the look and feel.
	*/
	protected JCChartLabel createChartLabel(String text, Border b) {
	//	JCChartLabel cl;
		cl = new JCChartLabel();
		cl.setText(text);
		cl.getComponent().setBorder(b);
		cl.getComponent().setOpaque(true);
		cl.getComponent().setBackground(textBg);
		cl.getComponent().setFont(new Font(chartFont, Font.BOLD, 18));
		cl.getComponent().setForeground(initTextColor);
		return cl;
	}

	/**
	Update text on the chart (chart label). This is displayed even when there is no chart, typically
	as a message to the user in the absence of a chart display. This can be called to update
	the message displayed where the chart typically is located.
	@param text A String of text to update the display with.
	*/
	public void updateChartLabel(String text) {
		String updateText = text;
		cl.setText(updateText);
	}

	/**
	Returns a JCChart chart object.
	<p>
	@return JCChart chart object
	*/
	public JCChart getChart() {
		return chart;
	}

	 /**
  Sets the Settings Object. The Settings Object is needed to get things
  like the score type (for the title) and the x axis labels, etc.

  @param  settingsObj  Settings object to set
  */
  public void setSettingsObj(Settings settingsObj) {
    this.settingsObj = settingsObj;
  }
  
  /**
  Sets the Results Object.

  @param  resultsObj  Settings object to set
  */
  public void setResultsObj(Results resultsObj) {
    this.resultsObj = resultsObj;
  }
	
    public Dimension getMinimumSize()
    { return new Dimension(chartWidth, chartHeight); }

    public Dimension getPreferredSize()
    { return getMinimumSize(); }

	// Open dialog box
	class OpenAction implements ActionListener {
		public void actionPerformed(ActionEvent ae) {
			//... Open a file dialog.
			int retval = _fileChooser.showSaveDialog(PlotChart.this);
			//recursivelySetFonts(_fileChooser, font);
			if (retval == JFileChooser.APPROVE_OPTION) {
				//... The user selected a file, get it, use it.
				File file = _fileChooser.getSelectedFile();
				// Encode the chart as a graphic of .PNG type
				try {
					logger.info("Saving graphic as " + file);
					JCEncodeComponent.encode (JCEncodeComponent.PNG,chart, file);
				}
				catch (Exception e){
					logger.error("Don't worry,exception has been caught" + e);
					Log.fatal("Cannot save the graphic as " + file + ". Try to save as another file. Otherwise, report a graphics encoding problem.", "#errorPanelText");
    			}
			}
		}
	}

	/**
	Recursively sets fonts for a specific component. This means that the component parts get changed as well that are associated with the component parameter.
	<p>
	@param comp Component to recursively set the font for
	@param font Font settings to set for the component
	*/
	public static void recursivelySetFonts(Component comp, Font font) {
		// Set the font
		comp.setFont(font);

		if (comp instanceof Container) {

			Container cont = (Container) comp;

			for(int j=0, ub=cont.getComponentCount(); j<ub; ++j)
				recursivelySetFonts(cont.getComponent(j), font);
		}
	} // End recursivelySetFonts()

	/**
	Initializes the button to save the chart as a PNG
	*/
	public void initSaveButton() {
		String saveChartImageText = "Save chart as image (PNG)";
		saveButton = new JButton (saveChartImageText);
		saveButton.setAlignmentX(Component.CENTER_ALIGNMENT);
		saveButton.addActionListener(new OpenAction());
		add(saveButton);
		saveButton.setVisible(false);
	}

	/**
	Shows the button to save the chart as a PNG
	*/
	public void showSaveButton() {
		saveButton.setVisible(true);
	}
	
	/**
	Hides the button to save the chart as a PNG
	*/
	public void hideSaveButton() {
		saveButton.setVisible(false);
	}

	// **** Methods used for creating static pre-processed graphics ***
	// Minimilaized available user interaction / User interaction not required
	// to create graphics

	/**
	Makes a chart utilizing the static run method (not used by the web application). This method is called by this classes' main method when this class is ran by the command line or as a cron job.
	<p>
	@param passedXMLString XML formatted String of data to use for the chart.
	*/
	public static void makeStaticChart(String passedXMLString) throws Exception {
		logger.trace("In makeStaticChart");
		// Set chart size to be larger than for the web tool version
		chartWidth  = 1200;
		chartHeight = 900;
		// Set process flag to 0 for non-Applet run
		processFlag = 0;
		JCExitFrame f;
		try {
			f = new JCExitFrame("PlotChart");
		} catch (Exception e) {
			logger.fatal("An X11 DISPLAY is required, but wasn't found. Please run Xvfb instead if you can't set an X11 DISPLAY. See the \"How to Install\" document under $VERIF_HOME/docs for more information");
			throw e;
		}
		contentPane = f.getContentPane();
		contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.Y_AXIS));

		// Create chart
		final PlotChart p = new PlotChart();
		p.makeChart();
		contentPane.add(p);

		//Create button to save chart without data
		JButton bSaveData = new JButton("Save Chart Without Data");
		bSaveData.setAlignmentX(Component.CENTER_ALIGNMENT);
		bSaveData.addActionListener(new ActionListener() {
			// Save the chart options
			public void actionPerformed(ActionEvent e) {
				p.saveChart("output.xml");
			}
		});
		contentPane.add(bSaveData);

		f.pack();
		try {
			staticXmlString = passedXMLString;
			// Overwrite filename
			contentPane.add(p);
			SwingUtilities.invokeLater(new UpdateStaticChart(p));
		}
		catch (Exception e) {
			e.printStackTrace(System.out);
			JLabel l = new JLabel(errorMsg);
			l.setVerticalAlignment(JLabel.TOP);
		}
		// Get ancestor of the plot chart
		Window w = SwingUtilities.getWindowAncestor(p);
		// Remove everything from the window and close application
		w.dispose();
	} // End makeStaticChart()


	/**
	Updates chart with a static method (ie. command line) of running the verification tool. This will also save the chart as a graphic, in the form of a PNG. This method can be altered to save the graphic as other image formats.The file(s) will be saved in the /output directory below the home directory of the verification web tool process. This is relative to the global environment variable that the user had set to run the verification software.
	*/
	public static class UpdateStaticChart implements Runnable {

		protected static PlotChart plotChart;

		UpdateStaticChart(PlotChart plotChart) {
			this.plotChart = plotChart;
		}

		public void run() {
			logger.trace("[PlotChart.class] staticXmlString is : " + staticXmlString);
			plotChart.updateChartData(staticXmlString);
			plotChart.chart.recalc();
			// Pass labels
			plotChart.updateLabels();
			plotChart.chart.recalc();
			plotChart.chart.revalidate();
			// Get the image filename
			if(resultsObj == null) {
				logger.fatal("Results object has not properly been set in the PlotChart object.");
				Log.fatal("Report a results object null issue in plotting the chart. This could result in a blank chart due to inability to set the max properly.", "#errorPanelText");
				System.exit(0);
			}
			if(settingsObj == null) {
				logger.fatal("Settings object has not properly been set in the PlotChart object. Call PlotChart.setSettingsObj(settingsObj) from the initiation code  after the object is properly loaded with data.This could result in problems saving to a file.");
				Log.fatal("Report a settings object null issue in plotting the chart. This could result in problems saving to a file.", "#errorPanelText");
				System.exit(0);
			}
			logger.debug("home dir name : "  + settingsObj.getHomeDir() );
			try {
				fileName = settingsObj.getHomeDir() + "/output/" + FormatLibrary.getImageFileName(settingsObj,resultsObj);
			} catch (Exception e) {
				logger.fatal("Cannot get the graphic file name");
				Log.fatal("Cannot get the graphic file name","#errorPanelText");
				// Eventually this can't be a System.exit(0)
				System.exit(0);
			}
			logger.info("Saving image to " + fileName + " with a size of " + chartWidth + "x" + chartHeight);
			// Try saving the chart to a graph
			try {
				JCEncodeComponent.encode (JCEncodeComponent.PNG,plotChart, new File(fileName));
			}
			catch (Exception ee) {
				ee.printStackTrace();
			}
		}
	}
	/**
	Hides the chart
	*/
	public void hideChart() {
		// Set the chart's visibility to false
		getChart().setVisible(false);
		// Hide the save button
		hideSaveButton();
	}
	/**
	Shows the chart
	*/
	public void showChart() {
		// Set the chart's visibility to true
		getChart().setVisible(true);
		// Show the save button
		showSaveButton();
	}

} // End PlotChart()
