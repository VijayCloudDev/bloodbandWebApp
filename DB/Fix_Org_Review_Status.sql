/*
  Fix_Org_Review_Status.sql
  -------------------------
  Adds status fields to org list + verifies IsVerified on approve.
  Run against your existing BloodBand database, then restart the API.
*/

SET NOCOUNT ON;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Organization_GetAll]
    @StatusId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        o.OrganizationId,
        o.Name,
        o.Description,
        o.Place,
        o.Pincode,
        o.PhoneNumber,
        o.Email,
        o.RegistrationNumber,
        o.RegistrationType,
        o.RegistrationDate,
        o.LicenseNumber,
        o.LicenseIssuedBy,
        o.IsVerified,
        o.CreatedAt,
        o.StatusId,
        sm.StatusName,
        c.CountryName,
        s.StateName,
        d.DistrictName
    FROM Organizations o
    LEFT JOIN StatusMaster sm ON o.StatusId = sm.StatusId
    LEFT JOIN Countries c ON o.CountryId = c.CountryId
    LEFT JOIN States s ON o.StateId = s.StateId
    LEFT JOIN Districts d ON o.DistrictId = d.DistrictId
    WHERE (@StatusId IS NULL OR o.StatusId = @StatusId)
    ORDER BY o.CreatedAt DESC;
END
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Organization_UpdateStatus]
    @OrganizationId INT,
    @StatusId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Organizations
    SET StatusId = @StatusId,
        IsVerified = CASE WHEN @StatusId = 2 THEN 1 ELSE 0 END
    WHERE OrganizationId = @OrganizationId;
END
GO

PRINT 'Organization review list/status SP fixes applied.';
GO
