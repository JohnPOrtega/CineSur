/* ============================================================================
   SCRIPT COMPLETO - CineSur (base Ing.Software)  -  SQL Server
   ----------------------------------------------------------------------------
   lo genere desde el management studio con esquema y datos y despues lo acomode
   pa que corra en cualquier compu: saque el CREATE DATABASE que traia las rutas
   de los archivos .mdf/.ldf de mi maquina (en otra pc esas carpetas no existen
   y falla) y todos los ALTER DATABASE de opciones. ahora la base se crea con
   los valores por defecto del servidor y solo si todavia no existe
   trae todas las tablas con sus datos, los procedimientos, las fk y los 3
   triggers de la bitacora de cambios de pelicula. los triggers van al final a
   proposito, si se crearan antes al insertar las pelis se duplicaria el historial
   se corre en una instancia que no tenga la base Ing.Software (si ya esta hay
   que borrarla antes o el script frena con un aviso)
   ============================================================================ */
USE [master]
GO
IF DB_ID(N'Ing.Software') IS NULL
    CREATE DATABASE [Ing.Software];
GO
USE [Ing.Software]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- si la base ya tenia las tablas freno aca, asi no tira un monton de errores de objeto existente
IF OBJECT_ID(N'[dbo].[Usuarios_43BO]', N'U') IS NOT NULL
BEGIN
    RAISERROR(N'La base Ing.Software ya tiene tablas. Borrala primero y volve a correr el script.', 16, 1);
    SET NOEXEC ON;
