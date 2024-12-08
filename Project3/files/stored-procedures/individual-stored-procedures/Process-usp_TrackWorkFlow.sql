-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/5/2024 >
-- Description:	< Create `[Process].[usp_TrackWorkFlow]` and `[Process].[usp_ShowWorkFlowSteps]` procedures >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Process].[usp_TrackWorkFlow]
    @UserAuthorizationKey INT,
    @WorkFlowStepsTableRowCount INT,
    @WorkFlowStepsDescription NVARCHAR(100)
AS
BEGIN
    INSERT INTO [Process].[WorkFlowSteps]
        (UserAuthorizationKey, WorkFlowStepsTableRowCount, WorkFlowStepsDescription)
    VALUES(@UserAuthorizationKey, @WorkFlowStepsTableRowCount, @WorkFlowStepsDescription);
END;
GO

CREATE PROCEDURE [Process].[usp_ShowWorkFlowSteps]
AS
BEGIN
	SELECT *
	FROM [Process].[WorkFlowSteps];
END;
GO