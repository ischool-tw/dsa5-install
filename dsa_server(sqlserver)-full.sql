/****** Object:  Table [dbo].[application]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[ref_server_id] [int] NULL,
	[resource] [ntext] NULL,
	[config] [ntext] NULL,
	[update_info] [nvarchar](50) NULL,
	[enabled] [bit] NULL,
	[deploy_version] [nvarchar](50) NULL,
	[expired_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_application_name] UNIQUE NONCLUSTERED 
(
	[name] ASC,
	[ref_server_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[application_params]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[application_params](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ref_server_id] [int] NOT NULL,
	[application_name] [nvarchar](50) NOT NULL,
	[param_name] [nvarchar](100) NOT NULL,
	[param_value] [ntext] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_server_app_param] UNIQUE NONCLUSTERED 
(
	[application_name] ASC,
	[ref_server_id] ASC,
	[param_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[contract]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[ref_application_id] [int] NULL,
	[config] [ntext] NULL,
	[resource] [ntext] NULL,
	[app_default] [bit] NULL,
	[update_info] [nvarchar](50) NULL,
	[enabled] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_application_contract] UNIQUE NONCLUSTERED 
(
	[ref_application_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[contract_params]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contract_params](
	[server_name] [nvarchar](50) NOT NULL,
	[application_name] [nvarchar](50) NOT NULL,
	[contract_name] [nvarchar](50) NOT NULL,
	[param_name] [nvarchar](100) NOT NULL,
	[context] [ntext] NOT NULL,
 CONSTRAINT [pk_contract_param] PRIMARY KEY CLUSTERED 
(
	[server_name] ASC,
	[application_name] ASC,
	[contract_name] ASC,
	[param_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[delay_request]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delay_request](
	[id] [nvarchar](100) NULL,
	[request] [ntext] NULL,
	[response] [ntext] NULL,
	[target_application] [nvarchar](100) NOT NULL,
	[target_contract] [nvarchar](100) NOT NULL,
	[target_service] [nvarchar](100) NOT NULL,
	[insert_timestamp] [datetime] NULL,
	[status] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[login]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[login](
	[login_name] [varchar](50) NOT NULL,
 CONSTRAINT [pk__login] PRIMARY KEY CLUSTERED 
(
	[login_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[package]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[package](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](255) NULL,
	[name] [nvarchar](50) NULL,
	[definition] [ntext] NULL,
	[ref_contract_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_contract_package] UNIQUE NONCLUSTERED 
(
	[full_name] ASC,
	[ref_contract_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[server]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[server](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[update_info] [nvarchar](50) NULL,
	[configuration] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_server_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[service]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[definition] [ntext] NULL,
	[full_name] [nvarchar](255) NULL,
	[ref_contract_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_contract_service] UNIQUE NONCLUSTERED 
(
	[full_name] ASC,
	[ref_contract_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[session]    Script Date: 2013/5/27 下午 12:15:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[session](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[session_id] [nvarchar](255) NOT NULL,
	[user_info] [ntext] NOT NULL,
	[expired] [datetime] NULL,
	[properties] [ntext] NULL,
	[server] [nvarchar](50) NULL,
	[application] [nvarchar](50) NULL,
	[contract] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uniq_session_id] UNIQUE NONCLUSTERED 
(
	[session_id] ASC,
	[contract] ASC,
	[application] ASC,
	[server] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_delay_request_id]    Script Date: 2013/5/27 下午 12:15:14 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_delay_request_id] ON [dbo].[delay_request]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_insert_timestamp]    Script Date: 2013/5/27 下午 12:15:14 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_insert_timestamp] ON [dbo].[delay_request]
(
	[insert_timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_session_id]    Script Date: 2013/5/27 下午 12:15:14 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_session_id] ON [dbo].[session]
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[application] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[contract] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[delay_request] ADD  DEFAULT (getdate()) FOR [insert_timestamp]
GO
ALTER TABLE [dbo].[application]  WITH CHECK ADD  CONSTRAINT [fk_server_application] FOREIGN KEY([ref_server_id])
REFERENCES [dbo].[server] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[application] CHECK CONSTRAINT [fk_server_application]
GO
ALTER TABLE [dbo].[contract]  WITH CHECK ADD  CONSTRAINT [fk_application_contract] FOREIGN KEY([ref_application_id])
REFERENCES [dbo].[application] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[contract] CHECK CONSTRAINT [fk_application_contract]
GO
ALTER TABLE [dbo].[package]  WITH CHECK ADD  CONSTRAINT [fk_contract_package] FOREIGN KEY([ref_contract_id])
REFERENCES [dbo].[contract] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[package] CHECK CONSTRAINT [fk_contract_package]
GO
ALTER TABLE [dbo].[service]  WITH CHECK ADD  CONSTRAINT [fk_contract_service] FOREIGN KEY([ref_contract_id])
REFERENCES [dbo].[contract] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[service] CHECK CONSTRAINT [fk_contract_service]
GO