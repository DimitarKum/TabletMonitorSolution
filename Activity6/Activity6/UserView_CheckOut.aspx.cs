using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LogIn : System.Web.UI.Page
{
    string logedInemployeeId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        logedInemployeeId = Request.QueryString["empId"];
        LblWelcomeMessage.Text = "Welcome " + getEmployeeName();
    }

    public string getEmployeeName()
    {
        SqlConnection sc = getSqlConnection();
        try
        {
            if (logedInemployeeId == null || logedInemployeeId == "") return "";
            string sqlQuery = "Select Employee.Lname From Employee Where Employee.Id = " + logedInemployeeId + ";";
            System.Diagnostics.Debug.WriteLine(sqlQuery);
            SqlCommand com = new SqlCommand(sqlQuery, sc);
            //com.Parameters.AddWithValue("@MessageId", 1); //Replace 1 with messageid you want to get
            Object o = com.ExecuteScalar();
            if (o != null)
            {
                return o.ToString();
            }
        }
        finally
        {
            sc.Close();

        }
        return "";
    }

    private SqlConnection getSqlConnection()
    {
        string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection sc = new SqlConnection(connString);

        sc.Open();

        return sc;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (logedInemployeeId == null || logedInemployeeId == "") return;
        SqlConnection sc = getSqlConnection();
        try
        {
            string dateTimeStr = DateTime.Now.ToString("yyyyMMdd HH:mm:ss tt");
            System.Diagnostics.Debug.WriteLine(dateTimeStr);
            string newDeviceRecordId = string.Format("{0}", (getLastDeviceRecordId() + 1));
            string deviceId = DrpListAvailableDevices.SelectedValue;

            string updateQuery1 = "Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(" + newDeviceRecordId + ", '" + dateTimeStr + "', NULL);";
            string updateQuery2 = "Insert Into DEVICE_HANDLE Values ("+ logedInemployeeId + ", "+ deviceId + ", "+ newDeviceRecordId + ");";
            string updateQuery3 = "Update Device SET IsCheckedOut = 1 WHERE Device.ID = " + deviceId + ";";


            string transactQuery = updateQuery1 + updateQuery2 + updateQuery3;
            System.Diagnostics.Debug.WriteLine(transactQuery);
            SqlCommand updateCmd = new SqlCommand(transactQuery, sc);
            updateCmd.ExecuteNonQuery();

            Response.Redirect("UserView_Return.aspx?empId=" + logedInemployeeId);
        }
        finally
        {
            sc.Close();
        }
    }

    private int getLastDeviceRecordId() {
        SqlConnection sc = getSqlConnection();
        try {
            Object o = new SqlCommand("Select MAX(ID) from DEVICE_RECORD;", sc).ExecuteScalar();
            if (o != null) {
                string strRepresentation = o.ToString();
                int deviceRecordId = int.Parse(strRepresentation);
                return deviceRecordId;
            }
        }finally { sc.Close(); }
        return -1;
    }
}