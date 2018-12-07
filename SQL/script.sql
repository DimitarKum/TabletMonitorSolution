/*
* RELATION EMPLOYEE
* Objective: Stores essential information about each Employee.
* Attributes:
    ID - Unique numeric identifier. When creating a new employee, the next available ID should be used.
    Fname - First name of employee.
    Lname - Last name of employee.
    Position - Employee's position in the company. Position be one of the following values "Team Member", "Supervisor". To add more positions modify the constraint CheckPositionValue.
    Phone - The employee's phone number.
    HoursPerWeek - The calculated quantity of hours per week worked based on the shifts taken by the employee.
*/
Create Table EMPLOYEE (
    ID Int Primary Key,
    Fname Varchar(MAX),
    Lname Varchar(MAX),
    Position Varchar(15) default 'Team Member',
    Phone Char(10),
    HoursPerWeek Int,
    Constraint CheckPositionValue Check (Position = 'Team Member' OR Position = 'Supervisor') -- Position can only be TeamMember or Supervisor
);

/*Sample EMPLOYEE tuples:*/
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(0, 'Anwar', 'Eugenio', 0000000000);
Insert Into EMPLOYEE(ID, Fname, Lname, Position, Phone) Values(1, 'Paula', 'Sheela', 'Supervisor', 1001001011);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(2, 'Aliya', 'Sylvia', 2002002022);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(3, 'Severin', 'Wandal', 3003003033);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(4, 'Cynthia', 'Justine', 4004004044);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(5, 'Naseem', 'Nikita', 5005005055);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(6, 'Sten', 'Mathilde', 6006006066);
Insert Into EMPLOYEE(ID, Fname, Lname, Position, Phone) Values(7, 'Conor', 'Rakesh', 'Supervisor', 7007007077);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(8, 'Jamil', 'Boris', 8008008088);
Insert Into EMPLOYEE(ID, Fname, Lname, Phone) Values(9, 'Ashton', 'Ruth', 9009009099);

/*
* RELATION SHIFT
* Objective: Map a number (ID) to one of the 21 possible shifts that can be worked (i.e. Monday Evening or Wednesday Morning etc.).
* Restrictions: When this relation is created all possible shifts are added to it (the 21 combinations of 7 days and 3 types of shifts) and NO NEW SHIFTS SHOULD BE ADDED TO THIS TABLE.
* Attributes:
    ID - The unique ID of the shift.
    DayOfWeek - The day of the week for this shift. Can be only one of the following values [Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday]
    SType - The type of this shift. Can only be on the following values [Morning, Evening, Graveyard].
*/
Create Table SHIFT (
    ID Int Primary Key,
    DayOfWeek Varchar(9),
    SType Varchar(15),
    Constraint CheckDayOfWeek Check(
        DayOfWeek = 'Monday' OR DayOfWeek = 'Tuesday' OR DayOfWeek = 'Wednesday' OR
        DayOfWeek = 'Thursday' OR DayOfWeek = 'Friday' OR DayOfWeek = 'Saturday' OR
        DayOfWeek = 'Sunday'),
    Constraint CheckSType Check(SType = 'Morning' OR SType = 'Evening' OR SType = 'Graveyard')
);

