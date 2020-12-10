#ready RODBC for use in this script 
require(RODBC)

#create a connection to SQL Server using our 64-Bit DSN 
myconn <- odbcConnect("Vidcast64")

#Ready the SQL to send to the Server 
sqlSelectStatement <- 
  "SELECT 
  vc_VidCast.vc_VidCastID
  , vc_VidCast.VidCastTitle
  , DATEPART(dw, StartDateTime) as StartDayofWeek 
  , DATEDIFF(n, StartDateTime, EndDateTime) as ActualDuration 
  , ScheduleDurationMinutes 
  , vc_user.vc_UserID
  , vc_user.UserName
FROM vc_VidCast
JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
"

# Send the request to the server and store the results in a variable 
sqlResult <- sqlQuery(myconn, sqlSelectStatement)

# Create a list of days of the week for charting later 
days <- c("Sun", "Mon", "Tue", "Weds", "Thurs", "Fri", "Sat")

#Create a histogram of durations (appears in the plots tab)
hist(sqlResult$ActualDuration, 
    main = "japicon How long are the VidCasts?",
    xlab="Minutes", 
    ylab="VidCasts", 
    border="red", 
    col="black",
    labels=TRUE
  )

# Plot a bar chart of video counts by day of the week 
daycounts <- table(sqlResult$StartDayofWeek)
barplot(daycounts, 
        main="japicon Vidcasts by Day of Week",
        ylab = "Day of Week", 
        xlab = "Count of VidCasts",
        border = "blue",
        names.arg = days
)

#Close all connections 
odbcCloseAll()

#Fin
