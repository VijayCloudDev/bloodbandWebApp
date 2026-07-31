USE [master]
GO
/****** Object:  Database [BloodBandDB_Main]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE DATABASE [BloodBandDB_Main]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BloodBandDB_Main', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BloodBandDB_Main.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BloodBandDB_Main_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BloodBandDB_Main_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BloodBandDB_Main] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BloodBandDB_Main].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BloodBandDB_Main] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET ARITHABORT OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BloodBandDB_Main] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BloodBandDB_Main] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BloodBandDB_Main] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BloodBandDB_Main] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET RECOVERY FULL 
GO
ALTER DATABASE [BloodBandDB_Main] SET  MULTI_USER 
GO
ALTER DATABASE [BloodBandDB_Main] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BloodBandDB_Main] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BloodBandDB_Main] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BloodBandDB_Main] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BloodBandDB_Main] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BloodBandDB_Main] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BloodBandDB_Main] SET QUERY_STORE = ON
GO
ALTER DATABASE [BloodBandDB_Main] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BloodBandDB_Main]
GO
/****** Object:  Table [dbo].[Advertisements]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisements](
	[AdId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[RedirectUrl] [nvarchar](255) NULL,
	[IsActive] [bit] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BloodGroups]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloodGroups](
	[BloodGroupId] [int] IDENTITY(1,1) NOT NULL,
	[BloodGroupName] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BloodGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BloodRequests]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BloodRequests](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [int] NULL,
	[PatientName] [nvarchar](100) NULL,
	[UnitsNeeded] [int] NULL,
	[State] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[HospitalName] [nvarchar](150) NULL,
	[Place] [nvarchar](150) NULL,
	[Description] [nvarchar](max) NULL,
	[RequestDate] [datetime] NULL,
	[RequestTime] [nvarchar](20) NULL,
	[StatusId] [int] NULL,
	[BloodGroupId] [int] NULL,
 CONSTRAINT [PK__BloodReq__33A8517A85A39A3C] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chats]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chats](
	[ChatId] [int] IDENTITY(1,1) NOT NULL,
	[SenderId] [int] NULL,
	[ReceiverId] [int] NULL,
	[Message] [nvarchar](max) NULL,
	[SentAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ChatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Districts]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Districts](
	[DistrictId] [int] IDENTITY(1,1) NOT NULL,
	[StateId] [int] NULL,
	[DistrictName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Donations]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[DonationId] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NULL,
	[DonorId] [int] NULL,
	[DonatedDate] [datetime] NULL,
	[StatusId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DonationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailAlerts]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAlerts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Email] [nvarchar](100) NULL,
	[Subject] [nvarchar](200) NULL,
	[Body] [nvarchar](max) NULL,
	[IsSent] [bit] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hospitals]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hospitals](
	[HospitalId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[State] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[Address] [nvarchar](255) NULL,
	[ContactNumber] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[HospitalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Message] [nvarchar](255) NULL,
	[IsRead] [bit] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganizationMembers]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationId] [int] NULL,
	[UserId] [int] NULL,
	[JoinDate] [datetime] NULL,
	[StatusId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganizationRegistrationTypes]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationRegistrationTypes](
	[RegistrationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OrganizationRegistrationTypes] PRIMARY KEY CLUSTERED 
(
	[RegistrationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organizations]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizations](
	[OrganizationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Description] [nvarchar](max) NULL,
	[State] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[Address] [nvarchar](255) NULL,
	[Place] [nvarchar](150) NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[StatusId] [int] NULL,
	[CountryId] [int] NULL,
	[StateId] [int] NULL,
	[DistrictId] [int] NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL,
	[Website] [nvarchar](150) NULL,
	[OrganizationTypeId] [int] NULL,
	[RegistrationNumber] [nvarchar](100) NULL,
	[RegistrationType] [nvarchar](50) NULL,
	[RegistrationDate] [date] NULL,
	[LicenseNumber] [nvarchar](100) NULL,
	[LicenseIssuedBy] [nvarchar](150) NULL,
	[IsVerified] [bit] NULL,
	[Pincode] [nvarchar](10) NULL,
 CONSTRAINT [PK__Organiza__CADB0B1291A78A61] PRIMARY KEY CLUSTERED 
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrganizationTypes]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationTypes](
	[OrganizationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrganizationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordChangeLogs]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordChangeLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ChangedAt] [datetime] NULL,
	[IsSuccess] [bit] NULL,
	[FailureReason] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Token] [nvarchar](500) NULL,
	[Expires] [datetime] NULL,
	[IsRevoked] [bit] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NULL,
	[StateName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusMaster]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusMaster](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusTypeId] [int] NULL,
	[StatusName] [nvarchar](50) NULL,
 CONSTRAINT [PK__StatusMa__C8EE20636425EDB3] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTypeMaster]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTypeMaster](
	[StatusTypeId] [int] IDENTITY(1,1) NOT NULL,
	[StatusType] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatusTypeMaster] PRIMARY KEY CLUSTERED 
(
	[StatusTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL,
	[PasswordHash] [nvarchar](255) NULL,
	[Gender] [nvarchar](10) NULL,
	[LastDonatedDate] [datetime] NULL,
	[RoleId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[FailedAttemptCount] [int] NULL,
	[IsLocked] [bit] NULL,
	[LockedAt] [datetime] NULL,
	[ProfileImageUrl] [nvarchar](255) NULL,
	[CountryId] [int] NULL,
	[StateId] [int] NULL,
	[DistrictId] [int] NULL,
	[Place] [nvarchar](150) NULL,
	[CurrentAddress] [nvarchar](255) NULL,
	[PermanentAddress] [nvarchar](255) NULL,
	[BloodGroupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BloodGroups] ON 
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (1, N'A+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (2, N'A-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (3, N'B+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (4, N'B-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (5, N'AB+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (6, N'AB-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (7, N'O+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (8, N'O-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (9, N'A+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (10, N'A-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (11, N'B+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (12, N'B-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (13, N'AB+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (14, N'AB-')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (15, N'O+')
GO
INSERT [dbo].[BloodGroups] ([BloodGroupId], [BloodGroupName]) VALUES (16, N'O-')
GO
SET IDENTITY_INSERT [dbo].[BloodGroups] OFF
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 
GO
INSERT [dbo].[Countries] ([CountryId], [CountryName], [IsActive]) VALUES (1, N'India', 1)
GO
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Districts] ON 
GO
INSERT [dbo].[Districts] ([DistrictId], [StateId], [DistrictName]) VALUES (1, 1, N'Thiruvananthapuram')
GO
SET IDENTITY_INSERT [dbo].[Districts] OFF
GO
SET IDENTITY_INSERT [dbo].[OrganizationRegistrationTypes] ON 
GO
INSERT [dbo].[OrganizationRegistrationTypes] ([RegistrationTypeId], [RegistrationTypeName]) VALUES (2, N'GOV Trust')
GO
INSERT [dbo].[OrganizationRegistrationTypes] ([RegistrationTypeId], [RegistrationTypeName]) VALUES (1, N'NGO')
GO
INSERT [dbo].[OrganizationRegistrationTypes] ([RegistrationTypeId], [RegistrationTypeName]) VALUES (3, N'Private')
GO
SET IDENTITY_INSERT [dbo].[OrganizationRegistrationTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[OrganizationTypes] ON 
GO
INSERT [dbo].[OrganizationTypes] ([OrganizationTypeId], [TypeName]) VALUES (1, N'Hospital')
GO
INSERT [dbo].[OrganizationTypes] ([OrganizationTypeId], [TypeName]) VALUES (2, N'Blood Bank')
GO
INSERT [dbo].[OrganizationTypes] ([OrganizationTypeId], [TypeName]) VALUES (3, N'NGO')
GO
SET IDENTITY_INSERT [dbo].[OrganizationTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshTokens] ON 
GO
INSERT [dbo].[RefreshTokens] ([Id], [UserId], [Token], [Expires], [IsRevoked], [CreatedAt]) VALUES (1, 1, N'k7Kt1urXXsWzJSkHN4N3yg4lxE0oeK6hU68Skn25U6QpztvZ/enEGtE5i1LOSJ3qwtj19l0BINci0i+dVUqEcw==', CAST(N'2026-07-11T12:10:36.633' AS DateTime), 0, CAST(N'2026-07-04T12:10:46.877' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [UserId], [Token], [Expires], [IsRevoked], [CreatedAt]) VALUES (2, 1, N'aFXM3vTaFI9V4xLrmYC1kfTsynk6Fh/U+DmIk/XqxRvGHP4bvnhZh61OrcbJoOt2bOgxQ/HuYeGl4RGsVXxr/A==', CAST(N'2026-07-11T12:14:34.527' AS DateTime), 0, CAST(N'2026-07-04T12:14:35.617' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [UserId], [Token], [Expires], [IsRevoked], [CreatedAt]) VALUES (3, 1, N'WkZM16M+QL40orNXM9lCrRbv8Xzucd+y+EU5W4H2X4HME52I8jbY/DJke6vIg2zoeql6BfghVoxkwBpej/OtGw==', CAST(N'2026-07-11T12:43:23.100' AS DateTime), 0, CAST(N'2026-07-04T12:43:24.640' AS DateTime))
GO
INSERT [dbo].[RefreshTokens] ([Id], [UserId], [Token], [Expires], [IsRevoked], [CreatedAt]) VALUES (4, 1, N'T2Fp03U1zaYzzQTKqYAwxjx5MvetuBlMeoHex29rSBmlZCZKxrfAIR4BzjZmnfwG/HrttULfCJDrBZ/NtW1Jdg==', CAST(N'2026-07-14T16:13:00.813' AS DateTime), 0, CAST(N'2026-07-07T16:13:00.830' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[RefreshTokens] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'SuperAdmin')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'OrganizationAdmin')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (3, N'Donor')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (4, N'Patient')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[States] ON 
GO
INSERT [dbo].[States] ([StateId], [CountryId], [StateName], [IsActive]) VALUES (1, 1, N'Kerala', 1)
GO
SET IDENTITY_INSERT [dbo].[States] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusMaster] ON 
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (1, 1, N'Pending')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (2, 1, N'Approved')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (3, 1, N'Rejected')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (4, 2, N'Pending')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (5, 2, N'Approved')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (6, 2, N'Rejected')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (7, 3, N'Accepted')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (8, 3, N'Holding')
GO
INSERT [dbo].[StatusMaster] ([StatusId], [StatusTypeId], [StatusName]) VALUES (9, 3, N'Rejected')
GO
SET IDENTITY_INSERT [dbo].[StatusMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[StatusTypeMaster] ON 
GO
INSERT [dbo].[StatusTypeMaster] ([StatusTypeId], [StatusType]) VALUES (1, N'Organization')
GO
INSERT [dbo].[StatusTypeMaster] ([StatusTypeId], [StatusType]) VALUES (2, N'OrgMember')
GO
INSERT [dbo].[StatusTypeMaster] ([StatusTypeId], [StatusType]) VALUES (3, N'Donation')
GO
SET IDENTITY_INSERT [dbo].[StatusTypeMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserId], [FullName], [PhoneNumber], [Email], [PasswordHash], [Gender], [LastDonatedDate], [RoleId], [IsActive], [CreatedAt], [FailedAttemptCount], [IsLocked], [LockedAt], [ProfileImageUrl], [CountryId], [StateId], [DistrictId], [Place], [CurrentAddress], [PermanentAddress], [BloodGroupId]) VALUES (1, N'System Super Admin', N'0000000000', N'superadmin@bloodband.com', N'$2a$11$mC11XvG900fQoXq3j0B8puxL9MBy48DoxA6O7LDe8ZitwT56C2B4q', N'Male', NULL, 1, 1, CAST(N'2026-07-04T11:27:01.847' AS DateTime), 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_BloodRequests_StatusId]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_BloodRequests_StatusId] ON [dbo].[BloodRequests]
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_UserId]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_UserId] ON [dbo].[Notifications]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrganizationMembers_OrgId]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrganizationMembers_OrgId] ON [dbo].[OrganizationMembers]
(
	[OrganizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrganizationMembers_StatusId]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrganizationMembers_StatusId] ON [dbo].[OrganizationMembers]
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_OrganizationRegistrationTypes_RegistrationTypeName]    Script Date: 7/31/2026 12:09:00 PM ******/
ALTER TABLE [dbo].[OrganizationRegistrationTypes] ADD  CONSTRAINT [UQ_OrganizationRegistrationTypes_RegistrationTypeName] UNIQUE NONCLUSTERED 
(
	[RegistrationTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Org_RegistrationNumber]    Script Date: 7/31/2026 12:09:00 PM ******/
ALTER TABLE [dbo].[Organizations] ADD  CONSTRAINT [UQ_Org_RegistrationNumber] UNIQUE NONCLUSTERED 
(
	[RegistrationNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__85FB4E387172097B]    Script Date: 7/31/2026 12:09:00 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_BloodGroupId]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Users_BloodGroupId] ON [dbo].[Users]
