
-- triggers

--1

CREATE TRIGGER IncreaseJobOpeningsAfterBlacklist
ON Blacklist
AFTER INSERT
AS
BEGIN
    -- Update the JobOpenings table to increase the number of positions for the corresponding job
    UPDATE JobOpenings
    SET NumberOfPositions = NumberOfPositions + 1
    FROM JobOpenings jo
    INNER JOIN inserted i ON jo.OpeningID = i.OpeningID; 
END;


--before trigger
select * from JobOpenings where openingId=3;


Insert into Blacklist values(3,'Bad Behaviour',3)

--after trigger

select * from JobOpenings where openingId=3;









--2
go

CREATE TRIGGER DecreaseJobOpeningsAfterHiring
ON ApplicationStatusChange
AFTER INSERT
AS
BEGIN
    -- Update the JobOpenings table to decrease the number of positions for the corresponding job
    UPDATE JobOpenings
    SET NumberOfPositions = NumberOfPositions - 1
    FROM JobOpenings jo
    INNER JOIN ApplicationStatusChange asc ON jo.OpeningID = (SELECT OpeningID FROM inserted WHERE StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Hired'));
END;

go

CREATE TRIGGER ChangeStatusToHired
ON JobOpenings
AFTER UPDATE
AS
BEGIN
    -- Update the Application table to change the status of candidates on-call to Hired
    UPDATE Application
    SET StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Hired')
    WHERE OpeningID IN (SELECT OpeningID FROM inserted)
    AND StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'On-call for next job opportunity')
    AND EXISTS (
        SELECT 1 FROM JobOpenings jo WHERE jo.OpeningID = Application.OpeningID AND jo.NumberOfPositions > 0
    );
END;



select A.candidateId,ASS.ApplicationStatus from Application A join ApplicationStatus ASS on  A.StatusID=ASS.StatusID 
where ASS.ApplicationStatus='Hired';


update Application set StatusID=(Select StatusID from ApplicationStatus where ApplicationStatus='On-call for next job opportunity') where CandidateID=2;

update JobOpenings set NumberOfPositions=3 where openingId=2;







go

--4

CREATE TRIGGER UpdateStatusToWaitlist
ON Complaints
AFTER INSERT
AS
BEGIN
    -- Update the Application table to change the status to "Waitlist" for the corresponding candidate
    UPDATE Application
    SET StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Waitlist')
    WHERE CandidateID IN (SELECT CandidateID FROM inserted);
END;











select A.candidateId,ASS.ApplicationStatus from Application A join ApplicationStatus ASS on  A.StatusID=ASS.StatusID where ASS.ApplicationStatus='Waitlist';
select * from Complaints where CandidateID=2;







Insert into ApplicationStatus values (11,'waitlist')
Insert into Complaints values (6,2,'Biased Interview',null,null)










---5
go

CREATE TRIGGER DeclinedOfferTrigger
ON Application
AFTER UPDATE
AS
BEGIN
    -- Check if the status has been updated to indicate offer decline
    IF (SELECT StatusID FROM inserted) = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Declined')
    BEGIN
        -- Update the candidate's status to "on-call for next job opportunity"
        UPDATE Application
        SET StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'On-call for next job opportunity')
        WHERE CandidateID IN (SELECT CandidateID FROM inserted);
    END
END;
--6
go
CREATE TRIGGER BlacklistCandidateOnNoShowTrigger
ON Application
AFTER UPDATE 
AS
BEGIN
    IF (SELECT StatusID FROM inserted) = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Didn''t show up') 
       AND (SELECT StatusID FROM deleted) = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'OnBoarded')
    BEGIN
        INSERT INTO Blacklist (CandidateID, BlacklistReason, OpeningID)
        SELECT i.CandidateID, 'Candidate didn''t show up', i.OpeningID
        FROM inserted i;
    END;
END;



Insert into ApplicationStatus values(12,'Didn''t show up')
select * from Application
---before trigger

select * from Blacklist where CandidateID=3;

--modification to initiate the trigger
update Application set StatusID=(SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'OnBoarded') where CandidateID=3;

update Application set StatusID=(SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Didn''t show up') where CandidateID=3;

--after trigger

select * from Blacklist where CandidateID=3;