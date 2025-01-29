--1

CREATE TRIGGER IncreaseJobOpeningsAfterBlacklist
ON Blacklist
AFTER INSERT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Update the JobOpenings table to increase the number of positions for the corresponding job
    UPDATE JobOpenings WITH (TABLOCKX) -- Apply an exclusive lock on the JobOpenings table
    SET NumberOfPositions = NumberOfPositions + 1
    FROM JobOpenings jo
    INNER JOIN inserted i ON jo.OpeningID = i.OpeningID; -- Assuming Blacklist table contains OpeningID

    COMMIT TRANSACTION;
END;




Select * from JobOpenings where OpeningId=2;


















 BEGIN TRANSACTION;
    -- Update the JobOpenings table to increase the number of positions for the corresponding job
    UPDATE JobOpenings WITH (TABLOCKX) -- Apply an exclusive lock on the JobOpenings table
    SET NumberOfPositions = NumberOfPositions + 1
    where OpeningID=2
 COMMIT TRANSACTION;

 










--2
go

CREATE TRIGGER DecreaseJobOpeningsAfterHiring
ON ApplicationStatusChange
AFTER INSERT
AS
BEGIN
    -- Update the JobOpenings table to decrease the number of positions for the corresponding job
    BEGIN TRANSACTION;
    UPDATE JobOpenings
    WITH (TABLOCKX) -- Applying lock
    SET NumberOfPositions = NumberOfPositions - 1
    FROM JobOpenings jo
    INNER JOIN ApplicationStatusChange ac ON jo.OpeningID = (SELECT OpeningID FROM inserted WHERE StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Hired'));
    COMMIT TRANSACTION;
END;












    -- Update the JobOpenings table to decrease the number of positions for the corresponding job
    BEGIN TRANSACTION;
    UPDATE JobOpenings
    WITH (TABLOCKX) -- Applying lock
    SET NumberOfPositions = NumberOfPositions - 1
    FROM JobOpenings WHERE OpeningID = 2;
    COMMIT TRANSACTION;










Select * from JobOpenings where OpeningId=2;















--3
BEGIN TRAN;

DECLARE @CandidateID INT;

SELECT @CandidateID = CandidateID
FROM Candidate
WHERE Name = 'Jane Smith';

INSERT INTO DrugTest (CandidateID, TestType, TestDate, Result)
VALUES (@CandidateID, 'Blood Test', GETDATE(), 'Positive');

COMMIT TRAN;

--4

BEGIN TRANSACTION

INSERT INTO Job
    (JobID,Title, Description, Type, Category, PlatformID, StartDate, NumberOfPositions)
VALUES
    (6,'Nurse', 'Registered Nurse Internship Program', 'Full-time', 'Healthcare Providers', 4, '2024-05-01', 5);

COMMIT TRANSACTION












SELECT * FROM Job where JobID=6;





BEGIN TRANSACTION;

UPDATE Reimbursement
SET Amount = rc.ReimbursementAmount
FROM Reimbursement r
JOIN Receipts rc ON r.ReceiptID = rc.ReceiptID
WHERE rc.IsReimbursementValid = 1;

UPDATE Reimbursement
SET Processed = 
    CASE 
        WHEN Amount = rc.ExpenseAmount THEN 'Processed'
        WHEN Amount < rc.ExpenseAmount THEN 'Partially'
        ELSE 'Pending'
    END
FROM Reimbursement r
JOIN Receipts rc ON r.ReceiptID = rc.ReceiptID;

COMMIT TRANSACTION;








-- Additional data for Receipts table
INSERT INTO Receipts (ReceiptID, CandidateID, ApplicationID, InterviewID, ExpenseType, ExpenseAmount, IsReimbursementValid, ReimbursementAmount)
VALUES
    (1, 1, 1, 1, 'Transportation', 50.00, 1, 50.00),
    (2, 2, 2, 2, 'Lodging', 150.00, 0, 100.00),
    (3, 3, 3, 3, 'Meals', 80.00, 1, 70),
    (4, 4, 4, 4, 'Miscellaneous', 25.00, 0, 25.00),
    (5, 5, 5, 5, 'Travel', 120.00, 1, 120.00);

-- Additional data for ReceiptDocument table
INSERT INTO ReceiptDocument (ReceiptDocumentID, ReceiptID, DocumentURL)
VALUES
    (1, 1, 'https://example.com/document4.pdf'),
    (2, 2, 'https://example.com/document5.pdf'),
    (3, 3, 'https://example.com/document6.pdf'),
    (4, 4, 'https://example.com/document7.pdf'),
    (5, 5, 'https://example.com/document8.pdf');

-- Additional data for Reimbursement table
INSERT INTO Reimbursement (ReimbursementID, ApplicationID, ReceiptID, Request)
VALUES
    (1, 1, 1, 'Transportation reimbursement request'),
    (2, 2, 2, 'Lodging reimbursement request'),
    (3, 3, 3, 'Meals reimbursement request'),
    (4, 4, 4, 'Miscellaneous reimbursement request'),
    (5, 5, 5, 'Travel reimbursement request');


select * from Reimbursement;



