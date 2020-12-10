SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, vc_Vidcast.vc_VidCastID 
FROM vc_Vidcast
JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID 
ORDER BY vc_User.UserName 

-- Look for users who have not yet made any VidCasts 
SELECT * FROM vc_User 
WHERE vc_UserID NOT IN (SELECT vc_UserID FROM vc_VidCast) 

-- Be sure to include all vc_User records 
SELECT 
	vc_User.UserName 
	, vc_User.EmailAddress
	, vc_Vidcast.vc_VidCastID
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID 
ORDER BY vc_User.UserName

-- High-level descriptive statistics for vc_VidCast 
SELECT 
	COUNT(vc_VidCastID) as NumberOfVidCasts
	, SUM(ScheduleDurationMinutes) as TotalScheduledMinutes 
	, MIN(ScheduleDurationMinutes) as MinScheduledMinutes 
	, AVG(ScheduleDurationMinutes) as AvgScheduledMinutes 
	, MAX(ScheduleDurationMinutes) as MaxScheduledMinutes 
FROM vc_VidCast 

SELECT
	vc_User.UserName
	, vc_User.EmailAddress
	, COUNT (vc_Vidcast.vc_VidcastID) CountOfVidCasts
FROM vc_Vidcast 
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID 
GROUP BY 
	vc_User.UserName
	, vc_User.EmailAddress
ORDER BY CountOfVidCasts DESC, vc_User.UserName

-- Our least prolific users
SELECT
	vc_User.UserName
	, vc_User.EmailAddress
	, COUNT (vc_Vidcast.vc_VidcastID) CountOfVidCasts
FROM vc_Vidcast 
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID 
GROUP BY 
	vc_User.UserName
	, vc_User.EmailAddress
HAVING COUNT(vc_VidCast.vc_VidCastID) < 10 
ORDER BY CountOfVidCasts DESC, vc_User.UserName


SELECT 
	vc_User.UserName 
	, vc_User.EmailAddress
	, SUM(DateDiff(n, StartDateTime, EndDateTime)) as SumActualDurationMinutes 
	, COUNT(vc_VidCastID) as CountOfVidCasts
	, MIN(DateDiff(n, StartDateTime, EndDateTime)) as MinActualDurationMinutes
	, AVG(DateDiff(n, StartDateTime, EndDateTime)) as AvgActualDurationMinutes 
	, MAX(DateDiff(n, StartDateTime, EndDateTime)) as MaxActualDurationMinutes 
FROM vc_VidCast
JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID 
JOIN vc_Status ON vc_Status.vc_StatusID = vc_VidCast.vc_StatusID
WHERE vc_Status.StatusText = 'Finished' 
GROUP BY 
	vc_User.UserName 
	, vc_user.EmailAddress
ORDER BY CountOfVidCasts DESC, vc_User.EmailAddress


