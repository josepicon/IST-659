CREATE TABLE vc_User (    
-- Columns for user table   
vc_userID int identity,    
UserName varchar(20) not null,    
EmailAddress varchar(50) not null,   
UserDescription varchar(200),    
WebsiteURL varchar(50),    
UserRegisteredDate datetime not null default GetDate(),    
-- Contraints on the User Table    
CONSTRAINT PK_vc_User PRIMARY KEY (vc_UserID),    
CONSTRAINT U1_vc_User UNIQUE(UserName),    
CONSTRAINT U2_vc_User UNIQUE(EmailAddress)
) 
-- End Creating the User Table 

-- Creating the UserLogin table

CREATE TABLE vc_UserLogin (    
--Columns for the User Login table    
vc_UserLoginID int identity,    
vc_UserID int not null,    
UserLoginTimestamp datetime not null default GetDate(),    
LoginLocation varchar(50) not null,   
-- Contraints on the UserLogin Table    
CONSTRAINT PK_vc_UserLogin PRIMARY KEY (vc_UserLoginID),    
CONSTRAINT FK1_vc_UserLogin FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID))

INSERT INTO vc_User(UserName, EmailAddress, UserDescription)    
	VALUES 
	('RDwight', 'rdwight@nodomain.xyz', 'Piano Teacher'), 
	('SaulHudson', 'slash@nodomain.xyz', 'I like Les Paul guitars'), 
	('Gordon', 'sumner@nodomain.xyz', 'Former cop')

SELECT * FROM vc_User

-- Creating the Follower List table
CREATE TABLE vc_FollowerList(    
	--Columns for the follower List Table    
	vc_FollowerListID int identity,    
	FollowerID int not null,    
	FollowedID int not null,    
	FollowerSince datetime not null,    
--Constrains on the Follower List table    
	CONSTRAINT PK_vc_FollowerList PRIMARY KEY (vc_FollowerListID),    
	CONSTRAINT U1_vc_FollowerList UNIQUE (FollowerID, FollowedID),    
	CONSTRAINT FK1_vc_FollowerList FOREIGN KEY (FollowerID) REFERENCES vc_User(vc_UserID),    
	CONSTRAINT FK2_vc_FollowerList FOREIGN KEY (FollowedID) REFERENCES vc_User(vc_UserID)
)
--End Creating the Follower List table

CREATE TABLE vc_Tag(   
	vc_TagID int identity not null,    
	TagText varchar(20) not null,    
	TagDescription varchar(100)    
	--Constrains on the vc_Tag table   
	CONSTRAINT PK_vc_Tag PRIMARY KEY (vc_TagID),    
	CONSTRAINT U1_vc_Tag UNIQUE (TagText)
)

CREATE TABLE vc_Status(    
vc_StatusID int identity not null,    
StatusText varchar(20)   
--Constrains on the vc_Status    
CONSTRAINT PK_vc_Status PRIMARY KEY (vc_StatusID)
)

CREATE TABLE vc_UserTagList (    
vc_UserTagListID int identity not null,    
vc_TagID int not null,    
vc_UserID int not null    
--Constrains on the vc_UserTagList    
CONSTRAINT PK_vc_UserTagList PRIMARY KEY (vc_UserTagListID)    
CONSTRAINT FK1_vc_UserTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag(vc_TagID)
)
CREATE TABLE vc_VidCast (
vc_VidCastID int identity not null,
VidCastTitle varchar(50) not null,
StartDateTime datetime,
EndDateTime datetime,
ScheduledDurationMinutes int,
RecordingURL varchar(50),
vc_UserID int,
vc_StatusID int
-- Constrains on the vc_VidCast table
CONSTRAINT PK_vc_VidCast PRIMARY KEY (vc_VidCastID),
CONSTRAINT FK2_vc_VidCast FOREIGN KEY (vc_StatusID) REFERENCES vc_Status
(vc_StatusID)
)

CREATE TABLE vc_VidCastTagList (
vc_VidCastTagListID int identity not null,
vc_tagID int not null,
vc_VidCastID int not null,
-- Constrains on the vc_VidCastTagList table
CONSTRAINT PK_vc_VidCastTagList PRIMARY KEY (vc_VidCastTagListID),
CONSTRAINT FK1_vc_VidCastTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag (vc_TagID),
CONSTRAINT FK2_vc_VidcastTagList FOREIGN KEY (vc_VidCastID) REFERENCES vc_VidCast (vc_VidcastID)
)

--Adding a row to the vc_Status table 
INSERT INTO vc_Status (StatusText)
	VALUES ('Scheduled') 

-- The following line shoes all of the rows in vc_status 
SELECT * FROM vc_Status

--Adding three more rows to the vc_Status table 
INSERT INTO vc_Status (StatusText) 
VALUES ('Started'), ('Finished'), ('On time') 

SELECT * FROM vc_User WHERE UserName = 'SaulHudson' 
SELECT * FROM vc_Status WHERE StatusText = 'Finished' 

--Adding a vidcast record to the VidCast Table 
INSERT INTO vc_VidCast	
	(VidCastTitle, StartDateTime, EndDateTime, ScheduledDurationMinutes, RecordingURL, vc_UserID, vc_StatusID) 
VALUES 
	('December Snow', '3/1/2018', '3/1/2018 14:30', 30, '/XVF1234', 2, 3) 

--Read all rows from vc_Vidcast 
SELECT * FROM vc_VidCast 