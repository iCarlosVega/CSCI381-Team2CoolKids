USE [master]
GO
/****** Object:  Database [QueensClassSchedule]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE DATABASE [QueensClassSchedule]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QC2019', FILENAME = N'/var/opt/mssql/data/QueensClassScheduleCurrentSemester.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QC2019_log', FILENAME = N'/var/opt/mssql/log/QueensClassScheduleCurrentSemester_0.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QueensClassSchedule] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QueensClassSchedule].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QueensClassSchedule] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET ARITHABORT OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QueensClassSchedule] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QueensClassSchedule] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QueensClassSchedule] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QueensClassSchedule] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET RECOVERY FULL 
GO
ALTER DATABASE [QueensClassSchedule] SET  MULTI_USER 
GO
ALTER DATABASE [QueensClassSchedule] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QueensClassSchedule] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QueensClassSchedule] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QueensClassSchedule] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QueensClassSchedule] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QueensClassSchedule] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QueensClassSchedule', N'ON'
GO
ALTER DATABASE [QueensClassSchedule] SET QUERY_STORE = OFF
GO
USE [QueensClassSchedule]
GO
/****** Object:  User [student]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE USER [student] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [EC3\thehitman]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE USER [EC3\thehitman] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BiStudent]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE USER [BiStudent] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [student]
GO
ALTER ROLE [db_owner] ADD MEMBER [EC3\thehitman]
GO
ALTER ROLE [db_datareader] ADD MEMBER [BiStudent]
GO
/****** Object:  Schema [Course]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Course]
GO
/****** Object:  Schema [DbSecurity]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [DbSecurity]
GO
/****** Object:  Schema [Department]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Department]
GO
/****** Object:  Schema [GroupNameProject3]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [GroupNameProject3]
GO
/****** Object:  Schema [Location]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Location]
GO
/****** Object:  Schema [Process]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Process]
GO
/****** Object:  Schema [Udt]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Udt]
GO
/****** Object:  Schema [Uploadfile]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Uploadfile]
GO
/****** Object:  Schema [Utils]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [Utils]
GO
/****** Object:  Schema [YourLastName]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE SCHEMA [YourLastName]
GO
/****** Object:  UserDefinedDataType [Udt].[ClassLength]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[ClassLength] FROM [nvarchar](30) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[ClassTime]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[ClassTime] FROM [nchar](5) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[DateAdded]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[DateAdded] FROM [datetime2](7) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[FirstName]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[FirstName] FROM [nvarchar](20) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[FloatField]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[FloatField] FROM [float] NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[GroupName]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[GroupName] FROM [nvarchar](20) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[IndividualProject]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[IndividualProject] FROM [nvarchar](60) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[LastName]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[LastName] FROM [nvarchar](35) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[Rows]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[Rows] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[String100]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[String100] FROM [nvarchar](100) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[String20]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[String20] FROM [nvarchar](20) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[String30]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[String30] FROM [nvarchar](30) NOT NULL
GO
/****** Object:  UserDefinedDataType [Udt].[String4]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[String4] FROM [nvarchar](4) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[String8]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[String8] FROM [nvarchar](8) NULL
GO
/****** Object:  UserDefinedDataType [Udt].[SurrogateKeyInt]    Script Date: 12/8/2024 5:23:23 PM ******/
CREATE TYPE [Udt].[SurrogateKeyInt] FROM [int] NULL
GO
/****** Object:  UserDefinedFunction [dbo].[JSONHierarchy]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[JSONHierarchy]
(
    @JSONData varchar(max)
  , @Parent_object_ID int = null
  , @MaxObject_id int = 0
  , @type int = null
)
returns @ReturnTable table
(											  
	-- https://www.red-gate.com/simple-talk/blogs/consuming-hierarchical-json-documents-sql-server-using-openjson/?utm_source=simpletalk&utm_medium=pubemail&utm_content=20171010-slota1&utm_term=simpletalkmain 
	--
    Element_ID int identity(1, 1) primary key /* internal surrogate primary key gives the order of parsing and the list order */
  , SequenceNo int null                       /* the sequence number in a list */
  , Parent_ID int                             /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
  , Object_ID int                             /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
  , Name nvarchar(2000)                       /* the name of the object */
  , StringValue nvarchar(max) not null        /*the string representation of the value of the element. */
  , ValueType varchar(10) not null            /* the declared type of the value represented as a string in StringValue*/
)
as
begin
    --the types of JSON
    declare @null    int = 0
          , @string  int = 1
          , @int     int = 2
          , @boolean int = 3
          , @array   int = 4
          , @object  int = 5;

    declare @OpenJSONData table
    (
        sequence int identity(1, 1)
      , [key] varchar(200)
      , Value varchar(max)
      , type int
    );

    declare @key       varchar(200)
          , @Value     varchar(max)
          , @Thetype   int
          , @ii        int
          , @iiMax     int
          , @NewObject int
          , @firstchar char(1);

    insert into @OpenJSONData
    (
        [key]
      , Value
      , type
    )
    select [Key]
         , Value
         , Type
    from openjson(@JSONData);
    select @ii    = 1
         , @iiMax = scope_identity();
    select @firstchar
        = --the first character to see if it is an object or an array
        substring(
                     @JSONData
                   , patindex(
                                 '%[^' + char(0) + '- ' + char(160) + ']%'
                               , ' ' + @JSONData + '!' collate SQL_Latin1_General_CP850_BIN
                             ) - 1
                   , 1
                 );
    if @type is null
       and @firstchar in ( '[', '{' )
    begin
        insert into @ReturnTable
        (
            SequenceNo
          , Parent_ID
          , Object_ID
          , Name
          , StringValue
          , ValueType
        )
        select 1
             , null
             , 1
             , '-'
             , ''
             , case @firstchar
                   when '[' then
                       'array'
                   else
                       'object'
               end;
        select @type             = case @firstchar
                                       when '[' then
                                           @array
                                       else
                                           @object
                                   end
             , @Parent_object_ID = 1
             , @MaxObject_id     = coalesce(@MaxObject_id, 1) + 1;
    end;
    while (@ii <= @iiMax)
    begin
        --OpenJSON renames list items with 0-nn which confuses the consumers of the table
        select @key     = case
                              when [key] like '[0-9]%' then
                                  null
                              else
                                  [key]
                          end
             , @Value   = Value
             , @Thetype = type
        from @OpenJSONData
        where sequence = @ii;

        if @Thetype in ( @array, @object ) --if we have been returned an array or object
        begin
            select @MaxObject_id = coalesce(@MaxObject_id, 1) + 1;
            --just in case we have an object or array returned
            insert into @ReturnTable --record the object itself
            (
                SequenceNo
              , Parent_ID
              , Object_ID
              , Name
              , StringValue
              , ValueType
            )
            select @ii
                 , @Parent_object_ID
                 , @MaxObject_id
                 , @key
                 , ''
                 , case @Thetype
                       when @array then
                           'array'
                       else
                           'object'
                   end;

            insert into @ReturnTable --and return all its children
            (
                SequenceNo
              , Parent_ID
              , Object_ID
              , [Name]
              , StringValue
              , ValueType
            )
            select SequenceNo
                 , Parent_ID
                 , Object_ID
                 , [Name]
                 , StringValue
                 , ValueType
            from dbo.JSONHierarchy(@Value, @MaxObject_id, @MaxObject_id, @type);
            select @MaxObject_id = max(Object_ID) + 1
            from @ReturnTable;
        end;
        else
            insert into @ReturnTable
            (
                SequenceNo
              , Parent_ID
              , Object_ID
              , Name
              , StringValue
              , ValueType
            )
            select @ii
                 , @Parent_object_ID
                 , null
                 , @key
                 , @Value
                 , case @Thetype
                       when @string then
                           'string'
                       when @null then
                           'null'
                       when @int then
                           'int'
                       when @boolean then
                           'boolean'
                       else
                           'int'
                   end;

        select @ii = @ii + 1;
    end;

    return;
