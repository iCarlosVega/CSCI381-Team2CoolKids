-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Course].[ModeOfInstruction]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Course].[ModeOfInstruction]    (
	[ModeID]                [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
	[ModeName]              [Udt].[String100]                       NOT NULL,
    -- Required fields:
	[UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
	[DateAdded]             [Udt].[DateAdded]                           NULL,
	[DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

ALTER TABLE [Course].[ModeOfInstruction]
ADD CONSTRAINT FK_ModeOfInstruction_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO