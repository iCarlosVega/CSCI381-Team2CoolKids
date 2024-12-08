-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[DbSecurity].[UserAuthorization]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [DbSecurity].[UserAuthorization]    (
    [UserAuthorizationKey]  [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [ClassTime]             [Udt].[ClassTime]                           NULL    DEFAULT ('10:45'),
    [IndividualProject]     [Udt].[IndividualProject]                   NULL    DEFAULT ('Project 3'),
    [GroupMemberLastName]   [Udt].[LastName]                        NOT NULL,
    [GroupMemberFirstName]  [Udt].[FirstName]                       NOT NULL,
    [GroupName]             [Udt].[GroupName]                       NOT NULL    DEFAULT ('Group 2'),
    [DateAdded]             [Udt].[DateAdded]                           NULL    DEFAULT (SYSDATETIME())
)
GO

INSERT  INTO    [DbSecurity].[UserAuthorization]    (GroupMemberFirstName,   GroupMemberLastName)
VALUES
    ('Sarmad',      'Ali'),
    ('Daniel',      'Gargiullo'),
    ('Augusta',     'Na'),
    ('Jascharan',   'Singh'),
    ('Carlos',      'Vega Lemus'),
    ('Oksana',      'Weigand-Suminski');