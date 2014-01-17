package gov.noaa.ncep.cpc.format;

/**
Constructs a chart object. This contains the various attributes that a chart would have, specifically charts that can be plotted by JClass.
*/
public class Chart {

//---------------------------------------------------------------------------
// Attributes/settings of Chart
// --------------------------------------------------------------------------
// - $attribute type    <XML label>  variableType(how var is passed to Chart)
// - chart data name  <chart-data name>  String
// - data point label <data-point-label> String[]
//
//---------------------------------------------------------------------------

	//---------------------------------------------------------------------------
	// Declare variables - content types
	//---------------------------------------------------------------------------
	private String chartName; // Title label for legend
	private String[] intXdataValuesArray; // Consecutive integer values as x-axis data holders for timeseries, not used in plots but assigned to <x-data>
	private String[] referenceArray; // Series of x axis reference values for labeling dates or probability bins. All timeseries score data also uses these values for plotting (all timeseries scores share same x values). Reliability diagram also uses these values for plotting the diagonal reference line.
	private String[][][] xdataScoreArray; // Series of x axis values unique to each score used for plotting a reliability diagram (each reliability score uses unique x values).
	private String[][][] scoreArray; //  Scores for each model, category, and day/location
	private String[] fcstSourceArray; // Forecast source(s)
	private String categoryType;      // category type from settings obj
	private String scoreType;         // score type from settings obj
	// End Declare variables
	//---------------------------------------------------------------------------

	/**
	Constructor(s) for JCLass timeseries chart formatted object.
	<p>
	@param chartName String of name of the chart
	@param intXdataValuesArray String array of consecutive integer values used as x-axis data holders for timeseries, not used in plots but assigned to <x-data>.
	@param referenceArray String array of x axis reference values for labeling dates. All timeseries score data also uses these values for plotting (all timeseries scores share same x values). 
	@param scoreArray String array of score values.
	@param fcstSourceArray String array of forecast sources.
	@param categoryType String of the category type.
	@param scoreType String of the score type.
	*/
	public Chart(String chartName, String[] intXdataValuesArray, String[] referenceArray, String[][][] scoreArray, String[] fcstSourceArray, String categoryType, String scoreType) {
		// Add the passed parameters(attributes) of values to the created chart object
		this.chartName = chartName;
		this.intXdataValuesArray = intXdataValuesArray;
		this.referenceArray = referenceArray;
		this.scoreArray = scoreArray;
		this.fcstSourceArray =fcstSourceArray;
		this.categoryType = categoryType;
		this.scoreType = scoreType;
	}

	/**
	Constructor(s) for JCLass reliability chart formatted object.
	<p>
	@param chartName String of name of the chart
	@param referenceArray String array of x axis reference values for labeling probability bins. Reliability diagram also uses these values for plotting the diagonal reference line.
	@param xdataScoreArray Series of x axis values unique to each score used for plotting a reliability diagram (each reliability score uses unique x values).
	@param scoreArray String array of score values.
	@param fcstSourceArray String array of forecast sources.
	@param categoryType String of the category type.
	@param scoreType String of the score type.
	*/
	public Chart(String chartName, String[] referenceArray, String[][][]xdataScoreArray, String[][][] scoreArray, String[] fcstSourceArray, String categoryType, String scoreType) {
		// Add the passed parameters(attributes) of values to the created chart object
		this.chartName = chartName;
		this.referenceArray = referenceArray;
		this.xdataScoreArray = xdataScoreArray;
		this.scoreArray = scoreArray;
		this.fcstSourceArray =fcstSourceArray;
		this.categoryType = categoryType;
		this.scoreType = scoreType;
	}

        /**
        Constructor(s) for JCLass chart formatted object.
		Don't think this is used since it does not have all the arguments.
        <p>
        @param chartName String of name of the chart
        @param intXdataValuesArray String array of values associated with the x-axis.
        @param referenceArray String array of x axis reference values.
        @param scoreArray String array of score values.
        @param fcstSourceArray String array of forecast sources.
			<p>Note : Currently FormatLibrary.java is responsible for creating the Chart object, different methods create different charts.
        */
        public Chart(String chartName, String[] intXdataValuesArray, String[] referenceArray, String[][][] scoreArray, String[] fcstSourceArray) {
                // Add the passed parameters(attributes) of values to the created chart object
                this.chartName = chartName;
                this.intXdataValuesArray = intXdataValuesArray;
                this.referenceArray = referenceArray;
                this.scoreArray = scoreArray;
                this.fcstSourceArray =fcstSourceArray;
        }

	//---------------------------------------------------------------------------
	//  Get Methods 
	//
	// Get methods can be used to obtain the values of the attributes of the
	// chart object
	//---------------------------------------------------------------------------

	// Chart name
	public String getChartName() {
		return chartName;
	}

	// integer x-data labels (these are assigned integer dummy x-axis values)
	public String[] getIntXdataValuesArray() {
		return intXdataValuesArray;
	}

	// Date or probability bin values
	public String[] getChartReferenceArray() {
		return referenceArray;
	}

	// x Data values for reliability diagram
	public String[][][] getXdataScoreArray() {
		return xdataScoreArray;
	}

	// y Data values
	public String[][][] getScoreArray() {
		return scoreArray;
	}

	// Forecast source values
	public String[] getFcstSourceArray() {
		return fcstSourceArray;
	}

    // Category type          
    public String getCategoryType() {
    	return categoryType;
    }

	// Score Type
	public String getScoreType() {
		return scoreType;
	}


	//---------------------------------------------------------------------------
	//  Set Methods 
	//---------------------------------------------------------------------------
		// Set methods can be used if an overloaded method is called by a program
	// that does not pass these attributes or these attributes are changed
	public void setChartName(String chartName) {
		this.chartName = chartName;
	}

	public void setIntXdataValuesArray(String[] intXdataValuesArray) {
		this.intXdataValuesArray = intXdataValuesArray;
	}

	public void setReferenceArray(String[] referenceArray) {
		this.referenceArray = referenceArray;
	}

    public void setXdataScoreArray(String[][][] xdataScoreArray) {
		this.xdataScoreArray = xdataScoreArray;
    }	

	public void setScoreArray(String[][][] scoreArray) {
		this.scoreArray = scoreArray;
	}

	public void setFcstSourceArray(String[] fcstSourceArray) {
		this.fcstSourceArray = fcstSourceArray;
	}

    public void setCategoryType(String categoryType) {
    	this.categoryType = categoryType;
    }

	public void setScoreType(String scoreType) {
		this.categoryType = categoryType;
	}

	// End get/set methods
	//---------------------------------------------------------------------------

	// toString method to print out values or attributes
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(" {Chart Details --");
		sb.append("Chart Name: " + getChartName());

		return sb.toString();
	}

} // End Chart.java

