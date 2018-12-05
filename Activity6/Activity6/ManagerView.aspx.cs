using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LogIn : System.Web.UI.Page
{
    private SqlConnection getSqlConnection()
    {
        string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection sc = new SqlConnection(connString);

        sc.Open();

        return sc;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}