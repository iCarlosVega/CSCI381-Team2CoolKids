-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Course].[Class]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Course].[usp_LoadClassTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[Class] (
        Section,
        Department,
        Hours,
        Credits,
        Days,
        ClassStart,
        ClassEnd,
        Enrollment,
        [Limit],
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT
        [Sec] AS Section,
        LEFT([Course (hr, crd)], CHARINDEX(' ', [Course (hr, crd)]) - 1) AS Department,
        TRY_CAST(
            TRIM(
                SUBSTRING(
                    [Course (hr, crd)],
                    CHARINDEX('(', [Course (hr, crd)]) + 1,
                    CHARINDEX(',', [Course (hr, crd)]) - CHARINDEX('(', [Course (hr, crd)]) - 1
                )
            ) AS FLOAT
        ) AS Hours,
        TRY_CAST(
            TRIM(
                SUBSTRING(
                    [Course (hr, crd)],
                    CHARINDEX(',', [Course (hr, crd)]) + 1,
                    CHARINDEX(')', [Course (hr, crd)]) - CHARINDEX(',', [Course (hr, crd)]) - 1
                )
            ) AS INT
        ) AS Credits,
        [Day] AS Days,
        TRIM(LEFT([Time], CHARINDEX('-', [Time]) - 1)) AS ClassStart,
        TRIM(SUBSTRING([Time], CHARINDEX('-', [Time]) + 1, LEN([Time]))) AS ClassEnd,
        TRY_CAST([Enrolled] AS INT) AS Enrollment,
        TRY_CAST([Limit] AS INT) AS [Limit],
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] c
    WHERE
        [Course (hr, crd)] IS NOT NULL
        AND CHARINDEX(' ', [Course (hr, crd)]) > 0
        AND CHARINDEX('-', [Time]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into Class table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;