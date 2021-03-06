
-- Database Schema
----------------------------------------------------------------------------------------

USE [master]
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'MihaiSurvey')
BEGIN
CREATE DATABASE [MihaiSurvey]
END
GO

USE [MihaiSurvey]
GO

-- Tables and PKs

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Answers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Answers](
	[Id] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Status] [smallint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnswerStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnswerStatus](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_AnswerStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Questions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Questions](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Status] [smallint] NOT NULL,
	[Type] [smallint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuestionStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QuestionStatus](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_QuestionStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuestionTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QuestionTypes](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_QuestionTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SurveyAnswers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SurveyAnswers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
 CONSTRAINT [PK_SurveyAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SurveyComments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SurveyComments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Comments] [nvarchar](1024) NULL,
 CONSTRAINT [PK_SurveyComments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Surveys]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Surveys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[UserId] [nvarchar](64) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Surveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- FKs

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Answers_AnswerStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Answers]'))
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_AnswerStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[AnswerStatus] ([Id])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Answers_AnswerStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Answers]'))
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_AnswerStatus]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Answers_Questions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Answers]'))
ALTER TABLE [dbo].[Answers]  WITH NOCHECK ADD  CONSTRAINT [FK_Answers_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
NOT FOR REPLICATION 
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Answers_Questions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Answers]'))
ALTER TABLE [dbo].[Answers] NOCHECK CONSTRAINT [FK_Answers_Questions]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Questions_QuestionStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Questions]'))
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_QuestionStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[QuestionStatus] ([Id])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Questions_QuestionStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Questions]'))
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_QuestionStatus]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Questions_QuestionTypes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Questions]'))
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_QuestionTypes] FOREIGN KEY([Type])
REFERENCES [dbo].[QuestionTypes] ([Id])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Questions_QuestionTypes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Questions]'))
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_QuestionTypes]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyAnswers_Answers]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyAnswers]'))
ALTER TABLE [dbo].[SurveyAnswers]  WITH NOCHECK ADD  CONSTRAINT [FK_SurveyAnswers_Answers] FOREIGN KEY([AnswerId])
REFERENCES [dbo].[Answers] ([Id])
NOT FOR REPLICATION 
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyAnswers_Answers]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyAnswers]'))
ALTER TABLE [dbo].[SurveyAnswers] NOCHECK CONSTRAINT [FK_SurveyAnswers_Answers]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyAnswers_Surveys]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyAnswers]'))
ALTER TABLE [dbo].[SurveyAnswers]  WITH NOCHECK ADD  CONSTRAINT [FK_SurveyAnswers_Surveys] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([Id])
NOT FOR REPLICATION 
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyAnswers_Surveys]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyAnswers]'))
ALTER TABLE [dbo].[SurveyAnswers] NOCHECK CONSTRAINT [FK_SurveyAnswers_Surveys]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyComments_Questions]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyComments]'))
ALTER TABLE [dbo].[SurveyComments]  WITH CHECK ADD  CONSTRAINT [FK_SurveyComments_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyComments_Questions]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyComments]'))
ALTER TABLE [dbo].[SurveyComments] CHECK CONSTRAINT [FK_SurveyComments_Questions]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyComments_Surveys]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyComments]'))
ALTER TABLE [dbo].[SurveyComments]  WITH CHECK ADD  CONSTRAINT [FK_SurveyComments_Surveys] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([Id])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SurveyComments_Surveys]') AND parent_object_id = OBJECT_ID(N'[dbo].[SurveyComments]'))
ALTER TABLE [dbo].[SurveyComments] CHECK CONSTRAINT [FK_SurveyComments_Surveys]
GO


-- Database Data
-------------------------------------------------------------------------------------------------------------------------------------------------

