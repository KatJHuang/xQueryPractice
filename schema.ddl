DROP SCHEMA IF EXISTS jobSearch CASCADE;
CREATE SCHEMA jobSearch;
SET search_path TO jobSearch;

-- The possible values of skills
CREATE TYPE whatSkill AS ENUM ('SQL', 'Scheme', 'Python', 'R', 'Latex');

-- the possible values of degrees
CREATE TYPE eduLevel AS ENUM ('certificate', 'undergraduate', 'professional', 'masters', 'doctoral');


-- The possible values of how important a skill is.
CREATE DOMAIN importanceLevel AS smallint 
   DEFAULT NULL
   CHECK (VALUE > 0 and VALUE <= 5);


CREATE DOMAIN assesmentResult AS int 
   DEFAULT NULL
   CHECK (VALUE >= 0 and VALUE <= 100);

-- the possible values of skill level
CREATE DOMAIN skillLevel AS smallint 
   DEFAULT NULL
   CHECK (VALUE > 0 and VALUE <= 5);

---------------------------------------------------------------------------------------------------
---------------------------------------- CANDIDATES -----------------------------------------------

CREATE TABLE CandidateHonorific ( 
  rID integer,
  honorifc varchar(30) NOT NULL
);

CREATE TABLE CandidateIdentification (
  rID integer REFERENCES CandidateHonorific,
  forename varchar(30) NOT NULL,
  surname varchar(30) NOT NULL,
  DOB varchar(30) NOT NULL,
  citizenship varchar(30) NOT NULL,
  address varchar(100) NOT NULL,
  telephone integer NOT NULL,
  email varchar(100) NOT NULL
);

CREATE TABLE CandidateTitle (
  rID integer REFERENCES CandidateHonorific,
  title varchar(30)
);


CREATE TABLE CandidateSummary (
  rID integer REFERENCES CandidateHonorific,
  summary varchar(200)
);

----------------------------------- education level of candidate --------------------------------------

CREATE TABLE DegreeMajor (
  degree_id SERIAL PRIMARY KEY,
  major varchar(200)
);

CREATE TABLE Degree (
  degree_id integer REFERENCES DegreeMajor,
  institution varchar(100) NOT NULL,
  honours varchar(100),
  start_date date NOT NULL,
  end_date date NOT NULL
) ;


CREATE TABLE DegreeMinor (
  degree_id integer REFERENCES DegreeMajor,
  minor varchar(200)
);


CREATE TABLE Education (
  rID integer REFERENCES CandidateIdentification,
  degree_id integer REFERENCES DegreeMajor,
  level eduLevel NOT NULL
);


----------------------------------- experiences of candidate --------------------------------------
CREATE TABLE PositionTitle (
  position_id SERIAL PRIMARY KEY,
  title varchar(100) NOT NULL
) ;

CREATE TABLE Position (
  position_id integer REFERENCES PositionTitle,
  location varchar(100) NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL
) ;

CREATE TABLE PositionDescription (
  position_id integer REFERENCES PositionTitle,
  description varchar(100)
) ;

CREATE TABLE Experience (
  rID integer REFERENCES CandidateIdentification,
  position_id integer REFERENCES PositionTitle
);


----------------------------------- skills of candidate --------------------------------------
CREATE TABLE Skills (
  rID integer REFERENCES CandidateIdentification,
  what_skill whatSkill NOT NULL,
  level skillLevel NOT NULL,
  PRIMARY KEY (rID, what_skill)
);

---------------------------------------------------------------------------------------------------
------------------------------------------- POSTINGS ----------------------------------------------
CREATE TABLE Posting (
  pID SERIAL PRIMARY KEY,
  position varchar(100) NOT NULL
) ;

CREATE TABLE Question (
  qID SERIAL PRIMARY KEY,
  question_content varchar(300) NOT NULL
) ;


CREATE TABLE reqSkill (
  pID integer REFERENCES Posting,
  what_skill whatSkill NOT NULL,
  level skillLevel NOT NULL,
  importance importanceLevel NOT NULL
) ;

CREATE TABLE PostingQuestion (
  pID integer REFERENCES Posting,
  qID integer REFERENCES Question
) ;

---------------------------------------------------------------------------------------------------
----------------------------------------- INTERVIEWERS --------------------------------------------
CREATE TABLE Interviewer ( -- interviewer+ can't be enforced
  sID integer REFERENCES Interviewer,
  sID integer PRIMARY KEY,
  forename varchar(30) NOT NULL,
  surname varchar(30) NOT NULL
);

CREATE TABLE InterviewerHonorific (
  sID integer REFERENCES Interviewer,
  sID integer PRIMARY KEY,
  honorifc varchar(30) NOT NULL
);


CREATE TABLE InterviewerTitle (
  sID integer REFERENCES Interviewer,
  title varchar(30)
);
---------------------------------------------------------------------------------------------------
----------------------------------------- INTERVIEWS ----------------------------------------------
CREATE TABLE Assesment (
  assesment_id SERIAL PRIMARY KEY,
  techProficiency assesmentResult NOT NULL,
  comm assesmentResult NOT NULL,
  enthusiasm assesmentResult NOT NULL
) ;

CREATE TABLE AssessmentCollegiality (
  assesment_id integer REFERENCES Assesment,
  collegiatlity assesmentResult
) ;

CREATE TABLE AssessmentQnA (
  assesment_id integer REFERENCES Assesment,
  qID integer REFERENCES Question,
  answer varchar(100) NOT NULL,
  PRIMARY KEY(assesment_id, qID)
) ;


CREATE TABLE Interview ( -- interview+ can't be enforced
  rID integer REFERENCES CandidateIdentification,
  pID integer REFERENCES Posting,
  sID integer REFERENCES Interviewer,
  dateOfInterview date NOT NULL,
  timeofInterview time NOT NULL,
  location varchar(100) NOT NULL,
  PRIMARY KEY(rID, pID, sID)
);

CREATE TABLE InterviewQnA (
  rID integer REFERENCES CandidateIdentification,
  pID integer REFERENCES Posting,
  sID integer REFERENCES Interviewer,
  assesment_id integer REFERENCES Assesment,
  PRIMARY KEY(rID, pID, sID)
);


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------