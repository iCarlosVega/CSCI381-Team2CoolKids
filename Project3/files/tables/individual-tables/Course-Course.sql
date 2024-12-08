-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Course].[Course]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Course].[Course]   (
	[CourseID]              [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [Section]               [Udt].[String4]                             NULL,
	[Course]                [Udt].[String30]                            NULL,
    [Semester]              [Udt].[String20]                            NULL,
	[Description]           [Udt].[String100]                           NULL,
    -- Required fields:
	[UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
	[DateAdded]             [Udt].[DateAdded]                           NULL,
	[DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

ALTER TABLE [Course].[Course]
ADD CONSTRAINT FK_Course_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO