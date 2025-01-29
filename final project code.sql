use finalProject

-- Job_Platform Table
CREATE TABLE JobPlatform (
    PlatformID INT PRIMARY KEY,
    PlatformName VARCHAR(100) NOT NULL,
    Description VARCHAR(MAX)
);

-- Job Table
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Description VARCHAR(MAX),
    Type VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    PlatformID INT,
    StartDate DATE NOT NULL,
    NumberOfPositions INT NOT NULL,
    FOREIGN KEY (PlatformID) REFERENCES JobPlatform(PlatformID)
);

-- ApplicationStatus Table
CREATE TABLE ApplicationStatus (
    StatusID INT PRIMARY KEY,
    ApplicationStatus VARCHAR(100) NOT NULL
);

-- JobOpenings Table
CREATE TABLE JobOpenings (
    OpeningID INT PRIMARY KEY,
    JobID INT NOT NULL,
    NumberOfPositions INT NOT NULL,
    StatusID INT NOT NULL,
    OpeningDate DATE NOT NULL,
    FOREIGN KEY (JobID) REFERENCES Job(JobID),
    FOREIGN KEY (StatusID) REFERENCES ApplicationStatus(StatusID)
);
-- Candidate Table
CREATE TABLE Candidate (
    CandidateID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    ShortProfile VARCHAR(MAX)
);

-- Application Table
CREATE TABLE Application (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    OpeningID INT NOT NULL,
    DateApplied DATE NOT NULL,
    Experience VARCHAR(MAX),
    Education VARCHAR(MAX),
    StatusID INT NOT NULL,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (OpeningID) REFERENCES JobOpenings(OpeningID),
    FOREIGN KEY (StatusID) REFERENCES ApplicationStatus(StatusID)
);



-- Documents Table
CREATE TABLE Documents (
    DocumentID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    DocumentType VARCHAR(50) NOT NULL,
    DocumentPath VARCHAR(MAX) NOT NULL,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

-- Interviewer Table
CREATE TABLE Interviewer (
    InterviewerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    Title VARCHAR(100)
);

-- InterviewType Table
CREATE TABLE InterviewType (
    InterviewTypeID INT PRIMARY KEY,
    Type VARCHAR(50) NOT NULL
);

-- Process Table
CREATE TABLE Process (
    ProcessID INT PRIMARY KEY,
    ProcessName VARCHAR(100) NOT NULL,
    Description VARCHAR(MAX)
);

-- Interview Table
CREATE TABLE Interview (
    InterviewID INT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    InterviewerID INT NOT NULL,
    InterviewTypeID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    ProcessID INT NOT NULL,
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewer(InterviewerID),
    FOREIGN KEY (InterviewTypeID) REFERENCES InterviewType(InterviewTypeID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);

-- Rounds Table
CREATE TABLE Rounds (
    RoundID INT PRIMARY KEY,
    RoundName VARCHAR(100) NOT NULL
);

-- ProcessRounds Table
CREATE TABLE ProcessRounds (
    ProcessRoundID INT PRIMARY KEY,
    ProcessID INT NOT NULL,
    RoundID INT NOT NULL,
    RoundNumber INT NOT NULL,
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
    FOREIGN KEY (RoundID) REFERENCES Rounds(RoundID)
);



-- BackgroundCheck Table
CREATE TABLE BackgroundCheck (
    CheckID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    CriminalBackground VARCHAR(MAX),
    EmploymentHistory VARCHAR(MAX),
    Status VARCHAR(20),
    CheckDate DATETIME NOT NULL,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

-- DrugTest Table
CREATE TABLE DrugTest (
    TestID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    TestType VARCHAR(50),
    TestDate DATETIME NOT NULL,
    Result VARCHAR(20),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

-- Evaluation Table
CREATE TABLE Evaluation (
    EvaluationID INT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    Notes VARCHAR(MAX),
    Result VARCHAR(20),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

-- Onboarding Table
CREATE TABLE Onboarding (
    OnboardingID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    JobID INT NOT NULL,
    StartDate DATE NOT NULL,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- FeedbackType Table
CREATE TABLE FeedbackType (
    FeedbackTypeID INT PRIMARY KEY,
    Type VARCHAR(50) NOT NULL
);

-- CandidateFeedback Table
CREATE TABLE CandidateFeedback (
    CandidateFeedbackID INT PRIMARY KEY,
    CandidateFeedback VARCHAR(100),
    FeedbackTypeID INT NOT NULL,
    ApplicationID INT NOT NULL,
    CandidateID INT NOT NULL,
    FeedbackDate DATE NOT NULL,
    InterviewID INT NOT NULL,
    FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID),
    FOREIGN KEY (FeedbackTypeID) REFERENCES FeedbackType(FeedbackTypeID)
);

-- InterviewerFeedback Table
CREATE TABLE InterviewerFeedback (
    InterviewerFeedbackID INT PRIMARY KEY,
    InterviewerFeedback VARCHAR(100),
    ApplicationID INT NOT NULL,
    FeedbackTypeID INT NOT NULL,
    InterviewerID INT NOT NULL,
    FeedbackDate DATE NOT NULL,
    InterviewID INT NOT NULL,
    FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID),
    FOREIGN KEY (FeedbackTypeID) REFERENCES FeedbackType(FeedbackTypeID)
);

-- Complaints Table
CREATE TABLE Complaints (
    ComplaintID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    ComplaintDescription VARCHAR(MAX),
    ComplaintStatus VARCHAR(50),
    InvestigationFindings VARCHAR(MAX),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

-- Blacklist Table
CREATE TABLE Blacklist (
    BlacklistID INT PRIMARY KEY IDENTITY(1,1),
    CandidateID INT NOT NULL,
    BlacklistReason VARCHAR(100),
	OpeningID INT NOT NULL,
    CONSTRAINT FK_Blacklist_CandidateID FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
	FOREIGN KEY (OpeningID) REFERENCES JobOpenings(OpeningID)
);

-- ApplicationStatusChange Table
CREATE TABLE ApplicationStatusChange (
    ApplicationStatusChangedID INT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    StatusID INT NOT NULL,
    StatusChanged DATE NOT NULL,
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    FOREIGN KEY (StatusID) REFERENCES ApplicationStatus(StatusID)
);



-- ApplicationDocuments Table
CREATE TABLE ApplicationDocuments (
    ApplicationDocumentID INT PRIMARY KEY,
    DocumentID INT NOT NULL,
    ApplicationID INT NOT NULL,
    FOREIGN KEY (DocumentID) REFERENCES Documents(DocumentID),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

-- Receipts Table
CREATE TABLE Receipts (
    ReceiptID INT PRIMARY KEY,
    CandidateID INT NOT NULL,
    ApplicationID INT NOT NULL,
    InterviewID INT NOT NULL,
    ExpenseType VARCHAR(100),
    ExpenseAmount MONEY,
    IsReimbursementValid BIT,
    ReimbursementAmount MONEY,
    CONSTRAINT FK_Receipts_CandidateID FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    CONSTRAINT FK_Receipts_ApplicationID FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    CONSTRAINT FK_Receipts_InterviewID FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID)
);

-- ReceiptDocument Table
CREATE TABLE ReceiptDocument (
    ReceiptDocumentID INT PRIMARY KEY,
    ReceiptID INT NOT NULL,
    DocumentURL VARCHAR(255),
    CONSTRAINT FK_ReceiptDocument_ReceiptID FOREIGN KEY (ReceiptID) REFERENCES Receipts(ReceiptID)
);

-- Reimbursement Table
CREATE TABLE Reimbursement (
    ReimbursementID INT PRIMARY KEY,
    ApplicationID INT NOT NULL,
    ReceiptID INT NOT NULL,
    Request VARCHAR(MAX),
    Processed VARCHAR(20),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    FOREIGN KEY (ReceiptID) REFERENCES Receipts(ReceiptID)
);

-- Reservation Table
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    InterviewID INT NOT NULL,
    CandidateID INT NOT NULL,
    ReservationDetails VARCHAR(255),
    CONSTRAINT FK_Reservation_InterviewID FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID),
    CONSTRAINT FK_Reservation_CandidateID FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

