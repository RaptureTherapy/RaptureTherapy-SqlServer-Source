--------------------------------------------------------------------------------
-- Copyright © 2021+ Éamonn Anthony Duffy. All Rights Reserved.
--------------------------------------------------------------------------------
--
-- Version: V1.0.0.
--
-- Created: Éamonn A. Duffy, 2-May-2021.
--
-- Updated: Éamonn A. Duffy, 7-May-2022.
--
-- Purpose: Roll Back Script for the Main Sql for the Rapture Therapy Sql Server Database.
--
-- Assumptions:
--
--  0.  The Sql Server Database has already been Created by some other means, and has been selected for Use.
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Some Variables.
--------------------------------------------------------------------------------

:SETVAR DatabaseVersionMajor                     1
:SETVAR DatabaseVersionMinor                     0
:SETVAR DatabaseVersionPatch                     0
:SETVAR DatabaseVersionBuild                    "0"
:SETVAR DatabaseVersionDescription              "Beta Build."

:SETVAR Schema                                  "Dad"

--------------------------------------------------------------------------------
-- Drop Tables.
--------------------------------------------------------------------------------

IF OBJECT_ID(N'$(Schema).RaptureTherapyDatabaseVersions', N'U') IS NOT NULL
BEGIN
	IF EXISTS (SELECT 1 FROM $(Schema).RaptureTherapyDatabaseVersions WHERE Major = $(DatabaseVersionMajor) AND Minor = $(DatabaseVersionMinor) AND Patch = $(DatabaseVersionPatch) AND Build = N'$(DatabaseVersionBuild)')
	BEGIN
		DELETE FROM $(Schema).RaptureTherapyDatabaseVersions
		WHERE Major = $(DatabaseVersionMajor) AND Minor = $(DatabaseVersionMinor) AND Patch = $(DatabaseVersionPatch) AND Build = N'$(DatabaseVersionBuild)';
	END
END
GO

-- NOTE: In Future Versions *ONLY* DELETE the relevant Database Version Row and leave the Table otherwise intact.
DROP TABLE IF EXISTS $(Schema).RaptureTherapyDatabaseVersions;

--------------------------------------------------------------------------------
-- Drop Schema if/as appropriate.
--------------------------------------------------------------------------------

DROP SCHEMA IF EXISTS $(Schema);

--------------------------------------------------------------------------------

GO

--------------------------------------------------------------------------------
-- End Of File.
--------------------------------------------------------------------------------
