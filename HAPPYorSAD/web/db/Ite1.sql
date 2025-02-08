USE [master]
GO
/****** Object:  Database [SWP1]    Script Date: 2/8/2025 12:11:30 PM ******/
CREATE DATABASE [SWP1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SWP1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP1] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SWP1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP1] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP1] SET  MULTI_USER 
GO
ALTER DATABASE [SWP1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP1', N'ON'
GO
ALTER DATABASE [SWP1] SET QUERY_STORE = ON
GO
ALTER DATABASE [SWP1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SWP1]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[manager_id] [int] NOT NULL,
	[mentor_id] [int] NOT NULL,
	[status] [nvarchar](10) NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
	[course_major_id] [int] NOT NULL,
	[image] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseMajor]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseMajor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[image] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[created_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mentee]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mentee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[is_deleted] [bit] NULL,
	[email] [nvarchar](100) NOT NULL,
	[goals] [nvarchar](max) NULL,
	[created_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mentor]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mentor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[rating] [float] NULL,
	[is_deleted] [bit] NULL,
	[reviews] [text] NULL,
	[price_per_slot] [decimal](10, 2) NULL,
	[expertise] [nvarchar](max) NULL,
	[bio] [nvarchar](max) NULL,
	[created_at] [datetime2](7) NULL,
	[base_rate] [decimal](10, 2) NULL,
	[multiplier] [decimal](3, 2) NULL,
	[image] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mentor_reviews]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mentor_reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mentor_id] [int] NOT NULL,
	[mentee_id] [int] NOT NULL,
	[rating] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[created_at] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[fullname] [nvarchar](255) NOT NULL,
	[avatar_path] [nvarchar](max) NULL,
	[password] [nvarchar](255) NOT NULL,
	[status] [nvarchar](10) NULL,
	[email] [nvarchar](100) NOT NULL,
	[address] [text] NULL,
	[phone_number] [nvarchar](15) NULL,
	[date_of_birth] [date] NULL,
	[gender] [nvarchar](10) NULL,
	[created_at] [datetime2](7) NULL,
	[role] [nvarchar](25) NULL,
	[is_guest] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Course] ON 
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (1, N'Intro to Programming', N'Basic programming concepts', 1, 1, N'active', CAST(N'2025-02-06T11:06:09.2433333' AS DateTime2), CAST(N'2025-02-06T11:06:09.2433333' AS DateTime2), 1, N'images/default_course.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (2, N'Machine Learning Basics', N'Introduction to ML algorithms', 2, 2, N'active', CAST(N'2025-02-06T11:06:09.2433333' AS DateTime2), CAST(N'2025-02-06T11:06:09.2433333' AS DateTime2), 2, N'images/default_course.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (3, N'Cybersecurity Fundamentals', N'Learn the basics of security', 3, 3, N'active', CAST(N'2025-02-06T11:06:09.2433333' AS DateTime2), CAST(N'2025-02-06T11:06:09.2433333' AS DateTime2), 3, N'images/default_course.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (17, N'Introduction to Computer Science', N'Learn the fundamentals of computer science.', 1, 1, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 1, N'images/computer_science.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (18, N'Data Science with Python', N'Master data science techniques using Python.', 1, 4, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 2, N'images/data_science.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (19, N'Cybersecurity Essentials', N'Understand key cybersecurity concepts and practices.', 2, 2, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 3, N'images/cybersecurity.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (20, N'Cloud Computing Fundamentals', N'Learn cloud computing concepts with AWS, Azure, and GCP.', 3, 1, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 4, N'images/cloud_computing.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (21, N'Business Strategy and Management', N'Develop business strategies for growth and success.', 2, 3, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 5, N'images/business_admin.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (22, N'Mechanical Engineering Basics', N'Introduction to mechanical engineering principles.', 3, 4, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 6, N'images/mechanical_engineering.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (23, N'Psychology of Human Behavior', N'Explore psychological principles and human behavior.', 1, 1, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 7, N'images/psychology.jpg')
GO
INSERT [dbo].[Course] ([id], [title], [description], [manager_id], [mentor_id], [status], [created_at], [updated_at], [course_major_id], [image]) VALUES (24, N'Graphic Design Essentials', N'Learn the fundamentals of design with Photoshop & Illustrator.', 2, 2, N'active', CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), CAST(N'2025-02-08T08:36:58.2100000' AS DateTime2), 8, N'images/graphic_design.jpg')
GO
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseMajor] ON 
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (1, N'Computer Science', N'Covers fundamental computing concepts', N'Computer Science.png')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (2, N'Data Science', N'Focus on data analytics and machine learning', N'Data Science.png')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (3, N'Cybersecurity', N'Covers security best practices and hacking prevention', N'Cybersecurity.png')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (4, N'Computer Cloud', NULL, N'images/computer_science.jpg')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (5, N'Business Administration', NULL, N'images/business_admin.jpg')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (6, N'Mechanical Engineering', NULL, N'images/mechanical_engineering.jpg')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (7, N'Psychology', NULL, N'images/psychology.jpg')
GO
INSERT [dbo].[CourseMajor] ([id], [name], [description], [image]) VALUES (8, N'Graphic Design', NULL, N'images/graphic_design.jpg')
GO
SET IDENTITY_INSERT [dbo].[CourseMajor] OFF
GO
SET IDENTITY_INSERT [dbo].[Manager] ON 
GO
INSERT [dbo].[Manager] ([id], [user_id], [name], [created_at]) VALUES (1, 3, N'Michael Brown', CAST(N'2025-02-06T11:06:09.2000000' AS DateTime2))
GO
INSERT [dbo].[Manager] ([id], [user_id], [name], [created_at]) VALUES (2, 6, N'Sarah Green', CAST(N'2025-02-06T11:06:09.2000000' AS DateTime2))
GO
INSERT [dbo].[Manager] ([id], [user_id], [name], [created_at]) VALUES (3, 9, N'Robert Jones', CAST(N'2025-02-06T11:06:09.2000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Manager] OFF
GO
SET IDENTITY_INSERT [dbo].[Mentee] ON 
GO
INSERT [dbo].[Mentee] ([id], [user_id], [name], [is_deleted], [email], [goals], [created_at]) VALUES (1, 2, N'Jane Smith', 0, N'jane.smith@example.com', N'Learn programming', CAST(N'2025-02-06T11:06:09.2200000' AS DateTime2))
GO
INSERT [dbo].[Mentee] ([id], [user_id], [name], [is_deleted], [email], [goals], [created_at]) VALUES (2, 5, N'David Black', 0, N'david.b@example.com', N'Improve problem-solving skills', CAST(N'2025-02-06T11:06:09.2200000' AS DateTime2))
GO
INSERT [dbo].[Mentee] ([id], [user_id], [name], [is_deleted], [email], [goals], [created_at]) VALUES (3, 8, N'Anna Moore', 0, N'anna.m@example.com', N'Become a data scientist', CAST(N'2025-02-06T11:06:09.2200000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Mentee] OFF
GO
SET IDENTITY_INSERT [dbo].[Mentor] ON 
GO
INSERT [dbo].[Mentor] ([id], [user_id], [name], [email], [rating], [is_deleted], [reviews], [price_per_slot], [expertise], [bio], [created_at], [base_rate], [multiplier], [image]) VALUES (1, 1, N'John Doe', N'john.doe@example.com', 4, 0, N'Great mentor', CAST(50.00 AS Decimal(10, 2)), N'Software Engineering', N'Experienced developer', CAST(N'2025-02-06T11:06:09.2100000' AS DateTime2), CAST(40.00 AS Decimal(10, 2)), CAST(1.20 AS Decimal(3, 2)), N'images/mentor1.jpg')
GO
INSERT [dbo].[Mentor] ([id], [user_id], [name], [email], [rating], [is_deleted], [reviews], [price_per_slot], [expertise], [bio], [created_at], [base_rate], [multiplier], [image]) VALUES (2, 4, N'Emily White', N'emily.w@example.com', 3, 0, N'Very knowledgeable', CAST(60.00 AS Decimal(10, 2)), N'Data Science', N'PhD in Data Science', CAST(N'2025-02-06T11:06:09.2100000' AS DateTime2), CAST(50.00 AS Decimal(10, 2)), CAST(1.30 AS Decimal(3, 2)), N'images/mentor2.jpg')
GO
INSERT [dbo].[Mentor] ([id], [user_id], [name], [email], [rating], [is_deleted], [reviews], [price_per_slot], [expertise], [bio], [created_at], [base_rate], [multiplier], [image]) VALUES (3, 7, N'Chris Wilson', N'chris.w@example.com', 5, 0, N'Helpful', CAST(45.00 AS Decimal(10, 2)), N'Cybersecurity', N'Cybersecurity expert', CAST(N'2025-02-06T11:06:09.2100000' AS DateTime2), CAST(35.00 AS Decimal(10, 2)), CAST(1.10 AS Decimal(3, 2)), N'images/mentor3.jpg')
GO
INSERT [dbo].[Mentor] ([id], [user_id], [name], [email], [rating], [is_deleted], [reviews], [price_per_slot], [expertise], [bio], [created_at], [base_rate], [multiplier], [image]) VALUES (4, 10, N'Linda Clark', N'linda.c@example.com', 4, 0, N'Highly recommended', CAST(70.00 AS Decimal(10, 2)), N'Machine Learning', N'10 years in AI research', CAST(N'2025-02-06T11:06:09.2100000' AS DateTime2), CAST(60.00 AS Decimal(10, 2)), CAST(1.40 AS Decimal(3, 2)), N'images/mentor4.jpg')
GO
SET IDENTITY_INSERT [dbo].[Mentor] OFF
GO
SET IDENTITY_INSERT [dbo].[mentor_reviews] ON 
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (1, 1, 1, 4, N'Fantastic mentor!', CAST(N'2025-02-06T11:06:09.2566667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (2, 2, 2, 3, N'Very helpful and patient', CAST(N'2025-02-06T11:06:09.2566667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (3, 3, 3, 5, N'Learned a lot!', CAST(N'2025-02-06T11:06:09.2566667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (4, 1, 1, 4, N'Great mentor!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (5, 1, 2, 4, N'Very knowledgeable', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (6, 1, 3, 4, N'Enjoyed the sessions!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (7, 2, 1, 3, N'Good but could be better', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (8, 2, 2, 3, N'Helpful guidance!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (9, 2, 3, 3, N'Highly recommended!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (10, 3, 1, 5, N'Awesome mentor!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (11, 3, 2, 5, N'Explained concepts well', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (12, 3, 3, 5, N'Really patient and kind', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (13, 4, 1, 4, N'Nice teaching style', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (14, 4, 2, 4, N'Excellent mentor!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
INSERT [dbo].[mentor_reviews] ([id], [mentor_id], [mentee_id], [rating], [comment], [created_at]) VALUES (15, 4, 3, 4, N'Learned a lot from them!', CAST(N'2025-02-08T10:01:13.9766667' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[mentor_reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (1, N'john_doe', N'John Doe', NULL, N'123', N'active', N'john.doe@example.com', N'123 Main St', N'1234567890', CAST(N'1990-05-10' AS Date), N'male', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentor', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (2, N'jane_smith', N'Jane Smith', NULL, N'123', N'active', N'jane.smith@example.com', N'456 Elm St', N'0987654321', CAST(N'1985-07-20' AS Date), N'female', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentee', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (3, N'michael_brown', N'Michael Brown', NULL, N'123', N'inactive', N'michael.b@example.com', N'789 Oak St', N'1112223333', CAST(N'1992-03-15' AS Date), N'male', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'manager', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (4, N'emily_white', N'Emily White', NULL, N'123', N'active', N'emily.w@example.com', N'321 Pine St', N'2223334444', CAST(N'1995-09-25' AS Date), N'female', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentor', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (5, N'david_black', N'David Black', NULL, N'123', N'active', N'david.b@example.com', N'654 Cedar St', N'3334445555', CAST(N'1988-11-30' AS Date), N'male', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentee', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (6, N'sarah_green', N'Sarah Green', NULL, N'123', N'active', N'sarah.g@example.com', N'987 Birch St', N'4445556666', CAST(N'1991-06-18' AS Date), N'female', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'manager', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (7, N'chris_wilson', N'Chris Wilson', NULL, N'123', N'inactive', N'chris.w@example.com', N'741 Spruce St', N'5556667777', CAST(N'1987-12-05' AS Date), N'male', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentor', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (8, N'anna_moore', N'Anna Moore', NULL, N'123', N'active', N'anna.m@example.com', N'852 Redwood St', N'6667778888', CAST(N'1994-04-22' AS Date), N'female', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentee', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (9, N'robert_jones', N'Robert Jones', NULL, N'123', N'active', N'robert.j@example.com', N'963 Fir St', N'7778889999', CAST(N'1993-08-14' AS Date), N'male', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'manager', 0)
GO
INSERT [dbo].[Users] ([id], [username], [fullname], [avatar_path], [password], [status], [email], [address], [phone_number], [date_of_birth], [gender], [created_at], [role], [is_guest]) VALUES (10, N'linda_clark', N'Linda Clark', NULL, N'123', N'active', N'linda.c@example.com', N'159 Cypress St', N'8889990000', CAST(N'1986-10-10' AS Date), N'female', CAST(N'2025-02-06T11:06:09.1866667' AS DateTime2), N'mentor', 0)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CourseMa__72E12F1B83FEF1B0]    Script Date: 2/8/2025 12:11:30 PM ******/
ALTER TABLE [dbo].[CourseMajor] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Mentee__AB6E61642F361A16]    Script Date: 2/8/2025 12:11:30 PM ******/
ALTER TABLE [dbo].[Mentee] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Mentor__AB6E61642F5E3D77]    Script Date: 2/8/2025 12:11:30 PM ******/
ALTER TABLE [dbo].[Mentor] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A1936A6B952979C5]    Script Date: 2/8/2025 12:11:30 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E6164E3718AFC]    Script Date: 2/8/2025 12:11:30 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC5728DCBCF6B]    Script Date: 2/8/2025 12:11:30 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Course] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[Course] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Course] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Manager] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Mentee] ADD  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Mentee] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Mentor] ADD  DEFAULT ((0)) FOR [rating]
GO
ALTER TABLE [dbo].[Mentor] ADD  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Mentor] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[mentor_reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [is_guest]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD FOREIGN KEY([course_major_id])
REFERENCES [dbo].[CourseMajor] ([id])
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[Manager] ([id])
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD FOREIGN KEY([mentor_id])
REFERENCES [dbo].[Mentor] ([id])
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mentee]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mentor]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[mentor_reviews]  WITH CHECK ADD FOREIGN KEY([mentee_id])
REFERENCES [dbo].[Mentee] ([id])
GO
ALTER TABLE [dbo].[mentor_reviews]  WITH CHECK ADD FOREIGN KEY([mentor_id])
REFERENCES [dbo].[Mentor] ([id])
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD CHECK  (([status]='inactive' OR [status]='active'))
GO
ALTER TABLE [dbo].[Mentor]  WITH CHECK ADD CHECK  (([price_per_slot]>=(0)))
GO
ALTER TABLE [dbo].[Mentor]  WITH CHECK ADD CHECK  (([rating]>=(0) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[mentor_reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([gender]='female' OR [gender]='male'))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([status]='inactive' OR [status]='active'))
GO
/****** Object:  Trigger [dbo].[trg_UpdateMentorRating]    Script Date: 2/8/2025 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_UpdateMentorRating]
ON [dbo].[mentor_reviews]
AFTER INSERT, UPDATE
AS
BEGIN
    -- Cập nhật rating trung bình của mentor dựa trên các đánh giá mới nhất
    UPDATE Mentor
    SET rating = (
        SELECT COALESCE(AVG(r.rating), 0) 
        FROM Mentor_Reviews r 
        WHERE r.mentor_id = Mentor.id
    )
    WHERE Mentor.id IN (SELECT DISTINCT mentor_id FROM inserted);
END;
GO
ALTER TABLE [dbo].[mentor_reviews] ENABLE TRIGGER [trg_UpdateMentorRating]
GO
USE [master]
GO
ALTER DATABASE [SWP1] SET  READ_WRITE 
GO
