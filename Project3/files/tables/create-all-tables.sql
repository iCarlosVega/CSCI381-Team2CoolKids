-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/4/2024 >
-- Description:	< Create the `[DbSecurity].[UserAuthorization]` table and other required tables >
-- =============================================

USE [QueensClassSchedule]
GO

/* [DbSecurity] schema */

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

/* [Process] schema */

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

/* [Course] schema */

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

/* [Location] schema */

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

/* [Department] schema */

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

-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/7/2024 >
-- Description:	< Create the `[Course].[CourseInstructor]` table, which is a bridge between `[Course].[Course]` and `[Department].[Instructor]` >
-- ================================================================

USE [QueensClassSchedule];
GO

CREATE TABLE [Course].[CourseInstructor]   (
    [CourseInstructorID]          [Udt].[SurrogateKeyInt] IDENTITY(1,1)   NOT NULL
        PRIMARY KEY CLUSTERED,
    [CourseID]              [Udt].[SurrogateKeyInt]                 NOT NULL,
    [InstructorID]          [Udt].[SurrogateKeyInt]                 NOT NULL,
    -- Required fields:
    [UserAuthorizationKey]  [Udt].[SurrogateKeyInt]                     NULL,
    [DateAdded]             [Udt].[DateAdded]                           NULL,
    [DateOfLastUpdate]      [Udt].[DateAdded]                           NULL
)
GO

-- Add foreign keys to enforce referential integrity
ALTER TABLE [Course].[CourseInstructor]
ADD CONSTRAINT FK_CourseInstructor_Course FOREIGN KEY (CourseID)
    REFERENCES [Course].[Course](CourseID);

ALTER TABLE [Course].[CourseInstructor]
ADD CONSTRAINT FK_CourseInstructor_Instructor FOREIGN KEY (InstructorID)
    REFERENCES [Department].[Instructor](InstructorID);

ALTER TABLE [Course].[CourseInstructor]
ADD CONSTRAINT FK_CourseInstructor_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
    REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski , Carlos Vega>
-- Create date: < 12/7/2024 >
-- Description:	< Create the `[Course].[ClassRoom]` table, which is a bridge between `[Course].[Class]` and `[Location].[RoomLocation]` >
-- ================================================================

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

