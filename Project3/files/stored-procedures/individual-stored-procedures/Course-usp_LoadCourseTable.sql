-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Course].[Course]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Course].[usp_LoadCourseTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[Course]
    (
        Section,
        Course,
        [Semester],
        [Description],
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        [Sec] AS Section,
        SUBSTRING([Course (hr, crd)], 1, CHARINDEX('(', [Course (hr, crd)]) - 1) AS Course,
        [Semester],
        [Description],
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM Uploadfile.CurrentSemesterCourseOfferings;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into Course table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO