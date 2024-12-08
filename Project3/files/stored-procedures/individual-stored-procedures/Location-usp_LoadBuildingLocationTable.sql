-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Location].[BuildingLocation]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Location].[usp_LoadBuildingLocationTable]
    @UserAuthorizationKey INT
AS
BEGIN
    -- Insert data into the BuildingLocation table
    INSERT INTO [Location].[BuildingLocation]
    (
        CourseCode,
        Description,
        Building,
        Day,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT
        [Code] AS CourseCode,
        [Description],
        TRIM(LEFT([Location], CHARINDEX(' ', [Location]) - 1)) AS Building,
        [Day],
        @UserAuthorizationKey AS UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings]
    WHERE
        [Location] IS NOT NULL
        AND CHARINDEX(' ', [Location]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into BuildingLocation table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO