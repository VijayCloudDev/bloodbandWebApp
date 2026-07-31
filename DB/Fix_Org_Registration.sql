/*
  Fix_Org_Registration.sql
  -------------------------
  Run against an existing BloodBandDB_Main (or current) database to fix
  organization self-registration failures:

  1) sp_Organization_Create looked up RoleName = 'Admin' (seed has OrganizationAdmin)
  2) sp_User_Login Admin path excluded OrganizationAdmin (org managers could not log in)
  3) Common geo SPs referenced invalid tables State / District

  After running: restart the API and retry /register-organization.
*/

SET NOCOUNT ON;
GO

/* ---- 1) Organization create: correct role ---- */
CREATE OR ALTER PROCEDURE [dbo].[sp_Organization_Create]
    @Name NVARCHAR(150),
    @Description NVARCHAR(MAX),
    @CountryId INT,
    @StateId INT,
    @DistrictId INT,
    @Place NVARCHAR(150),
    @Pincode NVARCHAR(10),
    @PhoneNumber NVARCHAR(15),
    @Email NVARCHAR(100),
    @RegistrationNumber NVARCHAR(100),
    @RegistrationType NVARCHAR(50),
    @RegistrationDate DATE,
    @LicenseNumber NVARCHAR(100),
    @LicenseIssuedBy NVARCHAR(150),
    @PasswordHash NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;
    DECLARE @OrgRoleId INT;

    SELECT TOP 1 @StatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'Organization' AND sm.StatusName = 'Pending';

    SELECT TOP 1 @OrgRoleId = RoleId FROM Roles WHERE RoleName = 'OrganizationAdmin';

    IF @OrgRoleId IS NULL
        THROW 50001, 'OrganizationAdmin role is missing from Roles.', 1;

    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @NewUserId INT;
        INSERT INTO Users (FullName, PhoneNumber, Email, PasswordHash, IsActive, RoleId, CreatedAt)
        VALUES (@Name + ' Admin', @PhoneNumber, @Email, @PasswordHash, 1, @OrgRoleId, GETDATE());

        SET @NewUserId = SCOPE_IDENTITY();

        INSERT INTO Organizations
        (
            Name, Description, CountryId, StateId, DistrictId, Place, Pincode,
            PhoneNumber, Email, RegistrationNumber, RegistrationType, RegistrationDate,
            LicenseNumber, LicenseIssuedBy, CreatedBy, CreatedAt, StatusId
        )
        VALUES
        (
            @Name, @Description, @CountryId, @StateId, @DistrictId, @Place, @Pincode,
            @PhoneNumber, @Email, @RegistrationNumber, @RegistrationType, @RegistrationDate,
            @LicenseNumber, @LicenseIssuedBy, @NewUserId, GETDATE(), @StatusId
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

/* ---- 2) Login: allow OrganizationAdmin on Admin path ---- */
CREATE OR ALTER PROCEDURE [dbo].[sp_User_Login]
    @PhoneNumber NVARCHAR(15) = NULL,
    @Email NVARCHAR(100) = NULL,
    @LoginType NVARCHAR(10) -- 'User' or 'Admin'
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.UserId,
        u.FullName,
        u.PhoneNumber,
        u.Email,
        u.PasswordHash,
        u.RoleId,
        r.RoleName
    FROM Users u
    JOIN Roles r ON u.RoleId = r.RoleId
    WHERE u.IsActive = 1
      AND u.IsLocked = 0
      AND (
          (
            @LoginType = 'User'
            AND @PhoneNumber IS NOT NULL
            AND u.PhoneNumber = @PhoneNumber
            AND r.RoleName NOT IN ('Admin', 'OrganizationAdmin', 'SuperAdmin')
          )
          OR
          (
            @LoginType = 'Admin'
            AND @Email IS NOT NULL
            AND u.Email = @Email
            AND r.RoleName IN ('Admin', 'OrganizationAdmin', 'SuperAdmin')
          )
      )
END
GO

/* ---- 3) Geo lookups: correct table names ---- */
CREATE OR ALTER PROCEDURE [dbo].[sp_Common_GetStatesByCountryId]
    @CountryId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [StateId],
        [StateName]
    FROM States
    WHERE CountryId = @CountryId
      AND IsActive = 1
    ORDER BY StateName;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Common_GetDistrictsByStateId]
    @StateId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        DistrictId,
        DistrictName
    FROM Districts
    WHERE StateId = @StateId
    ORDER BY DistrictName;
END
GO

PRINT 'Org registration SP fixes applied successfully.';
GO
