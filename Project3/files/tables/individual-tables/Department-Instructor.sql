-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Department].[Instructor]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Department].[Instructor]   (
    [InstructorID]          [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [DepartmentID]          [Udt].[SurrogateKeyInt]                 NOT NULL,
    [FirstName]             [Udt].[String30]                        NOT NULL,
    [LastName]              [Udt].[String30]                        NOT NULL,
    -- Required fields:
	[UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
	[DateAdded]             [Udt].[DateAdded]                           NULL,
	[DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

ALTER TABLE [Department].[Instructor]
ADD CONSTRAINT FK_Instructor_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO