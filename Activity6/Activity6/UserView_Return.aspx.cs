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
        LblCheckedOutDevice.Text = "";
        logedInemployeeId = Request.QueryString["empId"];
        LblWelcomeMessage.Text = "Welcome " + getEmployeeName();


        String checkedOutDevice = getCheckedOutDeviceInfo();
        LblCheckedOutDevice.Text = "You have checked out device: " + checkedOutDevice;
    }

    private string getCheckedOutDeviceInfo()
    {
        if (logedInemployeeId == null || logedInemployeeId == "") return "";
        string query =
            string.Format("Select Coalesce(\n" +
            "STR(DEVICE.ID) + ', ' + Device_MODEL.Make + ', '\n" +
            "+ DEVICE_MODEL.Model, '') as DeviceIdMakeModel\n" +
        "From DEVICE_HANDLE, DEVICE_RECORD, DEVICE, DEVICE_MODEL\n" +
        "Where {0} = DEVICE_HANDLE.EmployeeId AND\n" +
            "DEVICE_HANDLE.DeviceRecordId = DEVICE_RECORD.ID AND\n" +
            "DEVICE_RECORD.ReturnTime IS NULL AND\n" +
            "DEVICE.ID = DEVICE_HANDLE.DeviceId AND\n" +
            "DEVICE_MODEL.PurchaseDate = DEVICE.PurchaseDate;\n", logedInemployeeId);

        SqlConnection sc = getSqlConnection();

        try
        {
            SqlCommand sqlCmd = new SqlCommand(query, sc);
            Object o = sqlCmd.ExecuteScalar();
            if (o != null)
            {
                return o.ToString();
            }
        }
        finally { sc.Close(); }
        return "";

    }

    private string getCheckedOutDeviceId()
    {
        if (logedInemployeeId == null || logedInemployeeId == "") return "";
        string query =
            string.Format("Select Device.ID\n" +
        "From DEVICE_HANDLE, DEVICE_RECORD, DEVICE, DEVICE_MODEL\n" +
        "Where {0} = DEVICE_HANDLE.EmployeeId AND\n" +
            "DEVICE_HANDLE.DeviceRecordId = DEVICE_RECORD.ID AND\n" +
            "DEVICE_RECORD.ReturnTime IS NULL AND\n" +
            "DEVICE.ID = DEVICE_HANDLE.DeviceId AND\n" +
            "DEVICE_MODEL.PurchaseDate = DEVICE.PurchaseDate;\n", logedInemployeeId);
        System.Diagnostics.Debug.WriteLine(query);

        SqlConnection sc = getSqlConnection();

        try
        {
            SqlCommand sqlCmd = new SqlCommand(query, sc);
            Object o = sqlCmd.ExecuteScalar();
            if (o != null)
            {
                return o.ToString();
            }
        }
        finally { sc.Close(); }
        return "";

    }


    private string getCheckedOutDeviceRecordId()
    {
        if (logedInemployeeId == null || logedInemployeeId == "") return "";
        string query =
            string.Format("Select DEVICE_RECORD.ID\n" +
        "From DEVICE_HANDLE, DEVICE_RECORD, DEVICE, DEVICE_MODEL\n" +
        "Where {0} = DEVICE_HANDLE.EmployeeId AND\n" +
            "DEVICE_HANDLE.DeviceRecordId = DEVICE_RECORD.ID AND\n" +
            "DEVICE_RECORD.ReturnTime IS NULL AND\n" +
            "DEVICE.ID = DEVICE_HANDLE.DeviceId AND\n" +
            "DEVICE_MODEL.PurchaseDate = DEVICE.PurchaseDate;\n", logedInemployeeId);

        System.Diagnostics.Debug.WriteLine(query);
        SqlConnection sc = getSqlConnection();

        try
        {
            SqlCommand sqlCmd = new SqlCommand(query, sc);
            Object o = sqlCmd.ExecuteScalar();
            if (o != null)
            {
                return o.ToString();
            }
        }
        finally { sc.Close(); }
        return "";

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
            string checkedOutDeviceId = getCheckedOutDeviceId();
            string checkedOutDeviceRecordId = getCheckedOutDeviceRecordId();
            string dateTimeStr = DateTime.Now.ToString("yyyyMMdd HH:mm:ss tt");

            string updateQuery1 = "Update Device SET IsCheckedOut = 0 WHERE Device.ID = " + checkedOutDeviceId + ";\n";
            string updateQuery2 = "Update DEVICE_RECORD\n" +
                "SET ReturnTime = '" + dateTimeStr + "' WHERE DEVICE_RECORD.ID = " + checkedOutDeviceRecordId + ";";

            string transactQuery = updateQuery1 + updateQuery2;
            System.Diagnostics.Debug.WriteLine(transactQuery);
            SqlCommand updateCmd = new SqlCommand(transactQuery, sc);
            updateCmd.ExecuteNonQuery();

            Response.Redirect("UserView_CheckOut.aspx?empId=" + logedInemployeeId);

        }
        finally
        {
            sc.Close();

        }
    }
}