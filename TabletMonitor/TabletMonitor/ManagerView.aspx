<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManagerView.aspx.cs" Inherits="LogIn" %>

<!DOCTYPE html>



<html>
    <head>

    </head>
   <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="ManagerView.css">
  
    <title>TabletMonitor | DeviceReport</title>
    <body>
      
  <!-- Menu  -->

  <div class="container">
        
   <nav class="navbar navbar-expand-lg navbar-light bg-info ">

    <a class="navbar-brand" href="./LogIn.aspx"><img src="logo.jpg" alt="Tablet Monitor logo" width="27%" height="27%" class="logo"a></a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent" >
      <ul class="navbar-nav ml-auto">
         <li >
          <a class="nav-link" href="./LogIn.aspx">|Log Out|</a>
        </li>
  
      </ul>
    
    </div>
    </nav>
</div>

<!-- End menu -->
         <style>
            .tableView {
                width: 90%;

            }
            h1 {
                text-align: center;
                font-weight: 700;
            }
            
        </style>
        <br/>
        <h1>Device Report</h1> 
            <br/>
        <form runat="server" class="tableView">
            
            
        <asp:GridView ID="GridView1" runat="server"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                AllowPaging="True" PageSize="8" DataKeyNames="EmployeeID">
                <Columns>
                    <asp:BoundField DataField="DeviceId" HeaderText="DeviceId" SortExpression="DeviceId" />
                    <asp:BoundField DataField="Fname" HeaderText="Fname" SortExpression="Fname" />
                    <asp:BoundField DataField="Lname" HeaderText="Lname" SortExpression="Lname" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" />
                    <asp:BoundField DataField="EmployeeID" HeaderText="EmployeeID" SortExpression="EmployeeID" ReadOnly="True" />
                    <asp:BoundField DataField="CheckOutTime" HeaderText="CheckOutTime" SortExpression="CheckOutTime" />
                    <asp:BoundField DataField="ReturnTime" HeaderText="ReturnTime" SortExpression="ReturnTime" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select DEVICE_HANDLE.DeviceId, EMPLOYEE.Fname, EMPLOYEE.Lname,
	Employee.Phone as PhoneNumber, EMPLOYEE.ID As EmployeeID,
	DEVICE_RECORD.CheckOutTime, DEVICE_RECORD.ReturnTime
From EMPLOYEE, DEVICE_HANDLE, DEVICE_RECORD
Where DEVICE_RECORD.ID = DEVICE_HANDLE.DeviceRecordId AND
	EMPLOYEE.ID = DEVICE_HANDLE.EmployeeId
Order By DEVICE_RECORD.CheckOutTime DESC;"></asp:SqlDataSource>
            <br/>
            </form>

    </body>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</html>