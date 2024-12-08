-- ================================================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/6/2024 >
-- Description:	< Create the stored procedures for the required tables >
-- ================================================================

USE [QueensClassSchedule]
GO

CREATE PROCEDURE [Course].[usp_LoadCourseTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[Course]
    (
        Section,
        Course,
        [Semester],
        [Description],
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        [Sec] AS Section,
        SUBSTRING([Course (hr, crd)], 1, CHARINDEX('(', [Course (hr, crd)]) - 1) AS Course,
        [Semester],
        [Description],
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM Uploadfile.CurrentSemesterCourseOfferings;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into Course table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Course].[usp_LoadClassTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[Class] (
        Section,
        Department,
        Hours,
        Credits,
        Days,
        ClassStart,
        ClassEnd,
        Enrollment,
        [Limit],
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT
        [Sec] AS Section,
        LEFT([Course (hr, crd)], CHARINDEX(' ', [Course (hr, crd)]) - 1) AS Department,
        TRY_CAST(
            TRIM(
                SUBSTRING(
                    [Course (hr, crd)],
                    CHARINDEX('(', [Course (hr, crd)]) + 1,
                    CHARINDEX(',', [Course (hr, crd)]) - CHARINDEX('(', [Course (hr, crd)]) - 1
                )
            ) AS FLOAT
        ) AS Hours,
        TRY_CAST(
            TRIM(
                SUBSTRING(
                    [Course (hr, crd)],
                    CHARINDEX(',', [Course (hr, crd)]) + 1,
                    CHARINDEX(')', [Course (hr, crd)]) - CHARINDEX(',', [Course (hr, crd)]) - 1
                )
            ) AS INT
        ) AS Credits,
        [Day] AS Days,
        TRIM(LEFT([Time], CHARINDEX('-', [Time]) - 1)) AS ClassStart,
        TRIM(SUBSTRING([Time], CHARINDEX('-', [Time]) + 1, LEN([Time]))) AS ClassEnd,
        TRY_CAST([Enrolled] AS INT) AS Enrollment,
        TRY_CAST([Limit] AS INT) AS [Limit],
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] c
    WHERE
        [Course (hr, crd)] IS NOT NULL
        AND CHARINDEX(' ', [Course (hr, crd)]) > 0
        AND CHARINDEX('-', [Time]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into Class table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Course].[usp_LoadModeOfInstructionTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[ModeOfInstruction]
    (
        ModeName,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT [Mode of Instruction] AS ModeName, @UserAuthorizationKey, SYSDATETIME() AS DateAdded, SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings]
    --  Insert the user into the Process.WorkFlowTable
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription =  'Loading data into MOI table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Location].[usp_LoadBuildingLocationTable]
    @UserAuthorizationKey INT
AS
BEGIN
    -- Insert data into the BuildingLocation table
    INSERT INTO [Location].[BuildingLocation]
    (
        CourseCode,
        Description,
        Building,
        Day,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT
        [Code] AS CourseCode,
        [Description],
        TRIM(LEFT([Location], CHARINDEX(' ', [Location]) - 1)) AS Building,
        [Day],
        @UserAuthorizationKey AS UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings]
    WHERE
        [Location] IS NOT NULL
        AND CHARINDEX(' ', [Location]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into BuildingLocation table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Location].[usp_LoadRoomLocationTable]
    @UserAuthorizationKey INT
AS
BEGIN
    -- Insert data into the RoomLocation table
    INSERT INTO [Location].[RoomLocation]
    (
        Room,
        Time,
        Day,
        BuildingLocationID,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT
        TRIM(SUBSTRING(c.[Location], CHARINDEX(' ', c.[Location]) + 1, LEN(c.[Location]))) AS Room,
        c.[Time],
        c.[Day], -- Explicitly use table alias
        bl.BuildingLocationID,
        @UserAuthorizationKey AS UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] c
    INNER JOIN [Location].[BuildingLocation] bl
        ON bl.CourseCode = c.[Code]
    WHERE
        c.[Location] IS NOT NULL
        AND CHARINDEX(' ', c.[Location]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into RoomLocation table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

-- usp_LoadInstructorTable Procedure by Jascharan Singh

CREATE  PROCEDURE [Department].[usp_LoadInstructorTable]
    @UserAuthorizationKey INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Insert data into Department.Instructor table
    INSERT INTO [Department].[Instructor]
    (
        LastName,
        FirstName,
        DepartmentID,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        SUBSTRING([Instructor], 1, CHARINDEX(',', [Instructor]) - 1) AS LastName,
        LTRIM(SUBSTRING([Instructor], CHARINDEX(',', [Instructor]) + 1, LEN([Instructor]) - CHARINDEX(',', [Instructor]))) AS FirstName,
        1 AS DepartmentID,
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings]
    WHERE [Instructor] IS NOT NULL
          AND CHARINDEX(',', [Instructor]) > 0;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into Instructor table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Department].[usp_LoadDepartmentTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Department].[Department]
    (
        Department,
        InstructorID,
        FirstName,
        LastName,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        -- Extract department code (e.g., ACCT from ACCT 100)
        LEFT([Course (hr, crd)], CHARINDEX(' ', [Course (hr, crd)]) - 1) AS Department,
        -- InstructorID from the Instructor table
        inst.InstructorID,
        -- Extract LastName from Instructor column
        SUBSTRING(cso.[Instructor], 1, CHARINDEX(',', cso.[Instructor]) - 1) AS LastName,
        -- Extract FirstName from Instructor column
        LTRIM(SUBSTRING(cso.[Instructor], CHARINDEX(',', cso.[Instructor]) + 1, LEN(cso.[Instructor]) - CHARINDEX(',', cso.[Instructor]))) AS FirstName,
        @UserAuthorizationKey,
        SYSDATETIME() AS DateAdded,
        SYSDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] cso
    INNER JOIN [Department].[Instructor] inst
        ON inst.LastName = SUBSTRING(cso.[Instructor], 1, CHARINDEX(',', cso.[Instructor]) - 1)
        AND inst.FirstName = LTRIM(SUBSTRING(cso.[Instructor], CHARINDEX(',', cso.[Instructor]) + 1, LEN(cso.[Instructor]) - CHARINDEX(',', cso.[Instructor])))
    WHERE [Course (hr, crd)] IS NOT NULL
          AND CHARINDEX(' ', [Course (hr, crd)]) > 0
          AND cso.[Instructor] IS NOT NULL
          AND CHARINDEX(',', cso.[Instructor]) > 0;

    -- Log the workflow step
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkflowStepsDescription = 'Loading data into Department table',
        @WorkflowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Course].[usp_LoadCourseInstructorTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO [Course].[CourseInstructor]
    (
        CourseID,
        InstructorID,
        UserAuthorizationKey,
        DateAdded,
        DateOfLastUpdate
    )
    SELECT DISTINCT
        crs.CourseID,
        inst.InstructorID,
        @UserAuthorizationKey,
        SYSUTCDATETIME() AS DateAdded,
        SYSUTCDATETIME() AS DateOfLastUpdate
    FROM [Uploadfile].[CurrentSemesterCourseOfferings] cso
    INNER JOIN [Course].[Course] crs
        ON crs.[Course] = LTRIM(RTRIM(SUBSTRING(cso.[Course (hr, crd)], 1, CHARINDEX('(', cso.[Course (hr, crd)]) - 1)))
        AND crs.[Section] = cso.[Sec]
        AND crs.[Semester] = cso.[Semester]
    INNER JOIN [Department].[Instructor] inst
        ON inst.LastName = SUBSTRING(cso.[Instructor], 1, CHARINDEX(',', cso.[Instructor]) - 1)
        AND inst.FirstName = LTRIM(SUBSTRING(cso.[Instructor], CHARINDEX(',', cso.[Instructor]) + 1, LEN(cso.[Instructor]) - CHARINDEX(',', cso.[Instructor])));
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into CourseInstructor bridge table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

CREATE PROCEDURE [Course].[usp_LoadClassRoomTable]
    @UserAuthorizationKey INT
AS
BEGIN
    -- Insert the bridging records by matching Classes and RoomLocations based on Day and Time
    -- Class time = ClassStart + '-' + ClassEnd
    INSERT INTO [Course].[ClassRoom]
    (
        [ClassID],
        [RoomLocationID],
        [UserAuthorizationKey],
        [DateAdded],
        [DateOfLastUpdate]
    )
    SELECT
        cls.ClassID,
        rl.RoomLocationID,
        @UserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM [Course].[Class] cls
    INNER JOIN [Location].[RoomLocation] rl
        ON cls.Days = rl.Day
        AND (cls.ClassStart + '-' + cls.ClassEnd) = rl.Time;
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into ClassRoom bridge table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO

EXEC    [Course].[usp_LoadCourseTable]              @UserAuthorizationKey = 6
GO
EXEC    [Course].[usp_LoadClassTable]               @UserAuthorizationKey = 6
GO
EXEC    [Course].[usp_LoadModeOfInstructionTable]   @UserAuthorizationKey = 2
GO
EXEC    [Location].[usp_LoadBuildingLocationTable]  @UserAuthorizationKey = 2
GO
EXEC    [Location].[usp_LoadRoomLocationTable]      @UserAuthorizationKey = 2
GO
EXEC    [Department].[usp_LoadInstructorTable]      @UserAuthorizationKey = 4
GO
EXEC    [Department].[usp_LoadDepartmentTable]      @UserAuthorizationKey = 6
GO
EXEC    [Course].[usp_LoadCourseInstructorTable]    @UserAuthorizationKey = 2
GO
EXEC    [Course].[usp_LoadClassRoomTable]      		@UserAuthorizationKey = 5
GO