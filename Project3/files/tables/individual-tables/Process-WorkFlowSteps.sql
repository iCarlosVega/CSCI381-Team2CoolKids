-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Process].[WorkFlowSteps]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Process].[WorkFlowSteps]   (
    [WorkFlowStepsKey]              [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [WorkFlowStepsDescription]      [Udt].[String100]                       NOT NULL,
    [WorkFlowStepsTableRowCount]    [Udt].[Rows]                                NULL    DEFAULT ((0)),
    [StartingDateTime]              [Udt].[DateAdded]                           NULL    DEFAULT (SYSDATETIME()),
    [EndDateTime]                   [Udt].[DateAdded]                           NULL    DEFAULT (SYSDATETIME()),
    [ClassTime]                     [Udt].[ClassTime]                           NULL    DEFAULT ('10:45'),

    [UserAuthorizationKey]          [Udt].[SurrogateKeyInt]                 NOT NULL
)
GO

ALTER TABLE [Process].[WorkFlowSteps]
ADD CONSTRAINT FK_WorkFlowSteps_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO