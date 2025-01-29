
-- Create a login for the HR department
CREATE LOGIN HRLogin WITH PASSWORD = 'hr_password2024';
CREATE USER HRUser FOR LOGIN HRLogin;



-- HR Department Privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON Job TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Application TO HRUser;
GRANT SELECT ON Candidate TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Interview TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Complaints TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Blacklist TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Job TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Documents TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON ApplicationDocuments TO HRUser;
GRANT SELECT ON Evaluation TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON BackgroundCheck TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON DrugTest TO HRUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Reservation TO HRUser;
GRANT SELECT ON JobOpenings TO HRUser;
GRANT SELECT ON Onboarding TO HRUser;
GRANT SELECT ON InterviewerFeedback TO HRUser;
GRANT SELECT ON CandidateFeedback TO HRUser;

create role HRDepartment;
ALTER ROLE HRDepartment ADD MEMBER HRUser;






















-- Create a login for the finance department
CREATE LOGIN FinanceLogin WITH PASSWORD = 'finance_password2024';

-- Create a database user for the finance department and grant appropriate privileges
CREATE USER FinanceUser FOR LOGIN FinanceLogin;

-- Finance Department Privileges
GRANT SELECT ON Job TO FinanceUser;
GRANT SELECT ON Application TO FinanceUser;
GRANT SELECT ON Candidate TO FinanceUser;
GRANT SELECT ON Interview TO FinanceUser;
GRANT SELECT, INSERT, UPDATE ON Reimbursement TO FinanceUser;
GRANT SELECT, INSERT, UPDATE ON Receipts TO FinanceUser;
GRANT SELECT, INSERT, UPDATE ON ReceiptDocument TO FinanceUser;
GRANT SELECT, INSERT, UPDATE ON Reservation TO FinanceUser;

create role FinanceDepartment;
ALTER ROLE FinanceDepartment ADD MEMBER FinanceUser;





-- Script to create a database user with admin privileges
CREATE LOGIN AdminUser WITH PASSWORD = 'admin_password2024';
CREATE USER DataBaseAdmin FOR LOGIN AdminUser;

USE finalProject;
GRANT ALL PRIVILEGES TO DataBaseAdmin;


create role DataBaseDepartment;
ALTER ROLE DataBaseDepartment ADD MEMBER DataBaseAdmin;



















-- Create a login for the limited user
CREATE LOGIN LimitedLogin WITH PASSWORD = 'limited_password2024';
-- Create a database user for the limited user and grant limited privileges
CREATE USER Manager FOR LOGIN LimitedLogin;

-- Manager Privileges

GRANT SELECT ON Job TO Manager;
GRANT SELECT ON Application TO Manager;
GRANT SELECT ON Candidate TO Manager;
GRANT SELECT ON Interview TO Manager;
GRANT SELECT ON Evaluation TO Manager;
GRANT SELECT ON JobOpenings TO Manager;
GRANT SELECT ON Onboarding TO Manager;
GRANT SELECT ON Process TO Manager;
GRANT SELECT,UPDATE ON Tests TO Manager;
GRANT SELECT,UPDATE ON TestType TO Manager;
GRANT SELECT,UPDATE ON Rounds TO Manager;





