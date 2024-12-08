-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Department].[Department]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Department].[usp_LoadDepartmentTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Department].[Department]
    (
        Department,
        InstructorID,
        FirstName,
        LastName,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        -- Extract department code (e.g., ACCT from ACCT 100)
        LEFT([Course (hr, crd)], CHARINDEX(' ', [Course (hr, crd)]) - 1) AS Department,
        -- InstructorID from the Instructor table
        inst.InstructorID,
        -- Extract LastName from Instructor column
        SUBSTRING(cso.[Instructor], 1, CHARINDEX(',', cso.[Instructor]) - 1) AS LastName,
        -- Extract FirstName from Instructor column
        LTRIM(SUBSTRING(cso.[Instructor], CHARINDEX(',', cso.[Instructor]) + 1, LEN(cso.[Instructor]) - CHARINDEX(',', cso.[Instructor]))) AS FirstName,
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] cso
    INNER JOIN [Department].[Instructor] inst
        ON inst.LastName = SUBSTRING(cso.[Instructor], 1, CHARINDEX(',', cso.[Instructor]) - 1)
        AND inst.FirstName = LTRIM(SUBSTRING(cso.[Instructor], CHARINDEX(',', cso.[Instructor]) + 1, LEN(cso.[Instructor]) - CHARINDEX(',', cso.[Instructor])))
    WHERE [Course (hr, crd)] IS NOT NULL
          AND CHARINDEX(' ', [Course (hr, crd)]) > 0
          AND cso.[Instructor] IS NOT NULL
          AND CHARINDEX(',', cso.[Instructor]) > 0;

    -- Log the workflow step
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkflowStepsDescription = 'Loading data into Department table',
        @WorkflowStepsTableRowCount = @@ROWCOUNT;
END;
GO