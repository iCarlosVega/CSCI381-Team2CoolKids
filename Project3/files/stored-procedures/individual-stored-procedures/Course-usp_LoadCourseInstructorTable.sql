-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/7/2024 >
-- Description:	< Create the `[Course].[usp_LoadCourseInstructorTable]` stored procedure >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Course].[usp_LoadCourseInstructorTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[CourseInstructor]
    (
        CourseID,
        InstructorID,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        crs.CourseID,
        inst.InstructorID,
        @UserAuthorizationKey,
        SYSUTCDATETIME() AS DateAdded,
        SYSUTCDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] cso
    INNER JOIN [Course].[Course] crs
        ON crs.[Course] = LTRIM(RTRIM(SUBSTRING(cso.[Course (hr, crd)], 1, CHARINDEX('(', cso.[Course (hr, crd)]) - 1)))
        AND crs.[Section] = cso.[Sec]
        AND crs.[Semester] = cso.[Semester]
    INNER JOIN [Department].[Instructor] inst
        ON inst.LastName = SUBSTRING(cso.[Instructor], 1, CHARINDEX(',', cso.[Instructor]) - 1)
        AND inst.FirstName = LTRIM(SUBSTRING(cso.[Instructor], CHARINDEX(',', cso.[Instructor]) + 1, LEN(cso.[Instructor]) - CHARINDEX(',', cso.[Instructor])));
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into CourseInstructor bridge table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO