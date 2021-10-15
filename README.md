# CompanyDatabase
Company Database: includes tables, triggers, procedures (cursors), index and various select queries (to extract information from the tables)
Tables used in the database are as follow ...
 - Department
 - Employees
 - Employee Deletion 
 - Employee Names 
In the company database, i mainly used triggers to automate simple task such as
 - counting employees per department (and then updating the departments table)
 - calculating operation cost per department (in this database is assumed as employee salary)
 If any of the data values changed in the future (such as a pay rise for an employee, new employees, employees leaving) - the trigger will update the tables on deletion, update or insert of an employee  