END
GO
GO
/****** Objeto: Table [dbo].[AsientoFuncion_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AsientoFuncion_14OR](
	[IdFuncion_14OR] [int] NOT NULL,
	[IdButaca_14OR] [int] NOT NULL,
	[IdVenta_14OR] [int] NULL,
	[Estado_14OR] [varchar](15) NOT NULL,
	[Ingreso_14OR] [bit] NOT NULL,
 CONSTRAINT [PK_AsientoFuncion_14OR] PRIMARY KEY CLUSTERED 
(
	[IdFuncion_14OR] ASC,
	[IdButaca_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Bitacora_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora_43BO](
	[IdEvento_43BO] [int] IDENTITY(1,1) NOT NULL,
	[DNIuser_43BO] [int] NOT NULL,
	[Fecha_43BO] [datetime] NOT NULL,
	[Modulo_43BO] [nvarchar](50) NOT NULL,
	[Evento_43BO] [nvarchar](50) NOT NULL,
	[Criticidad_43BO] [int] NOT NULL,
 CONSTRAINT [PK_Bitacora_43BO] PRIMARY KEY CLUSTERED 
(
	[IdEvento_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Butaca_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Butaca_14OR](
	[IdButaca_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdSala_14OR] [int] NOT NULL,
	[NumeroFila_14OR] [int] NOT NULL,
	[NumeroAsiento_14OR] [int] NOT NULL,
 CONSTRAINT [PK_Butaca_14OR] PRIMARY KEY CLUSTERED 
(
	[IdButaca_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Cliente_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente_14OR](
	[IdCliente_14OR] [int] IDENTITY(1,1) NOT NULL,
	[DNI_14OR] [int] NOT NULL,
	[Nombre_14OR] [nvarchar](50) NOT NULL,
	[Apellido_14OR] [nvarchar](50) NOT NULL,
	[Email_14OR] [nvarchar](50) NULL,
	[Telefono_14OR] [varchar](20) NULL,
	[Suscriptor_14OR] [bit] NOT NULL,
	[Eliminado_14OR] [bit] NOT NULL,
 CONSTRAINT [PK_Cliente_14OR] PRIMARY KEY CLUSTERED 
(
	[IdCliente_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DetalleOrdenCompra_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleOrdenCompra_14OR](
	[IdDetalleOrdenCompra_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdOrdenCompra_14OR] [int] NOT NULL,
	[IdProducto_14OR] [int] NOT NULL,
	[NombreProducto_14OR] [nvarchar](100) NOT NULL,
	[Cantidad_14OR] [int] NOT NULL,
	[PrecioCosto_14OR] [decimal](18, 2) NOT NULL,
	[CantidadRecibida_14OR] [int] NULL,
 CONSTRAINT [PK_DetalleOrdenCompra_14OR] PRIMARY KEY CLUSTERED 
(
	[IdDetalleOrdenCompra_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DetallePresupuesto_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePresupuesto_14OR](
	[IdDetallePresupuesto_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdPresupuesto_14OR] [int] NOT NULL,
	[IdProducto_14OR] [int] NOT NULL,
	[NombreProducto_14OR] [nvarchar](100) NOT NULL,
	[Cantidad_14OR] [int] NOT NULL,
	[PrecioCotizado_14OR] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_DetallePresupuesto_14OR] PRIMARY KEY CLUSTERED 
(
	[IdDetallePresupuesto_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DetalleVentaCandy_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVentaCandy_14OR](
	[IdDetalleVentaCandy_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdVentaCandy_14OR] [int] NOT NULL,
	[IdProducto_14OR] [int] NOT NULL,
	[NombreProducto_14OR] [nvarchar](100) NOT NULL,
	[Cantidad_14OR] [int] NOT NULL,
	[PrecioUnitario_14OR] [decimal](18, 2) NOT NULL,
	[Subtotal_14OR] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_DetalleVentaCandy_14OR] PRIMARY KEY CLUSTERED 
(
	[IdDetalleVentaCandy_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DV_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DV_43BO](
	[NombreTabla_43BO] [varchar](50) NOT NULL,
	[DVH_43BO] [varchar](100) NOT NULL,
	[DVV_43BO] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NombreTabla_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Familia_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Familia_43BO](
	[IdFamilia_43BO] [int] IDENTITY(1,1) NOT NULL,
	[NombreFamilia_43BO] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Familia_43BO] PRIMARY KEY CLUSTERED 
(
	[IdFamilia_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Familia_Familia] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Familia_Familia](
	[IdFamiliaPadre_43BO] [int] NOT NULL,
	[IdFamiliaHijo_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFamiliaPadre_43BO] ASC,
	[IdFamiliaHijo_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Funcion_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funcion_14OR](
	[IdFuncion_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula_14OR] [int] NOT NULL,
	[IdSala_14OR] [int] NOT NULL,
	[Fecha_14OR] [datetime] NOT NULL,
	[Horario_14OR] [datetime] NOT NULL,
	[Formato_14OR] [varchar](10) NOT NULL,
	[Idioma_14OR] [varchar](20) NOT NULL,
	[Precio_14OR] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Funcion_14OR] PRIMARY KEY CLUSTERED 
(
	[IdFuncion_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[OrdenCompra_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenCompra_14OR](
	[IdOrdenCompra_14OR] [int] IDENTITY(1,1) NOT NULL,
	[NumeroOrden_14OR] [int] NOT NULL,
	[IdProveedor_14OR] [int] NOT NULL,
	[IdPresupuesto_14OR] [int] NOT NULL,
	[FechaEmision_14OR] [date] NOT NULL,
	[Estado_14OR] [nvarchar](20) NOT NULL,
	[Importe_14OR] [decimal](18, 2) NOT NULL,
	[FechaPago_14OR] [datetime] NULL,
	[NumeroRemito_14OR] [nvarchar](50) NULL,
	[FechaRecepcion_14OR] [datetime] NULL,
 CONSTRAINT [PK_OrdenCompra_14OR] PRIMARY KEY CLUSTERED 
(
	[IdOrdenCompra_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Patente_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_43BO](
	[IdPatente_43BO] [int] IDENTITY(1,1) NOT NULL,
	[NombrePatente_43BO] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Patente_43BO] PRIMARY KEY CLUSTERED 
(
	[IdPatente_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Patente_Familia] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[IdFamilia_43BO] [int] NOT NULL,
	[IdPatente_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFamilia_43BO] ASC,
	[IdPatente_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Pelicula_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pelicula_14OR](
	[IdPelicula_14OR] [int] IDENTITY(1,1) NOT NULL,
	[Titulo_14OR] [nvarchar](100) NOT NULL,
	[Genero_14OR] [nvarchar](50) NOT NULL,
	[Duracion_14OR] [int] NOT NULL,
	[Poster_14OR] [varchar](260) NULL,
 CONSTRAINT [PK_Pelicula_14OR] PRIMARY KEY CLUSTERED 
(
	[IdPelicula_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Pelicula_C_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pelicula_C_14OR](
	[IdCambio_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula_14OR] [int] NOT NULL,
	[Titulo_14OR] [nvarchar](200) NULL,
	[Genero_14OR] [nvarchar](200) NULL,
	[Duracion_14OR] [int] NULL,
	[Poster_14OR] [nvarchar](260) NULL,
	[Act_14OR] [bit] NOT NULL,
	[TipoCambio_14OR] [nvarchar](20) NOT NULL,
	[FechaHora_14OR] [datetime] NOT NULL,
 CONSTRAINT [PK_Pelicula_C_14OR] PRIMARY KEY CLUSTERED 
(
	[IdCambio_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Presupuesto_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presupuesto_14OR](
	[IdPresupuesto_14OR] [int] IDENTITY(1,1) NOT NULL,
	[NumeroPresupuesto_14OR] [int] NOT NULL,
	[IdProveedor_14OR] [int] NOT NULL,
	[FechaPedido_14OR] [date] NOT NULL,
	[Estado_14OR] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Presupuesto_14OR] PRIMARY KEY CLUSTERED 
(
	[IdPresupuesto_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Producto_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto_14OR](
	[IdProducto_14OR] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_14OR] [nvarchar](100) NOT NULL,
	[PrecioVenta_14OR] [decimal](18, 2) NOT NULL,
	[Stock_14OR] [int] NOT NULL,
	[StockCritico_14OR] [int] NOT NULL,
	[Activo_14OR] [bit] NOT NULL,
	[Imagen_14OR] [nvarchar](200) NULL,
	[PrecioCosto_14OR] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Producto_14OR] PRIMARY KEY CLUSTERED 
(
	[IdProducto_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Promocion_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promocion_14OR](
	[IdPromocion_14OR] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_14OR] [varchar](100) NOT NULL,
	[Tipo_14OR] [varchar](15) NOT NULL,
	[Valor_14OR] [decimal](10, 2) NOT NULL,
	[FechaInicio_14OR] [date] NOT NULL,
	[FechaFin_14OR] [date] NOT NULL,
	[Activa_14OR] [bit] NOT NULL,
 CONSTRAINT [PK_Promocion_14OR] PRIMARY KEY CLUSTERED 
(
	[IdPromocion_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Proveedor_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor_14OR](
	[IdProveedor_14OR] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_14OR] [nvarchar](100) NOT NULL,
	[Telefono_14OR] [nvarchar](50) NULL,
	[Email_14OR] [nvarchar](150) NULL,
	[Activo_14OR] [bit] NOT NULL,
	[Cuit_14OR] [varchar](11) NULL,
 CONSTRAINT [PK_Proveedor_14OR] PRIMARY KEY CLUSTERED 
(
	[IdProveedor_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Rol_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol_43BO](
	[IdRol_43BO] [int] IDENTITY(1,1) NOT NULL,
	[NombreRol_43BO] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Rol_43BO__C5D277CC5292C17E] PRIMARY KEY CLUSTERED 
(
	[IdRol_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Rol_Familia] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol_Familia](
	[IdRol_43BO] [int] NOT NULL,
	[IdFamilia_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol_43BO] ASC,
	[IdFamilia_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Rol_Patente] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol_Patente](
	[IdRol_43BO] [int] NOT NULL,
	[IdPatente_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol_43BO] ASC,
	[IdPatente_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Sala_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sala_14OR](
	[IdSala_14OR] [int] IDENTITY(1,1) NOT NULL,
	[Numero_14OR] [int] NOT NULL,
	[Capacidad_14OR] [int] NOT NULL,
	[Pasillos_14OR] [varchar](100) NULL,
 CONSTRAINT [PK_Sala_14OR] PRIMARY KEY CLUSTERED 
(
	[IdSala_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Usuarios_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios_43BO](
	[IdUser_43BO] [int] IDENTITY(1,1) NOT NULL,
	[DNI_43BO] [int] NOT NULL,
	[Nombre_43BO] [nvarchar](50) NOT NULL,
	[Apellido_43BO] [nvarchar](50) NOT NULL,
	[Bloqueado_43BO] [bit] NOT NULL,
	[Email_43BO] [nvarchar](50) NOT NULL,
	[Activo_43BO] [bit] NOT NULL,
	[Hash_43BO] [nvarchar](max) NOT NULL,
	[Rol_43BO] [int] NOT NULL,
	[Idioma_43BO] [varchar](10) NULL,
 CONSTRAINT [PK_Usuarios_43BO_1] PRIMARY KEY CLUSTERED 
(
	[DNI_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Venta_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta_14OR](
	[IdVenta_14OR] [int] IDENTITY(1,1) NOT NULL,
	[NumeroVenta_14OR] [int] NOT NULL,
	[IdCliente_14OR] [int] NULL,
	[Fecha_14OR] [datetime] NOT NULL,
	[Hora_14OR] [datetime] NOT NULL,
	[Estado_14OR] [varchar](15) NOT NULL,
	[MetodoPago_14OR] [varchar](15) NOT NULL,
	[MontoTotal_14OR] [decimal](10, 2) NOT NULL,
	[IdPromocion_14OR] [int] NULL,
	[MontoDescuento_14OR] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Venta_14OR] PRIMARY KEY CLUSTERED 
(
	[IdVenta_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[VentaCandy_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VentaCandy_14OR](
	[IdVentaCandy_14OR] [int] IDENTITY(1,1) NOT NULL,
	[NumeroVenta_14OR] [int] NOT NULL,
	[Fecha_14OR] [date] NOT NULL,
	[Hora_14OR] [datetime] NOT NULL,
	[MetodoPago_14OR] [nvarchar](30) NOT NULL,
	[MontoTotal_14OR] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_VentaCandy_14OR] PRIMARY KEY CLUSTERED 
(
	[IdVentaCandy_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 81, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 82, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 83, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 84, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 85, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 86, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 87, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 88, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 89, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 90, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 91, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 92, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 93, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 94, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 95, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 96, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 97, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 98, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 99, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 100, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 101, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 102, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 103, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 104, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 105, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 106, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 107, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 108, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 109, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 110, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 111, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 112, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 113, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 114, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 115, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 116, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 117, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 118, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 119, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 120, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 121, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 122, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 123, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 124, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 125, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 126, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 127, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 128, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 129, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 130, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 131, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 132, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 133, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 134, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 135, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 136, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 137, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 138, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 139, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 140, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 141, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 142, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 143, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 144, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 145, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 146, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 147, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 148, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 149, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 150, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 151, 13, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 152, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 153, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 154, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 155, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 156, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 157, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 158, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 159, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 160, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 161, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 162, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 163, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 164, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 165, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 166, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 167, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 168, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 169, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 170, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 171, 13, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 172, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 173, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 174, 13, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 175, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 176, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 177, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 178, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 179, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 180, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 181, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 182, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 183, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 184, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 185, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 186, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 187, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 188, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 189, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 190, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 191, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 192, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 193, 13, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 194, 13, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 195, 13, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 196, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 197, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 198, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 199, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (1, 200, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 1, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 2, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 3, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 4, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 5, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 6, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 7, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 8, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 9, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 10, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 11, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 12, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 13, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 14, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 15, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 16, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 17, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 18, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 19, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 20, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 21, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 22, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 23, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 24, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 25, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 26, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 27, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 28, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 29, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 30, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 31, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 32, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 33, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 34, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 35, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 36, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 37, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 38, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 39, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 40, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 41, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 42, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 43, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 44, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 45, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 46, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 47, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 48, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 49, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 50, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 51, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 52, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 53, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 54, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 55, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 56, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 57, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 58, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 59, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 60, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 61, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 62, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 63, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 64, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 65, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 66, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 67, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 68, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 69, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 70, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 71, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 72, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 73, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 74, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 75, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 76, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 77, 8, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 78, 8, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 79, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 80, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 411, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 412, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 413, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 414, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 415, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 416, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 417, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 418, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 419, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 420, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 421, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 422, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 423, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 424, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 425, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 426, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 427, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 428, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 429, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 430, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 431, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 432, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 433, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 434, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 435, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 436, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 437, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 438, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 439, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 440, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 441, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 442, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 443, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 444, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 445, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 446, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 447, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 448, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 449, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 450, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 451, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 452, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 453, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 454, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 455, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 456, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 457, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 458, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 459, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 460, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 461, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 462, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 463, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 464, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 465, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 466, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 467, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 468, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 469, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 470, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 471, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 472, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 473, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 474, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 475, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 476, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 477, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 478, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 479, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 480, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 481, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 482, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 483, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 484, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 485, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 486, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 487, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 488, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 489, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 490, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 491, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 492, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 493, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 494, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 495, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 496, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 497, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 498, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 499, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 500, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 501, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 502, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 503, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 504, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 505, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 506, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 507, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 508, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 509, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 510, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 511, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 512, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 513, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 514, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 515, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 516, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 517, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 518, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 519, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 520, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 521, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 522, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 523, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 524, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 525, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 526, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 527, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 528, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 529, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 530, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 531, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 532, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 533, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 534, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 535, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 536, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 537, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 538, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 539, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 540, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 541, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 542, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 543, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 544, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 545, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 546, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 547, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 548, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 549, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 550, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 551, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 552, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 553, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 554, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 555, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 556, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 557, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 558, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 559, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 560, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 561, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 562, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 563, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 564, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 565, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 566, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 567, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 568, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 569, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 570, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 571, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 572, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 573, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 574, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 575, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 576, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 577, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 578, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 579, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 580, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 581, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 582, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 583, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 584, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 585, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 586, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 587, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 588, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 589, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 590, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 591, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 592, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 593, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 594, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 595, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 596, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 597, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 598, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 599, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 600, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 601, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 602, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 603, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 604, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 605, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 606, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 607, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 608, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 609, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 610, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 611, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 612, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 613, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 614, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 615, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 616, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 617, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 618, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 619, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (2, 620, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 81, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 82, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 83, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 84, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 85, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 86, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 87, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 88, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 89, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 90, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 91, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 92, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 93, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 94, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 95, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 96, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 97, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 98, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 99, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 100, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 101, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 102, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 103, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 104, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 105, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 106, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 107, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 108, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 109, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 110, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 111, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 112, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 113, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 114, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 115, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 116, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 117, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 118, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 119, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 120, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 121, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 122, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 123, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 124, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 125, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 126, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 127, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 128, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 129, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 130, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 131, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 132, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 133, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 134, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 135, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 136, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 137, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 138, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 139, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 140, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 141, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 142, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 143, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 144, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 145, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 146, 1, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 147, 1, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 148, 1, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 149, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 150, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 151, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 152, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 153, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 154, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 155, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 156, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 157, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 158, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 159, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 160, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 161, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 162, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 163, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 164, 5, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 165, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 166, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 167, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 168, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 169, 2, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 170, 2, N'Ocupada', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 171, 2, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 172, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 173, 3, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 174, 3, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 175, 3, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 176, 3, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 177, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 178, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 179, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 180, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 181, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 182, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 183, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 184, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 185, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 186, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 187, 4, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 188, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 189, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 190, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 191, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 192, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 193, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 194, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 195, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 196, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 197, 3, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 198, 3, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 199, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (3, 200, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 81, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 82, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 83, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 84, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 85, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 86, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 87, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 88, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 89, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 90, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 91, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 92, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 93, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 94, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 95, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 96, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 97, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 98, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 99, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 100, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 101, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 102, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 103, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 104, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 105, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 106, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 107, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 108, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 109, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 110, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 111, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 112, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 113, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 114, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 115, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 116, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 117, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 118, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 119, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 120, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 121, 6, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 122, 6, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 123, 6, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 124, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 125, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 126, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 127, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 128, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 129, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 130, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 131, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 132, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 133, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 134, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 135, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 136, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 137, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 138, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 139, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 140, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 141, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 142, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 143, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 144, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 145, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 146, 7, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 147, 7, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 148, 7, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 149, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 150, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 151, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 152, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 153, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 154, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 155, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 156, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 157, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 158, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 159, 7, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 160, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 161, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 162, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 163, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 164, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 165, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 166, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 167, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 168, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 169, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 170, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 171, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 172, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 173, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 174, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 175, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 176, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 177, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 178, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 179, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 180, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 181, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 182, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 183, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 184, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 185, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 186, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 187, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 188, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 189, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 190, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 191, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 192, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 193, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 194, 9, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 195, 9, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 196, 9, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 197, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 198, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 199, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (4, 200, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 411, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 412, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 413, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 414, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 415, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 416, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 417, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 418, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 419, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 420, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 421, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 422, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 423, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 424, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 425, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 426, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 427, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 428, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 429, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 430, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 431, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 432, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 433, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 434, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 435, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 436, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 437, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 438, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 439, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 440, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 441, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 442, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 443, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 444, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 445, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 446, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 447, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 448, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 449, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 450, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 451, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 452, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 453, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 454, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 455, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 456, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 457, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 458, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 459, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 460, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 461, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 462, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 463, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 464, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 465, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 466, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 467, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 468, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 469, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 470, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 471, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 472, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 473, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 474, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 475, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 476, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 477, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 478, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 479, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 480, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 481, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 482, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 483, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 484, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 485, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 486, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 487, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 488, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 489, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 490, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 491, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 492, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 493, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 494, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 495, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 496, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 497, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 498, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 499, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 500, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 501, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 502, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 503, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 504, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 505, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 506, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 507, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 508, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 509, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 510, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 511, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 512, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 513, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 514, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 515, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 516, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 517, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 518, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 519, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 520, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 521, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 522, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 523, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 524, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 525, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 526, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 527, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 528, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 529, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 530, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 531, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 532, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 533, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 534, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 535, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 536, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 537, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 538, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 539, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 540, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 541, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 542, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 543, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 544, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 545, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 546, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 547, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 548, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 549, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 550, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 551, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 552, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 553, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 554, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 555, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 556, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 557, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 558, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 559, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 560, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 561, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 562, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 563, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 564, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 565, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 566, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 567, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 568, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 569, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 570, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 571, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 572, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 573, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 574, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 575, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 576, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 577, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 578, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 579, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 580, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 581, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 582, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 583, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 584, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 585, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 586, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 587, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 588, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 589, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 590, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 591, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 592, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 593, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 594, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 595, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 596, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 597, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 598, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 599, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 600, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 601, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 602, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 603, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 604, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 605, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 606, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 607, 12, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 608, 12, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 609, 11, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 610, 11, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 611, 11, N'Utilizada', 1)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 612, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 613, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 614, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 615, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 616, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 617, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 618, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 619, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (7, 620, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 81, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 82, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 83, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 84, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 85, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 86, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 87, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 88, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 89, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 90, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 91, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 92, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 93, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 94, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 95, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 96, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 97, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 98, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 99, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 100, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 101, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 102, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 103, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 104, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 105, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 106, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 107, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 108, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 109, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 110, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 111, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 112, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 113, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 114, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 115, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 116, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 117, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 118, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 119, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 120, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 121, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 122, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 123, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 124, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 125, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 126, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 127, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 128, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 129, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 130, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 131, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 132, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 133, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 134, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 135, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 136, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 137, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 138, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 139, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 140, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 141, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 142, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 143, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 144, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 145, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 146, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 147, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 148, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 149, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 150, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 151, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 152, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 153, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 154, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 155, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 156, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 157, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 158, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 159, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 160, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 161, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 162, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 163, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 164, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 165, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 166, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 167, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 168, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 169, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 170, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 171, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 172, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 173, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 174, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 175, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 176, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 177, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 178, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 179, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 180, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 181, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 182, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 183, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 184, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 185, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 186, 10, N'Ocupada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 187, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 188, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 189, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 190, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 191, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 192, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 193, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 194, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 195, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 196, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 197, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 198, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 199, NULL, N'Reservada', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (8, 200, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 411, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 412, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 413, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 414, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 415, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 416, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 417, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 418, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 419, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 420, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 421, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 422, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 423, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 424, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 425, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 426, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 427, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 428, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 429, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 430, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 431, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 432, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 433, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 434, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 435, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 436, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 437, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 438, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 439, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 440, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 441, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 442, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 443, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 444, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 445, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 446, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 447, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 448, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 449, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 450, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 451, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 452, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 453, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 454, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 455, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 456, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 457, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 458, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 459, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 460, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 461, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 462, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 463, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 464, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 465, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 466, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 467, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 468, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 469, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 470, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 471, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 472, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 473, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 474, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 475, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 476, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 477, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 478, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 479, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 480, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 481, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 482, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 483, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 484, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 485, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 486, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 487, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 488, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 489, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 490, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 491, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 492, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 493, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 494, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 495, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 496, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 497, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 498, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 499, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 500, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 501, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 502, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 503, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 504, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 505, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 506, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 507, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 508, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 509, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 510, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 511, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 512, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 513, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 514, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 515, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 516, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 517, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 518, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 519, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 520, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 521, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 522, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 523, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 524, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 525, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 526, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 527, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 528, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 529, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 530, NULL, N'Libre', 0)
GO
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 531, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 532, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 533, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 534, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 535, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 536, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 537, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 538, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 539, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 540, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 541, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 542, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 543, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 544, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 545, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 546, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 547, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 548, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 549, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 550, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 551, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 552, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 553, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 554, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 555, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 556, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 557, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 558, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 559, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 560, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 561, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 562, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 563, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 564, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 565, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 566, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 567, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 568, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 569, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 570, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 571, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 572, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 573, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 574, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 575, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 576, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 577, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 578, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 579, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 580, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 581, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 582, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 583, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 584, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 585, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 586, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 587, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 588, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 589, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 590, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 591, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 592, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 593, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 594, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 595, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 596, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 597, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 598, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 599, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 600, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 601, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 602, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 603, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 604, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 605, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 606, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 607, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 608, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 609, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 610, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 611, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 612, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 613, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 614, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 615, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 616, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 617, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 618, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 619, NULL, N'Libre', 0)
INSERT [dbo].[AsientoFuncion_14OR] ([IdFuncion_14OR], [IdButaca_14OR], [IdVenta_14OR], [Estado_14OR], [Ingreso_14OR]) VALUES (9, 620, NULL, N'Libre', 0)
GO
SET IDENTITY_INSERT [dbo].[Bitacora_43BO] ON 

INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2, 46498814, CAST(N'2026-04-28T22:59:33.523' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3, 46498814, CAST(N'2026-05-01T19:16:03.517' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4, 45678912, CAST(N'2026-05-01T19:24:56.973' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5, 45678912, CAST(N'2026-05-01T19:25:10.033' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6, 45678912, CAST(N'2026-05-01T19:38:25.577' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7, 45678912, CAST(N'2026-05-01T19:38:30.883' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8, 45678912, CAST(N'2026-05-01T19:38:35.127' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9, 46498814, CAST(N'2026-05-01T19:40:32.417' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (10, 46498814, CAST(N'2026-05-01T19:44:11.987' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (11, 46498814, CAST(N'2026-05-01T19:44:19.613' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (12, 46498814, CAST(N'2026-05-04T09:31:21.610' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (13, 46498814, CAST(N'2026-05-04T09:34:33.910' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (14, 46498814, CAST(N'2026-05-04T09:38:14.650' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (15, 46498814, CAST(N'2026-05-04T10:39:42.423' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (16, 46498814, CAST(N'2026-05-04T10:44:03.170' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1012, 46498814, CAST(N'2026-05-05T20:43:55.083' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1013, 46498814, CAST(N'2026-05-05T20:47:59.050' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1014, 46498814, CAST(N'2026-05-05T20:48:41.173' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1015, 46498814, CAST(N'2026-05-05T20:55:42.433' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1016, 46498814, CAST(N'2026-05-05T20:56:40.040' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1017, 46498814, CAST(N'2026-05-05T20:59:20.567' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1018, 46498814, CAST(N'2026-05-05T20:59:32.203' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1019, 46498814, CAST(N'2026-05-05T21:06:06.640' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1020, 46498814, CAST(N'2026-05-05T21:06:18.547' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1021, 46498814, CAST(N'2026-05-05T21:06:27.523' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1022, 46498814, CAST(N'2026-05-05T21:08:46.037' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1023, 46498814, CAST(N'2026-05-05T21:10:06.123' AS DateTime), N'Usuario', N'Crear', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1024, 46498815, CAST(N'2026-05-05T21:16:10.407' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1025, 46498815, CAST(N'2026-05-05T21:17:41.120' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1026, 46498815, CAST(N'2026-05-05T21:19:12.133' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1027, 46498815, CAST(N'2026-05-05T21:20:23.730' AS DateTime), N'Usuario', N'Desactivar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1028, 46498815, CAST(N'2026-05-05T21:28:58.837' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1029, 46498815, CAST(N'2026-05-05T21:29:48.677' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1030, 46498815, CAST(N'2026-05-05T21:30:38.853' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1031, 46498815, CAST(N'2026-05-05T22:17:47.457' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1032, 46498815, CAST(N'2026-05-05T22:18:12.670' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1033, 46498815, CAST(N'2026-05-05T22:18:24.200' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1034, 46498814, CAST(N'2026-05-05T22:18:50.033' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1035, 46498814, CAST(N'2026-05-05T22:19:23.063' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1036, 46498814, CAST(N'2026-05-05T22:19:36.393' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1037, 46498814, CAST(N'2026-05-17T14:01:23.223' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1038, 46498814, CAST(N'2026-05-17T14:04:56.717' AS DateTime), N'Usuario', N'Crear', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1039, 46498814, CAST(N'2026-05-17T14:06:36.130' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1040, 11222333, CAST(N'2026-05-17T14:06:56.343' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1041, 11222333, CAST(N'2026-05-17T14:08:57.833' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1042, 11222333, CAST(N'2026-05-17T14:09:07.830' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1043, 46498814, CAST(N'2026-05-17T15:08:25.547' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1044, 46498814, CAST(N'2026-05-17T15:09:14.797' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1045, 46498814, CAST(N'2026-05-17T15:11:47.137' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1046, 11222333, CAST(N'2026-05-17T15:12:12.147' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1047, 46498814, CAST(N'2026-05-17T17:19:21.363' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1048, 46498814, CAST(N'2026-05-17T17:19:40.460' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1049, 46498814, CAST(N'2026-05-17T17:27:26.087' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1050, 46498814, CAST(N'2026-05-17T17:32:55.947' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1051, 46498814, CAST(N'2026-05-17T17:39:58.203' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1052, 46498814, CAST(N'2026-05-17T18:04:12.113' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1053, 46498814, CAST(N'2026-05-17T18:05:34.337' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1054, 46498814, CAST(N'2026-05-17T18:05:48.570' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1055, 46498814, CAST(N'2026-05-17T18:12:01.313' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1056, 46498814, CAST(N'2026-05-17T18:15:26.203' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1057, 46498815, CAST(N'2026-05-17T18:24:09.350' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1058, 46498815, CAST(N'2026-05-17T18:36:55.210' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1059, 46498815, CAST(N'2026-05-17T19:04:30.153' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1060, 46498815, CAST(N'2026-05-17T19:30:41.543' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1061, 46498815, CAST(N'2026-05-17T19:48:22.387' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1062, 46498815, CAST(N'2026-05-17T21:37:39.717' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1063, 46498815, CAST(N'2026-05-17T21:41:48.400' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1064, 46498815, CAST(N'2026-05-17T21:45:35.667' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1065, 46498815, CAST(N'2026-05-17T21:52:29.140' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1066, 46498815, CAST(N'2026-05-17T21:59:31.167' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1067, 46498815, CAST(N'2026-05-17T22:03:48.243' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1068, 46498815, CAST(N'2026-05-17T22:04:28.977' AS DateTime), N'Usuario', N'Crear', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1069, 46498815, CAST(N'2026-05-17T22:12:24.137' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1070, 46498815, CAST(N'2026-05-17T22:15:24.750' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1071, 46498815, CAST(N'2026-05-17T22:47:47.820' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1072, 46498815, CAST(N'2026-05-17T22:52:16.390' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1073, 46498815, CAST(N'2026-05-17T23:16:21.640' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1074, 46498815, CAST(N'2026-05-17T23:26:46.127' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1075, 46498815, CAST(N'2026-05-17T23:30:10.503' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1076, 46498815, CAST(N'2026-05-17T23:32:26.030' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1077, 46498815, CAST(N'2026-05-17T23:35:59.543' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1078, 46498815, CAST(N'2026-05-17T23:37:07.357' AS DateTime), N'Usuario', N'Crear', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1079, 46498815, CAST(N'2026-05-18T19:52:45.777' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1080, 46498815, CAST(N'2026-05-18T19:53:52.420' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1081, 46498815, CAST(N'2026-05-18T19:54:24.733' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1082, 46498815, CAST(N'2026-05-18T23:01:28.363' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1083, 46498815, CAST(N'2026-05-18T23:03:59.097' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1084, 46498815, CAST(N'2026-05-19T13:51:52.460' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1085, 46498815, CAST(N'2026-05-19T13:52:18.720' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1086, 46498815, CAST(N'2026-05-19T13:53:05.403' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1087, 46498815, CAST(N'2026-05-19T13:58:02.213' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1088, 46498815, CAST(N'2026-05-19T14:07:34.900' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1089, 46498815, CAST(N'2026-05-19T17:30:10.410' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1090, 46498815, CAST(N'2026-05-19T17:36:45.173' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1091, 46498815, CAST(N'2026-05-19T18:02:43.507' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1092, 46498814, CAST(N'2026-05-19T18:04:14.537' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1093, 46498815, CAST(N'2026-05-19T19:03:10.887' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1094, 46498815, CAST(N'2026-05-19T20:16:33.807' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1095, 46498815, CAST(N'2026-05-19T20:19:32.907' AS DateTime), N'Usuario', N'Login', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1096, 46498815, CAST(N'2026-05-19T20:27:45.950' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1097, 46498815, CAST(N'2026-05-19T20:30:51.247' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1098, 46498815, CAST(N'2026-05-19T20:42:33.170' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1099, 46498815, CAST(N'2026-05-19T20:43:08.177' AS DateTime), N'Usuario', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1100, 46498815, CAST(N'2026-05-19T21:04:00.507' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1101, 46498815, CAST(N'2026-05-19T21:04:15.713' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1102, 46498815, CAST(N'2026-05-19T22:04:42.720' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1103, 46498815, CAST(N'2026-05-19T23:14:37.670' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1104, 46498815, CAST(N'2026-05-19T23:14:45.930' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1105, 46498815, CAST(N'2026-05-19T23:14:51.480' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1106, 46498815, CAST(N'2026-05-19T23:15:30.440' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1107, 46498815, CAST(N'2026-05-19T23:15:38.990' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1108, 46498815, CAST(N'2026-05-19T23:15:49.353' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1109, 46498815, CAST(N'2026-05-19T23:16:40.073' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1110, 46498815, CAST(N'2026-05-19T23:16:46.517' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1111, 46498814, CAST(N'2026-05-19T23:17:31.423' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1112, 46498814, CAST(N'2026-05-19T23:18:22.543' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1113, 46498815, CAST(N'2026-05-19T23:19:01.923' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1114, 46498815, CAST(N'2026-05-19T23:19:10.560' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1115, 46498815, CAST(N'2026-05-19T23:19:14.527' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1116, 46498814, CAST(N'2026-05-19T23:19:40.900' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1117, 46498815, CAST(N'2026-05-19T23:21:25.803' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1118, 46498815, CAST(N'2026-05-19T23:21:34.957' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1119, 46498815, CAST(N'2026-05-19T23:21:39.453' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1120, 46498814, CAST(N'2026-05-19T23:21:53.993' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1121, 46498814, CAST(N'2026-05-19T23:22:18.297' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1122, 46498815, CAST(N'2026-05-19T23:25:33.673' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1123, 46498815, CAST(N'2026-05-19T23:25:40.923' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1124, 46498815, CAST(N'2026-05-19T23:25:43.817' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1125, 46498814, CAST(N'2026-05-19T23:26:33.883' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1126, 46498814, CAST(N'2026-05-19T23:26:52.977' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1127, 46498814, CAST(N'2026-05-19T23:29:23.877' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1128, 46498815, CAST(N'2026-05-19T23:32:20.603' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1129, 46498815, CAST(N'2026-05-19T23:32:28.340' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1130, 46498815, CAST(N'2026-05-19T23:32:32.310' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1131, 46498814, CAST(N'2026-05-19T23:32:48.040' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1132, 46498814, CAST(N'2026-05-19T23:33:08.430' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1133, 46498815, CAST(N'2026-05-22T19:38:53.847' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1134, 46498815, CAST(N'2026-05-22T19:43:59.360' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1135, 46498815, CAST(N'2026-05-22T19:44:26.737' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1136, 46498815, CAST(N'2026-05-22T19:44:35.693' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1137, 46498815, CAST(N'2026-05-22T19:44:41.140' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1138, 46498814, CAST(N'2026-05-22T19:44:59.213' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1139, 46498814, CAST(N'2026-05-22T19:45:50.863' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1140, 46498814, CAST(N'2026-05-22T19:46:03.713' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1141, 46498814, CAST(N'2026-05-22T19:46:10.467' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1142, 46498815, CAST(N'2026-05-22T20:31:15.597' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1143, 46498815, CAST(N'2026-05-22T20:34:30.233' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1144, 46498815, CAST(N'2026-05-22T20:59:35.323' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1145, 46498815, CAST(N'2026-05-22T21:05:20.200' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1146, 46498815, CAST(N'2026-05-22T21:25:48.267' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1147, 46498815, CAST(N'2026-05-22T21:30:22.180' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1148, 46498815, CAST(N'2026-05-22T21:39:36.967' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1149, 46498815, CAST(N'2026-05-22T21:42:55.137' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1150, 46498815, CAST(N'2026-05-22T21:46:34.113' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1151, 46498815, CAST(N'2026-05-22T21:49:56.463' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (1152, 46498815, CAST(N'2026-05-22T21:56:17.473' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2133, 46498815, CAST(N'2026-05-25T18:39:29.893' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2134, 46498815, CAST(N'2026-05-25T18:39:39.180' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2135, 46498815, CAST(N'2026-05-25T18:39:42.977' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2136, 46498814, CAST(N'2026-05-25T18:40:03.090' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2137, 46498814, CAST(N'2026-05-25T18:40:33.603' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2138, 46498814, CAST(N'2026-05-25T18:41:01.017' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2139, 46498814, CAST(N'2026-05-25T18:41:05.653' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2140, 46498815, CAST(N'2026-05-25T18:41:50.817' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2141, 46498815, CAST(N'2026-05-25T18:43:09.573' AS DateTime), N'Usuario', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2142, 46498815, CAST(N'2026-05-25T18:43:18.920' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2143, 22666555, CAST(N'2026-05-25T18:43:29.513' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2144, 22666555, CAST(N'2026-05-25T18:44:49.913' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2145, 22666555, CAST(N'2026-05-25T18:44:54.850' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2146, 22666555, CAST(N'2026-05-25T18:45:15.613' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2147, 46498815, CAST(N'2026-05-25T18:49:41.223' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2148, 46498815, CAST(N'2026-05-25T18:55:07.163' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2149, 46498815, CAST(N'2026-05-25T18:57:34.147' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2150, 46498815, CAST(N'2026-05-25T18:58:57.257' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2151, 46498815, CAST(N'2026-05-25T19:02:49.033' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2152, 46498815, CAST(N'2026-05-25T19:06:11.297' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2153, 46498815, CAST(N'2026-05-25T19:09:14.843' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2154, 46498815, CAST(N'2026-05-25T19:18:04.673' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2155, 46498815, CAST(N'2026-05-25T19:20:40.633' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2156, 46498815, CAST(N'2026-05-25T19:27:22.827' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2157, 46498815, CAST(N'2026-05-25T19:28:03.130' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2158, 46498815, CAST(N'2026-05-25T19:33:18.640' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2159, 46498815, CAST(N'2026-05-25T19:51:34.670' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (2160, 46498815, CAST(N'2026-05-25T19:55:54.467' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3149, 46498815, CAST(N'2026-06-02T18:05:02.517' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3150, 46498815, CAST(N'2026-06-02T18:05:51.910' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3151, 46498815, CAST(N'2026-06-02T18:06:00.037' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3152, 46498815, CAST(N'2026-06-02T18:06:04.070' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3153, 46498815, CAST(N'2026-06-02T18:07:59.050' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3154, 46498815, CAST(N'2026-06-02T21:37:30.343' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3155, 46498815, CAST(N'2026-06-02T21:39:14.287' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3156, 46498815, CAST(N'2026-06-02T22:20:28.900' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3157, 46498815, CAST(N'2026-06-02T22:24:35.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3158, 46498815, CAST(N'2026-06-02T22:26:38.957' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3159, 46498815, CAST(N'2026-06-02T22:32:05.697' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3160, 46498815, CAST(N'2026-06-02T22:35:49.127' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3161, 46498815, CAST(N'2026-06-02T22:39:36.777' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3162, 46498815, CAST(N'2026-06-02T22:55:47.363' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3163, 46498815, CAST(N'2026-06-02T22:58:35.960' AS DateTime), N'Usuario', N'Login', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (3164, 46498815, CAST(N'2026-06-02T23:01:28.313' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4153, 46498815, CAST(N'2026-06-06T17:58:04.167' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4154, 46498815, CAST(N'2026-06-06T18:01:20.487' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4155, 46498815, CAST(N'2026-06-06T18:08:29.223' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4156, 46498815, CAST(N'2026-06-06T19:03:10.017' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4157, 46498815, CAST(N'2026-06-06T19:06:10.713' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4158, 46498815, CAST(N'2026-06-06T19:10:37.617' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4159, 46498815, CAST(N'2026-06-06T19:34:05.603' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4160, 46498815, CAST(N'2026-06-06T19:39:22.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4161, 46498815, CAST(N'2026-06-06T20:02:25.760' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4162, 46498815, CAST(N'2026-06-06T20:07:23.187' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4163, 46498815, CAST(N'2026-06-06T20:15:36.760' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4164, 46498815, CAST(N'2026-06-06T20:16:54.747' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4165, 46498815, CAST(N'2026-06-06T20:24:19.833' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4166, 46498815, CAST(N'2026-06-06T20:33:39.813' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4167, 46498815, CAST(N'2026-06-06T20:46:42.773' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4168, 46498815, CAST(N'2026-06-06T21:04:11.293' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4169, 46498815, CAST(N'2026-06-06T21:14:21.410' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4170, 46498815, CAST(N'2026-06-06T21:18:50.363' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4171, 46498815, CAST(N'2026-06-06T21:21:58.623' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4172, 46498815, CAST(N'2026-06-06T21:28:04.917' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4173, 46498815, CAST(N'2026-06-06T21:30:51.273' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4174, 46498815, CAST(N'2026-06-06T21:46:55.563' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4175, 46498815, CAST(N'2026-06-06T22:17:46.870' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4176, 46498815, CAST(N'2026-06-06T22:29:00.410' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4177, 46498815, CAST(N'2026-06-06T22:38:43.433' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4178, 46498815, CAST(N'2026-06-06T22:40:20.260' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4179, 46498815, CAST(N'2026-06-06T22:49:55.873' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (4180, 46498815, CAST(N'2026-06-06T22:51:47.947' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5175, 46498815, CAST(N'2026-06-08T15:42:51.393' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5176, 46498815, CAST(N'2026-06-08T16:15:08.657' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5177, 46498815, CAST(N'2026-06-08T16:38:02.100' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5178, 46498815, CAST(N'2026-06-08T17:31:10.657' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5179, 46498815, CAST(N'2026-06-08T17:34:44.403' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5180, 46498815, CAST(N'2026-06-08T18:17:41.370' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5181, 46498815, CAST(N'2026-06-08T18:23:38.687' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5182, 46498815, CAST(N'2026-06-08T18:27:37.993' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5183, 46498815, CAST(N'2026-06-08T18:38:03.157' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5184, 46498815, CAST(N'2026-06-08T19:09:03.407' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5185, 46498815, CAST(N'2026-06-08T19:10:22.860' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5186, 46498815, CAST(N'2026-06-08T19:22:32.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5187, 46498815, CAST(N'2026-06-08T19:25:15.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5188, 46498815, CAST(N'2026-06-08T19:26:40.437' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5189, 46498815, CAST(N'2026-06-08T19:34:04.730' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5190, 46498815, CAST(N'2026-06-08T19:40:50.907' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5191, 46498815, CAST(N'2026-06-08T19:48:00.480' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5192, 46498815, CAST(N'2026-06-08T19:48:57.400' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5193, 46498815, CAST(N'2026-06-08T20:02:01.493' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5194, 46498815, CAST(N'2026-06-08T20:07:53.870' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5195, 46498815, CAST(N'2026-06-08T20:18:45.013' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5196, 46498815, CAST(N'2026-06-08T20:36:08.810' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5197, 46498815, CAST(N'2026-06-08T20:39:32.510' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5198, 46498815, CAST(N'2026-06-08T20:42:41.790' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5199, 46498815, CAST(N'2026-06-08T20:51:01.290' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5200, 46498815, CAST(N'2026-06-08T20:58:02.617' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5201, 46498815, CAST(N'2026-06-08T21:02:23.793' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5202, 46498815, CAST(N'2026-06-08T21:07:49.987' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5203, 46498815, CAST(N'2026-06-08T21:09:41.413' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5204, 46498815, CAST(N'2026-06-08T21:10:29.777' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5205, 46498815, CAST(N'2026-06-08T21:13:32.450' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (5206, 46498815, CAST(N'2026-06-08T21:18:57.240' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6196, 46498815, CAST(N'2026-06-09T16:13:07.830' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6197, 46498815, CAST(N'2026-06-09T16:18:23.263' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6198, 46498815, CAST(N'2026-06-09T16:39:46.300' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6199, 46498815, CAST(N'2026-06-09T16:50:43.330' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6200, 46498815, CAST(N'2026-06-09T16:57:31.067' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6201, 46498815, CAST(N'2026-06-09T17:00:37.250' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6202, 46498815, CAST(N'2026-06-09T17:09:43.867' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6203, 46498815, CAST(N'2026-06-09T17:15:58.303' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6204, 46498815, CAST(N'2026-06-09T17:26:00.843' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6205, 46498815, CAST(N'2026-06-09T21:18:09.333' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6206, 46498815, CAST(N'2026-06-09T21:26:35.867' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6207, 46498815, CAST(N'2026-06-09T21:27:01.107' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6208, 46498815, CAST(N'2026-06-09T21:27:15.600' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6209, 46498815, CAST(N'2026-06-09T21:30:07.753' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6210, 46498815, CAST(N'2026-06-09T21:33:08.623' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6211, 46498815, CAST(N'2026-06-09T21:35:22.120' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6212, 46498815, CAST(N'2026-06-09T21:37:20.477' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6213, 46498815, CAST(N'2026-06-09T21:37:34.803' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6214, 46498815, CAST(N'2026-06-09T21:52:48.790' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6215, 46498815, CAST(N'2026-06-09T21:57:50.690' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6216, 46498815, CAST(N'2026-06-09T22:08:44.857' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6217, 46498815, CAST(N'2026-06-09T22:09:51.643' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6218, 46498815, CAST(N'2026-06-09T22:34:17.237' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6219, 46498815, CAST(N'2026-06-09T22:49:02.177' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6220, 46498815, CAST(N'2026-06-09T22:50:24.970' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6221, 46498815, CAST(N'2026-06-09T23:03:53.130' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6222, 46498815, CAST(N'2026-06-09T23:06:43.823' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6223, 46498815, CAST(N'2026-06-09T23:28:05.447' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6224, 46498815, CAST(N'2026-06-15T16:11:47.453' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6225, 46498815, CAST(N'2026-06-15T17:39:04.383' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6226, 46498815, CAST(N'2026-06-15T17:39:10.263' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6227, 46498815, CAST(N'2026-06-15T17:42:54.187' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6228, 46498815, CAST(N'2026-06-15T18:55:28.090' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6229, 46498815, CAST(N'2026-06-15T18:57:43.807' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6230, 46498815, CAST(N'2026-06-15T19:20:37.710' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6231, 46498815, CAST(N'2026-06-15T19:42:40.687' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6232, 46498815, CAST(N'2026-06-15T19:55:53.333' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6233, 46498815, CAST(N'2026-06-15T19:56:46.760' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6234, 46498814, CAST(N'2026-06-15T19:57:11.110' AS DateTime), N'Usuario', N'Login', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6235, 46498814, CAST(N'2026-06-15T20:07:11.840' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6236, 46498814, CAST(N'2026-06-15T20:09:08.047' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6237, 46498814, CAST(N'2026-06-15T20:11:20.130' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6238, 46498815, CAST(N'2026-06-15T20:11:51.400' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6239, 46498815, CAST(N'2026-06-15T20:12:56.210' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6240, 46498814, CAST(N'2026-06-15T20:13:09.850' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6241, 46498814, CAST(N'2026-06-15T20:20:35.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (6242, 46498814, CAST(N'2026-06-15T20:20:50.757' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7225, 46498815, CAST(N'2026-06-16T14:56:08.817' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7226, 46498815, CAST(N'2026-06-16T15:00:09.663' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7227, 46498815, CAST(N'2026-06-16T15:56:54.400' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7228, 46498815, CAST(N'2026-06-16T16:03:54.180' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7229, 46498815, CAST(N'2026-06-16T16:14:03.377' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7230, 46498815, CAST(N'2026-06-16T16:44:52.400' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7231, 46498815, CAST(N'2026-06-16T16:59:59.217' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7232, 46498815, CAST(N'2026-06-16T17:00:11.143' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7233, 46498815, CAST(N'2026-06-16T17:05:49.287' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7234, 46498815, CAST(N'2026-06-16T17:06:12.617' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7235, 46498815, CAST(N'2026-06-16T17:10:48.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7236, 46498815, CAST(N'2026-06-16T17:11:02.413' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7237, 46498815, CAST(N'2026-06-16T17:11:41.377' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7238, 46498815, CAST(N'2026-06-16T17:11:51.213' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7239, 46498815, CAST(N'2026-06-16T17:18:27.657' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7240, 46498815, CAST(N'2026-06-16T17:18:39.030' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7241, 46498815, CAST(N'2026-06-16T17:25:14.750' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7242, 46498815, CAST(N'2026-06-16T17:25:25.550' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7243, 46498815, CAST(N'2026-06-16T17:34:22.137' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7244, 46498815, CAST(N'2026-06-16T17:34:34.200' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7245, 46498815, CAST(N'2026-06-16T18:08:02.593' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7246, 46498815, CAST(N'2026-06-16T18:10:16.317' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7247, 46498814, CAST(N'2026-06-16T18:11:00.057' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7248, 46498814, CAST(N'2026-06-16T18:11:10.420' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7249, 46498815, CAST(N'2026-06-20T18:56:03.630' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7250, 46498815, CAST(N'2026-06-20T19:19:15.200' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7251, 46498815, CAST(N'2026-06-20T19:19:30.140' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7252, 46498815, CAST(N'2026-06-20T19:20:38.653' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7253, 46498815, CAST(N'2026-06-20T19:27:26.877' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7254, 46498815, CAST(N'2026-06-20T19:28:07.390' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7255, 46498815, CAST(N'2026-06-20T19:28:29.053' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7256, 46498815, CAST(N'2026-06-21T02:28:41.363' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7257, 46498815, CAST(N'2026-06-21T02:28:58.773' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7258, 46498815, CAST(N'2026-06-21T02:29:07.517' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7259, 46498815, CAST(N'2026-06-21T02:31:37.203' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7260, 46498815, CAST(N'2026-06-21T02:33:24.547' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7261, 46498815, CAST(N'2026-06-21T02:36:18.603' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7262, 46498815, CAST(N'2026-06-21T02:37:45.477' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7263, 46498815, CAST(N'2026-06-21T02:38:31.983' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7264, 46498815, CAST(N'2026-06-21T02:40:35.237' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7265, 46498815, CAST(N'2026-06-21T02:46:06.260' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7266, 46498815, CAST(N'2026-06-21T03:09:34.763' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7267, 46498815, CAST(N'2026-06-21T03:14:20.843' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7268, 46498815, CAST(N'2026-06-21T03:15:33.527' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7269, 46498815, CAST(N'2026-06-21T11:29:33.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7270, 46498815, CAST(N'2026-06-21T11:44:30.547' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7271, 46498815, CAST(N'2026-06-21T11:47:11.513' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7272, 46498815, CAST(N'2026-06-21T11:50:26.143' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7273, 46498815, CAST(N'2026-06-21T12:43:05.120' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7274, 46498815, CAST(N'2026-06-21T12:46:24.693' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7275, 46498815, CAST(N'2026-06-21T12:58:56.850' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7276, 46498815, CAST(N'2026-06-21T13:01:19.347' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7277, 46498815, CAST(N'2026-06-21T13:17:50.597' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7278, 46498815, CAST(N'2026-06-21T13:23:46.113' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7279, 46498815, CAST(N'2026-06-21T13:30:30.450' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7280, 46498815, CAST(N'2026-06-21T13:31:22.067' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7281, 46498815, CAST(N'2026-06-21T13:33:02.540' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7282, 46498815, CAST(N'2026-06-21T13:33:49.827' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7283, 46498815, CAST(N'2026-06-21T13:37:41.663' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7284, 46498815, CAST(N'2026-06-21T14:18:51.303' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7285, 46498815, CAST(N'2026-06-21T14:27:32.870' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7286, 46498815, CAST(N'2026-06-21T14:29:35.110' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7287, 46498815, CAST(N'2026-06-21T14:43:36.527' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7288, 46498815, CAST(N'2026-06-21T14:50:26.287' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7289, 46498815, CAST(N'2026-06-21T14:53:50.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7290, 46498815, CAST(N'2026-06-21T15:03:48.753' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7291, 46498815, CAST(N'2026-06-21T15:09:47.940' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7292, 46498815, CAST(N'2026-06-21T15:19:33.430' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7293, 46498815, CAST(N'2026-06-21T15:26:55.760' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7294, 46498815, CAST(N'2026-06-21T15:28:15.460' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7295, 46498815, CAST(N'2026-06-21T15:35:11.163' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7296, 46498815, CAST(N'2026-06-21T15:40:39.640' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7297, 46498815, CAST(N'2026-06-21T15:44:07.283' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7298, 46498815, CAST(N'2026-06-21T15:45:23.043' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7299, 46498815, CAST(N'2026-06-21T15:56:17.237' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7300, 46498815, CAST(N'2026-06-21T16:46:36.160' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7301, 46498815, CAST(N'2026-06-21T16:48:59.327' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7302, 46498815, CAST(N'2026-06-21T17:08:30.693' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7303, 46498815, CAST(N'2026-06-21T17:21:23.490' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7304, 46498815, CAST(N'2026-06-21T17:40:07.817' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7305, 46498815, CAST(N'2026-06-21T17:40:15.343' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7306, 46498815, CAST(N'2026-06-21T17:40:50.437' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7307, 46498815, CAST(N'2026-06-21T17:52:42.853' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7308, 46498815, CAST(N'2026-06-21T17:53:24.330' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7309, 46498815, CAST(N'2026-06-21T17:53:32.033' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7310, 46498815, CAST(N'2026-06-21T17:53:38.237' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (7311, 46498815, CAST(N'2026-06-21T17:53:59.390' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8300, 46498815, CAST(N'2026-06-22T16:27:51.630' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8301, 46498815, CAST(N'2026-06-22T16:39:48.483' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8302, 46498815, CAST(N'2026-06-22T16:47:11.280' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8303, 46498815, CAST(N'2026-06-22T16:49:08.710' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8304, 46498815, CAST(N'2026-06-22T16:51:18.660' AS DateTime), N'Usuario', N'Login', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8305, 46498815, CAST(N'2026-06-22T16:55:19.823' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8306, 46498815, CAST(N'2026-06-22T17:00:53.140' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8307, 46498815, CAST(N'2026-06-22T17:04:36.723' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8308, 46498815, CAST(N'2026-06-22T17:08:55.923' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8309, 46498815, CAST(N'2026-06-22T17:14:34.477' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8310, 46498815, CAST(N'2026-06-22T17:17:57.750' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8311, 46498815, CAST(N'2026-06-22T17:20:17.463' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8312, 46498815, CAST(N'2026-06-22T17:26:59.893' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8313, 46498815, CAST(N'2026-06-22T17:29:44.213' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8314, 46498815, CAST(N'2026-06-22T17:56:40.383' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8315, 46498815, CAST(N'2026-06-22T18:10:03.020' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (8316, 46498815, CAST(N'2026-06-22T18:15:45.410' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9315, 46498815, CAST(N'2026-06-23T00:12:07.433' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9316, 46498815, CAST(N'2026-06-23T00:19:47.573' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9317, 46498815, CAST(N'2026-06-23T00:26:31.273' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9318, 46498815, CAST(N'2026-06-23T00:31:48.097' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9319, 46498815, CAST(N'2026-06-23T00:36:56.110' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9320, 46498815, CAST(N'2026-06-23T00:46:05.777' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9321, 46498815, CAST(N'2026-06-23T00:57:17.117' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9322, 46498815, CAST(N'2026-06-23T01:05:57.880' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9323, 46498815, CAST(N'2026-06-23T01:11:54.507' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9324, 46498815, CAST(N'2026-06-23T01:33:33.990' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9325, 46498815, CAST(N'2026-06-23T01:33:49.997' AS DateTime), N'Perfiles', N'CrearRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9326, 46498815, CAST(N'2026-06-23T01:34:00.077' AS DateTime), N'Perfiles', N'ModificarRol', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9327, 46498815, CAST(N'2026-06-23T01:34:02.453' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9328, 46498815, CAST(N'2026-06-23T01:36:58.377' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9329, 46498815, CAST(N'2026-06-23T01:45:23.887' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9330, 46498815, CAST(N'2026-06-23T01:45:55.520' AS DateTime), N'Perfiles', N'CrearRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9331, 46498815, CAST(N'2026-06-23T01:46:20.753' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9332, 46498815, CAST(N'2026-06-23T01:46:28.323' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9333, 46498815, CAST(N'2026-06-23T01:51:53.190' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9334, 46498815, CAST(N'2026-06-23T01:52:47.487' AS DateTime), N'Perfiles', N'CrearRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9335, 46498815, CAST(N'2026-06-23T01:58:06.660' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9336, 46498815, CAST(N'2026-06-23T01:58:43.687' AS DateTime), N'Perfiles', N'CrearRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9337, 46498815, CAST(N'2026-06-23T01:58:45.277' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9338, 46498815, CAST(N'2026-06-23T02:12:35.613' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9339, 46498815, CAST(N'2026-06-23T02:19:09.160' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9340, 46498815, CAST(N'2026-06-23T02:29:45.263' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9341, 46498815, CAST(N'2026-06-23T02:37:25.750' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9342, 46498815, CAST(N'2026-06-23T02:40:31.527' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9343, 46498815, CAST(N'2026-06-23T02:49:12.960' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9344, 46498815, CAST(N'2026-06-23T02:57:15.393' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9345, 46498815, CAST(N'2026-06-23T03:04:07.190' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9346, 46498815, CAST(N'2026-06-23T03:06:22.453' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9347, 46498815, CAST(N'2026-06-23T03:10:02.837' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9348, 46498815, CAST(N'2026-06-23T03:16:31.653' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9349, 46498815, CAST(N'2026-06-23T14:00:55.903' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9350, 46498815, CAST(N'2026-06-23T14:02:03.777' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9351, 46498815, CAST(N'2026-06-23T14:07:02.870' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9352, 46498815, CAST(N'2026-06-23T14:13:02.580' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9353, 46498815, CAST(N'2026-06-23T14:13:19.687' AS DateTime), N'Perfiles', N'CrearRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9354, 46498815, CAST(N'2026-06-23T14:13:57.690' AS DateTime), N'Perfiles', N'EliminarRol', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9355, 46498815, CAST(N'2026-06-23T14:14:00.510' AS DateTime), N'Perfiles', N'EliminarRol', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9356, 46498815, CAST(N'2026-06-23T14:56:10.907' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9357, 46498815, CAST(N'2026-06-23T15:26:22.193' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9358, 46498815, CAST(N'2026-06-23T15:27:00.920' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9359, 46498815, CAST(N'2026-06-23T20:07:34.133' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9360, 46498815, CAST(N'2026-06-23T20:40:14.157' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9361, 46498815, CAST(N'2026-06-23T20:40:32.120' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9362, 46498815, CAST(N'2026-06-23T20:40:41.027' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9363, 46498815, CAST(N'2026-06-24T02:55:28.510' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9364, 46498815, CAST(N'2026-06-24T03:05:43.943' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9365, 46498815, CAST(N'2026-06-24T03:08:12.253' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9366, 46498815, CAST(N'2026-06-24T03:08:21.853' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9367, 46498815, CAST(N'2026-06-24T03:09:39.190' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9368, 46498815, CAST(N'2026-06-24T03:15:34.040' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9369, 46498815, CAST(N'2026-06-24T03:20:41.373' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9370, 46498815, CAST(N'2026-06-24T03:27:51.303' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9371, 46498815, CAST(N'2026-06-24T03:37:28.047' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9372, 46498815, CAST(N'2026-06-24T03:44:19.830' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9373, 46498815, CAST(N'2026-06-24T03:50:00.080' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9374, 46498815, CAST(N'2026-06-24T04:02:52.397' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9375, 46498815, CAST(N'2026-06-24T04:04:57.433' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9376, 46498815, CAST(N'2026-06-24T04:11:37.263' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9377, 46498815, CAST(N'2026-06-24T04:12:07.087' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9378, 46498815, CAST(N'2026-06-24T04:12:14.260' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9379, 46498815, CAST(N'2026-06-24T04:15:00.050' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9380, 46498815, CAST(N'2026-06-24T04:15:14.847' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9381, 46498815, CAST(N'2026-06-24T04:15:24.620' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9382, 46498815, CAST(N'2026-06-24T04:18:17.057' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9383, 46498815, CAST(N'2026-06-24T04:20:08.347' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9384, 46498815, CAST(N'2026-06-24T04:20:22.863' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9385, 46498815, CAST(N'2026-06-24T04:20:52.180' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9386, 46498815, CAST(N'2026-06-24T04:20:58.610' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9387, 46498815, CAST(N'2026-06-24T04:25:12.237' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9388, 46498815, CAST(N'2026-06-24T04:25:45.867' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9389, 46498815, CAST(N'2026-06-24T04:31:00.377' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9390, 46498815, CAST(N'2026-06-24T04:31:22.093' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9391, 46498815, CAST(N'2026-06-24T04:32:07.877' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9392, 46498815, CAST(N'2026-06-24T04:32:14.887' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9393, 46498815, CAST(N'2026-06-24T04:37:40.513' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9394, 46498815, CAST(N'2026-06-24T04:38:29.900' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9395, 46498815, CAST(N'2026-06-24T04:44:34.930' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9396, 46498815, CAST(N'2026-06-24T04:44:48.830' AS DateTime), N'Perfiles', N'CrearRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9397, 46498815, CAST(N'2026-06-24T04:44:59.920' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9398, 46498815, CAST(N'2026-06-24T04:45:03.480' AS DateTime), N'Perfiles', N'EliminarRol', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9399, 46498815, CAST(N'2026-06-24T05:04:22.127' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9400, 46498815, CAST(N'2026-06-24T05:04:41.577' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9401, 46498815, CAST(N'2026-06-24T05:04:42.263' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9402, 46498815, CAST(N'2026-06-24T05:04:51.640' AS DateTime), N'Usuario', N'Logout', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9403, 46498815, CAST(N'2026-06-24T05:05:00.503' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9404, 46498815, CAST(N'2026-06-24T05:13:56.267' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9405, 46498815, CAST(N'2026-06-24T05:20:56.080' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9406, 46498815, CAST(N'2026-06-24T05:21:06.780' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9407, 46498815, CAST(N'2026-06-24T05:21:52.210' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9408, 46498815, CAST(N'2026-06-24T05:26:37.913' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9409, 46498815, CAST(N'2026-06-24T05:26:53.283' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9410, 46498815, CAST(N'2026-06-24T05:35:43.430' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9411, 46498815, CAST(N'2026-06-24T05:36:01.090' AS DateTime), N'Perfiles', N'AsignarFamilia', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9412, 46498815, CAST(N'2026-06-24T05:41:34.673' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9413, 46498815, CAST(N'2026-06-24T05:43:18.810' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9414, 46498815, CAST(N'2026-06-24T05:46:21.903' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9415, 46498815, CAST(N'2026-06-24T05:49:42.597' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9416, 46498815, CAST(N'2026-07-06T23:51:10.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9417, 46498815, CAST(N'2026-07-07T01:09:46.810' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9418, 46498815, CAST(N'2026-07-07T01:21:36.460' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9419, 46498815, CAST(N'2026-07-07T01:23:46.693' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9420, 46498815, CAST(N'2026-07-07T01:43:07.720' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9421, 46498815, CAST(N'2026-07-07T01:49:43.863' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9422, 46498815, CAST(N'2026-07-07T01:49:45.693' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9423, 46498815, CAST(N'2026-07-07T01:49:47.920' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9424, 46498815, CAST(N'2026-07-07T01:51:07.250' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9425, 46498815, CAST(N'2026-07-07T01:51:07.933' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9426, 46498815, CAST(N'2026-07-07T01:51:09.940' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9427, 46498815, CAST(N'2026-07-07T01:51:29.300' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9428, 46498815, CAST(N'2026-07-07T02:04:11.027' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9429, 46498815, CAST(N'2026-07-07T02:04:22.327' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9430, 46498815, CAST(N'2026-07-07T02:04:36.370' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9431, 46498814, CAST(N'2026-07-07T02:05:30.527' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9432, 46498814, CAST(N'2026-07-07T02:05:51.553' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9433, 46498814, CAST(N'2026-07-07T02:06:13.540' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9434, 46498814, CAST(N'2026-07-07T02:06:32.317' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9435, 46498815, CAST(N'2026-07-07T02:06:40.430' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9436, 46498815, CAST(N'2026-07-07T02:07:42.907' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9437, 46498815, CAST(N'2026-07-07T02:07:51.960' AS DateTime), N'Perfiles', N'EliminarRol', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9438, 46498815, CAST(N'2026-07-07T02:07:58.100' AS DateTime), N'Perfiles', N'EliminarRol', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9439, 46498815, CAST(N'2026-07-07T02:09:00.360' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9440, 46498814, CAST(N'2026-07-07T02:09:22.173' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9441, 46498814, CAST(N'2026-07-07T02:12:06.980' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9442, 46498815, CAST(N'2026-07-07T02:12:14.957' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9443, 46498814, CAST(N'2026-07-07T02:19:36.977' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9444, 46498814, CAST(N'2026-07-07T02:21:27.640' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9445, 46498814, CAST(N'2026-07-07T02:21:39.867' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9446, 46498814, CAST(N'2026-07-07T02:24:47.113' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9447, 46498815, CAST(N'2026-07-07T02:24:55.620' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9448, 46498815, CAST(N'2026-07-07T02:25:13.830' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9449, 46498815, CAST(N'2026-07-07T02:25:16.067' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9450, 46498815, CAST(N'2026-07-07T02:25:22.497' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9451, 46498815, CAST(N'2026-07-07T02:25:32.077' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9452, 46498815, CAST(N'2026-07-07T02:26:32.080' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9453, 46498815, CAST(N'2026-07-07T02:26:41.797' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9454, 46498815, CAST(N'2026-07-07T02:27:01.413' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9455, 46498815, CAST(N'2026-07-07T02:27:07.980' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9456, 46498815, CAST(N'2026-07-07T02:27:27.900' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9457, 46498815, CAST(N'2026-07-07T02:27:45.030' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9458, 46498815, CAST(N'2026-07-07T02:28:01.473' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9459, 46498815, CAST(N'2026-07-07T02:28:30.403' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9460, 46498815, CAST(N'2026-07-07T02:28:48.830' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9461, 46498815, CAST(N'2026-07-07T15:30:35.277' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9462, 46498815, CAST(N'2026-07-07T15:30:41.190' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9463, 46498815, CAST(N'2026-07-07T15:31:45.707' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9464, 46498815, CAST(N'2026-07-07T15:31:55.503' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9465, 46498814, CAST(N'2026-07-07T15:40:24.183' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9466, 46498814, CAST(N'2026-07-07T15:40:29.250' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9467, 46498814, CAST(N'2026-07-07T15:41:09.290' AS DateTime), N'Usuario', N'Bloqueo', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9468, 46498815, CAST(N'2026-07-07T15:41:29.223' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9469, 46498815, CAST(N'2026-07-07T15:41:35.483' AS DateTime), N'Usuario', N'Desbloqueo', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9470, 46498815, CAST(N'2026-07-07T16:03:39.633' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9471, 46498815, CAST(N'2026-07-07T16:15:50.523' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9472, 46498815, CAST(N'2026-07-07T16:16:08.947' AS DateTime), N'Admin', N'Backup', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9473, 46498815, CAST(N'2026-09-12T17:55:56.863' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9474, 46498815, CAST(N'2026-09-12T20:13:39.360' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9475, 46498815, CAST(N'2026-09-12T21:08:05.207' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9476, 46498815, CAST(N'2026-09-12T21:12:33.660' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9477, 46498815, CAST(N'2026-09-12T22:49:17.110' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9478, 46498815, CAST(N'2026-09-12T23:21:06.233' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9479, 46498815, CAST(N'2026-09-14T17:56:05.023' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9480, 46498815, CAST(N'2026-09-14T17:58:40.710' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9481, 46498815, CAST(N'2026-09-14T18:09:22.453' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9482, 46498815, CAST(N'2026-09-14T18:26:26.080' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9483, 46498815, CAST(N'2026-09-14T19:12:36.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9484, 46498815, CAST(N'2026-09-14T19:21:04.233' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9485, 46498815, CAST(N'2026-09-14T19:30:11.277' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9486, 46498815, CAST(N'2026-09-14T19:43:33.053' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9487, 46498815, CAST(N'2026-09-15T12:28:24.153' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9488, 46498815, CAST(N'2026-09-15T12:51:01.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9489, 46498815, CAST(N'2026-09-15T13:20:40.767' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9490, 46498815, CAST(N'2026-09-15T13:27:21.477' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9491, 46498815, CAST(N'2026-09-15T13:28:19.947' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9492, 46498815, CAST(N'2026-09-15T17:39:39.847' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9493, 46498815, CAST(N'2026-09-15T19:36:53.880' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9494, 46498815, CAST(N'2026-09-15T22:50:33.883' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9495, 46498815, CAST(N'2026-09-15T23:10:54.277' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9496, 46498815, CAST(N'2026-09-17T11:39:49.093' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9497, 46498815, CAST(N'2026-09-17T20:25:17.453' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9498, 46498815, CAST(N'2026-09-17T20:28:14.480' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9499, 46498815, CAST(N'2026-09-20T22:39:42.370' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9500, 46498815, CAST(N'2026-09-20T23:08:33.323' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9501, 46498815, CAST(N'2026-09-21T12:50:36.117' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9502, 46498815, CAST(N'2026-09-26T18:48:06.587' AS DateTime), N'Usuario', N'Login', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9503, 46498815, CAST(N'2026-09-26T18:53:38.857' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9504, 46498815, CAST(N'2026-09-26T20:08:16.243' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9505, 46498815, CAST(N'2026-09-28T14:38:10.950' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9506, 46498815, CAST(N'2026-09-28T14:38:28.017' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9507, 46498815, CAST(N'2026-09-28T19:34:49.440' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9508, 46498815, CAST(N'2026-09-28T19:36:27.320' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9509, 46498815, CAST(N'2026-09-28T19:36:55.283' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9510, 46498815, CAST(N'2026-09-28T19:36:56.263' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9511, 46498815, CAST(N'2026-09-28T19:36:57.763' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9512, 46498815, CAST(N'2026-09-28T19:36:58.507' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9513, 46498815, CAST(N'2026-09-28T19:48:19.803' AS DateTime), N'Maestro', N'Desactivar', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9514, 46498815, CAST(N'2026-09-28T19:48:49.390' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9515, 46498815, CAST(N'2026-09-28T19:51:07.663' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9516, 46498815, CAST(N'2026-09-28T19:51:14.863' AS DateTime), N'Maestro', N'Desactivar', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9517, 46498815, CAST(N'2026-09-28T19:51:28.053' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9518, 46498815, CAST(N'2026-09-28T19:59:23.437' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9519, 46498815, CAST(N'2026-09-28T20:09:58.670' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9520, 46498815, CAST(N'2026-09-28T20:24:02.673' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9521, 46498815, CAST(N'2026-09-28T20:24:42.427' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9522, 46498815, CAST(N'2026-09-28T20:43:02.483' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9523, 46498815, CAST(N'2026-09-28T21:07:40.263' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9524, 46498815, CAST(N'2026-09-28T21:27:25.430' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9525, 46498815, CAST(N'2026-09-28T21:43:39.670' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9526, 46498815, CAST(N'2026-09-28T23:03:16.853' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9527, 46498815, CAST(N'2026-09-28T23:05:59.140' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9528, 46498815, CAST(N'2026-09-28T23:13:29.830' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9529, 46498815, CAST(N'2026-09-29T15:35:05.083' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9530, 46498815, CAST(N'2026-09-29T15:55:17.917' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9531, 46498815, CAST(N'2026-09-29T15:56:39.377' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9532, 46498815, CAST(N'2026-09-29T16:14:13.540' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9533, 46498815, CAST(N'2026-09-29T16:32:52.873' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9534, 46498815, CAST(N'2026-09-29T16:44:58.373' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9535, 46498815, CAST(N'2026-09-29T16:51:17.383' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9536, 46498815, CAST(N'2026-09-29T16:51:27.187' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9537, 46498815, CAST(N'2026-09-29T16:51:37.187' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9538, 46498815, CAST(N'2026-09-29T16:55:41.317' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9539, 46498815, CAST(N'2026-09-29T18:15:29.230' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9540, 46498815, CAST(N'2026-09-29T19:56:34.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9541, 46498815, CAST(N'2026-09-29T20:20:21.483' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9542, 46498815, CAST(N'2026-09-29T20:33:28.220' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9543, 46498815, CAST(N'2026-09-29T20:33:37.767' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9544, 46498815, CAST(N'2026-09-29T20:33:58.817' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9545, 46498815, CAST(N'2026-09-29T20:34:07.753' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9546, 46498815, CAST(N'2026-09-29T21:03:15.327' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9547, 46498815, CAST(N'2026-09-29T21:57:17.367' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9548, 46498815, CAST(N'2026-09-29T22:18:01.037' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9549, 46498815, CAST(N'2026-09-29T22:18:49.683' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9550, 46498815, CAST(N'2026-09-29T22:19:00.413' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9551, 46498815, CAST(N'2026-09-29T22:48:34.940' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9552, 46498815, CAST(N'2026-09-29T22:49:19.680' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9553, 46498815, CAST(N'2026-09-29T22:50:05.527' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9554, 46498815, CAST(N'2026-09-29T22:59:44.157' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9555, 46498815, CAST(N'2026-09-29T23:32:31.803' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9556, 46498815, CAST(N'2026-09-30T02:36:44.583' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9557, 46498815, CAST(N'2026-09-30T02:36:54.190' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9558, 46498815, CAST(N'2026-09-30T02:38:23.070' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9559, 46498815, CAST(N'2026-09-30T02:38:57.660' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9560, 46498814, CAST(N'2026-09-30T02:39:59.547' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9561, 46498814, CAST(N'2026-09-30T02:40:39.373' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9562, 46498814, CAST(N'2026-09-30T02:40:50.560' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9563, 46498814, CAST(N'2026-09-30T02:41:03.980' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9564, 46498815, CAST(N'2026-09-30T02:41:18.957' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9565, 46498815, CAST(N'2026-09-30T02:41:56.557' AS DateTime), N'Perfiles', N'AsignarRol', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9566, 46498815, CAST(N'2026-09-30T02:42:03.400' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9567, 46498814, CAST(N'2026-09-30T02:42:14.590' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9568, 46498815, CAST(N'2026-09-30T05:15:57.673' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9569, 46498815, CAST(N'2026-10-08T13:38:58.080' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9570, 46498815, CAST(N'2026-10-08T13:39:16.573' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9571, 46498815, CAST(N'2026-10-08T13:42:20.663' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9572, 46498815, CAST(N'2026-10-08T13:43:04.590' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9573, 46498815, CAST(N'2026-10-08T13:43:24.990' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9574, 46498815, CAST(N'2026-10-08T13:43:27.363' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9575, 46498815, CAST(N'2026-10-08T13:43:29.360' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9576, 46498815, CAST(N'2026-10-08T13:43:31.400' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9577, 46498815, CAST(N'2026-10-08T13:43:32.993' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9578, 46498815, CAST(N'2026-10-20T22:15:09.077' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9579, 46498815, CAST(N'2026-10-20T22:15:56.437' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9580, 46498815, CAST(N'2026-10-20T23:28:06.967' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9581, 46498815, CAST(N'2026-10-20T23:28:20.083' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9582, 46498815, CAST(N'2026-10-20T23:29:01.860' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9583, 46498815, CAST(N'2026-10-27T16:06:50.867' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9584, 46498815, CAST(N'2026-10-27T16:07:07.307' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9585, 46498815, CAST(N'2026-10-27T16:19:29.660' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9586, 46498815, CAST(N'2026-10-27T16:19:45.957' AS DateTime), N'Maestro', N'modificar', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9587, 46498815, CAST(N'2026-10-27T16:31:01.580' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9588, 46498815, CAST(N'2026-10-27T16:31:19.963' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9589, 46498815, CAST(N'2026-10-27T16:35:24.790' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9590, 46498815, CAST(N'2026-10-27T16:50:41.010' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9591, 46498815, CAST(N'2026-10-27T16:51:22.450' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9592, 46498815, CAST(N'2026-10-27T16:58:53.270' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9593, 46498815, CAST(N'2026-10-27T17:25:23.143' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9594, 46498815, CAST(N'2026-10-27T17:25:39.353' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9595, 46498815, CAST(N'2026-10-28T00:03:58.317' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9596, 46498815, CAST(N'2026-10-28T00:16:18.327' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9597, 46498815, CAST(N'2026-11-03T17:43:48.293' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9598, 46498815, CAST(N'2026-11-03T18:32:56.663' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9599, 46498815, CAST(N'2026-11-03T18:35:57.723' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9600, 46498815, CAST(N'2026-11-03T18:36:24.143' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9601, 46498815, CAST(N'2026-11-03T18:37:51.977' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9602, 46498815, CAST(N'2026-11-03T18:38:40.860' AS DateTime), N'Ventas', N'Ingreso', 1)
GO
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9603, 46498815, CAST(N'2026-11-03T18:38:41.677' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9604, 46498815, CAST(N'2026-11-03T18:38:42.397' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9605, 46498815, CAST(N'2026-11-03T18:38:43.113' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9606, 46498815, CAST(N'2026-11-03T18:38:43.750' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9607, 46498815, CAST(N'2026-11-03T18:38:44.400' AS DateTime), N'Ventas', N'Ingreso', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9608, 46498815, CAST(N'2026-11-03T23:39:12.917' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9609, 46498815, CAST(N'2026-11-03T23:40:48.583' AS DateTime), N'Ventas', N'Cobro', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9610, 46498815, CAST(N'2026-11-03T23:41:42.260' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9611, 46498815, CAST(N'2026-11-04T01:21:59.310' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9612, 46498815, CAST(N'2026-11-04T02:11:25.157' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9613, 46498815, CAST(N'2026-11-04T02:12:13.847' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9614, 46498815, CAST(N'2026-11-04T02:16:36.390' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9615, 46498815, CAST(N'2026-11-04T02:20:56.730' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9616, 46498815, CAST(N'2026-11-04T02:58:13.233' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9617, 46498815, CAST(N'2026-11-04T05:15:28.003' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9618, 46498815, CAST(N'2026-11-04T05:48:21.557' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9619, 46498815, CAST(N'2026-11-04T05:52:34.967' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9620, 46498815, CAST(N'2026-11-04T05:55:28.850' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9621, 46498815, CAST(N'2026-11-04T05:56:01.857' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9622, 46498815, CAST(N'2026-11-04T05:56:40.013' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9623, 46498815, CAST(N'2026-11-04T05:58:56.390' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9624, 46498815, CAST(N'2026-11-04T05:59:13.250' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9625, 46498815, CAST(N'2026-11-04T05:59:15.597' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9626, 46498815, CAST(N'2026-11-04T06:01:19.047' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9627, 46498815, CAST(N'2026-11-04T06:03:22.657' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9628, 46498815, CAST(N'2026-11-15T14:42:05.787' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9629, 46498815, CAST(N'2026-11-15T15:37:09.397' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9630, 46498815, CAST(N'2026-11-16T16:56:37.627' AS DateTime), N'Admin', N'RecalcularDV', 3)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9631, 46498815, CAST(N'2026-11-16T16:56:50.650' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9632, 46498815, CAST(N'2026-11-16T16:58:18.070' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9633, 46498815, CAST(N'2026-11-16T16:58:35.373' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9634, 46498815, CAST(N'2026-11-16T16:58:47.307' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9635, 46498815, CAST(N'2026-11-16T16:58:49.503' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9636, 46498815, CAST(N'2026-11-16T17:00:23.590' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9637, 46498815, CAST(N'2026-11-16T17:13:41.543' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9638, 46498815, CAST(N'2026-11-16T17:15:41.827' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9639, 46498815, CAST(N'2026-11-16T18:05:27.627' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9640, 46498815, CAST(N'2026-11-16T18:11:24.617' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9641, 46498815, CAST(N'2026-11-16T18:27:33.317' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9642, 46498815, CAST(N'2026-11-16T19:05:49.130' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9643, 46498815, CAST(N'2026-11-16T19:05:51.323' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9644, 46498815, CAST(N'2026-11-16T19:05:52.777' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9645, 46498815, CAST(N'2026-11-16T19:05:54.620' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9646, 46498815, CAST(N'2026-11-16T19:06:13.973' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9647, 46498815, CAST(N'2026-11-16T19:08:21.833' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9648, 46498815, CAST(N'2026-11-16T19:08:27.680' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9649, 46498815, CAST(N'2026-11-16T19:08:59.490' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9650, 46498815, CAST(N'2026-11-16T19:09:05.680' AS DateTime), N'Compras', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9651, 46498815, CAST(N'2026-11-16T19:09:21.703' AS DateTime), N'Compras', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9652, 46498815, CAST(N'2026-11-17T14:39:55.763' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9653, 46498815, CAST(N'2026-11-17T14:47:55.027' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9654, 46498815, CAST(N'2026-11-17T17:24:04.417' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9655, 46498815, CAST(N'2026-11-17T17:32:11.353' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9656, 46498815, CAST(N'2026-11-17T17:41:51.387' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9657, 46498815, CAST(N'2026-11-17T17:42:19.880' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9658, 46498815, CAST(N'2026-11-17T17:51:26.503' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9659, 46498815, CAST(N'2026-11-17T18:33:28.567' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9660, 46498815, CAST(N'2026-11-17T18:34:58.873' AS DateTime), N'Maestro', N'modificar', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9661, 46498815, CAST(N'2026-11-17T18:45:31.177' AS DateTime), N'Maestro', N'Crear', 2)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9662, 46498815, CAST(N'2026-11-17T19:51:16.553' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9663, 46498815, CAST(N'2026-11-17T19:52:46.353' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9664, 46498814, CAST(N'2026-11-17T19:53:05.250' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9665, 46498815, CAST(N'2026-11-17T20:00:42.777' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9666, 46498815, CAST(N'2026-11-17T20:00:55.203' AS DateTime), N'Usuario', N'Logout', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9667, 46498814, CAST(N'2026-11-17T20:01:03.850' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9668, 46498815, CAST(N'2026-11-17T20:20:56.520' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9669, 46498815, CAST(N'2026-11-17T21:27:00.340' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (9670, 46498815, CAST(N'2026-11-18T01:27:40.397' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (10670, 46498815, CAST(N'2026-11-18T03:28:23.197' AS DateTime), N'Usuario', N'Login', 1)
INSERT [dbo].[Bitacora_43BO] ([IdEvento_43BO], [DNIuser_43BO], [Fecha_43BO], [Modulo_43BO], [Evento_43BO], [Criticidad_43BO]) VALUES (10671, 46498815, CAST(N'2026-11-18T04:49:13.053' AS DateTime), N'Usuario', N'Login', 1)
SET IDENTITY_INSERT [dbo].[Bitacora_43BO] OFF
GO
SET IDENTITY_INSERT [dbo].[Butaca_14OR] ON 

INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (2, 1, 1, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (3, 1, 1, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (4, 1, 1, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (5, 1, 1, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (6, 1, 1, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (7, 1, 1, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (8, 1, 1, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (9, 1, 2, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (10, 1, 2, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (11, 1, 2, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (12, 1, 2, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (13, 1, 2, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (14, 1, 2, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (15, 1, 2, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (16, 1, 2, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (17, 1, 3, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (18, 1, 3, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (19, 1, 3, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (20, 1, 3, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (21, 1, 3, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (22, 1, 3, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (23, 1, 3, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (24, 1, 3, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (25, 1, 4, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (26, 1, 4, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (27, 1, 4, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (28, 1, 4, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (29, 1, 4, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (30, 1, 4, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (31, 1, 4, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (32, 1, 4, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (33, 1, 5, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (34, 1, 5, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (35, 1, 5, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (36, 1, 5, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (37, 1, 5, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (38, 1, 5, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (39, 1, 5, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (40, 1, 5, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (41, 1, 6, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (42, 1, 6, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (43, 1, 6, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (44, 1, 6, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (45, 1, 6, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (46, 1, 6, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (47, 1, 6, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (48, 1, 6, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (49, 1, 7, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (50, 1, 7, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (51, 1, 7, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (52, 1, 7, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (53, 1, 7, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (54, 1, 7, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (55, 1, 7, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (56, 1, 7, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (57, 1, 8, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (58, 1, 8, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (59, 1, 8, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (60, 1, 8, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (61, 1, 8, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (62, 1, 8, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (63, 1, 8, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (64, 1, 8, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (65, 1, 9, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (66, 1, 9, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (67, 1, 9, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (68, 1, 9, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (69, 1, 9, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (70, 1, 9, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (71, 1, 9, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (72, 1, 9, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (73, 1, 10, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (74, 1, 10, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (75, 1, 10, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (76, 1, 10, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (77, 1, 10, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (78, 1, 10, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (79, 1, 10, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (80, 1, 10, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (81, 2, 1, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (82, 2, 1, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (83, 2, 1, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (84, 2, 1, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (85, 2, 1, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (86, 2, 1, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (87, 2, 1, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (88, 2, 1, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (89, 2, 1, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (90, 2, 1, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (91, 2, 1, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (92, 2, 1, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (93, 2, 2, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (94, 2, 2, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (95, 2, 2, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (96, 2, 2, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (97, 2, 2, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (98, 2, 2, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (99, 2, 2, 7)
GO
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (100, 2, 2, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (101, 2, 2, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (102, 2, 2, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (103, 2, 2, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (104, 2, 2, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (105, 2, 3, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (106, 2, 3, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (107, 2, 3, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (108, 2, 3, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (109, 2, 3, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (110, 2, 3, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (111, 2, 3, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (112, 2, 3, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (113, 2, 3, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (114, 2, 3, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (115, 2, 3, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (116, 2, 3, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (117, 2, 4, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (118, 2, 4, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (119, 2, 4, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (120, 2, 4, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (121, 2, 4, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (122, 2, 4, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (123, 2, 4, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (124, 2, 4, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (125, 2, 4, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (126, 2, 4, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (127, 2, 4, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (128, 2, 4, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (129, 2, 5, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (130, 2, 5, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (131, 2, 5, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (132, 2, 5, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (133, 2, 5, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (134, 2, 5, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (135, 2, 5, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (136, 2, 5, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (137, 2, 5, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (138, 2, 5, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (139, 2, 5, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (140, 2, 5, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (141, 2, 6, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (142, 2, 6, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (143, 2, 6, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (144, 2, 6, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (145, 2, 6, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (146, 2, 6, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (147, 2, 6, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (148, 2, 6, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (149, 2, 6, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (150, 2, 6, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (151, 2, 6, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (152, 2, 6, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (153, 2, 7, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (154, 2, 7, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (155, 2, 7, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (156, 2, 7, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (157, 2, 7, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (158, 2, 7, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (159, 2, 7, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (160, 2, 7, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (161, 2, 7, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (162, 2, 7, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (163, 2, 7, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (164, 2, 7, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (165, 2, 8, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (166, 2, 8, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (167, 2, 8, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (168, 2, 8, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (169, 2, 8, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (170, 2, 8, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (171, 2, 8, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (172, 2, 8, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (173, 2, 8, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (174, 2, 8, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (175, 2, 8, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (176, 2, 8, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (177, 2, 9, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (178, 2, 9, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (179, 2, 9, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (180, 2, 9, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (181, 2, 9, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (182, 2, 9, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (183, 2, 9, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (184, 2, 9, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (185, 2, 9, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (186, 2, 9, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (187, 2, 9, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (188, 2, 9, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (189, 2, 10, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (190, 2, 10, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (191, 2, 10, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (192, 2, 10, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (193, 2, 10, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (194, 2, 10, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (195, 2, 10, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (196, 2, 10, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (197, 2, 10, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (198, 2, 10, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (199, 2, 10, 11)
GO
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (200, 2, 10, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (411, 3, 1, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (412, 3, 1, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (413, 3, 1, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (414, 3, 1, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (415, 3, 1, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (416, 3, 1, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (417, 3, 1, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (418, 3, 1, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (419, 3, 1, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (420, 3, 1, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (421, 3, 1, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (422, 3, 1, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (423, 3, 1, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (424, 3, 1, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (425, 3, 1, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (426, 3, 1, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (427, 3, 1, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (428, 3, 1, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (429, 3, 1, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (430, 3, 1, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (431, 3, 1, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (432, 3, 2, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (433, 3, 2, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (434, 3, 2, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (435, 3, 2, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (436, 3, 2, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (437, 3, 2, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (438, 3, 2, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (439, 3, 2, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (440, 3, 2, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (441, 3, 2, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (442, 3, 2, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (443, 3, 2, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (444, 3, 2, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (445, 3, 2, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (446, 3, 2, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (447, 3, 2, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (448, 3, 2, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (449, 3, 2, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (450, 3, 2, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (451, 3, 2, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (452, 3, 2, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (453, 3, 3, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (454, 3, 3, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (455, 3, 3, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (456, 3, 3, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (457, 3, 3, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (458, 3, 3, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (459, 3, 3, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (460, 3, 3, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (461, 3, 3, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (462, 3, 3, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (463, 3, 3, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (464, 3, 3, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (465, 3, 3, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (466, 3, 3, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (467, 3, 3, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (468, 3, 3, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (469, 3, 3, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (470, 3, 3, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (471, 3, 3, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (472, 3, 3, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (473, 3, 3, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (474, 3, 4, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (475, 3, 4, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (476, 3, 4, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (477, 3, 4, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (478, 3, 4, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (479, 3, 4, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (480, 3, 4, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (481, 3, 4, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (482, 3, 4, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (483, 3, 4, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (484, 3, 4, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (485, 3, 4, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (486, 3, 4, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (487, 3, 4, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (488, 3, 4, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (489, 3, 4, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (490, 3, 4, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (491, 3, 4, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (492, 3, 4, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (493, 3, 4, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (494, 3, 4, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (495, 3, 5, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (496, 3, 5, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (497, 3, 5, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (498, 3, 5, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (499, 3, 5, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (500, 3, 5, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (501, 3, 5, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (502, 3, 5, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (503, 3, 5, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (504, 3, 5, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (505, 3, 5, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (506, 3, 5, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (507, 3, 5, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (508, 3, 5, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (509, 3, 5, 15)
GO
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (510, 3, 5, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (511, 3, 5, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (512, 3, 5, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (513, 3, 5, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (514, 3, 5, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (515, 3, 5, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (516, 3, 6, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (517, 3, 6, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (518, 3, 6, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (519, 3, 6, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (520, 3, 6, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (521, 3, 6, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (522, 3, 6, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (523, 3, 6, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (524, 3, 6, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (525, 3, 6, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (526, 3, 6, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (527, 3, 6, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (528, 3, 6, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (529, 3, 6, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (530, 3, 6, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (531, 3, 6, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (532, 3, 6, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (533, 3, 6, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (534, 3, 6, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (535, 3, 6, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (536, 3, 6, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (537, 3, 7, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (538, 3, 7, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (539, 3, 7, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (540, 3, 7, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (541, 3, 7, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (542, 3, 7, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (543, 3, 7, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (544, 3, 7, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (545, 3, 7, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (546, 3, 7, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (547, 3, 7, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (548, 3, 7, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (549, 3, 7, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (550, 3, 7, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (551, 3, 7, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (552, 3, 7, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (553, 3, 7, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (554, 3, 7, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (555, 3, 7, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (556, 3, 7, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (557, 3, 7, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (558, 3, 8, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (559, 3, 8, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (560, 3, 8, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (561, 3, 8, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (562, 3, 8, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (563, 3, 8, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (564, 3, 8, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (565, 3, 8, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (566, 3, 8, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (567, 3, 8, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (568, 3, 8, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (569, 3, 8, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (570, 3, 8, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (571, 3, 8, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (572, 3, 8, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (573, 3, 8, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (574, 3, 8, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (575, 3, 8, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (576, 3, 8, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (577, 3, 8, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (578, 3, 8, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (579, 3, 9, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (580, 3, 9, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (581, 3, 9, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (582, 3, 9, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (583, 3, 9, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (584, 3, 9, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (585, 3, 9, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (586, 3, 9, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (587, 3, 9, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (588, 3, 9, 10)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (589, 3, 9, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (590, 3, 9, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (591, 3, 9, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (592, 3, 9, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (593, 3, 9, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (594, 3, 9, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (595, 3, 9, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (596, 3, 9, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (597, 3, 9, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (598, 3, 9, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (599, 3, 9, 21)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (600, 3, 10, 1)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (601, 3, 10, 2)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (602, 3, 10, 3)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (603, 3, 10, 4)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (604, 3, 10, 5)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (605, 3, 10, 6)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (606, 3, 10, 7)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (607, 3, 10, 8)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (608, 3, 10, 9)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (609, 3, 10, 10)
GO
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (610, 3, 10, 11)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (611, 3, 10, 12)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (612, 3, 10, 13)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (613, 3, 10, 14)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (614, 3, 10, 15)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (615, 3, 10, 16)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (616, 3, 10, 17)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (617, 3, 10, 18)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (618, 3, 10, 19)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (619, 3, 10, 20)
INSERT [dbo].[Butaca_14OR] ([IdButaca_14OR], [IdSala_14OR], [NumeroFila_14OR], [NumeroAsiento_14OR]) VALUES (620, 3, 10, 21)
SET IDENTITY_INSERT [dbo].[Butaca_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente_14OR] ON 

INSERT [dbo].[Cliente_14OR] ([IdCliente_14OR], [DNI_14OR], [Nombre_14OR], [Apellido_14OR], [Email_14OR], [Telefono_14OR], [Suscriptor_14OR], [Eliminado_14OR]) VALUES (1, 55789123, N'Esteban', N'hernandez', N'Esteby@gmail.com', N'1165582252', 1, 0)
INSERT [dbo].[Cliente_14OR] ([IdCliente_14OR], [DNI_14OR], [Nombre_14OR], [Apellido_14OR], [Email_14OR], [Telefono_14OR], [Suscriptor_14OR], [Eliminado_14OR]) VALUES (3, 22587741, N'Martin', N'Gutierrez', N'HSv+w6CB4zkeNWob+bs5Sw==', N'1122553366', 1, 0)
INSERT [dbo].[Cliente_14OR] ([IdCliente_14OR], [DNI_14OR], [Nombre_14OR], [Apellido_14OR], [Email_14OR], [Telefono_14OR], [Suscriptor_14OR], [Eliminado_14OR]) VALUES (4, 55846325, N'Jorge', N'Perez', N'+Th0WYMmWIwvSUwdFUUduHSQAyqxXoi5d1a5TIqdg3E=', N'1155223365', 1, 0)
SET IDENTITY_INSERT [dbo].[Cliente_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[DetalleOrdenCompra_14OR] ON 

INSERT [dbo].[DetalleOrdenCompra_14OR] ([IdDetalleOrdenCompra_14OR], [IdOrdenCompra_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCosto_14OR], [CantidadRecibida_14OR]) VALUES (1, 3, 4, N'Combo pochoclos + gaseosa', 6, CAST(2280.00 AS Decimal(18, 2)), 6)
INSERT [dbo].[DetalleOrdenCompra_14OR] ([IdDetalleOrdenCompra_14OR], [IdOrdenCompra_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCosto_14OR], [CantidadRecibida_14OR]) VALUES (2, 4, 4, N'Combo pochoclos + gaseosa', 15, CAST(2140.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[DetalleOrdenCompra_14OR] ([IdDetalleOrdenCompra_14OR], [IdOrdenCompra_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCosto_14OR], [CantidadRecibida_14OR]) VALUES (3, 5, 2, N'Pochoclos chico', 9, CAST(120000.00 AS Decimal(18, 2)), 9)
SET IDENTITY_INSERT [dbo].[DetalleOrdenCompra_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallePresupuesto_14OR] ON 

INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (1, 1, 4, N'Combo pochoclos + gaseosa', 6, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (2, 2, 4, N'Combo pochoclos + gaseosa', 15, CAST(2140.00 AS Decimal(18, 2)))
INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (3, 3, 4, N'Combo pochoclos + gaseosa', 6, CAST(2280.00 AS Decimal(18, 2)))
INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (4, 4, 4, N'Combo pochoclos + gaseosa', 1, CAST(2280.00 AS Decimal(18, 2)))
INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (5, 4, 3, N'Gaseosa 500ml', 1, CAST(1026.00 AS Decimal(18, 2)))
INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (6, 4, 1, N'Pochoclos grande', 2, CAST(1368.00 AS Decimal(18, 2)))
INSERT [dbo].[DetallePresupuesto_14OR] ([IdDetallePresupuesto_14OR], [IdPresupuesto_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioCotizado_14OR]) VALUES (7, 5, 2, N'Pochoclos chico', 9, CAST(120000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[DetallePresupuesto_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[DetalleVentaCandy_14OR] ON 

INSERT [dbo].[DetalleVentaCandy_14OR] ([IdDetalleVentaCandy_14OR], [IdVentaCandy_14OR], [IdProducto_14OR], [NombreProducto_14OR], [Cantidad_14OR], [PrecioUnitario_14OR], [Subtotal_14OR]) VALUES (1, 1, 4, N'Combo pochoclos + gaseosa', 22, CAST(3800.00 AS Decimal(18, 2)), CAST(83600.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[DetalleVentaCandy_14OR] OFF
GO
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'AsientoFuncion_14OR', N'908090', N'908090')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Bitacora_43BO', N'2111599', N'2111599')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Butaca_14OR', N'131560', N'131560')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Cliente_14OR', N'14948', N'14948')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'DetalleOrdenCompra_14OR', N'8182', N'8182')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'DetallePresupuesto_14OR', N'17604', N'17604')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'DetalleVentaCandy_14OR', N'3338', N'3338')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Familia_43BO', N'6420', N'6420')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Familia_Familia', N'201', N'201')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Funcion_14OR', N'20553', N'20553')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'OrdenCompra_14OR', N'11726', N'11726')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Patente_43BO', N'89690', N'89690')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Patente_Familia', N'581', N'581')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Pelicula_14OR', N'7995', N'7995')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Pelicula_C_14OR', N'16098', N'16098')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Presupuesto_14OR', N'8318', N'8318')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Producto_14OR', N'14202', N'14202')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Promocion_14OR', N'3170', N'3170')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Proveedor_14OR', N'9421', N'9421')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Rol_43BO', N'9293', N'9293')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Rol_Familia', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Rol_Patente', N'7261', N'7261')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Sala_14OR', N'1000', N'1000')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'TOTAL_BD_43BO', N'3511981', N'3511981')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Usuarios_43BO', N'62486', N'62486')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Venta_14OR', N'45532', N'45532')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'VentaCandy_14OR', N'2713', N'2713')
GO
SET IDENTITY_INSERT [dbo].[Familia_43BO] ON 

INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (4, N'PatentesVendedor')
INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (13, N'BasicoOperario')
INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (14, N'PatentesBasico')
INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (16, N'PatentesGerente')
SET IDENTITY_INSERT [dbo].[Familia_43BO] OFF
GO
INSERT [dbo].[Familia_Familia] ([IdFamiliaPadre_43BO], [IdFamiliaHijo_43BO]) VALUES (13, 14)
GO
SET IDENTITY_INSERT [dbo].[Funcion_14OR] ON 

INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (1, 1, 2, CAST(N'2026-11-20T00:00:00.000' AS DateTime), CAST(N'2026-11-20T13:28:30.860' AS DateTime), N'3D', N'Doblada', CAST(1200.00 AS Decimal(10, 2)))
INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (2, 2, 3, CAST(N'2026-11-05T00:00:00.000' AS DateTime), CAST(N'2026-11-05T11:40:22.000' AS DateTime), N'4DX', N'Doblada', CAST(3600.00 AS Decimal(10, 2)))
INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (3, 1, 2, CAST(N'2026-09-18T00:00:00.000' AS DateTime), CAST(N'2026-09-18T11:41:35.087' AS DateTime), N'3D', N'Subtitulada', CAST(2500.00 AS Decimal(10, 2)))
INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (4, 2, 2, CAST(N'2026-09-29T00:00:00.000' AS DateTime), CAST(N'2026-09-29T10:08:53.000' AS DateTime), N'3D', N'Doblada', CAST(2600.00 AS Decimal(10, 2)))
INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (7, 1, 3, CAST(N'2026-10-09T00:00:00.000' AS DateTime), CAST(N'2026-10-09T20:20:59.753' AS DateTime), N'4DX', N'Doblada', CAST(2700.00 AS Decimal(10, 2)))
INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (8, 1, 2, CAST(N'2026-10-09T00:00:00.000' AS DateTime), CAST(N'2026-10-09T00:36:26.000' AS DateTime), N'4DX', N'Subtitulada', CAST(3500.00 AS Decimal(10, 2)))
INSERT [dbo].[Funcion_14OR] ([IdFuncion_14OR], [IdPelicula_14OR], [IdSala_14OR], [Fecha_14OR], [Horario_14OR], [Formato_14OR], [Idioma_14OR], [Precio_14OR]) VALUES (9, 1, 3, CAST(N'2026-11-26T00:00:00.000' AS DateTime), CAST(N'2026-11-26T17:42:04.523' AS DateTime), N'2D', N'Subtitulada', CAST(1700.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Funcion_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[OrdenCompra_14OR] ON 

INSERT [dbo].[OrdenCompra_14OR] ([IdOrdenCompra_14OR], [NumeroOrden_14OR], [IdProveedor_14OR], [IdPresupuesto_14OR], [FechaEmision_14OR], [Estado_14OR], [Importe_14OR], [FechaPago_14OR], [NumeroRemito_14OR], [FechaRecepcion_14OR]) VALUES (3, 3, 2, 3, CAST(N'2026-11-04' AS Date), N'Cerrada', CAST(13680.00 AS Decimal(18, 2)), CAST(N'2026-11-04T00:00:00.000' AS DateTime), N'0001-00001234', CAST(N'2026-11-04T00:00:00.000' AS DateTime))
INSERT [dbo].[OrdenCompra_14OR] ([IdOrdenCompra_14OR], [NumeroOrden_14OR], [IdProveedor_14OR], [IdPresupuesto_14OR], [FechaEmision_14OR], [Estado_14OR], [Importe_14OR], [FechaPago_14OR], [NumeroRemito_14OR], [FechaRecepcion_14OR]) VALUES (4, 4, 1, 2, CAST(N'2026-11-16' AS Date), N'Cerrada', CAST(32100.00 AS Decimal(18, 2)), CAST(N'2026-11-16T00:00:00.000' AS DateTime), N'4544545454', CAST(N'2026-11-16T00:00:00.000' AS DateTime))
INSERT [dbo].[OrdenCompra_14OR] ([IdOrdenCompra_14OR], [NumeroOrden_14OR], [IdProveedor_14OR], [IdPresupuesto_14OR], [FechaEmision_14OR], [Estado_14OR], [Importe_14OR], [FechaPago_14OR], [NumeroRemito_14OR], [FechaRecepcion_14OR]) VALUES (5, 5, 2, 5, CAST(N'2026-11-16' AS Date), N'Cerrada', CAST(1080000.00 AS Decimal(18, 2)), CAST(N'2026-11-16T00:00:00.000' AS DateTime), N'21222223', CAST(N'2026-11-16T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[OrdenCompra_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Patente_43BO] ON 

INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (1, N'GestionUsuarios_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (2, N'GestionUsuarios_Alta')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (3, N'GestionUsuarios_Desbloquear')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (4, N'GestionUsuarios_Modificar')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (5, N'GestionUsuarios_ActivarDesactivar')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (6, N'GestionUsuarios_Listar')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (7, N'Auditoria_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (8, N'Auditoria_Consultar')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (9, N'Auditoria_Imprimir')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (10, N'Menu_SeccionAdmin')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (11, N'Menu_SeccionMaster')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (12, N'Menu_SeccionVenta')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (13, N'Menu_SeccionCompra')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (14, N'Menu_SeccionReporte')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (15, N'GestionPerfiles_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (16, N'GestionPerfiles_AsignarRelaciones')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (17, N'GestionPerfiles_ConfigurarEstructura')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (18, N'GestionUsuarios_Aplicar')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (19, N'Usuario_CambioContraseña')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (20, N'Usuario_CambioIdioma')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (21, N'Admin_Backup')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (22, N'Admin_RecalcularDV')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (23, N'Admin_Restore')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (24, N'Master_Peliculas_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (25, N'Master_Salas_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (26, N'Master_Funciones_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (27, N'Master_Promociones_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (28, N'Master_Clientes_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (29, N'Venta_ReservarButacas_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (30, N'Venta_ControlAcceso_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (31, N'Reporte_FuncionesOcupacion_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (32, N'Compra_Productos_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (33, N'Compra_Proveedores_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (34, N'Venta_CandyBar_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (35, N'Compra_Presupuestos_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (36, N'Compra_OrdenesCompra_Acceso')
INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (37, N'Maestro_AuditoriaCambios_Acceso')
SET IDENTITY_INSERT [dbo].[Patente_43BO] OFF
GO
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (4, 8)
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (13, 7)
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (16, 7)
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (16, 9)
GO
SET IDENTITY_INSERT [dbo].[Pelicula_14OR] ON 

INSERT [dbo].[Pelicula_14OR] ([IdPelicula_14OR], [Titulo_14OR], [Genero_14OR], [Duracion_14OR], [Poster_14OR]) VALUES (1, N'Godzilla Minus One', N'accion,ciencia ficcion', 125, N'Poster GMO.jpg')
INSERT [dbo].[Pelicula_14OR] ([IdPelicula_14OR], [Titulo_14OR], [Genero_14OR], [Duracion_14OR], [Poster_14OR]) VALUES (2, N'The ring', N'Accion', 90, N'Vendedor.jpg')
SET IDENTITY_INSERT [dbo].[Pelicula_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Pelicula_C_14OR] ON 

INSERT [dbo].[Pelicula_C_14OR] ([IdCambio_14OR], [IdPelicula_14OR], [Titulo_14OR], [Genero_14OR], [Duracion_14OR], [Poster_14OR], [Act_14OR], [TipoCambio_14OR], [FechaHora_14OR]) VALUES (1, 1, N'Godzilla Minus One', N'accion,ciencia ficcion', 125, N'Poster GMO.jpg', 1, N'Alta', CAST(N'2026-10-27T16:06:23.747' AS DateTime))
INSERT [dbo].[Pelicula_C_14OR] ([IdCambio_14OR], [IdPelicula_14OR], [Titulo_14OR], [Genero_14OR], [Duracion_14OR], [Poster_14OR], [Act_14OR], [TipoCambio_14OR], [FechaHora_14OR]) VALUES (3, 2, N'The ring', N'comedio', 90, N'Vendedor.jpg', 0, N'Modificacion', CAST(N'2026-10-27T16:19:29.633' AS DateTime))
INSERT [dbo].[Pelicula_C_14OR] ([IdCambio_14OR], [IdPelicula_14OR], [Titulo_14OR], [Genero_14OR], [Duracion_14OR], [Poster_14OR], [Act_14OR], [TipoCambio_14OR], [FechaHora_14OR]) VALUES (4, 2, N'The ring', N'Accion', 90, N'Vendedor.jpg', 1, N'Modificacion', CAST(N'2026-10-27T16:35:24.770' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pelicula_C_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Presupuesto_14OR] ON 

INSERT [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR], [NumeroPresupuesto_14OR], [IdProveedor_14OR], [FechaPedido_14OR], [Estado_14OR]) VALUES (1, 1, 2, CAST(N'2026-10-20' AS Date), N'Recibido')
INSERT [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR], [NumeroPresupuesto_14OR], [IdProveedor_14OR], [FechaPedido_14OR], [Estado_14OR]) VALUES (2, 2, 1, CAST(N'2026-11-03' AS Date), N'Aceptado')
INSERT [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR], [NumeroPresupuesto_14OR], [IdProveedor_14OR], [FechaPedido_14OR], [Estado_14OR]) VALUES (3, 3, 2, CAST(N'2026-11-04' AS Date), N'Aceptado')
INSERT [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR], [NumeroPresupuesto_14OR], [IdProveedor_14OR], [FechaPedido_14OR], [Estado_14OR]) VALUES (4, 4, 2, CAST(N'2026-11-16' AS Date), N'Rechazado')
INSERT [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR], [NumeroPresupuesto_14OR], [IdProveedor_14OR], [FechaPedido_14OR], [Estado_14OR]) VALUES (5, 5, 2, CAST(N'2026-11-16' AS Date), N'Aceptado')
SET IDENTITY_INSERT [dbo].[Presupuesto_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto_14OR] ON 

INSERT [dbo].[Producto_14OR] ([IdProducto_14OR], [Nombre_14OR], [PrecioVenta_14OR], [Stock_14OR], [StockCritico_14OR], [Activo_14OR], [Imagen_14OR], [PrecioCosto_14OR]) VALUES (1, N'Pochoclos grande', CAST(2500.00 AS Decimal(18, 2)), 40, 10, 1, N'images.jpg', CAST(1200.00 AS Decimal(18, 2)))
INSERT [dbo].[Producto_14OR] ([IdProducto_14OR], [Nombre_14OR], [PrecioVenta_14OR], [Stock_14OR], [StockCritico_14OR], [Activo_14OR], [Imagen_14OR], [PrecioCosto_14OR]) VALUES (2, N'Pochoclos chico', CAST(1500.00 AS Decimal(18, 2)), 59, 10, 1, NULL, CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[Producto_14OR] ([IdProducto_14OR], [Nombre_14OR], [PrecioVenta_14OR], [Stock_14OR], [StockCritico_14OR], [Activo_14OR], [Imagen_14OR], [PrecioCosto_14OR]) VALUES (3, N'Gaseosa 500ml', CAST(1800.00 AS Decimal(18, 2)), 60, 15, 1, NULL, CAST(900.00 AS Decimal(18, 2)))
INSERT [dbo].[Producto_14OR] ([IdProducto_14OR], [Nombre_14OR], [PrecioVenta_14OR], [Stock_14OR], [StockCritico_14OR], [Activo_14OR], [Imagen_14OR], [PrecioCosto_14OR]) VALUES (4, N'Combo pochoclos + gaseosa', CAST(3800.00 AS Decimal(18, 2)), 24, 8, 1, NULL, CAST(2000.00 AS Decimal(18, 2)))
INSERT [dbo].[Producto_14OR] ([IdProducto_14OR], [Nombre_14OR], [PrecioVenta_14OR], [Stock_14OR], [StockCritico_14OR], [Activo_14OR], [Imagen_14OR], [PrecioCosto_14OR]) VALUES (5, N'Roklets', CAST(2500.00 AS Decimal(18, 2)), 10, 20, 1, N'images (1).jpg', CAST(1700.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Producto_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Promocion_14OR] ON 

INSERT [dbo].[Promocion_14OR] ([IdPromocion_14OR], [Nombre_14OR], [Tipo_14OR], [Valor_14OR], [FechaInicio_14OR], [FechaFin_14OR], [Activa_14OR]) VALUES (2, N'Promo Parejas', N'2x1', CAST(0.00 AS Decimal(10, 2)), CAST(N'2026-09-28' AS Date), CAST(N'2026-09-30' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Promocion_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Proveedor_14OR] ON 

INSERT [dbo].[Proveedor_14OR] ([IdProveedor_14OR], [Nombre_14OR], [Telefono_14OR], [Email_14OR], [Activo_14OR], [Cuit_14OR]) VALUES (1, N'Distribuidora Candy SA', N'11-4000-1000', N'ventas@candysa.com', 1, NULL)
INSERT [dbo].[Proveedor_14OR] ([IdProveedor_14OR], [Nombre_14OR], [Telefono_14OR], [Email_14OR], [Activo_14OR], [Cuit_14OR]) VALUES (2, N'Bebidas del Sur', N'11-4000-2000', N'pedidos@bebidassur.com', 1, N'52523326554')
SET IDENTITY_INSERT [dbo].[Proveedor_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol_43BO] ON 

INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (1, N'Administrador')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (2, N'Basico')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (9, N'Vendedor')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (16, N'ParaSassa')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (1016, N'Gerente')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (1025, N'ParaPepe')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (1026, N'PruebaBitacora')
INSERT [dbo].[Rol_43BO] ([IdRol_43BO], [NombreRol_43BO]) VALUES (1027, N'pruebaauditoria2')
SET IDENTITY_INSERT [dbo].[Rol_43BO] OFF
GO
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 1)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 2)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 3)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 4)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 5)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 6)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 7)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 8)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 9)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 10)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 11)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 12)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 13)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 14)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 15)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 16)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 17)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 18)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 19)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 20)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 21)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 22)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 23)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 24)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 25)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 26)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 27)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 28)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 29)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 30)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 31)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 32)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 33)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 34)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 35)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 36)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 37)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (9, 12)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (9, 29)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (9, 30)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (9, 34)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (16, 7)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (16, 10)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (16, 12)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (16, 19)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (16, 20)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (16, 30)
INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1025, 16)
GO
SET IDENTITY_INSERT [dbo].[Sala_14OR] ON 

INSERT [dbo].[Sala_14OR] ([IdSala_14OR], [Numero_14OR], [Capacidad_14OR], [Pasillos_14OR]) VALUES (1, 1, 80, NULL)
INSERT [dbo].[Sala_14OR] ([IdSala_14OR], [Numero_14OR], [Capacidad_14OR], [Pasillos_14OR]) VALUES (2, 2, 120, N'4,8')
INSERT [dbo].[Sala_14OR] ([IdSala_14OR], [Numero_14OR], [Capacidad_14OR], [Pasillos_14OR]) VALUES (3, 3, 210, N'4,6')
SET IDENTITY_INSERT [dbo].[Sala_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios_43BO] ON 

INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1003, 11222333, N'Martin', N'Martinez', 0, N'Martin@gmail', 1, N'b2835a48f99bdbe2c0176f286c6059721a374011d32d89d16795266f1e2c922d', 2, NULL)
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1008, 22666555, N'Pepe', N'Pepe', 0, N'Pepe@gmail.com', 1, N'7c9e7c1494b2684ab7c19d6aff737e460fa9e98d5a234da1310c97ddf5691834', 2, NULL)
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1004, 44555666, N'Marcelo', N'Caceres', 0, N'marce@gmail.com', 1, N'a36b91001a3b0fe052b4b3f882a1d16f6963cbc82d5c770d5565c7dc4e217502', 2, NULL)
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (2, 45678912, N'Monica', N'Argento', 0, N'Jose@gmail.com', 1, N'd2353870a9735aa607f2a61141f61aa255ff802070ecdcf83af0119f9bf22933', 2, NULL)
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1, 46498814, N'Joaquin', N'Sassaroli', 0, N'hola.,com', 1, N'b460b1982188f11d175f60ed670027e1afdd16558919fe47023ecd38329e0b7f', 16, N'es')
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1002, 46498815, N'Juan', N'Ortega', 0, N'juanpi@gmail.com', 1, N'b460b1982188f11d175f60ed670027e1afdd16558919fe47023ecd38329e0b7f', 1, N'es')
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1007, 66123456, N'Javier', N'fernandez', 0, N'hola@gmail.com', 1, N'8b98d66c6502057ec2c970917bed152e5d58563434e19a0292453ff18eea9930', 2, NULL)
INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1006, 77888999, N'Juan', N'Ortega', 0, N'ortegita@gmail.com', 1, N'cae98ae06faab98103fd533e4b8636ab350dbeaabf0e42ee498e31b0147d7eb9', 1, NULL)
SET IDENTITY_INSERT [dbo].[Usuarios_43BO] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta_14OR] ON 

INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (1, 1, NULL, CAST(N'2026-09-17T00:00:00.000' AS DateTime), CAST(N'2026-09-17T11:44:15.230' AS DateTime), N'Pagada', N'Efectivo', CAST(10800.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (2, 2, NULL, CAST(N'2026-09-17T00:00:00.000' AS DateTime), CAST(N'2026-09-17T11:46:30.303' AS DateTime), N'Pagada', N'Tarjeta', CAST(10800.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (3, 3, NULL, CAST(N'2026-09-17T00:00:00.000' AS DateTime), CAST(N'2026-09-17T20:25:54.183' AS DateTime), N'Pagada', N'Efectivo', CAST(24000.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (4, 4, NULL, CAST(N'2026-09-17T00:00:00.000' AS DateTime), CAST(N'2026-09-17T20:28:28.783' AS DateTime), N'Pagada', N'Efectivo', CAST(4000.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (5, 5, NULL, CAST(N'2026-09-17T00:00:00.000' AS DateTime), CAST(N'2026-09-17T20:35:35.257' AS DateTime), N'Pagada', N'Efectivo', CAST(32000.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (6, 6, NULL, CAST(N'2026-09-26T00:00:00.000' AS DateTime), CAST(N'2026-09-26T20:08:41.077' AS DateTime), N'Pagada', N'Efectivo', CAST(12300.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (7, 7, NULL, CAST(N'2026-09-28T00:00:00.000' AS DateTime), CAST(N'2026-09-28T19:36:27.273' AS DateTime), N'Pagada', N'Efectivo', CAST(16400.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (8, 8, NULL, CAST(N'2026-09-28T00:00:00.000' AS DateTime), CAST(N'2026-09-28T20:24:42.387' AS DateTime), N'Pagada', N'Efectivo', CAST(13200.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (9, 9, NULL, CAST(N'2026-09-29T00:00:00.000' AS DateTime), CAST(N'2026-09-29T15:56:39.333' AS DateTime), N'Pagada', N'Tarjeta', CAST(12300.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (10, 10, 3, CAST(N'2026-09-29T00:00:00.000' AS DateTime), CAST(N'2026-09-29T22:19:00.373' AS DateTime), N'Pagada', N'Efectivo', CAST(6500.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (11, 11, NULL, CAST(N'2026-10-08T00:00:00.000' AS DateTime), CAST(N'2026-10-08T13:42:20.613' AS DateTime), N'Pagada', N'Efectivo', CAST(17100.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (12, 12, NULL, CAST(N'2026-10-08T00:00:00.000' AS DateTime), CAST(N'2026-10-08T13:43:04.547' AS DateTime), N'Pagada', N'Efectivo', CAST(11400.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[Venta_14OR] ([IdVenta_14OR], [NumeroVenta_14OR], [IdCliente_14OR], [Fecha_14OR], [Hora_14OR], [Estado_14OR], [MetodoPago_14OR], [MontoTotal_14OR], [IdPromocion_14OR], [MontoDescuento_14OR]) VALUES (13, 13, NULL, CAST(N'2026-11-03T00:00:00.000' AS DateTime), CAST(N'2026-11-03T18:37:51.917' AS DateTime), N'Pagada', N'Efectivo', CAST(16200.00 AS Decimal(10, 2)), NULL, CAST(0.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Venta_14OR] OFF
GO
SET IDENTITY_INSERT [dbo].[VentaCandy_14OR] ON 

INSERT [dbo].[VentaCandy_14OR] ([IdVentaCandy_14OR], [NumeroVenta_14OR], [Fecha_14OR], [Hora_14OR], [MetodoPago_14OR], [MontoTotal_14OR]) VALUES (1, 1, CAST(N'2026-11-03' AS Date), CAST(N'2026-11-03T23:40:48.507' AS DateTime), N'Efectivo', CAST(83600.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[VentaCandy_14OR] OFF
GO
SET ANSI_PADDING ON
GO
/****** Objeto: Index [UX_Proveedor_Cuit_Activo] Fecha de script: 18/11/2026 05:50:21 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_Proveedor_Cuit_Activo] ON [dbo].[Proveedor_14OR]
(
	[Cuit_14OR] ASC
)
WHERE ([Cuit_14OR] IS NOT NULL AND [Activo_14OR]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Objeto: Index [UQ_DNI] Fecha de script: 18/11/2026 05:50:21 ******/
ALTER TABLE [dbo].[Usuarios_43BO] ADD  CONSTRAINT [UQ_DNI] UNIQUE NONCLUSTERED 
(
	[DNI_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR] ADD  DEFAULT ('Libre') FOR [Estado_14OR]
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR] ADD  DEFAULT ((0)) FOR [Ingreso_14OR]
GO
ALTER TABLE [dbo].[Cliente_14OR] ADD  CONSTRAINT [DF_Cliente_Eliminado_14OR]  DEFAULT ((0)) FOR [Eliminado_14OR]
GO
ALTER TABLE [dbo].[Producto_14OR] ADD  CONSTRAINT [DF_Producto_14OR_Activo]  DEFAULT ((1)) FOR [Activo_14OR]
GO
ALTER TABLE [dbo].[Producto_14OR] ADD  CONSTRAINT [DF_Producto_PrecioCosto]  DEFAULT ((0)) FOR [PrecioCosto_14OR]
GO
ALTER TABLE [dbo].[Promocion_14OR] ADD  CONSTRAINT [DF__Promocion__Valor__4F47C5E3]  DEFAULT ((0)) FOR [Valor_14OR]
GO
ALTER TABLE [dbo].[Promocion_14OR] ADD  CONSTRAINT [DF__Promocion__Activ__503BEA1C]  DEFAULT ((1)) FOR [Activa_14OR]
GO
ALTER TABLE [dbo].[Proveedor_14OR] ADD  CONSTRAINT [DF_Proveedor_14OR_Activo]  DEFAULT ((1)) FOR [Activo_14OR]
GO
ALTER TABLE [dbo].[Usuarios_43BO] ADD  CONSTRAINT [DF_Usuarios_43BO_Bloqueado_43BO]  DEFAULT ((0)) FOR [Bloqueado_43BO]
GO
ALTER TABLE [dbo].[Usuarios_43BO] ADD  CONSTRAINT [DF_Usuarios_43BO_Activo_43BO]  DEFAULT ((1)) FOR [Activo_43BO]
GO
ALTER TABLE [dbo].[Usuarios_43BO] ADD  DEFAULT ('es') FOR [Idioma_43BO]
GO
ALTER TABLE [dbo].[Venta_14OR] ADD  DEFAULT ((0)) FOR [MontoDescuento_14OR]
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_AF_Butaca_14OR] FOREIGN KEY([IdButaca_14OR])
REFERENCES [dbo].[Butaca_14OR] ([IdButaca_14OR])
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR] CHECK CONSTRAINT [FK_AF_Butaca_14OR]
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_AF_Funcion_14OR] FOREIGN KEY([IdFuncion_14OR])
REFERENCES [dbo].[Funcion_14OR] ([IdFuncion_14OR])
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR] CHECK CONSTRAINT [FK_AF_Funcion_14OR]
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_AF_Venta_14OR] FOREIGN KEY([IdVenta_14OR])
REFERENCES [dbo].[Venta_14OR] ([IdVenta_14OR])
GO
ALTER TABLE [dbo].[AsientoFuncion_14OR] CHECK CONSTRAINT [FK_AF_Venta_14OR]
GO
ALTER TABLE [dbo].[Bitacora_43BO]  WITH CHECK ADD  CONSTRAINT [FK_Bitacora_43BO_Usuarios_43BO] FOREIGN KEY([DNIuser_43BO])
REFERENCES [dbo].[Usuarios_43BO] ([DNI_43BO])
GO
ALTER TABLE [dbo].[Bitacora_43BO] CHECK CONSTRAINT [FK_Bitacora_43BO_Usuarios_43BO]
GO
ALTER TABLE [dbo].[Butaca_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Butaca_14OR_Sala_14OR] FOREIGN KEY([IdSala_14OR])
REFERENCES [dbo].[Sala_14OR] ([IdSala_14OR])
GO
ALTER TABLE [dbo].[Butaca_14OR] CHECK CONSTRAINT [FK_Butaca_14OR_Sala_14OR]
GO
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetOrden_Orden] FOREIGN KEY([IdOrdenCompra_14OR])
REFERENCES [dbo].[OrdenCompra_14OR] ([IdOrdenCompra_14OR])
GO
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] CHECK CONSTRAINT [FK_DetOrden_Orden]
GO
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetOrden_Producto] FOREIGN KEY([IdProducto_14OR])
REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
GO
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] CHECK CONSTRAINT [FK_DetOrden_Producto]
GO
ALTER TABLE [dbo].[DetallePresupuesto_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetPresu_Presupuesto] FOREIGN KEY([IdPresupuesto_14OR])
REFERENCES [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR])
GO
ALTER TABLE [dbo].[DetallePresupuesto_14OR] CHECK CONSTRAINT [FK_DetPresu_Presupuesto]
GO
ALTER TABLE [dbo].[DetallePresupuesto_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetPresu_Producto] FOREIGN KEY([IdProducto_14OR])
REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
GO
ALTER TABLE [dbo].[DetallePresupuesto_14OR] CHECK CONSTRAINT [FK_DetPresu_Producto]
GO
ALTER TABLE [dbo].[DetalleVentaCandy_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetVentaCandy_Producto] FOREIGN KEY([IdProducto_14OR])
REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
GO
ALTER TABLE [dbo].[DetalleVentaCandy_14OR] CHECK CONSTRAINT [FK_DetVentaCandy_Producto]
GO
ALTER TABLE [dbo].[DetalleVentaCandy_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetVentaCandy_Venta] FOREIGN KEY([IdVentaCandy_14OR])
REFERENCES [dbo].[VentaCandy_14OR] ([IdVentaCandy_14OR])
GO
ALTER TABLE [dbo].[DetalleVentaCandy_14OR] CHECK CONSTRAINT [FK_DetVentaCandy_Venta]
GO
ALTER TABLE [dbo].[Familia_Familia]  WITH CHECK ADD  CONSTRAINT [FK__Familia_F__IdFam__2BFE89A6] FOREIGN KEY([IdFamiliaPadre_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Familia_Familia] CHECK CONSTRAINT [FK__Familia_F__IdFam__2BFE89A6]
GO
ALTER TABLE [dbo].[Familia_Familia]  WITH CHECK ADD  CONSTRAINT [FK__Familia_F__IdFam__2CF2ADDF] FOREIGN KEY([IdFamiliaHijo_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Familia_Familia] CHECK CONSTRAINT [FK__Familia_F__IdFam__2CF2ADDF]
GO
ALTER TABLE [dbo].[Funcion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Funcion_14OR_Pelicula_14OR] FOREIGN KEY([IdPelicula_14OR])
REFERENCES [dbo].[Pelicula_14OR] ([IdPelicula_14OR])
GO
ALTER TABLE [dbo].[Funcion_14OR] CHECK CONSTRAINT [FK_Funcion_14OR_Pelicula_14OR]
GO
ALTER TABLE [dbo].[Funcion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Funcion_14OR_Sala_14OR] FOREIGN KEY([IdSala_14OR])
REFERENCES [dbo].[Sala_14OR] ([IdSala_14OR])
GO
ALTER TABLE [dbo].[Funcion_14OR] CHECK CONSTRAINT [FK_Funcion_14OR_Sala_14OR]
GO
ALTER TABLE [dbo].[OrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_OrdenCompra_Presupuesto] FOREIGN KEY([IdPresupuesto_14OR])
REFERENCES [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR])
GO
ALTER TABLE [dbo].[OrdenCompra_14OR] CHECK CONSTRAINT [FK_OrdenCompra_Presupuesto]
GO
ALTER TABLE [dbo].[OrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_OrdenCompra_Proveedor] FOREIGN KEY([IdProveedor_14OR])
REFERENCES [dbo].[Proveedor_14OR] ([IdProveedor_14OR])
GO
ALTER TABLE [dbo].[OrdenCompra_14OR] CHECK CONSTRAINT [FK_OrdenCompra_Proveedor]
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
ALTER TABLE [dbo].[Presupuesto_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Presupuesto_Proveedor] FOREIGN KEY([IdProveedor_14OR])
REFERENCES [dbo].[Proveedor_14OR] ([IdProveedor_14OR])
GO
ALTER TABLE [dbo].[Presupuesto_14OR] CHECK CONSTRAINT [FK_Presupuesto_Proveedor]
GO
ALTER TABLE [dbo].[Rol_Familia]  WITH CHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Rol_Familia]  WITH CHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Rol_Familia]  WITH CHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Rol_Familia]  WITH CHECK ADD  CONSTRAINT [FK__Rol_Famil__IdRol__245D67DE] FOREIGN KEY([IdRol_43BO])
REFERENCES [dbo].[Rol_43BO] ([IdRol_43BO])
GO
ALTER TABLE [dbo].[Rol_Familia] CHECK CONSTRAINT [FK__Rol_Famil__IdRol__245D67DE]
GO
ALTER TABLE [dbo].[Rol_Patente]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
ALTER TABLE [dbo].[Rol_Patente]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
ALTER TABLE [dbo].[Rol_Patente]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
ALTER TABLE [dbo].[Rol_Patente]  WITH NOCHECK ADD  CONSTRAINT [FK__Rol_Paten__IdRol__1EA48E88] FOREIGN KEY([IdRol_43BO])
REFERENCES [dbo].[Rol_43BO] ([IdRol_43BO])
GO
ALTER TABLE [dbo].[Rol_Patente] CHECK CONSTRAINT [FK__Rol_Paten__IdRol__1EA48E88]
GO
ALTER TABLE [dbo].[Usuarios_43BO]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_43BO_Rol_43BO] FOREIGN KEY([Rol_43BO])
REFERENCES [dbo].[Rol_43BO] ([IdRol_43BO])
GO
ALTER TABLE [dbo].[Usuarios_43BO] CHECK CONSTRAINT [FK_Usuarios_43BO_Rol_43BO]
GO
ALTER TABLE [dbo].[Venta_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Venta_14OR_Cliente_14OR] FOREIGN KEY([IdCliente_14OR])
REFERENCES [dbo].[Cliente_14OR] ([IdCliente_14OR])
GO
ALTER TABLE [dbo].[Venta_14OR] CHECK CONSTRAINT [FK_Venta_14OR_Cliente_14OR]
GO
ALTER TABLE [dbo].[Venta_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Promocion_14OR] FOREIGN KEY([IdPromocion_14OR])
REFERENCES [dbo].[Promocion_14OR] ([IdPromocion_14OR])
GO
ALTER TABLE [dbo].[Venta_14OR] CHECK CONSTRAINT [FK_Venta_Promocion_14OR]
GO
/****** Objeto: StoredProcedure [dbo].[DesvincularComponente_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[DesvincularComponente_43BO]
    @idPadre INT, 
    @idHijo INT, 
    @tipo VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @tipo = 'RolPatente' 
        DELETE FROM Rol_Patente WHERE IdRol_43BO = @idPadre AND IdPatente_43BO = @idHijo;
    ELSE IF @tipo = 'RolFamilia' 
        DELETE FROM Rol_Familia WHERE IdRol_43BO = @idPadre AND IdFamilia_43BO = @idHijo;
    ELSE IF @tipo = 'PatenteFamilia' 
        DELETE FROM Patente_Familia WHERE IdFamilia_43BO = @idPadre AND IdPatente_43BO = @idHijo;
    ELSE IF @tipo = 'FamiliaFamilia' 
        DELETE FROM Familia_Familia WHERE IdFamiliaPadre_43BO = @idPadre AND IdFamiliaHijo_43BO = @idHijo;
END



GO
/****** Objeto: StoredProcedure [dbo].[EliminarComponente_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[EliminarComponente_43BO]
    @idComponente INT,
    @tipo VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @tipo = 'Rol'
    BEGIN
        DELETE FROM Rol_Patente WHERE IdRol_43BO = @idComponente;
        DELETE FROM Rol_Familia WHERE IdRol_43BO = @idComponente;
        DELETE FROM Rol_43BO WHERE IdRol_43BO = @idComponente;
    END
    ELSE IF @tipo = 'Familia'
    BEGIN
        DELETE FROM Rol_Familia WHERE IdFamilia_43BO = @idComponente;
        DELETE FROM Patente_Familia WHERE IdFamilia_43BO = @idComponente;
        DELETE FROM Familia_Familia WHERE IdFamiliaPadre_43BO = @idComponente OR IdFamiliaHijo_43BO = @idComponente;
        DELETE FROM Familia_43BO WHERE IdFamilia_43BO = @idComponente;
    END
END



GO
/****** Objeto: StoredProcedure [dbo].[InsertarComponente_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertarComponente_43BO]
    @nombre VARCHAR(100),
    @tipo VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @tipo = 'Familia'
    BEGIN
        INSERT INTO Familia_43BO (NombreFamilia_43BO) VALUES (@nombre);
        SELECT SCOPE_IDENTITY();
    END
    ELSE IF @tipo = 'Rol'
    BEGIN
        INSERT INTO Rol_43BO (NombreRol_43BO) VALUES (@nombre);
        SELECT SCOPE_IDENTITY();
    END
END



GO
/****** Objeto: StoredProcedure [dbo].[ListarTodo_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ListarTodo_43BO]
    @tipo VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @tipo = 'Patente'
        SELECT IdPatente_43BO AS Id_43BO, NombrePatente_43BO AS Nombre_43BO FROM Patente_43BO;
    ELSE IF @tipo = 'Familia'
        SELECT IdFamilia_43BO AS Id_43BO, NombreFamilia_43BO AS Nombre_43BO FROM Familia_43BO;
    ELSE IF @tipo = 'Rol'
        SELECT IdRol_43BO AS Id_43BO, NombreRol_43BO AS Nombre_43BO FROM Rol_43BO;
END



GO
/****** Objeto: StoredProcedure [dbo].[ModificarNombreComponente_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[ModificarNombreComponente_43BO]
    @Id INT,
    @NuevoNombre VARCHAR(100),
    @Tipo VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Pasamos a mayúsculas y limpiamos espacios por las dudas
    DECLARE @TipoLimpio VARCHAR(20) = UPPER(TRIM(@Tipo));

    IF @TipoLimpio = 'ROL'
    BEGIN
        UPDATE Rol_43BO 
        SET NombreRol_43BO = @NuevoNombre 
        WHERE IdRol_43BO = @Id;
    END
    ELSE IF @TipoLimpio = 'FAMILIA'
    BEGIN
        UPDATE Familia_43BO 
        SET NombreFamilia_43BO = @NuevoNombre 
        WHERE IdFamilia_43BO = @Id;
    END
END


GO
/****** Objeto: StoredProcedure [dbo].[ObtenerComponentesHijos_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerComponentesHijos_43BO]
    @idPadre INT,
    @tipo VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @tipo = 'PatentesRol'
        SELECT rp.IdPatente_43BO AS Id_43BO, p.NombrePatente_43BO AS Nombre_43BO 
        FROM Rol_Patente rp 
        INNER JOIN Patente_43BO p ON rp.IdPatente_43BO = p.IdPatente_43BO 
        WHERE rp.IdRol_43BO = @idPadre;
        
    ELSE IF @tipo = 'FamiliasRol'
        SELECT rf.IdFamilia_43BO AS Id_43BO, f.NombreFamilia_43BO AS Nombre_43BO 
        FROM Rol_Familia rf 
        INNER JOIN Familia_43BO f ON rf.IdFamilia_43BO = f.IdFamilia_43BO 
        WHERE rf.IdRol_43BO = @idPadre;
        
    ELSE IF @tipo = 'PatentesFamilia'
        SELECT pf.IdPatente_43BO AS Id_43BO, p.NombrePatente_43BO AS Nombre_43BO 
        FROM Patente_Familia pf 
        INNER JOIN Patente_43BO p ON pf.IdPatente_43BO = p.IdPatente_43BO 
        WHERE pf.IdFamilia_43BO = @idPadre;
        
    ELSE IF @tipo = 'FamiliasHijas'
        SELECT ff.IdFamiliaHijo_43BO AS Id_43BO, f.NombreFamilia_43BO AS Nombre_43BO 
        FROM Familia_Familia ff 
        INNER JOIN Familia_43BO f ON ff.IdFamiliaHijo_43BO = f.IdFamilia_43BO 
        WHERE ff.IdFamiliaPadre_43BO = @idPadre;
END


GO
/****** Objeto: StoredProcedure [dbo].[ObtenerIdsPermisosPorRol_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerIdsPermisosPorRol_43BO]
    @idRol INT
AS
BEGIN
    SET NOCOUNT ON;
    WITH CTE_Familias AS (
        SELECT IdFamilia_43BO 
        FROM Rol_Familia 
        WHERE IdRol_43BO = @idRol
        UNION ALL
        SELECT ff.IdFamiliaHijo_43BO
        FROM Familia_Familia ff
        INNER JOIN CTE_Familias c ON ff.IdFamiliaPadre_43BO = c.IdFamilia_43BO
    )
    SELECT IdPatente_43BO FROM Rol_Patente WHERE IdRol_43BO = @idRol
    UNION
    SELECT pf.IdPatente_43BO 
    FROM Patente_Familia pf
    INNER JOIN CTE_Familias f ON pf.IdFamilia_43BO = f.IdFamilia_43BO;
END


GO
/****** Objeto: StoredProcedure [dbo].[sp_RollbackPelicula_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RollbackPelicula_14OR]
    @IdCambio_14OR int
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdPel int, @Tit nvarchar(200), @Gen nvarchar(200), @Dur int, @Pos nvarchar(260);

    SELECT @IdPel = IdPelicula_14OR, @Tit = Titulo_14OR, @Gen = Genero_14OR,
           @Dur = Duracion_14OR, @Pos = Poster_14OR
    FROM [dbo].[Pelicula_C_14OR]
    WHERE IdCambio_14OR = @IdCambio_14OR;

    IF @IdPel IS NULL
    BEGIN
        RAISERROR(N'No se encontro el registro historico a reactivar.', 16, 1);
        RETURN;
    END

    -- suprimo los triggers: el historico lo ajusto a mano aca (reactivo la fila elegida)
    EXEC sys.sp_set_session_context N'rollback', 1;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- en el historico: todas las versiones de esta pelicula pasan a 0, y la elegida a 1
        UPDATE [dbo].[Pelicula_C_14OR] SET Act_14OR = 0 WHERE IdPelicula_14OR = @IdPel;
        UPDATE [dbo].[Pelicula_C_14OR] SET Act_14OR = 1 WHERE IdCambio_14OR = @IdCambio_14OR;

        -- sincronizo la tabla viva con la version elegida
        IF EXISTS (SELECT 1 FROM [dbo].[Pelicula_14OR] WHERE IdPelicula_14OR = @IdPel)
        BEGIN
            UPDATE [dbo].[Pelicula_14OR]
            SET Titulo_14OR = @Tit, Genero_14OR = @Gen, Duracion_14OR = @Dur, Poster_14OR = @Pos
            WHERE IdPelicula_14OR = @IdPel;
        END
        ELSE
        BEGIN
            -- la pelicula estaba borrada: la vuelvo a crear con su mismo Id
            SET IDENTITY_INSERT [dbo].[Pelicula_14OR] ON;
            INSERT INTO [dbo].[Pelicula_14OR] (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR)
            VALUES (@IdPel, @Tit, @Gen, @Dur, @Pos);
            SET IDENTITY_INSERT [dbo].[Pelicula_14OR] OFF;
        END

        COMMIT TRANSACTION;
        EXEC sys.sp_set_session_context N'rollback', 0;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        EXEC sys.sp_set_session_context N'rollback', 0;
        THROW;
    END CATCH
END

GO
/****** Objeto: StoredProcedure [dbo].[VincularComponente_43BO] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. CORRECCIÓN AL SP DE VINCULACIÓN
CREATE PROCEDURE [dbo].[VincularComponente_43BO]
    @idPadre INT, 
    @idHijo INT, 
    @tipo VARCHAR(30)
AS
BEGIN
    SET NOCOUNT OFF; -- Activado para que devuelva las filas afectadas a C#
    
    IF @tipo = 'RolPatente' 
        INSERT INTO Rol_Patente (IdRol_43BO, IdPatente_43BO) VALUES (@idPadre, @idHijo);
    ELSE IF @tipo = 'RolFamilia' 
        INSERT INTO Rol_Familia (IdRol_43BO, IdFamilia_43BO) VALUES (@idPadre, @idHijo);
    ELSE IF @tipo = 'PatenteFamilia' 
        INSERT INTO Patente_Familia (IdFamilia_43BO, IdPatente_43BO) VALUES (@idPadre, @idHijo);
    ELSE IF @tipo = 'FamiliaFamilia' 
        INSERT INTO Familia_Familia (IdFamiliaPadre_43BO, IdFamiliaHijo_43BO) VALUES (@idPadre, @idHijo);
END


GO
/****** Objeto: Trigger [dbo].[trg_Pelicula_C_Delete_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Pelicula_C_Delete_14OR]
ON [dbo].[Pelicula_14OR]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF SESSION_CONTEXT(N'rollback') = 1 RETURN;
    DELETE c FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN deleted d ON d.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 0;
    UPDATE c SET c.Act_14OR = 0, c.TipoCambio_14OR = N'Baja', c.FechaHora_14OR = GETDATE()
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN deleted d ON d.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 1;
END

GO
ALTER TABLE [dbo].[Pelicula_14OR] ENABLE TRIGGER [trg_Pelicula_C_Delete_14OR]
GO
/****** Objeto: Trigger [dbo].[trg_Pelicula_C_Insert_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Pelicula_C_Insert_14OR]
ON [dbo].[Pelicula_14OR]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF SESSION_CONTEXT(N'rollback') = 1 RETURN;
    INSERT INTO [dbo].[Pelicula_C_14OR]
        (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR)
    SELECT i.IdPelicula_14OR, i.Titulo_14OR, i.Genero_14OR, i.Duracion_14OR, i.Poster_14OR, 1, N'Alta', GETDATE()
    FROM inserted i;
END

GO
ALTER TABLE [dbo].[Pelicula_14OR] ENABLE TRIGGER [trg_Pelicula_C_Insert_14OR]
GO
/****** Objeto: Trigger [dbo].[trg_Pelicula_C_Update_14OR] Fecha de script: 18/11/2026 05:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Pelicula_C_Update_14OR]
ON [dbo].[Pelicula_14OR]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF SESSION_CONTEXT(N'rollback') = 1 RETURN;
    -- 2 estados: borro la version vieja anterior (la que ya estaba en Act=0)
    DELETE c FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN inserted i ON i.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 0;
    -- la vigente pasa a anterior
    UPDATE c SET c.Act_14OR = 0 FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN inserted i ON i.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 1;
    -- nueva version vigente
    INSERT INTO [dbo].[Pelicula_C_14OR]
        (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR)
    SELECT i.IdPelicula_14OR, i.Titulo_14OR, i.Genero_14OR, i.Duracion_14OR, i.Poster_14OR, 1, N'Modificacion', GETDATE()
    FROM inserted i;
END

GO
ALTER TABLE [dbo].[Pelicula_14OR] ENABLE TRIGGER [trg_Pelicula_C_Update_14OR]
GO
SET NOEXEC OFF
GO
PRINT 'Script terminado: base Ing.Software creada con sus datos.'
GO
