-- Insert sample data into ApplicationStatus table
INSERT INTO ApplicationStatus (StatusID, ApplicationStatus) VALUES
(1, 'Submitted'),
(2, 'Under Review'),
(3, 'Interview Scheduled'),
(4, 'Hired'),
(5, 'Rejected');

-- Insert sample data into Candidate table
INSERT INTO Candidate (CandidateID, Name, Email, Phone, ShortProfile) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', 'Experienced professional in the IT industry.'),
(2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', 'Recent graduate seeking entry-level position.'),
(3, 'Michael Johnson', 'michael.johnson@example.com', '456-789-0123', 'Skilled developer with expertise in web technologies.'),
(4, 'Emily Brown', 'emily.brown@example.com', '789-012-3456', 'Marketing enthusiast with a passion for digital campaigns.'),
(5, 'David Wilson', 'david.wilson@example.com', '321-654-9870', 'Experienced project manager with a proven track record.');

-- Insert sample data into JobPlatform table
INSERT INTO JobPlatform (PlatformID, PlatformName, Description) VALUES
(1, 'LinkedIn', 'Professional networking platform.'),
(2, 'Handshake', 'College recruiting platform.'),
(3, 'Indeed', 'Job search engine.'),
(4, 'Glassdoor', 'Company reviews and job search platform.'),
(5, 'Monster', 'Job search and career advice platform.');

-- Insert sample data into Job table
INSERT INTO Job (JobID, Title, Description, Type, Category, PlatformID, StartDate, NumberOfPositions) VALUES
(1, 'Software Engineer', 'Develop software applications using modern technologies.', 'Full-time', 'Software Development', 1, '2024-04-01', 5),
(2, 'Marketing Specialist', 'Create and execute marketing campaigns to promote products.', 'Full-time', 'Marketing', 2, '2024-04-15', 3),
(3, 'Data Analyst', 'Analyze data to provide insights and support decision-making processes.', 'Full-time', 'Data Analytics', 3, '2024-05-01', 2),
(4, 'Graphic Designer', 'Design visual content for various marketing materials and campaigns.', 'Full-time', 'Design', 4, '2024-05-15', 2),
(5, 'Customer Support Representative', 'Provide assistance and support to customers via phone, email, and chat.', 'Full-time', 'Customer Service', 5, '2024-06-01', 3);

-- Insert sample data into JobOpenings table
INSERT INTO JobOpenings (OpeningID, JobID, NumberOfPositions, StatusID, OpeningDate) VALUES
(1, 1, 3, 1, '2024-04-01'),
(2, 1, 2, 1, '2024-04-01'),
(3, 2, 1, 1, '2024-04-15'),
(4, 3, 1, 1, '2024-05-01'),
(5, 4, 1, 1, '2024-05-15');

-- Insert sample data into Application table
INSERT INTO Application (ApplicationID, CandidateID, OpeningID, DateApplied, Experience, Education, StatusID) VALUES
(1, 1, 1, '2024-04-05', '5 years of experience in software development.', 'Bachelor''s Degree in Computer Science', 3),
(2, 2, 2, '2024-04-10', 'Fresh graduate with internship experience.', 'Bachelor''s Degree in Marketing', 3),
(3, 3, 3, '2024-04-20', '3 years of experience in data analysis.', 'Bachelor''s Degree in Statistics', 3),
(4, 4, 4, '2024-05-05', 'Proficient in Adobe Creative Suite.', 'Bachelor''s Degree in Graphic Design', 3),
(5, 5, 5, '2024-06-10', 'Experience in customer service roles.', 'High School Diploma', 3);

-- Insert sample data into ApplicationStatusChange table
INSERT INTO ApplicationStatusChange (ApplicationStatusChangedID, ApplicationID, StatusID, StatusChanged) VALUES
(1, 1, 4, '2024-04-20'),
(2, 2, 4, '2024-04-25'),
(3, 3, 4, '2024-05-10'),
(4, 4, 4, '2024-05-20'),
(5, 5, 4, '2024-06-15');


--1
go

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

select * from CandidateJobApplicationDetails;

--2
go







-- View to show the count of job openings per job category
CREATE VIEW JobCategoryCount AS
SELECT j.Category, COUNT(jo.JobID) AS NumberOfOpenings
FROM Job j
LEFT JOIN JobOpenings jo ON j.JobID = jo.JobID
GROUP BY j.Category;






go
select * from JobCategoryCount;




go
INSERT INTO InterviewType (InterviewTypeID, Type) VALUES
(1, 'Onsite'),
(2, 'Online');

INSERT INTO Interviewer (InterviewerID, Name, Department, Title) VALUES
(1, 'Alice Johnson', 'Human Resources', 'HR Manager'),
(2, 'Bob Smith', 'Technical', 'Senior Software Engineer'),
(3, 'Charlie Brown', 'Marketing', 'Marketing Director'),
(4, 'Diana Martinez', 'Data Analysis', 'Data Analyst'),
(5, 'Eleanor Wilson', 'Customer Service', 'Customer Support Manager');

-- Insert dummy data into Process table
INSERT INTO Process (ProcessID, ProcessName, Description) VALUES
(1, 'Recruitment Process', 'Standard recruitment process including screening, interviews, and evaluations'),
(2, 'Onboarding Process', 'Process for welcoming and integrating new hires into the organization');

-- Insert dummy data into Rounds table
INSERT INTO Rounds (RoundID, RoundName) VALUES
(1, 'Screening Round'),
(2, 'Technical Interview Round'),
(3, 'HR Interview Round'),
(4, 'Managerial Interview Round'),
(5, 'Final Interview Round');

-- Insert dummy data into ProcessRounds table
INSERT INTO ProcessRounds (ProcessRoundID, ProcessID, RoundID, RoundNumber) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 1, 3, 3),
(4, 1, 4, 4),
(5, 1, 5, 5);

