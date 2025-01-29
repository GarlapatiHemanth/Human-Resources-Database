--views

--1

CREATE VIEW CandidateJobApplicationDetails AS
SELECT 
    A.ApplicationID,
    A.CandidateID,
    C.Name AS CandidateName,
    C.Email AS CandidateEmail,
    C.Phone AS CandidatePhone,
    AO.OpeningID,
    J.Title AS JobTitle,
    J.Description AS JobDescription  
FROM 
    Application A
INNER JOIN 
    Candidate C ON A.CandidateID = C.CandidateID
INNER JOIN 
    ApplicationStatusChange AC ON A.ApplicationID = AC.ApplicationID
INNER JOIN 
    JobOpenings AO ON A.OpeningID = AO.OpeningID
INNER JOIN 
    Job J ON AO.JobID = J.JobID
WHERE 
    AC.StatusID = (SELECT StatusID FROM ApplicationStatus WHERE ApplicationStatus = 'Hired');

--2
go

-- View to show the count of job openings per job category
CREATE VIEW JobCategoryCount AS
SELECT j.Category, COUNT(jo.JobID) AS NumberOfOpenings
FROM Job j
LEFT JOIN JobOpenings jo ON j.JobID = jo.JobID
GROUP BY j.Category;

go
-- View 3: View to display interview details along with candidate information
CREATE VIEW InterviewDetails AS
SELECT i.InterviewID, i.ApplicationID, i.InterviewerID, i.InterviewTypeID, i.StartTime, i.EndTime,
       c.Name AS CandidateName, c.Email AS CandidateEmail, c.Phone AS CandidatePhone
FROM Interview i
JOIN Application a ON i.ApplicationID = a.ApplicationID
JOIN Candidate c ON a.CandidateID = c.CandidateID;

go
--4


CREATE VIEW ComplaintsDetails AS
SELECT 
    C.ComplaintID,
    C.CandidateID,
    CD.Name AS CandidateName,
    CD.Email AS CandidateEmail,
    CD.Phone AS CandidatePhone,
    C.ComplaintDescription,
    C.ComplaintStatus,
    C.InvestigationFindings,
    I.InterviewID,
    I.StartTime AS InterviewStartTime,
    I.EndTime AS InterviewEndTime
FROM 
    Complaints C
INNER JOIN 
    Candidate CD ON C.CandidateID = CD.CandidateID
INNER JOIN
	Application A on A.CandidateID=CD.CandidateID
LEFT JOIN 
    Interview I on A.ApplicationID= I.ApplicationID;










