Create Table EMPLOYEE (
    ID Int Primary Key,
    Fname Varchar(MAX),
    Lname Varchar(MAX),
    Position Varchar(15) default 'Team Member',
    Phone Char(10),
    HoursPerWeek Int,
    Constraint CheckPositionValue Check (Position = 'Team Member' OR Position = 'Supervisor') -- Position can only be TeamMember or Supervisor
);

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


Create Table DEVICE_MODEL (
	PurchaseDate Date Primary Key,
	Make Varchar(20) default 'Apple',
	Model Varchar(30)
);
Insert Into DEVICE_MODEL(PurchaseDate, Model) Values(DATEFROMPARTS(2016, 8, 19), 'IPad Air');
Insert Into DEVICE_MODEL(PurchaseDate, Model) Values(DATEFROMPARTS(2017, 5, 2), 'IPad Mini');
Insert Into DEVICE_MODEL(PurchaseDate, Make, Model) Values(DATEFROMPARTS(2017, 11, 25), 'Samsung', 'Galaxy Tab S2');
Insert Into DEVICE_MODEL(PurchaseDate, Model) Values(DATEFROMPARTS(2018, 4, 20), 'IPad Pro');


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

Create Table DEVICE_RECORD (
	ID Int Primary Key,
	CheckOutTime DateTime,
	ReturnTime DateTime
);

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(0, '20181025 10:34:09 AM', '20181025 11:34:06 PM'); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(1, '20181025 10:00:00 AM', '20181026 5:34:09 PM'); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(2, '20181025 11:00:00 AM', NULL); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(3, '20181024 8:00:00 AM', '20181024 4:30:00 PM'); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(4, '20181024 8:15:44 AM', NULL); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(5, '20181024 6:00:05 AM', '20181024 12:34:01 PM'); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(6, '20181023 10:30:04 AM',NULL); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(7, '20181023 11:45:11 PM', '20181024 9:30:00 AM'); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(8, '20181023 4:30:17 PM', '20181024 12:34:09 AM'); 

Insert Into DEVICE_RECORD(ID, CheckOutTime, ReturnTime) Values(9, '20181023 3:15:00 PM', NULL); 


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

select Device.ID as DeviceID, DEVICE_MODEL.Make, DEVICE_MODEL.Model
from DEVICE_MODEL, DEVICE
where DEVICE_MODEL.PurchaseDate = DEVICE.PurchaseDate 
and device.IsCheckedOut = 0 order by DEVICE_MODEL.PurchaseDate 
