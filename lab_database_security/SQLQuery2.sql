SELECT * FROM vc_User

SELECT * FROM vc_MostProlificUsers

DECLARE @addedValue int 
EXEC @addedValue = vc_AddUserLogin 'TheDoctor', 'Gallifrey' 

EXEC vc_FinishVidCast @newVC 

