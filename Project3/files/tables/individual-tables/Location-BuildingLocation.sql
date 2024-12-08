-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Location].[BuildingLocation]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Location].[BuildingLocation]   (
    [BuildingLocationID]    [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [CourseCode]            [Udt].[String30]                        NOT NULL,
    [Description]           [Udt].[String100]                           NULL,
    [Building]              [Udt].[String30]                        NOT NULL,
    [Day]                   [Udt].[String30]                            NULL,
    -- Required fields:
    [UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
    [DateAdded]             [Udt].[DateAdded]                           NULL,
    [DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

ALTER TABLE [Location].[BuildingLocation]
ADD CONSTRAINT FK_BuildingLocation_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO