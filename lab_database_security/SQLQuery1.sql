--Creating a guestuser database user
CREATE USER guestlogin FOR LOGIN guestlogin

--Grant read permission on the user table 
GRANT SELECT ON vc_User to guestlogin

--Revoke the select permission 
REVOKE SELECT ON vc_User to guestlogin

--Give them the view instead
GRANT SELECT ON vc_MostProlificUsers to guestlogin 

--Allow guest user to run some stored procedures 
GRANT EXECUTE ON vc_AddUserLogin TO guestlogin 

GRANT EXECUTE ON vc_FinishVidCast TO guestlogin 

DECLARE @newVC int 
INSERT INTO vc_Vidcast 
	(VidCastTitle, StartDateTime, ScheduleDurationMinutes, vc_UserID, vc_StatusID) 
VALUES (
	'Rock Your Way To Success' 
	, DATEADD(n, -45, GETDATE())
	, 45
	, (SELECT vc_UserID FROM vc_User WHERE UserName = 'tardy') 
	, (SELECT vc_StatusID FROM vc_Status WHERE StatusText = 'Started') 
) 

SET @newVC = @@identity 

SELECT * FROM vc_UserLogin