INSERT INTO Interview (InterviewID, ApplicationID, InterviewerID, InterviewTypeID, StartTime, EndTime, ProcessID) VALUES
(1, 1, 1, 1, '2024-04-20 09:00:00', '2024-04-20 10:00:00', 1),
(2, 2, 2, 2, '2024-04-25 10:00:00', '2024-04-25 11:00:00', 2),
(3, 3, 3, 1, '2024-05-02 09:30:00', '2024-05-02 10:30:00', 1),
(4, 4, 4, 2, '2024-05-05 11:00:00', '2024-05-05 12:00:00', 2),
(5, 5, 5, 1, '2024-05-12 10:30:00', '2024-05-12 11:30:00', 1);




go

-- View 3: View to display interview details along with candidate information
CREATE VIEW InterviewDetails AS
SELECT i.InterviewID, i.ApplicationID, i.InterviewerID, i.InterviewTypeID, i.StartTime, i.EndTime,
       c.Name AS CandidateName, c.Email AS CandidateEmail, c.Phone AS CandidatePhone
FROM Interview i
JOIN Application a ON i.ApplicationID = a.ApplicationID
JOIN Candidate c ON a.CandidateID = c.CandidateID;


go

select * from InterviewDetails;














--4
go

INSERT INTO Complaints (ComplaintID, CandidateID, ComplaintDescription, ComplaintStatus, InvestigationFindings) VALUES
(1, 1, 'Candidate showed unprofessional behavior during interview.', 'Open', 'Pending investigation'),
(2, 2, 'Candidate was late for interview without prior notice.', 'Open', 'Pending investigation'),
(3, 3, 'Candidate provided false information on resume.', 'Open', 'Pending investigation'),
(4, 4, 'Candidate was disrespectful towards interviewers.', 'Open', 'Pending investigation'),
(5, 5, 'Candidate failed to attend scheduled interview.', 'Open', 'Pending investigation');
go
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

go

select * from ComplaintsDetails;

go















