-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Location].[RoomLocation]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Location].[usp_LoadRoomLocationTable]
    @UserAuthorizationKey INT
AS
BEGIN
    -- Insert data into the RoomLocation table
    INSERT INTO [Location].[RoomLocation]
    (
        Room,
        Time,
        Day,
        BuildingLocationID,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT
        TRIM(SUBSTRING(c.[Location], CHARINDEX(' ', c.[Location]) + 1, LEN(c.[Location]))) AS Room,
        c.[Time],
        c.[Day], -- Explicitly use table alias
        bl.BuildingLocationID,
        @UserAuthorizationKey AS UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] c
    INNER JOIN [Location].[BuildingLocation] bl
        ON bl.CourseCode = c.[Code]
    WHERE
        c.[Location] IS NOT NULL
        AND CHARINDEX(' ', c.[Location]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into RoomLocation table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO