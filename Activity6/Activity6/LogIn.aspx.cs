using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LogIn : System.Web.UI.Page
{
    static string loged_employee_id = "";
    const string SQL_QUERY_EMPLOYEE_CHECKEDOUT_DEVICES =
        "Select DEVICE_HANDLE.DeviceId, DEVICE_RECORD.CheckOutTime\n" +
        "From DEVICE_HANDLE, DEVICE_RECORD\n" +
        "Where {0} = DEVICE_HANDLE.EmployeeId AND\n" +
        "DEVICE_HANDLE.DeviceRecordId = DEVICE_RECORD.ID AND\n" +
        "DEVICE_RECORD.ReturnTime IS NULL;";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private SqlConnection getSqlConnection() {
        string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection sc = new SqlConnection(connString);

        sc.Open();

        return sc;
    }

    protected void LogInButton_Click(object sender, EventArgs e)
    {
        ErrorLabel.Visible = false;
        SqlConnection sc = getSqlConnection();
        try
        {
            string employeeId = InputUsername.Text;
            int result;
            if (!int.TryParse(employeeId, out result))
            {
                ErrorLabel.Text = "Employee id must be a number! (but \"" + employeeId + "\" found.)";
                ErrorLabel.Visible = true;
                return;
            }

            SqlCommand com =
                new SqlCommand(
                    "Select Employee.Position From Employee Where Employee.Id = " + employeeId + ";",
                    sc);
            //com.Parameters.AddWithValue("@MessageId", 1); //Replace 1 with messageid you want to get
            Object o = com.ExecuteScalar();
            if (o != null)
            {
                string employeePosition = o.ToString();
                if (employeePosition == "Team Member")
                {
                    if (hasEmployeeCheckedOutDevice(sc, employeeId))
                    {
                        loged_employee_id = employeeId;
                        Response.Redirect("UserView_Return.aspx?empId=" + employeeId);
                    }
                    else {
                        loged_employee_id = employeeId;
                        Response.Redirect("UserView_CheckOut.aspx?empId=" + employeeId);
                    }
                }
                else if (employeePosition == "Supervisor")
                {
                    loged_employee_id = employeeId;
                    Response.Redirect("ManagerView.aspx?empId=" + employeeId);
                }
            }
            else
            {
                ErrorLabel.Text = "No employee found with Employee ID: " + employeeId;
                ErrorLabel.Visible = true;
                return;
            }
        }
        finally {
            sc.Close();
        }
    }

    private Boolean hasEmployeeCheckedOutDevice(SqlConnection sc, string employeeId) {
        Object temp = new SqlCommand(
            String.Format(SQL_QUERY_EMPLOYEE_CHECKEDOUT_DEVICES, employeeId), sc).ExecuteScalar();
        if (temp != null) {
            System.Diagnostics.Debug.WriteLine(temp.ToString());
        }
        return temp != null;
    }
}