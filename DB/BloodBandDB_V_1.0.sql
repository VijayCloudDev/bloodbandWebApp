
-- BloodBandDB Complete SQL Script

CREATE DATABASE BloodBandDB;
GO
USE BloodBandDB;
GO

-- =========================
-- ROLES
-- =========================
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL
);

INSERT INTO Roles (RoleName) VALUES
('SuperAdmin'), ('OrganizationAdmin'), ('Donor'), ('Patient');

-- =========================
-- USERS
-- =========================
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    PhoneNumber NVARCHAR(15) UNIQUE,
    Email NVARCHAR(100),
    PasswordHash NVARCHAR(255),
    Gender NVARCHAR(10),
    BloodGroup NVARCHAR(5),
    LastDonatedDate DATETIME NULL,
    RoleId INT,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

-- =========================
-- ORGANIZATIONS
-- =========================
CREATE TABLE Organizations (
    OrganizationId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(150),
    Description NVARCHAR(MAX),
    State NVARCHAR(100),
    District NVARCHAR(100),
    Address NVARCHAR(255),
    IsApproved BIT DEFAULT 0,
    CreatedBy INT,
    CreatedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (CreatedBy) REFERENCES Users(UserId)
);

-- =========================
-- ORGANIZATION MEMBERS
-- =========================
CREATE TABLE OrganizationMembers (
    Id INT PRIMARY KEY IDENTITY,
    OrganizationId INT,
    UserId INT,
    Status NVARCHAR(20) DEFAULT 'Pending',
    JoinDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (OrganizationId) REFERENCES Organizations(OrganizationId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- =========================
-- BLOOD REQUESTS
-- =========================
CREATE TABLE BloodRequests (
    RequestId INT PRIMARY KEY IDENTITY,
    CreatedBy INT,
    PatientName NVARCHAR(100),
    BloodGroup NVARCHAR(5),
    UnitsNeeded INT,
    State NVARCHAR(100),
    District NVARCHAR(100),
    HospitalName NVARCHAR(150),
    Place NVARCHAR(150),
    Description NVARCHAR(MAX),
    RequestDate DATETIME,
    RequestTime NVARCHAR(20),
    Status NVARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (CreatedBy) REFERENCES Users(UserId)
);

-- =========================
-- DONATIONS
-- =========================
CREATE TABLE Donations (
    DonationId INT PRIMARY KEY IDENTITY,
    RequestId INT,
    DonorId INT,
    Status NVARCHAR(20) DEFAULT 'Accepted',
    DonatedDate DATETIME NULL,

    FOREIGN KEY (RequestId) REFERENCES BloodRequests(RequestId),
    FOREIGN KEY (DonorId) REFERENCES Users(UserId)
);

-- =========================
-- CHATS
-- =========================
CREATE TABLE Chats (
    ChatId INT PRIMARY KEY IDENTITY,
    SenderId INT,
    ReceiverId INT,
    Message NVARCHAR(MAX),
    SentAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (SenderId) REFERENCES Users(UserId),
    FOREIGN KEY (ReceiverId) REFERENCES Users(UserId)
);

-- =========================
-- NOTIFICATIONS
-- =========================
CREATE TABLE Notifications (
    NotificationId INT PRIMARY KEY IDENTITY,
    UserId INT,
    Message NVARCHAR(255),
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- =========================
-- HOSPITALS
-- =========================
CREATE TABLE Hospitals (
    HospitalId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(150),
    State NVARCHAR(100),
    District NVARCHAR(100),
    Address NVARCHAR(255),
    ContactNumber NVARCHAR(15)
);

-- =========================
-- ADVERTISEMENTS
-- =========================
CREATE TABLE Advertisements (
    AdId INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(150),
    ImageUrl NVARCHAR(255),
    RedirectUrl NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    StartDate DATETIME,
    EndDate DATETIME,
    CreatedBy INT,

    FOREIGN KEY (CreatedBy) REFERENCES Users(UserId)
);

-- =========================
-- STORED PROCEDURES
-- =========================

GO
CREATE PROCEDURE sp_User_Register
    @FullName NVARCHAR(100),
    @PhoneNumber NVARCHAR(15),
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(255),
    @BloodGroup NVARCHAR(5),
    @Gender NVARCHAR(10),
    @RoleId INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Users (FullName, PhoneNumber, Email, PasswordHash, BloodGroup, Gender, RoleId)
    VALUES (@FullName, @PhoneNumber, @Email, @PasswordHash, @BloodGroup, @Gender, @RoleId);
END
GO

CREATE PROCEDURE sp_User_Login
    @PhoneNumber NVARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM Users WHERE PhoneNumber = @PhoneNumber AND IsActive = 1;
END
GO

CREATE PROCEDURE sp_Request_Create
    @CreatedBy INT,
    @PatientName NVARCHAR(100),
    @BloodGroup NVARCHAR(5),
    @UnitsNeeded INT,
    @State NVARCHAR(100),
    @District NVARCHAR(100),
    @HospitalName NVARCHAR(150),
    @Place NVARCHAR(150),
    @Description NVARCHAR(MAX),
    @RequestDate DATETIME,
    @RequestTime NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO BloodRequests (
        CreatedBy, PatientName, BloodGroup, UnitsNeeded,
        State, District, HospitalName, Place,
        Description, RequestDate, RequestTime
    )
    VALUES (
        @CreatedBy, @PatientName, @BloodGroup, @UnitsNeeded,
        @State, @District, @HospitalName, @Place,
        @Description, @RequestDate, @RequestTime
    );
END
GO

CREATE PROCEDURE sp_Donation_Accept
    @RequestId INT,
    @DonorId INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Donations (RequestId, DonorId, Status)
    VALUES (@RequestId, @DonorId, 'Accepted');
END
GO

CREATE PROCEDURE sp_Ad_GetActive
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM Advertisements
    WHERE IsActive = 1
    AND GETDATE() BETWEEN StartDate AND EndDate;
END
GO

