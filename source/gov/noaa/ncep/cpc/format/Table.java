package gov.noaa.ncep.cpc.format;

/**
Constructs a table object (This class has not been completed yet). This contains various attributes that a table would have. 
*/
public class Table {

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
	private String chartName;
	private String[] dataPointLabel;

	// End Declare variables
	//---------------------------------------------------------------------------

	//---------------------------------------------------------------------------
	// Constructor(s)
	// Adds attributes to the Chart object
	//---------------------------------------------------------------------------
	public Table(String chartName, String[] dataPointLabel) {
		// Add the passed parameters(attributes) of values to the created chart object
		this.chartName = chartName;
		this.dataPointLabel = dataPointLabel;
	}

	//---------------------------------------------------------------------------
	//  Get Methods 
	//---------------------------------------------------------------------------
	// Get methods can be used to obtain the values of the attributes of the
	// chart object
	public String getTableName() {
		return chartName;
	}

	public String[] getDataPointLabel() {
		return dataPointLabel;
	}

	public String getDataPointLabel(int index) {
		return dataPointLabel[index];
	}
	//---------------------------------------------------------------------------
	//  Set Methods 
	//---------------------------------------------------------------------------
		// Set methods can be used if an overloaded method is called by a program
	// that does not pass these attributes or these attributes are changed
	public void setTableName(String chartName) {
		this.chartName = chartName;
	}

	public void setDataPointLabel(String[] dataPointLabel) {
		this.dataPointLabel = dataPointLabel;
	}

	// End get/set methods
	//---------------------------------------------------------------------------

	// toString method to print out values or attributes
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(" {Chart Details --");
		sb.append("Chart Name: " + getTableName());

		return sb.toString();
	}

} // End Chart.java

