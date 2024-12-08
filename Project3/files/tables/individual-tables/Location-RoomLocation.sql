-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[Location].[RoomLocation]` table >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TABLE   [Location].[RoomLocation]   (
	[RoomLocationID]        [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [Room]                  [Udt].[String30]                        NOT NULL,
    [Time]                  [Udt].[String20]                        NOT NULL,
    [Day]                   [Udt].[String20]                        NOT NULL,
	[BuildingLocationID]    [Udt].[SurrogateKeyInt]                 NOT NULL,
    -- Required fields:
	[UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
	[DateAdded]             [Udt].[DateAdded]                           NULL,
	[DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

ALTER TABLE [Location].[RoomLocation]
ADD CONSTRAINT FK_RoomLocation_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);
GO