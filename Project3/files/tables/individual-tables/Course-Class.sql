-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Course].[Class]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Course].[Class]    (
    [ClassID]               [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [Enrollment]            [Udt].[SurrogateKeyInt]                     NULL,
    [Limit]                 [Udt].[SurrogateKeyInt]                     NULL,
    [Section]               [Udt].[String30]                            NULL,
    [Department]            [Udt].[String30]                            NULL,
    [Hours]                 [Udt].[FloatField]                          NULL,
    [Credits]               [Udt].[SurrogateKeyInt]                     NULL,
    [Days]                  [Udt].[String30]                            NULL,
    [ClassStart]            [Udt].[String20]                            NULL,
    [ClassEnd]              [Udt].[String20]                            NULL,
    -- Required fields:
    [UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
    [DateAdded]             [Udt].[DateAdded]                           NULL    DEFAULT (SYSDATETIME()),
    [DateOfLastUpdate]      [Udt].[DateAdded]                           NULL    DEFAULT (SYSDATETIME())
)
GO

ALTER TABLE [Course].[Class]
ADD CONSTRAINT FK_Class_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO