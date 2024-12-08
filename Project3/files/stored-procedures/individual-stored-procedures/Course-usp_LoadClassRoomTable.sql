-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski , Carlos Vega>
-- Create date: < 12/7/2024 >
-- Description:	< Create the stored procedure to populate the `[Course].[ClassRoom]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Course].[usp_LoadClassRoomTable]
    @UserAuthorizationKey INT
AS
BEGIN
    -- Insert the bridging records by matching Classes and RoomLocations based on Day and Time
    -- Class time = ClassStart + '-' + ClassEnd
    INSERT INTO [Course].[ClassRoom]
    (
        [ClassID],
        [RoomLocationID],
        [UserAuthorizationKey],
        [DateAdded],
        [DateOfLastUpdate]
    )
    SELECT
        cls.ClassID,
        rl.RoomLocationID,
        @UserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM [Course].[Class] cls
    INNER JOIN [Location].[RoomLocation] rl
        ON cls.Days = rl.Day
        AND (cls.ClassStart + '-' + cls.ClassEnd) = rl.Time;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into ClassRoom bridge table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO