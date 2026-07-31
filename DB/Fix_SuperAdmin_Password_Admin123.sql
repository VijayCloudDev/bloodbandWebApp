-- Fix SuperAdmin password hash so BCrypt.Verify("Admin@123", PasswordHash) returns true.
-- Run against your existing BloodBand database (BloodBandDB_Main / BloodBandDB_main).

USE [BloodBandDB_Main];
GO

UPDATE [dbo].[Users]
SET [PasswordHash] = N'$2a$11$xsrXH9d7S8A9.oWb9TwaGO9lpdxgXIspliRftVwB.w3IPL0jgFnbW',
    [FailedAttemptCount] = 0,
    [IsLocked] = 0,
    [LockedAt] = NULL
WHERE [Email] = N'superadmin@bloodband.com'
   OR [UserId] = 1;
GO

-- Login credentials after this script:
-- Email:    superadmin@bloodband.com
-- Password: Admin@123
-- Endpoint: POST /api/user/admin-login
