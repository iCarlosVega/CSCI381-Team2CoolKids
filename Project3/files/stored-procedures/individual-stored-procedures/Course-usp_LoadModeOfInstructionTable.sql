-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create a stored procedure for loading the `[Course].[ModeOfInstruction]` table >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Course].[usp_LoadModeOfInstructionTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[ModeOfInstruction]
    (
        ModeName,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT [Mode of Instruction] AS ModeName, @UserAuthorizationKey, SYSDATETIME() AS DateAdded, SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings]
    --  Insert the user into the Process.WorkFlowTable
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription =  'Loading data into MOI table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO