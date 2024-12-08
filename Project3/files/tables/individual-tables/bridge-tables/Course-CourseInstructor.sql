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
