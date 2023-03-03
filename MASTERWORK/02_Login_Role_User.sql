USE Borderless
GO

-- Create SQL login
CREATE LOGIN HELPERS
    WITH PASSWORD = N'Refuge',
    CHECK_POLICY = OFF,
    CHECK_EXPIRATION = OFF,
    DEFAULT_DATABASE = Borderless;
GO

-- Create database users for the login
CREATE USER JoakaroJoe FOR LOGIN HELPERS;
GO
CREATE USER DolgosPaul WITHOUT LOGIN;
GO
CREATE USER BeszedesTeca WITHOUT LOGIN;
GO

-- Create database roles
CREATE ROLE [Project Manager];
GO
CREATE ROLE [Project Team Leader];
GO
CREATE ROLE [Project Assistant];
GO

-- Add user to each database role
ALTER ROLE [Project Manager] ADD MEMBER JoakaroJoe;
GO
ALTER ROLE [Project Team Leader] ADD MEMBER DolgosPaul;
GO
ALTER ROLE [Project Assistant] ADD MEMBER BeszedesTeca;
GO

-- Grant select, update, delete, insert permissions on the "Aid" schema to the "Project Manager" database role
GRANT SELECT, UPDATE, DELETE, INSERT ON SCHEMA::Aid TO [Project Manager];
GO

-- Grant select permissions on the "Aid" schema to the "Project" database role
GRANT SELECT ON SCHEMA::Aid TO [Project Team Leader];
GO

-- Grant select on the "Aid.APL" table to the "Project assistant" database role
GRANT SELECT ON Aid.APL TO [Project assistant];
GO