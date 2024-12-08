-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Department].[Department]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Department].[Department]   (
    [DepartmentID]          [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [Department]            [Udt].[String8]                         NOT NULL,
    [InstructorID]          [Udt].[SurrogateKeyInt]                 NOT NULL,
    [FirstName]             [Udt].[String30]                        NOT NULL,
    [LastName]              [Udt].[String30]                        NOT NULL,
    -- Required fields:
    [UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
    [DateAdded]             [Udt].[DateAdded]                           NULL,
    [DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

ALTER TABLE [Department].[Department]
ADD CONSTRAINT FK_Department_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO