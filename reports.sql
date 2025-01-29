
WITH CandidateStatusCount AS (
    SELECT 
        A.StatusID,
        COUNT(C.CandidateID) AS TotalCandidates
    FROM 
        Application A
    INNER JOIN 
        Candidate C ON A.CandidateID = C.CandidateID
    GROUP BY 
        A.StatusID
)
SELECT 
    AC.StatusID,
    AC.TotalCandidates,
    AS1.ApplicationStatus
FROM 
    CandidateStatusCount AC
INNER JOIN 
    ApplicationStatus AS1 ON AC.StatusID = AS1.StatusID;





SELECT 
    C.CandidateID,
    C.Name,
    B.BlacklistReason
FROM 
    Candidate C
INNER JOIN 
    Blacklist B ON C.CandidateID = B.CandidateID;



WITH AverageEvaluation AS (
    SELECT 
        CandidateID,
        AVG(CAST(Result AS INT)) AS AvgRating
    FROM 
        Evaluation
    GROUP BY 
        CandidateID
)
SELECT 
    C.Name,
    AE.AvgRating
FROM 
    Candidate C
INNER JOIN 
    AverageEvaluation AE ON C.CandidateID = AE.CandidateID;




SELECT 
    J.JobID,
    J.Title
FROM 
    Job J
LEFT JOIN 
    Application A ON J.JobID = A.OpeningID
WHERE 
    A.ApplicationID IS NULL;



WITH ReimbursementReport AS (
    SELECT 
        R.ReimbursementID,
        C.Name AS CandidateName,
        J.Title AS JobTitle,
        RD.DocumentURL AS ReceiptDocumentURL,
        RC.ExpenseType,
        RC.ExpenseAmount,
        RC.IsReimbursementValid,
        RC.ReimbursementAmount
    FROM 
        Reimbursement R
    INNER JOIN 
        Application A ON R.ApplicationID = A.ApplicationID
	INNER JOIN 
        Receipts RC ON RC.CandidateID = R.ReceiptID
    INNER JOIN 
        Candidate C ON A.CandidateID = C.CandidateID
    INNER JOIN 
        Job J ON A.OpeningID = J.JobID
    LEFT JOIN 
        ReceiptDocument RD ON R.ReceiptID = RD.ReceiptID
)
SELECT 
    *
FROM 
    ReimbursementReport;



WITH FailedDrugTestCandidates AS (
    SELECT 
        C.CandidateID,
        C.Name,
        D.TestDate,
        D.TestType,
        D.Result
    FROM 
        Candidate AS C
    INNER JOIN 
        DrugTest AS D ON C.CandidateID = D.CandidateID
    WHERE 
        D.Result = 'Failed'
)
SELECT 
    CandidateID,
    Name,
    TestDate,
    TestType
FROM 
    FailedDrugTestCandidates;