end;
GO
/****** Object:  UserDefinedFunction [dbo].[DatabaseObjects]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[DatabaseObjects]
/**
    Summary: >
      lists out the full names, schemas and (where appropriate)
      the owner of the object.
    Author: PhilFactor
    Date: 10/9/2017
    Examples:
       - Select * from dbo.DatabaseObjects('2123154609,960722475,1024722703')
    Returns: >
      A table with the id, name of object and so on.
            **/
(
    @ListOfObjectIDs varchar(max)
)
returns table
--WITH ENCRYPTION|SCHEMABINDING, ..
as
return
(
    select object_id
         , schema_name(schema_id) + '.' + coalesce(object_name(parent_object_id) + '.', '') + name as name
    from sys.objects as ob
        inner join openjson(N'[' + @ListOfObjectIDs + N']')
            on convert(int, Value) = ob.object_id
);
GO
/****** Object:  View [Utils].[uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Utils].[uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint] AS
SELECT  CONCAT(tbl.TABLE_SCHEMA, '.', tbl.TABLE_NAME) AS FullyQualifiedTableName ,
        tbl.TABLE_SCHEMA AS SchemaName ,
        tbl.TABLE_NAME AS TableName ,
        col.COLUMN_NAME AS ColumnName ,
        col.ORDINAL_POSITION AS OrdinalPosition,
        CONCAT(col.DOMAIN_SCHEMA, '.', col.DOMAIN_NAME) AS FullyQualifiedDomainName ,
        col.DOMAIN_NAME AS DomainName ,
        CASE 
			 WHEN col.DATA_TYPE = 'varchar'
             THEN CONCAT('varchar(', CHARACTER_MAXIMUM_LENGTH, ')')
			 WHEN col.DATA_TYPE = 'nvarchar'
             THEN CONCAT('nvarchar(', CHARACTER_MAXIMUM_LENGTH, ')')
			 WHEN col.DATA_TYPE = 'nchar'
             THEN CONCAT('nchar(', CHARACTER_MAXIMUM_LENGTH, ')')
             WHEN col.DATA_TYPE = 'numeric'
             THEN CONCAT('numeric(', NUMERIC_PRECISION_RADIX, ', ',
                         NUMERIC_SCALE, ')')
             WHEN col.DATA_TYPE = 'decimal'
             THEN CONCAT('decimal(', NUMERIC_PRECISION_RADIX, ', ',
                         NUMERIC_SCALE, ')')
             ELSE col.DATA_TYPE
        END AS DataType ,
        col.IS_NULLABLE AS IsNullable,
        dcn.DefaultName ,
        col.COLUMN_DEFAULT AS DefaultNameDefinition ,
        cc.CONSTRAINT_NAME AS CheckConstraintRuleName,
        cc.CHECK_CLAUSE  AS CheckConstraintRuleNameDefinition
FROM    ( SELECT    TABLE_CATALOG ,
                    TABLE_SCHEMA ,
                    TABLE_NAME ,
                    TABLE_TYPE
          FROM      INFORMATION_SCHEMA.TABLES
          WHERE     ( TABLE_TYPE = 'BASE TABLE' )
        ) AS tbl
        INNER JOIN ( SELECT TABLE_CATALOG ,
                            TABLE_SCHEMA ,
                            TABLE_NAME ,
                            COLUMN_NAME ,
                            ORDINAL_POSITION ,
                            COLUMN_DEFAULT ,
                            IS_NULLABLE ,
                            DATA_TYPE ,
                            CHARACTER_MAXIMUM_LENGTH ,
                            CHARACTER_OCTET_LENGTH ,
                            NUMERIC_PRECISION ,
                            NUMERIC_PRECISION_RADIX ,
                            NUMERIC_SCALE ,
                            DATETIME_PRECISION ,
                            CHARACTER_SET_CATALOG ,
                            CHARACTER_SET_SCHEMA ,
                            CHARACTER_SET_NAME ,
                            COLLATION_CATALOG ,
                            COLLATION_SCHEMA ,
                            COLLATION_NAME ,
                            DOMAIN_CATALOG ,
                            DOMAIN_SCHEMA ,
                            DOMAIN_NAME
                     FROM   INFORMATION_SCHEMA.COLUMNS
                   ) AS col ON col.TABLE_CATALOG = tbl.TABLE_CATALOG
                               AND col.TABLE_SCHEMA = tbl.TABLE_SCHEMA
                               AND col.TABLE_NAME = tbl.TABLE_NAME
        LEFT OUTER JOIN ( SELECT    t.name AS TableName ,
                                    SCHEMA_NAME(s.schema_id) AS SchemaName ,
                                    ac.name AS ColumnName ,
                                    d.name AS DefaultName
                          FROM      sys.all_columns AS ac
                                    INNER JOIN sys.tables AS t ON ac.object_id = t.object_id
                                    INNER JOIN sys.schemas AS s ON t.schema_id = s.schema_id
                                    INNER JOIN sys.default_constraints AS d ON ac.default_object_id = d.object_id
                        ) AS dcn ON dcn.SchemaName = tbl.TABLE_SCHEMA
                                    AND dcn.TableName = tbl.TABLE_NAME
                                    AND dcn.ColumnName = col.COLUMN_NAME
        LEFT OUTER JOIN ( SELECT    cu.TABLE_CATALOG ,
                                    cu.TABLE_SCHEMA ,
                                    cu.TABLE_NAME ,
                                    cu.COLUMN_NAME ,
                                    c.CONSTRAINT_CATALOG ,
                                    c.CONSTRAINT_SCHEMA ,
                                    c.CONSTRAINT_NAME ,
                                    c.CHECK_CLAUSE
                          FROM      INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
                                    AS cu
                                    INNER JOIN INFORMATION_SCHEMA.CHECK_CONSTRAINTS
                                    AS c ON c.CONSTRAINT_NAME = cu.CONSTRAINT_NAME
                        ) AS cc ON cc.TABLE_SCHEMA = tbl.TABLE_SCHEMA
                                   AND cc.TABLE_NAME = tbl.TABLE_NAME
                                   AND cc.COLUMN_NAME = col.COLUMN_NAME


GO
/****** Object:  Table [Course].[Class]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[Class](
	[ClassID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[Enrollment] [Udt].[SurrogateKeyInt] NULL,
	[Limit] [Udt].[SurrogateKeyInt] NULL,
	[Section] [Udt].[String30] NULL,
	[Department] [Udt].[String30] NULL,
	[Hours] [Udt].[FloatField] NULL,
	[Credits] [Udt].[SurrogateKeyInt] NULL,
	[Days] [Udt].[String30] NULL,
	[ClassStart] [Udt].[String20] NULL,
	[ClassEnd] [Udt].[String20] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Course].[ClassRoom]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[ClassRoom](
	[ClassRoomID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[ClassID] [Udt].[SurrogateKeyInt] NOT NULL,
	[RoomLocationID] [Udt].[SurrogateKeyInt] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
 CONSTRAINT [PK_ClassRoom] PRIMARY KEY CLUSTERED 
(
	[ClassRoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Course].[Course]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[Course](
	[CourseID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[Section] [Udt].[String4] NULL,
	[Course] [Udt].[String30] NULL,
	[Semester] [Udt].[String20] NULL,
	[Description] [Udt].[String100] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Course].[CourseInstructor]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[CourseInstructor](
	[CourseInstructorID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[CourseID] [Udt].[SurrogateKeyInt] NOT NULL,
	[InstructorID] [Udt].[SurrogateKeyInt] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseInstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Course].[ModeOfInstruction]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Course].[ModeOfInstruction](
	[ModeID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[ModeName] [Udt].[String100] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DbSecurity].[UserAuthorization]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DbSecurity].[UserAuthorization](
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[ClassTime] [Udt].[ClassTime] NULL,
	[IndividualProject] [Udt].[IndividualProject] NULL,
	[GroupMemberLastName] [Udt].[LastName] NOT NULL,
	[GroupMemberFirstName] [Udt].[FirstName] NOT NULL,
	[GroupName] [Udt].[GroupName] NOT NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserAuthorizationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Department].[Department]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Department].[Department](
	[DepartmentID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[Department] [Udt].[String8] NOT NULL,
	[InstructorID] [Udt].[SurrogateKeyInt] NOT NULL,
	[FirstName] [Udt].[String30] NOT NULL,
	[LastName] [Udt].[String30] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Department].[Instructor]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Department].[Instructor](
	[InstructorID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [Udt].[SurrogateKeyInt] NOT NULL,
	[FirstName] [Udt].[String30] NOT NULL,
	[LastName] [Udt].[String30] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Location].[BuildingLocation]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Location].[BuildingLocation](
	[BuildingLocationID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[CourseCode] [Udt].[String30] NOT NULL,
	[Description] [Udt].[String100] NULL,
	[Building] [Udt].[String30] NOT NULL,
	[Day] [Udt].[String30] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[BuildingLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Location].[RoomLocation]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Location].[RoomLocation](
	[RoomLocationID] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[Room] [Udt].[String30] NOT NULL,
	[Time] [Udt].[String20] NOT NULL,
	[Day] [Udt].[String20] NOT NULL,
	[BuildingLocationID] [Udt].[SurrogateKeyInt] NOT NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NULL,
	[DateAdded] [Udt].[DateAdded] NULL,
	[DateOfLastUpdate] [Udt].[DateAdded] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Process].[WorkFlowSteps]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[WorkFlowSteps](
	[WorkFlowStepsKey] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[WorkFlowStepsDescription] [Udt].[String100] NOT NULL,
	[WorkFlowStepsTableRowCount] [Udt].[Rows] NULL,
	[StartingDateTime] [Udt].[DateAdded] NULL,
	[EndDateTime] [Udt].[DateAdded] NULL,
	[ClassTime] [Udt].[ClassTime] NULL,
	[UserAuthorizationKey] [Udt].[SurrogateKeyInt] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkFlowStepsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Uploadfile].[CurrentSemesterCourseOfferings]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Uploadfile].[CurrentSemesterCourseOfferings](
	[Semester] [varchar](50) NULL,
	[Sec] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[Course (hr, crd)] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Day] [varchar](50) NULL,
	[Time] [varchar](50) NULL,
	[Instructor] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[Enrolled] [varchar](50) NULL,
	[Limit] [varchar](50) NULL,
	[Mode of Instruction] [varchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [Course].[Class] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Course].[Class] ADD  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [Course].[ClassRoom] ADD  CONSTRAINT [DF_ClassRoom_DateAdded]  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Course].[ClassRoom] ADD  CONSTRAINT [DF_ClassRoom_DateOfLastUpdate]  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('10:45') FOR [ClassTime]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('Project 3') FOR [IndividualProject]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT ('Group 2') FOR [GroupName]
GO
ALTER TABLE [DbSecurity].[UserAuthorization] ADD  DEFAULT (sysdatetime()) FOR [DateAdded]
GO
ALTER TABLE [Process].[WorkFlowSteps] ADD  DEFAULT ((0)) FOR [WorkFlowStepsTableRowCount]
GO
ALTER TABLE [Process].[WorkFlowSteps] ADD  DEFAULT (sysdatetime()) FOR [StartingDateTime]
GO
ALTER TABLE [Process].[WorkFlowSteps] ADD  DEFAULT (sysdatetime()) FOR [EndDateTime]
GO
ALTER TABLE [Process].[WorkFlowSteps] ADD  DEFAULT ('10:45') FOR [ClassTime]
GO
ALTER TABLE [Uploadfile].[CurrentSemesterCourseOfferings] ADD  CONSTRAINT [DF_CurrentSemesterCourseOfferings_Semester]  DEFAULT ('Current Semester') FOR [Semester]
GO
ALTER TABLE [Course].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[Class] CHECK CONSTRAINT [FK_Class_UserAuthorization]
GO
ALTER TABLE [Course].[ClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoom_Class] FOREIGN KEY([ClassID])
REFERENCES [Course].[Class] ([ClassID])
GO
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_Class]
GO
ALTER TABLE [Course].[ClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoom_RoomLocation] FOREIGN KEY([RoomLocationID])
REFERENCES [Location].[RoomLocation] ([RoomLocationID])
GO
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_RoomLocation]
GO
ALTER TABLE [Course].[ClassRoom]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoom_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_UserAuthorization]
GO
ALTER TABLE [Course].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[Course] CHECK CONSTRAINT [FK_Course_UserAuthorization]
GO
ALTER TABLE [Course].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_Course] FOREIGN KEY([CourseID])
REFERENCES [Course].[Course] ([CourseID])
GO
ALTER TABLE [Course].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_Course]
GO
ALTER TABLE [Course].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [Department].[Instructor] ([InstructorID])
GO
ALTER TABLE [Course].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_Instructor]
GO
ALTER TABLE [Course].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_UserAuthorization]
GO
ALTER TABLE [Course].[ModeOfInstruction]  WITH CHECK ADD  CONSTRAINT [FK_ModeOfInstruction_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Course].[ModeOfInstruction] CHECK CONSTRAINT [FK_ModeOfInstruction_UserAuthorization]
GO
ALTER TABLE [Department].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Department].[Department] CHECK CONSTRAINT [FK_Department_UserAuthorization]
GO
ALTER TABLE [Department].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Department] FOREIGN KEY([DepartmentID])
REFERENCES [Department].[Department] ([DepartmentID])
GO
ALTER TABLE [Department].[Instructor] CHECK CONSTRAINT [FK_Instructor_Department]
GO
ALTER TABLE [Department].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Department].[Instructor] CHECK CONSTRAINT [FK_Instructor_UserAuthorization]
GO
ALTER TABLE [Location].[BuildingLocation]  WITH CHECK ADD  CONSTRAINT [FK_BuildingLocation_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Location].[BuildingLocation] CHECK CONSTRAINT [FK_BuildingLocation_UserAuthorization]
GO
ALTER TABLE [Location].[RoomLocation]  WITH CHECK ADD  CONSTRAINT [FK_RoomLocation_BuildingLocation] FOREIGN KEY([BuildingLocationID])
REFERENCES [Location].[BuildingLocation] ([BuildingLocationID])
GO
ALTER TABLE [Location].[RoomLocation] CHECK CONSTRAINT [FK_RoomLocation_BuildingLocation]
GO
ALTER TABLE [Location].[RoomLocation]  WITH CHECK ADD  CONSTRAINT [FK_RoomLocation_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Location].[RoomLocation] CHECK CONSTRAINT [FK_RoomLocation_UserAuthorization]
GO
ALTER TABLE [Process].[WorkFlowSteps]  WITH CHECK ADD  CONSTRAINT [FK_WorkFlowSteps_UserAuthorization] FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization] ([UserAuthorizationKey])
GO
ALTER TABLE [Process].[WorkFlowSteps] CHECK CONSTRAINT [FK_WorkFlowSteps_UserAuthorization]
GO
/****** Object:  StoredProcedure [Course].[usp_LoadClassRoomTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a stored procedure to populate the ClassRoom table
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

    -- Log the workflow step
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey,
        @WorkFlowStepsDescription = 'Loading data into ClassRoom bridge table',
        @WorkFlowStepsTableRowCount = @@ROWCOUNT;
END;
GO
/****** Object:  StoredProcedure [Course].[usp_LoadClassTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [Course].[usp_LoadCourseInstructorTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [Course].[usp_LoadCourseTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Course].[usp_LoadCourseTable]
    @UserAuthorizationKey INT
AS
BEGIN
    INSERT INTO Course.Course
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
/****** Object:  StoredProcedure [Course].[usp_LoadModeOfInstructionTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [Department].[usp_LoadDepartmentTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
    EXEC [Process].[usp_TrackWorkFlow]
        @UserAuthorizationKey = @UserAuthorizationKey, 
        @WorkflowStepsDescription = 'Loading data into Department table',
        @WorkflowStepsTableRowCount = @@ROWCOUNT;
END;

GO
/****** Object:  StoredProcedure [Department].[usp_LoadInstructorTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_LoadInstructorTable Procedure by Jascharan Singh
CREATE  PROCEDURE [Department].[usp_LoadInstructorTable]
    @UserAuthorizationKey INT
AS
BEGIN
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
/****** Object:  StoredProcedure [Location].[usp_LoadBuildingLocationTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Location].[usp_LoadBuildingLocationTable]
    @UserAuthorizationKey INT
AS
BEGIN
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
/****** Object:  StoredProcedure [Location].[usp_LoadRoomLocationTable]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Location].[usp_LoadRoomLocationTable]
    @UserAuthorizationKey INT
AS
BEGIN
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
/****** Object:  StoredProcedure [Process].[usp_AddForeignKeys]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Process].[usp_AddForeignKeys]

    @UserAuthorizationKey INT
AS
BEGIN

 -- Add foreign key [Course].[Class]
ALTER TABLE [Course].[Class]
ADD CONSTRAINT FK_Class_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Course].[Course]
ALTER TABLE [Course].[Course]
ADD CONSTRAINT FK_Course_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Course].[CourseInstructor]
ALTER TABLE [Course].[CourseInstructor]
ADD CONSTRAINT FK_CourseInstructor_Course FOREIGN KEY (CourseID)
    REFERENCES [Course].[Course](CourseID);

ALTER TABLE [Course].[CourseInstructor]
ADD CONSTRAINT FK_CourseInstructor_Instructor FOREIGN KEY (InstructorID)
    REFERENCES [Department].[Instructor](InstructorID);

ALTER TABLE [Course].[CourseInstructor]
ADD CONSTRAINT FK_CourseInstructor_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
    REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Course].[ModeOfInstruction]
ALTER TABLE [Course].[ModeOfInstruction]
ADD CONSTRAINT FK_ModeOfInstruction_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Department].[Department]
ALTER TABLE [Department].[Department]
ADD CONSTRAINT FK_Department_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Department].[Instructor]
ALTER TABLE [Department].[Instructor]
ADD CONSTRAINT FK_Instructor_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

ALTER TABLE [Department].[Instructor]
ADD CONSTRAINT FK_Instructor_Department FOREIGN KEY (DepartmentID)
REFERENCES [Department].[Department](DepartmentID);

-- Add foreign key [Location].[BuildingLocation]
ALTER TABLE [Location].[BuildingLocation]
ADD CONSTRAINT FK_BuildingLocation_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Location].[RoomLocation]
ALTER TABLE [Location].[RoomLocation]
ADD CONSTRAINT FK_RoomLocation_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

ALTER TABLE [Location].[RoomLocation]
ADD CONSTRAINT FK_RoomLocation_BuildingLocation FOREIGN KEY (BuildingLocationID)
REFERENCES [Location].[BuildingLocation](BuildingLocationID);

-- Add foreign key [Process].[WorkFlowSteps]
ALTER TABLE [Process].[WorkFlowSteps]
ADD CONSTRAINT FK_WorkFlowSteps_UserAuthorization FOREIGN KEY (UserAuthorizationKey)
REFERENCES [DbSecurity].[UserAuthorization](UserAuthorizationKey);

-- Add foreign key [Course].[ClassRoom]
ALTER TABLE [Course].[ClassRoom] WITH CHECK 
ADD CONSTRAINT [FK_ClassRoom_Class] 
FOREIGN KEY([ClassID])
REFERENCES [Course].[Class]([ClassID]);
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_Class];

ALTER TABLE [Course].[ClassRoom] WITH CHECK 
ADD CONSTRAINT [FK_ClassRoom_RoomLocation] 
FOREIGN KEY([RoomLocationID])
REFERENCES [Location].[RoomLocation]([RoomLocationID]);
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_RoomLocation];

-- Tie UserAuthorizationKey to UserAuthorization table

ALTER TABLE [Course].[ClassRoom] WITH CHECK 
ADD CONSTRAINT [FK_ClassRoom_UserAuthorization]
FOREIGN KEY([UserAuthorizationKey])
REFERENCES [DbSecurity].[UserAuthorization]([UserAuthorizationKey]);
ALTER TABLE [Course].[ClassRoom] CHECK CONSTRAINT [FK_ClassRoom_UserAuthorization];

EXEC [Process].[usp_TrackWorkFlow]
@UserAuthorizationKey = @UserAuthorizationKey,
@WorkFlowStepsDescription = 'Add Foreign Keys to DB',
@WorkFlowStepsTableRowCount = @@ROWCOUNT;

END

GO
/****** Object:  StoredProcedure [Process].[usp_ShowWorkFlowSteps]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Process].[usp_ShowWorkFlowSteps] 
AS
BEGIN
	SELECT *
	FROM [Process].[WorkFlowSteps];
END;

GO
/****** Object:  StoredProcedure [Process].[usp_TrackWorkFlow]    Script Date: 12/8/2024 5:23:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Process].[usp_TrackWorkFlow]
    @UserAuthorizationKey INT,
    @WorkFlowStepsTableRowCount INT,
    @WorkFlowStepsDescription NVARCHAR(100)
AS
BEGIN
    INSERT INTO [Process].[WorkFlowSteps]
        (UserAuthorizationKey, WorkFlowStepsTableRowCount, WorkFlowStepsDescription)
    VALUES(@UserAuthorizationKey, @WorkFlowStepsTableRowCount, @WorkFlowStepsDescription);
END;

GO
USE [master]
GO
ALTER DATABASE [QueensClassSchedule] SET  READ_WRITE 
GO
