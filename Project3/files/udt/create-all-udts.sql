-- =============================================
-- Author:		< Daniel Gargiullo, Oksana Weigand-Suminski >
-- Create date: < 12/3/2024 >
-- Description:	< Create UDT's >
-- =============================================

USE [QueensClassSchedule]
GO

CREATE  TYPE    [Udt].[SurrogateKeyInt]     FROM    [int]               NULL
GO
CREATE  TYPE    [Udt].[DateAdded]           FROM    Datetime2(7)    NOT NULL
GO
CREATE  TYPE    [Udt].[ClassTime]           FROM    NCHAR(5)        NOT NULL
GO
CREATE  TYPE    [Udt].[IndividualProject]   FROM    NVARCHAR(60)    NOT NULL
GO
CREATE  TYPE    [Udt].[LastName]            FROM    NVARCHAR(35)    NOT NULL
GO
CREATE  TYPE    [Udt].[FirstName]           FROM    NVARCHAR(20)    NOT NULL
GO
CREATE  TYPE    [Udt].[GroupName]           FROM    NVARCHAR(20)    NOT NULL
GO
CREATE  TYPE    [Udt].[String100]           FROM    NVARCHAR(100)   NOT NULL
GO
CREATE  TYPE    [Udt].[Rows]                FROM    [int]           NOT NULL
GO
CREATE  TYPE    [Udt].[String4]             FROM    NVARCHAR(4)         NULL
GO
CREATE  TYPE    [Udt].[String8]             FROM    NVARCHAR(8)         NULL
GO
CREATE  TYPE    [Udt].[String20]            FROM    NVARCHAR(20)        NULL
GO
CREATE  TYPE    [Udt].[String30]            FROM    NVARCHAR(30)    NOT NULL
GO
CREATE  TYPE    [Udt].[ClassLength]         FROM    NVARCHAR(30)    NOT NULL
GO
CREATE  TYPE    [Udt].[FloatField]          FROM    FLOAT           NOT NULL
GO