(
	[BloodGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_PhoneNumber]    Script Date: 7/31/2026 12:09:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_Users_PhoneNumber] ON [dbo].[Users]
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Advertisements] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BloodRequests] ADD  CONSTRAINT [DF_BloodRequest_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Chats] ADD  DEFAULT (getdate()) FOR [SentAt]
GO
ALTER TABLE [dbo].[Countries] ADD  CONSTRAINT [DF_Countries_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Donations] ADD  CONSTRAINT [DF_Donation_Status]  DEFAULT ((7)) FOR [StatusId]
GO
ALTER TABLE [dbo].[EmailAlerts] ADD  DEFAULT ((0)) FOR [IsSent]
GO
ALTER TABLE [dbo].[EmailAlerts] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrganizationMembers] ADD  DEFAULT (getdate()) FOR [JoinDate]
GO
ALTER TABLE [dbo].[OrganizationMembers] ADD  CONSTRAINT [DF_OrgMember_Status]  DEFAULT ((4)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Organizations] ADD  CONSTRAINT [DF__Organizat__Creat__403A8C7D]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Organizations] ADD  CONSTRAINT [DF_Org_Status]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Organizations] ADD  CONSTRAINT [DF__Organizat__IsVer__4C6B5938]  DEFAULT ((0)) FOR [IsVerified]
GO
ALTER TABLE [dbo].[PasswordChangeLogs] ADD  DEFAULT (getdate()) FOR [ChangedAt]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT ((0)) FOR [IsRevoked]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[States] ADD  CONSTRAINT [DF_States_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [FailedAttemptCount]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsLocked]
GO
ALTER TABLE [dbo].[Advertisements]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BloodRequests]  WITH CHECK ADD  CONSTRAINT [FK__BloodRequ__Creat__4AB81AF0] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BloodRequests] CHECK CONSTRAINT [FK__BloodRequ__Creat__4AB81AF0]
GO
ALTER TABLE [dbo].[BloodRequests]  WITH CHECK ADD  CONSTRAINT [FK_BloodRequests_BloodGroup] FOREIGN KEY([BloodGroupId])
REFERENCES [dbo].[BloodGroups] ([BloodGroupId])
GO
ALTER TABLE [dbo].[BloodRequests] CHECK CONSTRAINT [FK_BloodRequests_BloodGroup]
GO
ALTER TABLE [dbo].[Chats]  WITH CHECK ADD FOREIGN KEY([ReceiverId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Chats]  WITH CHECK ADD FOREIGN KEY([SenderId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Districts]  WITH CHECK ADD FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD FOREIGN KEY([DonorId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK__Donations__Reque__4E88ABD4] FOREIGN KEY([RequestId])
REFERENCES [dbo].[BloodRequests] ([RequestId])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK__Donations__Reque__4E88ABD4]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donations_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusMaster] ([StatusId])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donations_Status]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[OrganizationMembers]  WITH CHECK ADD  CONSTRAINT [FK__Organizat__Organ__45F365D3] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
ALTER TABLE [dbo].[OrganizationMembers] CHECK CONSTRAINT [FK__Organizat__Organ__45F365D3]
GO
ALTER TABLE [dbo].[OrganizationMembers]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[OrganizationMembers]  WITH CHECK ADD  CONSTRAINT [FK_OrgMembers_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusMaster] ([StatusId])
GO
ALTER TABLE [dbo].[OrganizationMembers] CHECK CONSTRAINT [FK_OrgMembers_Status]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK__Organizat__Creat__412EB0B6] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK__Organizat__Creat__412EB0B6]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK_Org_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK_Org_Country]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK_Org_District] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[Districts] ([DistrictId])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK_Org_District]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK_Org_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK_Org_State]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [FK_Organizations_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusMaster] ([StatusId])
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [FK_Organizations_Status]
GO
ALTER TABLE [dbo].[PasswordChangeLogs]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[States]  WITH CHECK ADD FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[StatusMaster]  WITH CHECK ADD  CONSTRAINT [FK_StatusMaster_Type] FOREIGN KEY([StatusTypeId])
REFERENCES [dbo].[StatusTypeMaster] ([StatusTypeId])
GO
ALTER TABLE [dbo].[StatusMaster] CHECK CONSTRAINT [FK_StatusMaster_Type]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_BloodGroup] FOREIGN KEY([BloodGroupId])
REFERENCES [dbo].[BloodGroups] ([BloodGroupId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_BloodGroup]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Country]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_District] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[Districts] ([DistrictId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_District]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_State]
GO
ALTER TABLE [dbo].[Organizations]  WITH CHECK ADD  CONSTRAINT [CHK_Org_Pincode] CHECK  ((len([Pincode])>=(5) AND len([Pincode])<=(10)))
GO
ALTER TABLE [dbo].[Organizations] CHECK CONSTRAINT [CHK_Org_Pincode]
GO
/****** Object:  StoredProcedure [dbo].[sp_Ad_Create]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Ad_Create]
    @Title NVARCHAR(150),
    @ImageUrl NVARCHAR(255),
    @RedirectUrl NVARCHAR(255),
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Advertisements
    (Title, ImageUrl, RedirectUrl, IsActive, StartDate, EndDate, CreatedBy)
    VALUES
    (@Title, @ImageUrl, @RedirectUrl, 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), @CreatedBy);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Ad_GetActive]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Ad_GetActive]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM Advertisements
    WHERE IsActive = 1
    AND GETDATE() BETWEEN StartDate AND EndDate;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Ad_UpdateStatus]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Ad_UpdateStatus]
    @AdId INT,
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Advertisements
    SET IsActive = @IsActive
    WHERE AdId = @AdId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Chat_Get]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Chat_Get]
    @User1 INT,
    @User2 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Chats
    WHERE (SenderId = @User1 AND ReceiverId = @User2)
       OR (SenderId = @User2 AND ReceiverId = @User1)
    ORDER BY SentAt;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Chat_Send]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Chat_Send]
    @SenderId INT,
    @ReceiverId INT,
    @Message NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Chats (SenderId, ReceiverId, Message, SentAt)
    VALUES (@SenderId, @ReceiverId, @Message, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Common_GetCountries]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Common_GetCountries] --[dbo].[sp_Common_GetCountries]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [CountryId],
		[CountryName]
        
    FROM Countries
    WHERE IsActive = 1
    ORDER BY CountryName;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Common_GetDistrictsByStateId]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Common_GetDistrictsByStateId]
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
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_Common_GetRegistrationTypes]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Common_GetRegistrationTypes]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [RegistrationTypeId] AS [Id],
        [RegistrationTypeName] AS [Name]
    FROM [dbo].[OrganizationRegistrationTypes]
    ORDER BY [RegistrationTypeName];
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Common_GetStatesByCountryId]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Common_GetStatesByCountryId]
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
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Dashboard_Get]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Dashboard_Get]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------
    -- ✅ 1. TOTAL REQUESTS
    --------------------------------------------------
    SELECT COUNT(*) AS TotalRequests
    FROM BloodRequests;

    --------------------------------------------------
    -- ✅ 2. USER DONATIONS COUNT
    --------------------------------------------------
    SELECT COUNT(*) AS MyDonations
    FROM Donations
    WHERE DonorId = @UserId;

    --------------------------------------------------
    -- ✅ 3. PENDING REQUEST COUNT (FIXED ✅)
    --------------------------------------------------
    DECLARE @PendingStatusId INT;

    SELECT TOP 1 @PendingStatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm 
        ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'Request'
    AND sm.StatusName = 'Pending';

    SELECT COUNT(*) AS PendingRequests
    FROM BloodRequests
    WHERE StatusId = @PendingStatusId;

    --------------------------------------------------
    -- ✅ 4. RECENT BLOOD REQUESTS
    --------------------------------------------------
    SELECT TOP 5
    br.RequestId,
    br.PatientName,
    bg.BloodGroupName,
    br.UnitsNeeded,
    br.District,
    br.RequestDate
FROM BloodRequests br
LEFT JOIN BloodGroups bg ON br.BloodGroupId = bg.BloodGroupId
ORDER BY br.RequestDate DESC;

    --------------------------------------------------
    -- ✅ 5. RECENT NOTIFICATIONS
    --------------------------------------------------
    SELECT TOP 5
        NotificationId,
        Message,
        IsRead,
        CreatedAt
    FROM Notifications
    WHERE UserId = @UserId
    ORDER BY CreatedAt DESC;

    --------------------------------------------------
    -- ✅ 6. ORGANIZATION COUNT
    --------------------------------------------------
    SELECT COUNT(*) AS TotalOrganizations
    FROM Organizations;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Donation_Accept]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Donation_Accept]
    @RequestId INT,
    @DonorId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;

    SELECT TOP 1 @StatusId = StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'Donation' AND sm.StatusName = 'Holding';

    INSERT INTO Donations (RequestId, DonorId, StatusId)
    VALUES (@RequestId, @DonorId, @StatusId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Donation_Complete]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Donation_Complete]
    @DonationId INT
AS
BEGIN
    SET NOCOUNT ON;

   UPDATE Donations
	SET DonatedDate = GETDATE(),
    StatusId = (SELECT StatusId FROM StatusMaster WHERE StatusName = 'Completed')
	WHERE DonationId = @DonationId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Donation_GetByUser]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Donation_GetByUser]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.DonationId,
        d.RequestId,
        d.DonatedDate,
        sm.StatusName
    FROM Donations d
    LEFT JOIN StatusMaster sm ON d.StatusId = sm.StatusId
    WHERE d.DonorId = @UserId
    ORDER BY d.DonatedDate DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Master_GetBloodGroups]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Master_GetBloodGroups]
AS
BEGIN
    SELECT * FROM BloodGroups;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Master_GetCountries]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Master_GetCountries]
AS
BEGIN
    SELECT * FROM Countries;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Master_GetDistricts]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Master_GetDistricts]
    @StateId INT
AS
BEGIN
    SELECT * FROM Districts WHERE StateId = @StateId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Master_GetStates]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Master_GetStates]
    @CountryId INT
AS
BEGIN
    SELECT * FROM States WHERE CountryId = @CountryId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Notification_GetAll]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Notification_GetAll]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Notifications
    WHERE UserId = @UserId
    ORDER BY CreatedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Notification_IsOwner]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Notification_IsOwner]
    @NotificationId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(1)
    FROM Notifications
    WHERE NotificationId = @NotificationId
      AND UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Notification_Read]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Notification_Read]
    @NotificationId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Notifications
    SET IsRead = 1
    WHERE NotificationId = @NotificationId
      AND UserId = @UserId;

    SELECT @@ROWCOUNT AS AffectedRows;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Organization_Create]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Organization_Create]
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
    @PasswordHash NVARCHAR(MAX) -- Added parameter field
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;
    DECLARE @OrgRoleId INT;

    -- Fetch default Pending organization status index
    SELECT TOP 1 @StatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'Organization' AND sm.StatusName = 'Pending';

    -- Facility manager role (seed uses OrganizationAdmin, not Admin)
    SELECT TOP 1 @OrgRoleId = RoleId FROM Roles WHERE RoleName = 'OrganizationAdmin';

    IF @OrgRoleId IS NULL
        THROW 50001, 'OrganizationAdmin role is missing from Roles.', 1;

    BEGIN TRANSACTION;
    BEGIN TRY
        -- Step A: Insert the manager record into the Users matrix first to satisfy relationships
        DECLARE @NewUserId INT;
        INSERT INTO Users (FullName, PhoneNumber, Email, PasswordHash, IsActive, RoleId, CreatedAt)
        VALUES (@Name + ' Admin', @PhoneNumber, @Email, @PasswordHash, 1, @OrgRoleId, GETDATE());
        
        SET @NewUserId = SCOPE_IDENTITY();

        -- Step B: Insert the medical facility node linking back to the manager
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
/****** Object:  StoredProcedure [dbo].[sp_Organization_GetAll]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Organization_GetAll]
AS
BEGIN
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
        o.IsVerified,

        c.CountryName,
        s.StateName,
        d.DistrictName

    FROM Organizations o
    LEFT JOIN Countries c ON o.CountryId = c.CountryId
    LEFT JOIN States s ON o.StateId = s.StateId
    LEFT JOIN Districts d ON o.DistrictId = d.DistrictId

    ORDER BY o.CreatedAt DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Organization_UpdateStatus]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Organization_UpdateStatus]
    @OrganizationId INT,
    @StatusId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Organizations
    SET StatusId = @StatusId
    WHERE OrganizationId = @OrganizationId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_OrgMember_Add]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrgMember_Add]
    @OrganizationId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 
        FROM OrganizationMembers
        WHERE OrganizationId = @OrganizationId 
        AND UserId = @UserId
    )
    BEGIN
        RAISERROR('User already requested or is a member', 16, 1);
        RETURN;
    END

    DECLARE @StatusId INT;

    SELECT TOP 1 @StatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm 
        ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'OrgMember'
    AND sm.StatusName = 'Pending';

    INSERT INTO OrganizationMembers
    (OrganizationId, UserId, StatusId, JoinDate)
    VALUES
    (@OrganizationId, @UserId, @StatusId, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[sp_OrgMember_GetByOrg]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrgMember_GetByOrg]
    @OrganizationId INT,
    @StatusName NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        om.Id,
        om.OrganizationId,
        om.UserId,
        u.FullName,
        u.PhoneNumber,
        om.JoinDate,
        sm.StatusName
    FROM OrganizationMembers om
    JOIN Users u ON om.UserId = u.UserId
    LEFT JOIN StatusMaster sm ON om.StatusId = sm.StatusId
    WHERE om.OrganizationId = @OrganizationId
      AND (@StatusName IS NULL OR sm.StatusName = @StatusName)
    ORDER BY om.JoinDate DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_OrgMember_GetPending]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrgMember_GetPending]
    @OrganizationId INT,
    @PageNumber INT = 1,
    @PageSize INT = 10,
    @SortColumn NVARCHAR(50) = 'JoinDate',   -- ✅ default column
    @SortDirection NVARCHAR(4) = 'DESC'      -- ✅ ASC / DESC
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;

    --  Get Pending StatusId
    SELECT TOP 1 @StatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm 
        ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'OrgMember'
      AND sm.StatusName = 'Pending';

    --  Build dynamic SQL for sorting safely
    DECLARE @Sql NVARCHAR(MAX);

    SET @Sql = '
    SELECT 
        om.Id,
        om.OrganizationId,
        om.UserId,
        u.FullName,
        u.PhoneNumber,
        u.Email,
        om.JoinDate
    FROM OrganizationMembers om
    INNER JOIN Users u ON om.UserId = u.UserId
    WHERE om.OrganizationId = @OrganizationId
      AND om.StatusId = @StatusId
    ORDER BY ' + 
    CASE 
        WHEN @SortColumn IN ('JoinDate', 'FullName') THEN @SortColumn 
        ELSE 'JoinDate' 
    END + ' ' +
    CASE 
        WHEN @SortDirection = 'ASC' THEN 'ASC' 
        ELSE 'DESC' 
    END + '
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY';

    --  Execute dynamic query safely
    EXEC sp_executesql 
        @Sql,
        N'@OrganizationId INT, @StatusId INT, @PageNumber INT, @PageSize INT',
        @OrganizationId=@OrganizationId,
        @StatusId=@StatusId,
        @PageNumber=@PageNumber,
        @PageSize=@PageSize;

    --  Total count
    SELECT COUNT(*) AS TotalCount
    FROM OrganizationMembers
    WHERE OrganizationId = @OrganizationId
      AND StatusId = @StatusId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_OrgMember_Status]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrgMember_Status]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;

    SELECT TOP 1 @StatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm 
        ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'OrgMember'
    AND sm.StatusName = 'Approved';

    UPDATE OrganizationMembers
    SET StatusId = @StatusId
    WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_OrgMember_UpdateStatus]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_OrgMember_UpdateStatus]
    @Id INT,
    @StatusName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StatusId INT;

    SELECT TOP 1 @StatusId = sm.StatusId
    FROM StatusMaster sm
    JOIN StatusTypeMaster stm 
        ON sm.StatusTypeId = stm.StatusTypeId
    WHERE stm.StatusType = 'OrgMember'
    AND sm.StatusName = @StatusName;

    UPDATE OrganizationMembers
    SET StatusId = @StatusId
    WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RefreshToken_Get]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RefreshToken_Get]
    @Token NVARCHAR(500)
AS
BEGIN
    SELECT * FROM RefreshTokens
    WHERE Token = @Token AND IsRevoked = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RefreshToken_Revoke]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RefreshToken_Revoke]
    @Token NVARCHAR(500)
AS
BEGIN
    UPDATE RefreshTokens
    SET IsRevoked = 1
    WHERE Token = @Token;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RefreshToken_Save]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RefreshToken_Save]
    @UserId INT,
    @Token NVARCHAR(500),
    @Expires DATETIME
AS
BEGIN
    INSERT INTO RefreshTokens (UserId, Token, Expires)
    VALUES (@UserId, @Token, @Expires);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Request_Create]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Request_Create]
    @CreatedBy INT,
    @PatientName NVARCHAR(100),
    @BloodGroupId INT,
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
    CreatedBy, PatientName, BloodGroupId, UnitsNeeded,
    State, District, HospitalName, Place,
    Description, RequestDate, RequestTime
)
VALUES (
    @CreatedBy, @PatientName, @BloodGroupId, @UnitsNeeded,
    @State, @District, @HospitalName, @Place,
    @Description, @RequestDate, @RequestTime
);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Request_Delete]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Request_Delete]
    @RequestId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM BloodRequests
    WHERE RequestId = @RequestId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Request_GetAll]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Request_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

   SELECT
    br.RequestId,
    br.PatientName,
    bg.BloodGroupName,
    br.UnitsNeeded,
    br.District,
    br.RequestDate
FROM BloodRequests br
LEFT JOIN BloodGroups bg ON br.BloodGroupId = bg.BloodGroupId
ORDER BY br.RequestDate DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Request_GetById]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Request_GetById]
    @RequestId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM BloodRequests
    WHERE RequestId = @RequestId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Request_Update]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Request_Update]
    @RequestId INT,
    @PatientName NVARCHAR(100),
    @BloodGroupId INT,
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
    UPDATE BloodRequests
    SET PatientName = @PatientName,
        BloodGroupId = @BloodGroupId,
        UnitsNeeded = @UnitsNeeded,
        State = @State,
        District = @District,
        HospitalName = @HospitalName,
        Place = @Place,
        Description = @Description,
        RequestDate = @RequestDate,
        RequestTime = @RequestTime
    WHERE RequestId = @RequestId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Request_UpdateStatus]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[sp_Request_UpdateStatus]
    @RequestId INT,
    @StatusId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE BloodRequests
    SET StatusId = @StatusId
    WHERE RequestId = @RequestId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Search_Donors]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Search_Donors]
    @BloodGroupId INT,
    @DistrictId INT = NULL  -- ✅ optional filter
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        u.UserId,
        u.FullName,
        u.PhoneNumber,

        bg.BloodGroupName,
        d.DistrictName,
        s.StateName

    FROM Users u
    LEFT JOIN BloodGroups bg ON u.BloodGroupId = bg.BloodGroupId
    LEFT JOIN Districts d ON u.DistrictId = d.DistrictId
    LEFT JOIN States s ON u.StateId = s.StateId

    WHERE u.IsActive = 1
      AND u.BloodGroupId = @BloodGroupId
      AND (@DistrictId IS NULL OR u.DistrictId = @DistrictId)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Search_Hospitals]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Search_Hospitals]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Hospitals;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Search_Organizations]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Search_Organizations]
AS
BEGIN
    SELECT 
        o.*,
        c.CountryName,
        s.StateName,
        d.DistrictName
    FROM Organizations o
    LEFT JOIN Countries c ON o.CountryId = c.CountryId
    LEFT JOIN States s ON o.StateId = s.StateId
    LEFT JOIN Districts d ON o.DistrictId = d.DistrictId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_ChangePassword]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_ChangePassword]
    @UserId INT,
    @OldPasswordHash NVARCHAR(255),
    @NewPasswordHash NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ErrorMessage NVARCHAR(255);
    DECLARE @FailedCount INT;
    DECLARE @IsLocked BIT;
    DECLARE @LockedAt DATETIME;

    -- ✅ Get current user status
    SELECT 
        @FailedCount = FailedAttemptCount,
        @IsLocked = IsLocked,
        @LockedAt = LockedAt
    FROM Users
    WHERE UserId = @UserId;

    -- ✅ AUTO-UNLOCK AFTER 30 MINUTES
    IF @IsLocked = 1
    BEGIN
        IF DATEADD(MINUTE, 30, @LockedAt) <= GETDATE()
        BEGIN
            -- 🔓 Unlock user
            UPDATE Users
            SET IsLocked = 0,
                FailedAttemptCount = 0,
                LockedAt = NULL
            WHERE UserId = @UserId;

            SET @IsLocked = 0;
        END
    END

    -- ✅ If still locked → block
    IF @IsLocked = 1
    BEGIN
        RAISERROR('Account is locked. Try again after 30 minutes.', 16, 1);
        RETURN;
    END

    -- ✅ Prevent same password
    IF @OldPasswordHash = @NewPasswordHash
    BEGIN
        SET @ErrorMessage = 'New password cannot be same as old password';

        INSERT INTO PasswordChangeLogs (UserId, IsSuccess, FailureReason)
        VALUES (@UserId, 0, @ErrorMessage);

        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

    -- ✅ Validate old password
    IF NOT EXISTS (
        SELECT 1 
        FROM Users
        WHERE UserId = @UserId 
          AND PasswordHash = @OldPasswordHash
          AND IsActive = 1
    )
    BEGIN
        SET @FailedCount = ISNULL(@FailedCount, 0) + 1;

        UPDATE Users
        SET FailedAttemptCount = @FailedCount
        WHERE UserId = @UserId;

        SET @ErrorMessage = 'Invalid old password';

        INSERT INTO PasswordChangeLogs (UserId, IsSuccess, FailureReason)
        VALUES (@UserId, 0, @ErrorMessage);

        -- 🔒 Lock after 5 failures
        IF @FailedCount >= 5
        BEGIN
            UPDATE Users
            SET IsLocked = 1,
                LockedAt = GETDATE()
            WHERE UserId = @UserId;

            RAISERROR('Account locked due to multiple failed attempts', 16, 1);
            RETURN;
        END

        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

    -- ✅ Reset failed attempts on success
    UPDATE Users
    SET FailedAttemptCount = 0
    WHERE UserId = @UserId;

    -- ✅ Update password
    UPDATE Users
    SET PasswordHash = @NewPasswordHash
    WHERE UserId = @UserId;

    -- ✅ Log success
    INSERT INTO PasswordChangeLogs (UserId, IsSuccess)
    VALUES (@UserId, 1);

    SELECT 'Password updated successfully' AS Message;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Delete]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_Delete]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Users
    SET IsActive = 0
    WHERE UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_GetById]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_GetById]
    @UserId INT
AS
BEGIN
    SELECT   
        u.UserId,
        u.FullName,
        u.PhoneNumber,
        u.Email,
        u.Gender,
        bg.BloodGroupName
    FROM Users u
    LEFT JOIN BloodGroups bg ON u.BloodGroupId = bg.BloodGroupId
    WHERE u.UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_GetProfile]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_GetProfile]
    @UserId INT
AS
BEGIN
    SELECT 
        u.UserId,
        u.FullName,
        u.PhoneNumber,
        u.Email,
        u.Gender,
        bg.BloodGroupName,
        u.ProfileImageUrl,
        u.Place,
        u.CurrentAddress,
        u.PermanentAddress,

        c.CountryName,
        s.StateName,
        d.DistrictName

    FROM Users u
    LEFT JOIN BloodGroups bg ON u.BloodGroupId = bg.BloodGroupId
    LEFT JOIN Countries c ON u.CountryId = c.CountryId
    LEFT JOIN States s ON u.StateId = s.StateId
    LEFT JOIN Districts d ON u.DistrictId = d.DistrictId

    WHERE u.UserId = @UserId AND u.IsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_GetProfileImage]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_GetProfileImage]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ProfileImageUrl
    FROM Users
    WHERE UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Login]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_User_Login]
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
        u.PasswordHash, -- We return this to verify it in C# using BCrypt
        u.RoleId,
        r.RoleName
    FROM Users u
    JOIN Roles r ON u.RoleId = r.RoleId
    WHERE u.IsActive = 1
      AND u.IsLocked = 0
      AND (
          -- Path A: Regular app users logging in via Phone
          (
            @LoginType = 'User' 
            AND @PhoneNumber IS NOT NULL 
            AND u.PhoneNumber = @PhoneNumber 
            AND r.RoleName NOT IN ('Admin', 'OrganizationAdmin', 'SuperAdmin')
          )
          OR
          -- Path B: Management panel logging in via Email
          (
            @LoginType = 'Admin' 
            AND @Email IS NOT NULL 
            AND u.Email = @Email 
            AND r.RoleName IN ('Admin', 'OrganizationAdmin', 'SuperAdmin')
          )
      )
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Register]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_Register]
    @FullName NVARCHAR(100),
    @PhoneNumber NVARCHAR(15),
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(255),
    @BloodGroupId INT,
    @Gender NVARCHAR(10),
    @RoleId INT
AS
BEGIN
    INSERT INTO Users 
    (FullName, PhoneNumber, Email, PasswordHash, BloodGroupId, Gender, RoleId)
    VALUES 
    (@FullName, @PhoneNumber, @Email, @PasswordHash, @BloodGroupId, @Gender, @RoleId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Update]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_Update]
    @UserId INT,
    @FullName NVARCHAR(100),
    @PhoneNumber NVARCHAR(15),
    @Email NVARCHAR(100),
    @Gender NVARCHAR(10),
    @BloodGroupId INT,
    @PasswordHash NVARCHAR(255) = NULL
AS
BEGIN
    UPDATE Users
    SET FullName = @FullName,
        PhoneNumber = @PhoneNumber,
        Email = @Email,
        Gender = @Gender,
        BloodGroupId = @BloodGroupId,
        PasswordHash = ISNULL(@PasswordHash, PasswordHash)
    WHERE UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_UpdateProfile]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_UpdateProfile]
    @UserId INT,
    @FullName NVARCHAR(100),
    @PhoneNumber NVARCHAR(15),
    @Email NVARCHAR(100),
    @Gender NVARCHAR(10),
    @BloodGroupId INT,
    @CountryId INT,
    @StateId INT,
    @DistrictId INT,
    @Place NVARCHAR(150),
    @CurrentAddress NVARCHAR(255),
    @PermanentAddress NVARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET FullName = @FullName,
        PhoneNumber = @PhoneNumber,
        Email = @Email,
        Gender = @Gender,
        BloodGroupId = @BloodGroupId,
        CountryId = @CountryId,
        StateId = @StateId,
        DistrictId = @DistrictId,
        Place = @Place,
        CurrentAddress = @CurrentAddress,
        PermanentAddress = @PermanentAddress
    WHERE UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_UpdateProfileImage]    Script Date: 7/31/2026 12:09:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_UpdateProfileImage]
    @UserId INT,
    @ProfileImageUrl NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Users
    SET ProfileImageUrl = @ProfileImageUrl
    WHERE UserId = @UserId;

    SELECT 'Profile image updated successfully' AS Message;
END
GO
USE [master]
GO
ALTER DATABASE [BloodBandDB_Main] SET  READ_WRITE 
GO