/*All possible SHIFT tuples. SHIFTS SHOULD NOT BE ADDED BEYOND THESE*/
Insert Into SHIFT(ID, DayOfWeek, SType) Values('0', 'Monday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('1', 'Monday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('2', 'Monday', 'Graveyard');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('3', 'Tuesday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('4', 'Tuesday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('5', 'Tuesday', 'Graveyard');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('6', 'Wednesday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('7', 'Wednesday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('8', 'Wednesday', 'Graveyard');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('9', 'Thursday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('10', 'Thursday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('11', 'Thursday', 'Graveyard');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('12', 'Friday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('13', 'Friday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('14', 'Friday', 'Graveyard');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('15', 'Saturday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('16', 'Saturday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('17', 'Saturday', 'Graveyard');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('18', 'Sunday', 'Morning');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('19', 'Sunday', 'Evening');
Insert Into SHIFT(ID, DayOfWeek, SType) Values('20', 'Sunday', 'Graveyard');


/*
* RELATION WORKS_ON
* Objective: Related an employee to the shift they work on. For example a row with values (1, 5) means that employee with ID 1 works on shift 5, which is the Tuesday Graveyard shift.
* Attributes:
    EmployeeId - The ID of the employee.
    ShiftId - The ID of the shift the employee works on.
*/
Create Table WORKS_ON (
    EmployeeId Int,
    ShiftId Int,
    Primary Key (EmployeeId, ShiftId),
    Foreign Key (EmployeeId) References EMPLOYEE(ID)
        /*Delete all employee shifts is employee is removed.*/
        On Delete Cascade
        /*Update all works_on records to use the new employee ID*/
        On Update Cascade,
    Foreign Key (ShiftId) References SHIFT(ID)
        /*Shifts should not be deleted or modified.*/
        On Delete No Action
        /*Shifts should not be deleted or modified.*/
        On Update No Action
);

/*Sample WORKS_ON tuples:*/
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(0, 0);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(0, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(0, 5);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(1, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(1, 2);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(1, 4);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(1, 9);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(1, 11);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(2, 2);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(2, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(2, 13);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(2, 16);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(3, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(3, 14);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(3, 15);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(4, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(4, 12);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(4, 15);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(5, 0);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(5, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(5, 15);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(6, 1);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(6, 3);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(6, 8);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(6, 11);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(6, 15);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(7, 13);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(7, 14);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(7, 20);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(8, 7);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(8, 17);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(8, 19);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(8, 20);

Insert Into WORKS_ON(EmployeeId, ShiftId) Values(9, 6);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(9, 9);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(9, 10);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(9, 14);
Insert Into WORKS_ON(EmployeeId, ShiftId) Values(9, 18);


/*
* RELATION EMPLOYEE_EMAIL
* Objective: Relate an employee to their email addresses. This relation is used instead of adding email to employee since a single employee can provide multiple email addresses.
* Attributes:
    EmployeeId - The ID of the employee.
    Email - The email address for that employee.
*/
Create Table EMPLOYEE_EMAIL (
    EmployeeId Int,
    Email Varchar(50),
    Primary Key (EmployeeId, Email),
    Foreign Key (EmployeeId) References EMPLOYEE(ID)
        /*Delete all employee email if employee is removed.*/
        On Delete Cascade
        /*Update all employee_email records to use the new employee ID.*/
        On Update Cascade,
    Constraint EmailFormat Check (Email LIKE '%@%.%')
);

/*Sample EMPLOYEE_EMAIL tuples:*/
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(0, 'aneugionio@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(1, 'pasheela@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(2, 'alsylvia@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(3, 'sewandal@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(3, 'sewandal@yahoo.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(4, 'cyjustine@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(4, 'cyjustine@yahoo.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(5, 'nanikite@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(5, 'nanikite@yahoo.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(6, 'stmathilde@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(7, 'corakesh@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(7, 'corakesh@yahoo.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(8, 'jaboris@gmail.com');
Insert Into EMPLOYEE_EMAIL(EmployeeId, Email) Values(9, 'asruth@gmail.com');


/*
* RELATION DEVICE_MODEL
* Objective: Relate a device using its ID to its Make and Model. This relation was created instead of adding attributes to the device for the PurchaseDate, Make and Model since devices are bought in batches on the same date with the same make and model. Since the device's purchase date determines its make and model this table allows us to efficiently store the make and model and only reference it by its purchase date.
* Attributes:
    PurchaseDate - The purchase date for this batch of devices.
    Make - The make of the devices.
    Model - The model of the devices.
*/
Create Table DEVICE_MODEL (
    PurchaseDate Date Primary Key,
    Make Varchar(20) default 'Apple', -- The company mostly uses ipads
    Model Varchar(30)
);
/*Sample DEVICE_MODEL tuples:*/
Insert Into DEVICE_MODEL(PurchaseDate, Model) Values(DATEFROMPARTS(2016, 8, 19), 'IPad Air');
Insert Into DEVICE_MODEL(PurchaseDate, Model) Values(DATEFROMPARTS(2017, 5, 2), 'IPad Mini');
Insert Into DEVICE_MODEL(PurchaseDate, Make, Model) Values(DATEFROMPARTS(2017, 11, 25), 'Samsung', 'Galaxy Tab S2');
Insert Into DEVICE_MODEL(PurchaseDate, Model) Values(DATEFROMPARTS(2018, 4, 20), 'IPad Pro');


/*
* RELATION Device
* Objective: Store information about an individual device that can be checked out and returned by the employees of the company.
* Attributes:
    ID - The unique identifier for the device. When adding a new device, the next available ID should be used.
    IsCheckedOut - Whether this device is currently checked out or not. This determines whether the device can be checked out. This attribute should be modified by the back-end whenever a device is checked out or returned.
    Condition - A written description of device condition - does it have any defects, is a key chipped off, etc.
    PurchaseDate - The purchase date of this device which can be linked to its Make and Model via the DEVICE_MODEL relation.
*/
Create Table DEVICE (
    ID Int Primary Key,
    IsCheckedOut BIT Default 0,
    Condition Varchar(MAX) default 'Good (no defects)',
    PurchaseDate Date,
    Foreign Key (PurchaseDate) References DEVICE_MODEL(PurchaseDate)
        /*Device models should not be deleted.*/
        On Delete No Action
        /*Update all devices to use the updated device model.*/
        On Update Cascade
);

/*Sample DEVICE tuples:*/
Insert Into DEVICE(ID, PurchaseDate) Values(0, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(1, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(2, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(3, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(4, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(5, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(6, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(7, DATEFROMPARTS(2016, 8, 19));
Insert Into DEVICE(ID, PurchaseDate) Values(8, DATEFROMPARTS(2016, 8, 19));

Insert Into DEVICE(ID, PurchaseDate) Values(9, DATEFROMPARTS(2017, 5, 2));
Insert Into DEVICE(ID, PurchaseDate) Values(10, DATEFROMPARTS(2017, 5, 2));
Insert Into DEVICE(ID, PurchaseDate) Values(11, DATEFROMPARTS(2017, 5, 2));
Insert Into DEVICE(ID, PurchaseDate) Values(12, DATEFROMPARTS(2017, 5, 2));
Insert Into DEVICE(ID, PurchaseDate) Values(13, DATEFROMPARTS(2017, 5, 2));

Insert Into DEVICE(ID, PurchaseDate) Values(14, DATEFROMPARTS(2017, 11, 25));
Insert Into DEVICE(ID, PurchaseDate) Values(15, DATEFROMPARTS(2017, 11, 25));
Insert Into DEVICE(ID, PurchaseDate) Values(16, DATEFROMPARTS(2017, 11, 25));
Insert Into DEVICE(ID, PurchaseDate) Values(17, DATEFROMPARTS(2017, 11, 25));
Insert Into DEVICE(ID, PurchaseDate) Values(18, DATEFROMPARTS(2017, 11, 25));
Insert Into DEVICE(ID, PurchaseDate) Values(19, DATEFROMPARTS(2017, 11, 25));
Insert Into DEVICE(ID, PurchaseDate) Values(20, DATEFROMPARTS(2017, 11, 25));

Insert Into DEVICE(ID, PurchaseDate) Values(21, DATEFROMPARTS(2018, 4, 20));
Insert Into DEVICE(ID, PurchaseDate) Values(22, DATEFROMPARTS(2018, 4, 20));
Insert Into DEVICE(ID, PurchaseDate) Values(23, DATEFROMPARTS(2018, 4, 20));



/*
* RELATION DEVICE_RECORD
* Objective: Store the record for a device being checked out and possibly returned. The device record only contains information about the check out and return time, i.e. a session or a log. In order to find the device id or the employee ID use DEVICE_HANDLE.
* Attributes:
    ID - The unique identifier for this device record. When creating a new device record, the next available ID should be used.
    CheckOutTime - The datetime at which a device was checked out.
    ReturnTime - The datetime at which a device was returned after usage. When this attribute is null this signifies that the device has not been returned yet and is still being used.
*/
Create Table DEVICE_RECORD (
    ID Int Primary Key,
    CheckOutTime DateTime,
    ReturnTime DateTime
);

/*Sample DEVICE_RECORD tuples:*/
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(0, '20181025 10:34:09 AM', '20181025 11:34:06 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(1, '20181025 10:00:00 AM', '20181026 5:34:09 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(2, '20181025 11:00:00 AM', '20181026 5:30:00 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(3, '20181024 8:00:00 AM', '20181024 4:30:00 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(4, '20181024 8:15:44 AM', '20181024 6:34:19 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(5, '20181024 6:00:05 AM', '20181024 12:34:01 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(6, '20181023 10:30:04 AM', '20181023 11:59:39 PM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(7, '20181023 11:45:11 PM', '20181024 9:30:00 AM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(8, '20181023 4:30:17 PM', '20181024 12:34:09 AM'); 
Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(9, '20181023 3:15:00 PM', '20181024 12:01:07 AM'); 

/*
* RELATION DEVICE_HANDLE
* Objective: Identify each usage of a device by an employee. This table links together EMPLOYEE, DEVICE and DEVICE_RECORD. Each row signifies a single usage of a device. In order to find out when the devices was checked out and possibly returned see relation DEVICE_RECORD.
* Attributes:
    EmployeeId - The id of the empoyee that used the device.
    DeviceId - The id of the device being used by the employee.
    DeviceRecordId - The id of the device record which can be used to identify when the device was checked out and possibly returned (see relation DEVICE_RECORD).
*/
Create Table DEVICE_HANDLE (
    EmployeeId Int,
    DeviceId Int,
    DeviceRecordId Int primary key,
    Foreign Key (EmployeeId) References EMPLOYEE(ID)
        /*Delete all employee device_handle records if employee is removed.*/
        On Delete Cascade
        /*Update all device_handle records to use the new employee ID.*/
        On Update Cascade,
    Foreign Key (DeviceId) References DEVICE(ID)
        /*Delete all employee device_handle records if device is removed.*/
        On Delete Cascade
        /*Update all device_handle records to use the new device ID.*/
        On Update Cascade,
    Foreign Key (DeviceRecordId) References DEVICE_RECORD(ID)
        /*Delete all employee device_handle records if a device_record is removed.*/
        On Delete Cascade
        /*Update all device_handle records to use the new device_record ID.*/
        On Update Cascade,
);

/*Sample DEVICE_HANDLE tuples:*/
Insert Into DEVICE_HANDLE Values (0, 23, 9);
Insert Into DEVICE_HANDLE Values (1, 22, 8);
Insert Into DEVICE_HANDLE Values (2, 21, 7);
Insert Into DEVICE_HANDLE Values (3, 19, 6);
Insert Into DEVICE_HANDLE Values (4, 13, 5);
Insert Into DEVICE_HANDLE Values (5, 0, 4);
Insert Into DEVICE_HANDLE Values (6, 3, 3);
Insert Into DEVICE_HANDLE Values (7, 16, 2);
Insert Into DEVICE_HANDLE Values (8, 19, 1);
Insert Into DEVICE_HANDLE Values (9, 14, 0);