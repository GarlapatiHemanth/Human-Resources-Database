
-- Define a function named JobsByCategory that retrieves jobs based on a specified category
CREATE FUNCTION JobsByCategory
    (@Category VARCHAR(50))  -- Input parameter: Category of jobs to filter
RETURNS TABLE
AS
RETURN
(
    -- Return a table containing job details filtered by the provided category
    SELECT J.Title, J.Description, J.Type, J.StartDate, J.NumberOfPositions
    FROM Job AS J
    WHERE J.Category = @Category  -- Filter jobs based on the provided category
);



go

SELECT * FROM JobsByCategory('Design');










--2
go

-- Define a SQL function named JobDetailsFunc
CREATE FUNCTION JobDetailsFunc
    (@Title VARCHAR(200))  -- Declare a parameter for the job title
RETURNS TABLE
AS
RETURN
(
    -- Return a table containing job details
    SELECT O.StartDate, C.Name, J.Title
    FROM Onboarding AS O
    JOIN Job AS J ON O.JobID = J.JobID
    JOIN Candidate AS C ON O.CandidateID = C.CandidateID
    WHERE J.Title = @Title  -- Filter the results by the specified job title
);

select * from JobDetailsFunc('Data Analyst');








INSERT INTO Onboarding (OnboardingID,CandidateID, JobID, StartDate)
VALUES 
    (1,2, 3, '2024-05-05')
     















--3
--Retrieves a list of candidates who have completed a specific number of interviews.
go

CREATE FUNCTION GetInterviewedCandidatesFunction
    (@NumberOfInterviews INT)
RETURNS TABLE
AS
RETURN
(
    SELECT C.CandidateID, C.Name AS CandidateName
    FROM Candidate C
    JOIN Application A ON C.CandidateID = A.CandidateID
    GROUP BY C.CandidateID, C.Name
    HAVING COUNT(DISTINCT A.OpeningID) >= @NumberOfInterviews
);





--Retrieves feedback provided by interviewers for a specific candidate's interview.
go

CREATE FUNCTION GetInterviewerFeedbackFunction (@CandidateID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT IFeed.InterviewerFeedback
    FROM InterviewerFeedback IFeed
    JOIN Interview I ON IFeed.InterviewID = I.InterviewID
    JOIN Candidate C ON  C.CandidateID=(select CandidateID from Application where ApplicationID=I.ApplicationID)
    WHERE C.CandidateID = @CandidateID
);

select * from GetInterviewerFeedbackFunction(2);




INSERT INTO FeedbackType (FeedbackTypeID, Type)
VALUES
(1, 'General'),
(2, 'Performance'),
(3, 'Behavioral');

INSERT INTO InterviewerFeedback (InterviewerFeedbackID,InterviewerFeedback, ApplicationID, FeedbackTypeID, InterviewerID, FeedbackDate, InterviewID)
VALUES (1,'Good Coder', 2, 2, 2, '2024-04-30', 2);











CREATE FUNCTION GetCandidateDetailsFromBlacklist (@CandidateID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT B.CandidateID, C.Name AS CandidateName, C.Email AS CandidateEmail, C.Phone AS CandidatePhone,
           B.BlacklistReason
    FROM Blacklist B
    JOIN Candidate C ON B.CandidateID = C.CandidateID
    WHERE B.CandidateID = @CandidateID
);


select * from GetCandidateDetailsFromBlacklist(1);






