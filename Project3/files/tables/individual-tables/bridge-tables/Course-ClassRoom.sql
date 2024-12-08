-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski , Carlos Vega>
-- Create date: < 12/7/2024 >
-- Description:	< Create the `[Course].[ClassRoom]` table, which is a bridge between `[Course].[Class]` and `[Location].[RoomLocation]` >
-- ================================================================

USE [QueensClassSchedule];
GO

-- Create the ClassRoom bridge table.
CREATE TABLE [Course].[ClassRoom](
    [ClassRoomID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
    [ClassID] [Udt].[SurrogateKeyInt] NOT NULL,
    [RoomLocationID] [Udt].[SurrogateKeyInt] NOT NULL,
    [UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
    [DateAdded] [Udt].[DateAdded] NULL,
    [DateOfLastUpdate] [Udt].[DateAdded] NULL,
    CONSTRAINT [PK_ClassRoom] PRIMARY KEY CLUSTERED ([ClassRoomID] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];
GO

-- Set default values for DateAdded and DateOfLastUpdate
ALTER TABLE [Course].[ClassRoom]
    ADD CONSTRAINT [DF_ClassRoom_DateAdded]
    DEFAULT (sysdatetime()) FOR [DateAdded];
GO

ALTER TABLE [Course].[ClassRoom]
    ADD CONSTRAINT [DF_ClassRoom_DateOfLastUpdate]
    DEFAULT (sysdatetime()) FOR [DateOfLastUpdate];
GO

-- Add foreign key constraints
ALTER TABLE [Course].[ClassRoom] WITH CHECK
ADD CONSTRAINT [FK_ClassRoom_Class]
FOREIGN KEY([ClassID])
REFERENCES [Course].[Class]([ClassID]);
GO
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_Class];
GO

ALTER TABLE [Course].[ClassRoom] WITH CHECK
ADD CONSTRAINT [FK_ClassRoom_RoomLocation]
FOREIGN KEY([RoomLocationID])
REFERENCES [Location].[RoomLocation]([RoomLocationID]);
GO
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_RoomLocation];
GO

-- Optional: Tie UserAuthorizationKey to UserAuthorization table for auditing consistency
ALTER TABLE [Course].[ClassRoom] WITH CHECK
ADD CONSTRAINT [FK_ClassRoom_UserAuthorization]
FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization]([UserAuthorizationKey]);
GO
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_UserAuthorization];
GO