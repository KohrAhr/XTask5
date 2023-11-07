/*
 Navicat Premium Data Transfer

 Source Server         : SQL2019
 Source Server Type    : SQL Server
 Source Server Version : 15002104 (15.00.2104)
 Source Host           : SDK\SQL2019:1433
 Source Catalog        : DEV
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002104 (15.00.2104)
 File Encoding         : 65001

 Date: 07/11/2023 19:06:07
*/


-- ----------------------------
-- Table structure for transactions
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[transactions]') AND type IN ('U'))
	DROP TABLE [dbo].[transactions]
GO

CREATE TABLE [dbo].[transactions] (
  [amount] int  NOT NULL,
  [date] date  NOT NULL
)
GO

ALTER TABLE [dbo].[transactions] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'1000', N'2020-01-06')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-10', N'2020-01-14')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-75', N'2020-01-20')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-5', N'2020-01-25')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-4', N'2020-01-29')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'2000', N'2020-03-10')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-75', N'2020-03-12')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-20', N'2020-03-15')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'40', N'2020-03-15')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-50', N'2020-03-17')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'200', N'2020-10-10')
GO

INSERT INTO [dbo].[transactions] ([amount], [date]) VALUES (N'-200', N'2020-10-10')
GO

