-- ================================================================
-- Author:		< Jascharan Singh >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Department].[Instructor]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE  PROCEDURE [Department].[usp_LoadInstructorTable]
    @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Insert data into Department.Instructor table
    INSERT INTO [Department].[Instructor]
    (
        LastName,
        FirstName,
        DepartmentID,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        SUBSTRING([Instructor], 1, CHARINDEX(',', [Instructor]) - 1) AS LastName,
        LTRIM(SUBSTRING([Instructor], CHARINDEX(',', [Instructor]) + 1, LEN([Instructor]) - CHARINDEX(',', [Instructor]))) AS FirstName,
        1 AS DepartmentID,
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings]
    WHERE [Instructor] IS NOT NULL
          AND CHARINDEX(',', [Instructor]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into Instructor table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO