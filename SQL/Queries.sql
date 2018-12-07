/*
* The following are all the queries used throughout our website.
* Many of these queries are parametrized using C# so they return results or perform updates for a specific employee, device, etc.. Parameters inside of queries will be indicated by {0}, {1}, {2}, etc. These are placeholders that are filled by our back-end as needed.
*/

/* QUERY 1
* Objective: Check if an employee exists using an employee id.
* Arguments:
    {0} - employee id
* Used In: LogIn.aspx during loging in to determine whether the employee exists.
*/
Select *
From Employee
Where Employee.Id = {0};

/* QUERY 2
* Objective: Look up employee position based on the employee id.
* Arguments:
    {0} - employee id
* Used In: LogIn.aspx to determine whether the employee is a Team Member or Manager and redirect them to the appropriate web page.
*/
Select Employee.Position
From Employee
Where Employee.Id = {0};

/* QUERY 3
* Objective: Determine the employee's last name.
* Arguments:
    {0} - employee id
* Used In: UserView_CheckOut.aspx, UserView_Return.aspx and ManagerView.aspx to display the name of thelogged in employee in a welcome message.
*/ 
Select Employee.Lname
From Employee
Where Employee.Id = {0};

/* QUERY 4
* Objective: Determine if employee has checked out a device (if so which device) given an employee id.
* Arguments:
    {0} - employee id
* Used In: LogIn.aspx to determine whether the employee has checked out a tablet already. This is used to decide if the employee should be redirected to UserView_CheckOut.aspx or UserView_Return.aspx.
*/ 
Select Device_Handle.DeviceId, Device_Record.CheckOutTime
From Device_Handle, Device_Record
Where {0} = Device_Handle.EmployeeId AND
    Device_Handle.DeviceRecordId = Device_Record.Id AND
    Device_Record.ReturnTime IS NULL;


/* QUERY 5 (multiple queries, but treated as a single transaction)
* Objective: Check out a device by an employee. This involves inserting rows and making chnages in several relations.
* Arguments:
    {0} - the next available device record id, which is calculated by adding one to the first query
    {1} - the current date/time formated as yyyyMMdd HH:mm:ss tt (tt is AM/PM)
    {2} - the ID of the employee checking out the device
    {3} - the ID of the device being checked out
* Used In: UserView_CheckOut.aspx to check out the chosen device by the logged in user.
*/ 
{0} = (Select MAX(ID) From Device_Record; + 1)

Insert Into Device_Record(ID, CheckOutTime, ReturnTime)
Values({0}, {1}, NULL);
Insert Into Device_Handle
Values ({2}, {3}, {0});
Update Device
Set IsCheckedOut = 1
Where Device.ID = {3};


/* QUERY 6
* Objective: Determine information for the device checked out by an employee as a single attribute.
* Arguments:
    {0} - employee id
* Used In: UserView_Return.aspx to show the device ID, make and model on the page so the user knows which device they would be returning.
*/
Select Coalesce(STR(Device.Id), Device_Model.Make, Device_Model.Model, '') as DeviceIdMakeModel
From Device_Handle, Device_Record, DEVICE, Device_Model
Where {0} = Device_Handle.EmployeeId AND
    Device_Handle.DeviceRecordId = Device_Record.Id AND
    Device_Record.ReturnTime IS NULL AND
    Device.Id = Device_Handle.DeviceId AND
    Device_Model.PurchaseDate = Device.PurchaseDate;

/* QUERY 7
* Objective: Determine the id of the device checked out by an employee.
* Arguments:
    {0} - employee id
* Used In: UserView_Return.aspx to find the id of the device that the user is returning which is used to update the necessery relations. (see QUERY 9)
*/
Select Device.Id
From Device_Handle, Device_Record, DEVICE, Device_Model
Where {0} = Device_Handle.EmployeeId AND
    Device_Handle.DeviceRecordId = Device_Record.Id AND
    Device_Record.ReturnTime IS NULL AND
    Device.Id = Device_Handle.DeviceId AND
    Device_Model.PurchaseDate = Device.PurchaseDate;

/* QUERY 8
* Objective: Determine the device record id for the device record containing information for the device currently checked out by an employee.
* Arguments:
    {0} - employee id
* Used In: UserView_Return.aspx to find out the device record id, since that record needs to be updated. This is needed since the return time in the device record needs to be set to the current time date. (see QUERY 9)
*/
Select Device_Record.Id
From Device_Handle, Device_Record, DEVICE, Device_Model
Where {0} = Device_Handle.EmployeeId AND
    Device_Handle.DeviceRecordId = Device_Record.Id AND
    Device_Record.ReturnTime IS NULL AND
    Device.Id = Device_Handle.DeviceId AND
    Device_Model.PurchaseDate = Device.PurchaseDate;


/* QUERY 9 (multiple queries, but treated as a single transaction)
* Objective: Return a device that was previously checked out by an employee.
* Arguments:
    {0} - the ID of the device being returned. (see QUERY 7)
    {1} - the device record ID corresponding to this device being checked out by this employee. (see QUERY 8)
    {2} - the current date/time formated as yyyyMMdd HH:mm:ss tt (tt is AM/PM).
* Used In: UserView_CheckOut.aspx to return the device currently checked out by the logged in employee.
*/ 
Update Device
Set IsCheckedOut = 0
Where Device.Id = {0};
Update Device_Record
Set ReturnTime = {2}
Where Device_Record.Id = {1};

/* QUERY 10
* Objective: Show all device records, including the ID of the device being checked out, the name, id and phone of the employee checking out the device, the time the device was checked out and returned (or empty if still checked out). Additionally, results are sorted by check out time in order to show the most recent device usages first.
* Arguments: None
* Used In: ManagerView.aspx to display all device records for the manager to inspect and potentially contact employees that have not returned their devices.
*/ 
Select Device_Handle.DeviceId, EMPLOYEE.Fname, EMPLOYEE.Lname,
    Employee.Phone as PhoneNumber, EMPLOYEE.Id as EmployeeID,
    Device_Record.CheckOutTime, Device_Record.ReturnTime
From EMPLOYEE, Device_Handle, Device_Record
Where Device_Record.Id = Device_Handle.DeviceRecordId AND
    EMPLOYEE.Id = Device_Handle.EmployeeId
Order By Device_Record.CheckOutTime DESC;

/* QUERY 11
* Objective: Show the device id and also the device id, make and model as a single attribute for all devices that can be checked out.
* Arguments: None
* Used In: UserView_CheckOut.aspx to display a menu with all devices that are available for check out. The ID, make, model need to be shown as a single attribute due to a limitation of Visual Studio's menu to only be capable of displaying a single attribute from the query results.
*/ 
Select Device.Id,
    Coalesce(STR(Device.Id), Device_Model.Make, Device_Model.Model, '') as DeviceIdMakeModel
From Device_Model, DEVICE
Where Device_Model.PurchaseDate = Device.PurchaseDate 
    AND Device.IsCheckedOut = 0
Order By Device_Model.PurchaseDate;