INSERT [dbo].[QuestionStatus] ([Id], [Name]) VALUES (0, N'Inactive')
GO
INSERT [dbo].[QuestionStatus] ([Id], [Name]) VALUES (1, N'Active')
GO
INSERT [dbo].[QuestionTypes] ([Id], [Name]) VALUES (0, N'Button')
GO
INSERT [dbo].[QuestionTypes] ([Id], [Name]) VALUES (1, N'Radio Button')
GO
INSERT [dbo].[QuestionTypes] ([Id], [Name]) VALUES (2, N'Check Button')
GO
INSERT [dbo].[QuestionTypes] ([Id], [Name]) VALUES (3, N'Text')
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (1, N'How likely is it that you would recommend this company to a friend or colleague?', 1, 1, 0, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (2, N'Overall, how satisfied or dissatisfied are you with our company?', 2, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (3, N'Which of the following words would you use to describe our products? Select all that apply. ', 3, 1, 2, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (4, N'How well do our products meet your needs?', 4, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (5, N'How would you rate the quality of the product?', 5, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (6, N'How would you rate the value for money of the product?', 6, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (7, N'How responsive have we been to your questions or concerns about our products?', 7, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (8, N'How long have you been a customer of our company? ', 8, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (9, N'How likely are you to purchase any of our products again?', 9, 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Questions] ([Id], [Name], [DisplayOrder], [Status], [Type], [CreateDate], [UpdateDate]) VALUES (10, N'Do you have any other comments, questions, or concerns? ', 10, 1, 3, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[AnswerStatus] ([Id], [Name]) VALUES (0, N'Inactive')
GO
INSERT [dbo].[AnswerStatus] ([Id], [Name]) VALUES (1, N'Active')
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (0, 1, N'0', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (1, 1, N'1', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (2, 1, N'2', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (3, 1, N'3', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (4, 1, N'4', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (5, 1, N'5', 5, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (6, 1, N'6', 6, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (7, 1, N'7', 7, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (8, 1, N'8', 8, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (9, 1, N'9', 9, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (10, 1, N'10', 10, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (11, 2, N'Very satisfied', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (12, 2, N'Somewhat satisfied', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (13, 2, N'Neither satisfied nor dissatisfied ', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (14, 2, N'Somewhat dissatisfied', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (15, 2, N'Very dissatisfied', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (16, 3, N'Reliable', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (17, 3, N'High quality', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (18, 3, N'Useful', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (19, 3, N'Unique', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (20, 3, N'Good value for money', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (21, 3, N'Overpriced', 5, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (22, 3, N'Impractical', 6, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (23, 3, N'Ineffective', 7, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (24, 3, N'Poor quality', 8, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (25, 3, N'Unreliable', 9, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (26, 4, N'Extremely well', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (27, 4, N'Very well', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (28, 4, N'Somewhat well', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (29, 4, N'Not so well', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (30, 4, N'Not at all well', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (31, 5, N'Very high quality', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (32, 5, N'High quality', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (33, 5, N'Neither high nor low quality', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (34, 5, N'Low quality', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (35, 5, N'Very low quality', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (36, 6, N'Excellent', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (37, 6, N'Above average', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (38, 6, N'Average', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (39, 6, N'Below average', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (40, 6, N'Poor', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (41, 7, N'Extremely responsive', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (42, 7, N'Very responsive', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (43, 7, N'Somewhat responsive', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (44, 7, N'Not so responsive', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (45, 7, N'Not at all responsive', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (46, 7, N'Not applicable', 5, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (47, 8, N'This is my first purchase', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (48, 8, N'Less than six months', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (49, 8, N'Six months to a year', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (50, 8, N'1 - 2 years', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (51, 8, N'3 or more years', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (52, 8, N'I haven''t made a purchase yet', 5, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (53, 9, N'Extremely likely', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (54, 9, N'Very likely', 1, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (55, 9, N'Somewhat likely', 2, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (56, 9, N'Not so likely', 3, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (57, 9, N'Not at all likely', 4, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Answers] ([Id], [QuestionId], [Name], [DisplayOrder], [Status], [CreateDate], [UpdateDate]) VALUES (58, 10, N'Comments', 0, 1, CAST(N'2017-03-10 00:00:00.000' AS DateTime), CAST(N'2017-03-10 00:00:00.000' AS DateTime))
GO
