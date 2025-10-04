CREATE DATABASE LinkedInResults;
USE LinkedInResults;
CREATE TABLE LinkedInUser (
    UserID INT PRIMARY KEY,
    CurrentRole VARCHAR(100),
    FirstName VARCHAR(100),
    MiddleName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE
);
CREATE TABLE connects (
    UserID1 INT,
    UserID2 INT,
    DateConnected DATE,
    ConnectionStatus VARCHAR(100),
    PRIMARY KEY (UserID1, UserID2),
    FOREIGN KEY (UserID1) REFERENCES LinkedInUser(UserID),
    FOREIGN KEY (UserID2) REFERENCES LinkedInUser(UserID)
);
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    Industry VARCHAR(100),
    Location VARCHAR(100)
);
CREATE TABLE Employee (
    UserID INT,
    CompanyID INT,
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (UserID, CompanyID),
    FOREIGN KEY (UserID) REFERENCES LinkedInUser(UserID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);
CREATE TABLE Job (
   JobID INT PRIMARY KEY,
   JobName VARCHAR(100)
);
CREATE TABLE List (
   CompanyID INT,
   JobID INT,
   PostDate DATE,
   PRIMARY KEY (CompanyID, JobID),
   FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
   FOREIGN KEY (JobID) REFERENCES Job(JobID)
);
CREATE TABLE Work (
   UserID INT,
   JobID INT,
   PRIMARY KEY (UserID, JobID),
   FOREIGN KEY (UserID) REFERENCES LinkedInUser(UserID),
   FOREIGN KEY (JobID) REFERENCES Job(JobID)
);
CREATE TABLE Experience (
   UserID INT,
   Role VARCHAR(100),
   Company VARCHAR(100),
   StartDate DATE,
   EndDate DATE,
   PRIMARY KEY (UserID, Role),
   FOREIGN KEY (UserID) REFERENCES LinkedInUser(UserID)
);
CREATE TABLE Post (
   PostID INT PRIMARY KEY,
   UserID INT,
   CompanyID INT,
   PostTime DATETIME,
   Image TEXT,
   Caption TEXT,
   FOREIGN KEY (UserID) REFERENCES LinkedInUser(UserID),
   FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);
CREATE TABLE creates (
   UserID INT,
   PostID INT,
   PRIMARY KEY (UserID, PostID),
   FOREIGN KEY (UserID) REFERENCES LinkedInUser(UserID),
   FOREIGN KEY (PostID) REFERENCES Post(PostID)
);
CREATE TABLE posts (
   CompanyID INT,
   PostID INT,
   PRIMARY KEY (CompanyID, PostID),
   FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
   FOREIGN KEY (PostID) REFERENCES Post(PostID)
);
CREATE TABLE Comment (
   PostID INT,
   Text VARCHAR(100),
   PostTime DATETIME,
   PRIMARY KEY (PostID, Text),
   FOREIGN KEY (PostID) REFERENCES Post(PostID)
);
INSERT INTO LinkedInUser VALUES
(1, 'Software Engineer', 'Adam', 'Samson', 'Nguyen', '2001-02-24'),
(2, 'Data Analyst', 'Ben', 'James', 'Smith', '1988-06-13'),
(3, 'Actor', 'Chris', 'Smith', 'Hanson', '1988-08-08'),
(4, 'Banker', 'Devon', 'Grace', 'Hendryx', '1999-09-09'),
(5, 'Accountant', 'Earl', 'Paige', 'Hill', '2002-10-10'),
(6, 'Audio Engineer', 'Anita', 'Michael', 'Stewart', '1978-05-23'),
(7, 'Substitute Teacher', 'Thomas', 'Michelle', 'Green', '2001-10-24'),
(8, 'Educational Administrator', 'Christopher', 'Mary', 'Page', '1964-07-21'),
(9, 'Surgeon', 'Tristan', 'Mikayla', 'Sanchez', '1986-08-09'),
(10, 'Biomedical Scientist', 'James', 'Ashley', 'Allen', '1974-03-04'),
(11, 'Speech and Language Therapist', 'Seth', 'Christopher', 'Flores', '1999-01-15'),
(12, 'Software Engineer', 'Daniel', 'Andrea', 'Mann', '2001-09-23'),
(13, 'K-5 Teacher', 'Lisa', 'Amber', 'Maynard', '2001-09-18'),
(14, 'Theatre Manager', 'Keith', 'Christopher', 'Yates', '1986-01-19'),
(15, 'Teaching Laboratory Technician', 'John', 'Ivan', 'Underwood', '1966-09-20');


INSERT INTO Company VALUES
(1, 'Alliance Inc.', 'Software', 'Chicago'),
(2, 'Myers, Thornton and Hill', 'Banking', 'Evanston'),
(3, 'The Renegade Theatre', 'Performance Arts', 'Skokie'),
(4, 'Chill Vibez Studio', 'Audio', 'Oklahoma City'),
(5, 'Indiana Zoo', 'Zoology', 'Indianapolis'),
(6, 'Devon Corp.', 'Software', 'Iowa City'),
(7, 'Enhance AI', 'Software', 'Chicago'),
(8, 'Fort Data Co.', 'Data Analytics', 'Skokie'),
(9, 'Brown ELementary School', 'Education', 'Barrington'),
(10, 'Lincoln High School', 'Education', 'Toronto'),
(11, 'King, Carlson and Ramos', 'Banking', 'San Francisco'),
(12, 'Jerusalem Hospital', 'Public Health', 'Jerusalem'),
(13, 'MyBusiness', 'E-commerce', 'San Antonio'),
(14, 'New Age Corp.', 'Software', 'Dallas'),
(15, 'Hype Studio', 'Audio', 'Houston');


INSERT INTO Job VALUES
(1, 'Data Analyst'),
(2, 'Animal Caretaker'),
(3, 'Actor'),
(4, 'Audio Engineer'),
(5, 'Futures Trader'),
(6, 'Software Engineer'),
(7, 'Product Manager'),
(8, 'Secretary'),
(9, 'Surgeon'),
(10, 'Nurse'),
(11, 'Accountant'),
(12, 'Academic Librarian'),
(13, 'Banker'),
(14, 'Research Officer'),
(15, 'CFO'),
(16, 'Teacher'),
(17, 'Scientist'),
(18, 'Manager');


INSERT INTO Experience VALUES
(12, 'Software Engineer', 'Alliance Inc.', '2016-08-24', '2022-09-28'),
(2, 'Data Analyst', 'Myers, Thornton and Hill', '2015-10-30', '2022-11-08'),
(8, 'Teaching Consultant', 'Brown Elementary School', '2016-02-17', '2022-12-26'),
(7, 'Teachers Aid', 'Brown Elementary School', '2018-07-19', '2022-02-23'),
(9, 'Doctor', 'Jerusalem Hospital', '2020-05-07', '2023-06-26'),
(14, 'Set Designer', 'The Renegade Theatre', '2020-11-05', '2022-06-18'),
(1, 'Software Developer/Programmer', 'Alliance Inc.', '2015-02-27', '2021-07-11'),
(12, 'Programmer', 'Enhance AI', '2014-06-22', '2015-01-03'),
(10, 'Secretary', 'King, Carlson and Ramos', '2020-07-14', '2022-11-14'),
(4, 'Assistant Banker', 'King, Carlson and Ramos', '2018-08-25', '2021-05-09'),
(4, 'Futures Trader', 'King, Carlson and Ramos', '2022-06-27', '2024-05-04'),
(13, 'Educational Advisor', 'Brown Elementary School', '2016-08-06', '2023-07-07'),
(2, 'Data Miner', 'Fort Data Co.', '2023-11-26', '2024-10-18'),
(15, 'Educational Consultant', 'Lincoln High School', '2020-09-11', '2023-09-30'),
(2, 'Leisure Center Manager', 'Lincoln High School', '2010-05-19', '2011-08-20');


INSERT INTO Post VALUES
(1, NULL, 2, '2025-04-11 22:40:31', 'https://placekitten.com/73/84', 'This is amazing.'),
(2, 9, NULL, '2021-02-06 18:43:44', 'https://placeimg.com/600/235/any', 'I cant believe this.'),
(3, 14, NULL, '2022-10-17 16:16:47', 'https://www.lorempixel.com/612/849', NULL),
(4, NULL, 4, '2022-12-03 16:31:13', 'https://www.lorempixel.com/254/981', NULL),
(5, NULL, 10, '2025-06-07 22:14:07', 'https://www.lorempixel.com/178/134', NULL),
(6, NULL, 10, '2023-10-25 13:53:09', 'https://placeimg.com/1000/444/any', 'They look so happy!'),
(7, 5, NULL, '2023-09-01 18:10:12', 'https://www.lorempixel.com/393/734', 'Incredible work from my buddy Jerome.'),
(8, 2, NULL, '2021-09-18 14:56:28', 'https://placeimg.com/243/1018/any', NULL),
(9, NULL, 7, '2021-09-07 01:42:58', 'https://placekitten.com/938/774', NULL),
(10, 6, NULL, '2024-06-07 09:37:29', 'https://placeimg.com/1014/660/any', 'Such a disappointment'),
(11, NULL, 5, '2022-09-15 19:08:37', 'https://dummyimage.com/659x72', 'Another executive at the company speaks out!'),
(12, NULL, 4, '2024-01-01 13:54:22', 'https://www.lorempixel.com/135/173', NULL),
(13, NULL, 3, '2022-10-24 02:54:08', 'https://placeimg.com/329/304/any', 'Sad.'),
(14, 1, NULL, '2025-02-07 13:51:07', 'https://dummyimage.com/156x873', NULL),
(15, 11, NULL, '2023-04-22 05:47:47', 'https://www.lorempixel.com/478/41', NULL);


INSERT INTO Comment VALUES
(8, 'Haha! Good one.', '2022-06-10 22:51:29'),
(2, 'So true.', '2023-01-01 00:34:28'),
(2, 'Happy to see this!', '2022-10-03 08:34:52'),
(11, 'Nice!', '2020-12-10 20:31:49'),
(13, 'Love this!', '2025-04-16 14:28:25'),
(3, 'Oh great.', '2021-01-12 15:36:14'),
(15, 'Awesome!', '2020-05-04 05:10:30'),
(3, 'Very true.', '2024-04-09 22:37:04'),
(15, 'Nice!', '2020-04-05 09:13:15'),
(1, 'Very true.', '2022-12-09 06:15:14'),
(14, 'XOXO', '2021-01-17 17:34:19'),
(2, 'XD', '2021-03-16 19:53:39'),
(15, 'Haha :)', '2022-11-06 20:23:31'),
(12, 'Nice!', '2023-03-16 00:30:21'),
(15, 'So true.', '2023-07-28 05:27:59');

INSERT INTO connects VALUES
(11, 2, '2024-05-29', 'Connected'),
(12, 5, '2024-11-13', 'Connected'),
(4, 3, '2024-10-12', 'Blocked'),
(12, 9, '2024-10-08', 'Connected'),
(10, 7, '2025-01-30', 'Connected'),
(1, 2, '2025-05-15', 'Connected'),
(4, 9, '2024-09-26', 'Blocked'),
(1, 9, '2025-03-16', 'Connected'),
(12, 11, '2025-02-27', 'Blocked'),
(9, 7, '2023-08-12', 'Connected'),
(8, 10, '2024-01-23', 'Pending'),
(13, 14, '2024-11-22', 'Connected'),
(13, 15, '2023-12-24', 'Connected'),
(12, 7, '2023-07-10', 'Pending'),
(5, 3, '2024-09-24', 'Connected');

INSERT INTO Employee (UserID, CompanyID, StartDate, EndDate) VALUES
(1, 6, '2024-01-15', NULL),
(12, 6, '2023-03-04', NULL),
(6, 4, '2015-09-12', NULL),
(13, 10, '2024-06-15', NULL),
(14, 10, '2023-12-28', NULL),
(11, 9, '2015-04-20', NULL),
(7, 10, '2024-05-05', NULL),
(2, 14, '2025-04-20', NULL),
(10, 12, '2023-03-08', NULL),
(3, 3, '2020-05-16', NULL),
(4, 2, '2025-09-08', NULL),
(5, 11, '2019-10-10', '2024-06-24'),
(8, 10, '2023-11-30', '2025=05-05'),
(9, 12, '2020-05-07', NULL),
(15, 9, '2024-09-08', NULL);


INSERT INTO List VALUES
(8, 1, '2015-04-01'),
(10, 12, '2014-04-05'),
(12, 8, '2012-12-24'),
(4, 4, '2011-11-11'),
(6, 15, '2010-10-10'),
(12, 9, '2009-09-09'),
(14, 1, '2008-08-08'),
(15, 4, '2007-07-07'),
(3, 3, '2006-06-06'),
(11, 5, '2005-05-05'),
(13, 7, '2013-12-13'),
(13, 15, '2012-12-13'),
(3, 8, '2014-09-27'),
(5, 2, '2013-09-08'),
(9, 12, '2011-11-26');


INSERT INTO Work (UserID, JobID) VALUES
(2, 1),
(1, 6),
(3, 3),
(7, 16),
(4, 13),
(5, 11),
(6, 4),
(8, 16),
(10, 17),
(9, 9),
(13, 16),
(3, 8),
(12, 6),
(14, 18),
(15, 16);


INSERT INTO creates (UserID, PostID) VALUES
(1, 2),
(2, 3),
(3, 7),
(4, 8),
(5, 10),
(6, 14),
(7, 15);


INSERT INTO posts (CompanyID, PostID) VALUES
(1, 1),
(2, 4),
(3, 5),
(4, 6),
(5, 9),
(6, 11),
(7, 12),
(8, 13);

CREATE INDEX CompanyLocations ON Company(Location);
show index from Company;

CREATE INDEX Birthdays ON LinkedInUser(DateOfBirth);
show index from LinkedInUser;

show index from Company;
show index from LinkedInUser;

CREATE INDEX CurrRole ON LinkedInUser(CurrentRole);
show index from LinkedInUser;

CREATE INDEX CompaniesWorkedFor ON Experience(Company);
show index from Experience;

CREATE INDEX JobTitle ON Job(JobName);
show index from Job;

CREATE INDEX TimePosted ON Post(PostTime);
show index from Post;

CREATE INDEX ThePost ON Comment(PostID);
show index from Comment;

CREATE VIEW NewHires as
    SELECT c.CompanyName, u.FirstName, e.StartDate
    FROM Company c, LinkedInUser u, Employee e
    WHERE u.UserID = e.UserID and c.CompanyID = e.CompanyID and SUBSTRING(e.StartDate, 1, 4) = '2025';

select * FROM NewHires;

CREATE VIEW Connected as
    SELECT CONCAT(u.FirstName, ' ', u.LastName), CONCAT(v.FirstName, ' ', v.LastName)
    FROM LinkedInUser u, LinkedInUser v, connects c
    WHERE (c.UserID1 = u.UserID and c.UserID2 = v.UserID);

select * FROM Connected;

CREATE VIEW Opportunity as
    SELECT CONCAT(u.FirstName, ' ', u.LastName), c.CompanyName, j.JobName
    FROM LinkedInUser u, Company c, Job j, List l
    WHERE j.JobID = l.JobID and u.CurrentRole = j.JobName and l.CompanyID = c.CompanyID;

select * FROM Opportunity;

CREATE TEMPORARY TABLE DataAnalysts
    SELECT CONCAT(u.FirstName, ' ', u.LastName)
    FROM LinkedInUser u
    WHERE u.CurrentRole = 'Data Analyst';

select * FROM DataAnalysts;

CREATE TEMPORARY TABLE TechCompanies
    SELECT c.CompanyName
    FROM Company c
    where c.Industry = 'Software';

select * FROM TechCompanies;

CREATE TEMPORARY TABLE TrendingContent
    SELECT p.Image
    FROM Post p
    JOIN (
        SELECT PostID
        FROM Comment
        GROUP BY PostID
        HAVING COUNT(*) > 1
) c ON p.PostID = c.PostID;

select * FROM TrendingContent;

DROP VIEW Connected;

CREATE VIEW Connected as
    SELECT CONCAT(u.FirstName, ' ', u.LastName), CONCAT(v.FirstName, ' ', v.LastName)
    FROM LinkedInUser u, LinkedInUser v, connects c
    WHERE c.UserID1 = u.UserID and c.UserID2 = v.UserID and c.ConnectionStatus = 'Connected';

select * FROM Connected;

DELIMITER //

CREATE PROCEDURE GetConnectionCount (IN p_UserID INT)
BEGIN

    SELECT COUNT(*) AS ConnectionCount
    FROM connects
    WHERE (UserID1 = p_UserID OR UserID2 = p_UserID)
      AND ConnectionStatus = 'Connected';

END;
//

DELIMITER ;

CALL GetConnectionCount(5);

DELIMITER //

CREATE PROCEDURE HeadCount (IN p_CompanyID INT)
BEGIN

    SELECT COUNT(*)
    FROM Employee
    WHERE CompanyID = p_CompanyID;

END;
//

CALL HeadCount(6);
CALL HeadCount(10);

DELIMITER //

CREATE TRIGGER update_job
AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
    DECLARE job_title VARCHAR(100);

    SELECT j.JobName INTO job_title
    FROM List l
    JOIN Job j ON l.JobID = j.JobID
    WHERE l.CompanyID = NEW.CompanyID
    ORDER BY l.PostDate DESC
    LIMIT 1;

    UPDATE LinkedInUser
    SET CurrentRole = job_title
    WHERE UserID = NEW.UserID;
END;
//

DELIMITER ;

INSERT INTO Employee (UserID, CompanyID, StartDate, EndDate)
VALUES (5, 3, '2024-07-01', NULL);

SELECT UserID, CurrentRole FROM LinkedInUser WHERE UserID = 5;
-- User 5 started a new job, shows their new position.

CALL HeadCount(3);
-- Shows number of employees at Company 3

CALL GetConnectionCount(12);
-- Shows User 12's number of connections

select * FROM NewHires;
-- Shows employees that started their current job this year

select * FROM Connected;
-- Shows users that are connections with each other

select * FROM Opportunity;
-- Shows users that work a role that a company is hiring for

select * FROM DataAnalysts;
-- Shows all Users who are Data Analysts

select * FROM TechCompanies;
-- Shows all companies that specialize in software

select * FROM TrendingContent;
-- Shows posts with at least 2 comments

select * from Post where CompanyID = 3;
-- Shows all posts made by Company 3

SELECT PostID, COUNT(*) AS CommentCount
FROM Comment
GROUP BY PostID;
-- Shows how many comments each post has received

SELECT u.FirstName, u.LastName, j.JobName
FROM LinkedInUser u
JOIN Work w ON u.UserID = w.UserID
JOIN Job j ON w.JobID = j.JobID;
-- Shows all users and the jobs they are currently working

SELECT FirstName, LastName, DateOfBirth
FROM LinkedInUser
WHERE DateOfBirth < '1990-01-01';
-- Shows all users born before 1990

SELECT * FROM Company
WHERE Location = 'Chicago';
-- Shows all companies located in Chicago

SELECT u.UserID, u.FirstName, u.LastName
FROM LinkedInUser u
LEFT JOIN connects c ON u.UserID = c.UserID1 OR u.UserID = c.UserID2
WHERE c.UserID1 IS NULL AND c.UserID2 IS NULL;
-- Shows users who have no connections

CALL GetConnectionCount(12);
-- Shows User 12's number of connections




