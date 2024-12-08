-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/7/2024 >
-- Description:	< Fix Data Anomalies >
-- ================================================================

USE [QueensClassSchedule];
GO
-- Missing Day
UPDATE Uploadfile.CurrentSemesterCourseOfferings
SET Day = 'UNKNOWN'
WHERE DAY LIKE ''

-- Missing Time
UPDATE Uploadfile.CurrentSemesterCourseOfferings
SET Time = 'UNKNOWN'
WHERE TIME LIKE '-'

-- Missing Instructor
UPDATE Uploadfile.CurrentSemesterCourseOfferings
SET Instructor = 'Jane, Doe'
WHERE Instructor LIKE ','

-- Missing Location
UPDATE Uploadfile.CurrentSemesterCourseOfferings
SET Location = 'UNKNOWN'
WHERE Location LIKE ''