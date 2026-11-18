/* ============================================================================
   DEPLOY Ing.Software  -  SCRIPT IDEMPOTENTE / DE MIGRACION
   ----------------------------------------------------------------------------
   Se puede correr las VECES QUE SEA, sobre una base nueva o una ya existente:
   crea SOLO lo que falta y NO toca los datos que ya estan cargados.

   Como esta armado y como meterle cambios mas adelante. Las tablas se crean
   con IF OBJECT_ID IS NULL asi que si ya xeisten no las toca. Si en una v2 o v3
   agregas columnas nuevas las ponemos abajo de todo en la seccion MIGRACIONES
   con un IF COL_LENGTH IS NULL y un ALTER TABLE ADD. Los datos semilla se
   cargan nada mas si la tabla esta vacia pa no re-insertar ni pisar lo que el
   usario ya tenga. Las FK y los DEFAULT van con IF NOT EXISTS asi no se
   duplican. Los SP quedan con CREATE OR ALTER y los triggers con DROP mas
   CREATE asi siempre estan en la ultima version. Y los datos de referencia que
   si o si tienen que estar (los permisos nuevos) van como INSERT guardado por
   clave tambien en MIGRACIONES.

   Esto lo corre el instalador con sqlcmd y cuadno termina bien deja un DEPLOY_OK.

   v3 (base vacia): si es una instalacion nueva la base queda solo con la estructura,
   los sp y triggers, los roles patentes y familias como estaban y un solo usuario que es
   Sassaroli (dni 46498814) como administrador. le deje la contraseña de fabrica (dni +
   apellido) asi cuando entra el sistema le pide cambiarla
   los datos de negocio (pelis, salas, funciones, ventas, clientes, productos, proveedores,
   presupuestos, bitacora y los demas usuarios) los pase a Database\Datos_Prueba.sql que se
   corre aparte si queres datos de prueba, despues hay que recalcular el dv desde la app
   si es una actualizacion (la base ya tiene las 27 tablas) no cambia nada, ese bloque se
   saltea entero y lo que estaba cargado queda igual
   ============================================================================ */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET XACT_ABORT ON
GO

/* -- 1) La base: se crea solo si no existe (no pisa una base ya cargada) -- */
IF DB_ID(N'Ing.Software') IS NULL
BEGIN
    CREATE DATABASE [Ing.Software];
END
GO
USE [Ing.Software]
GO

/* ============================ ESQUEMA + DATOS (Script v13) ============================ */

/* Si la base YA tiene el esquema COMPLETO (estan las 27 tablas), salteo de una
   TODO este bloque: tablas, datos, constraints, FKs y SPs. Ya esta todo cargado,
   asi que no hay nada que crear y nada puede chocar. Mas abajo, despues de
   SET NOEXEC OFF, SIEMPRE corren los triggers y las migraciones (idempotentes).
   v2: antes miraba solo Usuarios_43BO, y si habia una base vieja a medias (con las
   tablas de seguridad pero sin las del cine) se salteaba todo y fallaban los triggers.
   Ahora, si falta alguna tabla, corre el bloque: cada tabla se crea solo si no existe
   y los datos iniciales se cargan solo si la tabla esta vacia. */
IF (SELECT COUNT(*) FROM sys.tables WHERE schema_id = SCHEMA_ID(N'dbo') AND name IN (
        N'AsientoFuncion_14OR', N'Bitacora_43BO', N'Butaca_14OR', N'Cliente_14OR', N'DV_43BO',
        N'DetalleOrdenCompra_14OR', N'DetallePresupuesto_14OR', N'DetalleVentaCandy_14OR',
        N'Familia_43BO', N'Familia_Familia', N'Funcion_14OR', N'OrdenCompra_14OR', N'Patente_43BO',
        N'Patente_Familia', N'Pelicula_14OR', N'Pelicula_C_14OR', N'Presupuesto_14OR', N'Producto_14OR',
        N'Promocion_14OR', N'Proveedor_14OR', N'Rol_43BO', N'Rol_Familia', N'Rol_Patente', N'Sala_14OR',
        N'Usuarios_43BO', N'VentaCandy_14OR', N'Venta_14OR')) = 27
    SET NOEXEC ON;
GO
/****** Objeto: Table [dbo].[AsientoFuncion_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[AsientoFuncion_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Bitacora_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Bitacora_43BO]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Butaca_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Butaca_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Cliente_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Cliente_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[DetalleOrdenCompra_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[DetalleOrdenCompra_14OR]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[DetalleOrdenCompra_14OR](
	[IdDetalleOrdenCompra_14OR] [int] IDENTITY(1,1) NOT NULL,
	[IdOrdenCompra_14OR] [int] NOT NULL,
	[IdProducto_14OR] [int] NOT NULL,
	[NombreProducto_14OR] [nvarchar](100) NOT NULL,
	[Cantidad_14OR] [int] NOT NULL,
	[PrecioCosto_14OR] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_DetalleOrdenCompra_14OR] PRIMARY KEY CLUSTERED 
(
	[IdDetalleOrdenCompra_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[DetallePresupuesto_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[DetallePresupuesto_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[DetalleVentaCandy_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[DetalleVentaCandy_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[DV_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[DV_43BO]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[DV_43BO](
	[NombreTabla_43BO] [varchar](50) NOT NULL,
	[DVH_43BO] [varchar](100) NOT NULL,
	[DVV_43BO] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NombreTabla_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Familia_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Familia_43BO]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Familia_43BO](
	[IdFamilia_43BO] [int] IDENTITY(1,1) NOT NULL,
	[NombreFamilia_43BO] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Familia_43BO] PRIMARY KEY CLUSTERED 
(
	[IdFamilia_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Familia_Familia] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Familia_Familia]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Familia_Familia](
	[IdFamiliaPadre_43BO] [int] NOT NULL,
	[IdFamiliaHijo_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFamiliaPadre_43BO] ASC,
	[IdFamiliaHijo_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Funcion_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Funcion_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[OrdenCompra_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[OrdenCompra_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Patente_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Patente_43BO]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Patente_43BO](
	[IdPatente_43BO] [int] IDENTITY(1,1) NOT NULL,
	[NombrePatente_43BO] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Patente_43BO] PRIMARY KEY CLUSTERED 
(
	[IdPatente_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Patente_Familia] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Patente_Familia]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Patente_Familia](
	[IdFamilia_43BO] [int] NOT NULL,
	[IdPatente_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFamilia_43BO] ASC,
	[IdPatente_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Pelicula_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Pelicula_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Pelicula_C_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Pelicula_C_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Presupuesto_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Presupuesto_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Producto_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Producto_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Promocion_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Promocion_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Proveedor_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Proveedor_14OR]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Proveedor_14OR](
	[IdProveedor_14OR] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_14OR] [nvarchar](100) NOT NULL,
	[Telefono_14OR] [nvarchar](50) NULL,
	[Email_14OR] [nvarchar](150) NULL,
	[Activo_14OR] [bit] NOT NULL,
 CONSTRAINT [PK_Proveedor_14OR] PRIMARY KEY CLUSTERED 
(
	[IdProveedor_14OR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/* PN2 - CUIT del proveedor (CUN-009). Tambien sirve si la base ya existia */
IF COL_LENGTH(N'dbo.Proveedor_14OR', N'Cuit_14OR') IS NULL
    ALTER TABLE [dbo].[Proveedor_14OR] ADD [Cuit_14OR] [varchar](11) NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UX_Proveedor_Cuit_Activo' AND object_id = OBJECT_ID(N'[dbo].[Proveedor_14OR]'))
    CREATE UNIQUE NONCLUSTERED INDEX [UX_Proveedor_Cuit_Activo]
        ON [dbo].[Proveedor_14OR] ([Cuit_14OR])
        WHERE [Cuit_14OR] IS NOT NULL AND [Activo_14OR] = 1
GO
/****** Objeto: Table [dbo].[Rol_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Rol_43BO]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Rol_43BO](
	[IdRol_43BO] [int] IDENTITY(1,1) NOT NULL,
	[NombreRol_43BO] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Rol_43BO__C5D277CC5292C17E] PRIMARY KEY CLUSTERED 
(
	[IdRol_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Rol_Familia] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Rol_Familia]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Rol_Familia](
	[IdRol_43BO] [int] NOT NULL,
	[IdFamilia_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol_43BO] ASC,
	[IdFamilia_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Rol_Patente] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Rol_Patente]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Rol_Patente](
	[IdRol_43BO] [int] NOT NULL,
	[IdPatente_43BO] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol_43BO] ASC,
	[IdPatente_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto: Table [dbo].[Sala_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Sala_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Usuarios_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Usuarios_43BO]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[Venta_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Venta_14OR]', N'U') IS NULL
BEGIN
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
END
GO
/****** Objeto: Table [dbo].[VentaCandy_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[VentaCandy_14OR]', N'U') IS NULL
BEGIN
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
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[DV_43BO])
BEGIN
/* v3: los dv ya calculados pa la base vacia (catalogos + Sassaroli) */
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'AsientoFuncion_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Bitacora_43BO', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Butaca_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Cliente_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'DetalleOrdenCompra_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'DetallePresupuesto_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'DetalleVentaCandy_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Familia_43BO', N'6420', N'6420')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Familia_Familia', N'201', N'201')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Funcion_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'OrdenCompra_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Patente_43BO', N'89690', N'89690')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Patente_Familia', N'581', N'581')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Pelicula_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Pelicula_C_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Presupuesto_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Producto_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Promocion_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Proveedor_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Rol_43BO', N'9293', N'9293')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Rol_Familia', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Rol_Patente', N'7261', N'7261')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Sala_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'TOTAL_BD_43BO', N'120841', N'120841')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Usuarios_43BO', N'7395', N'7395')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'VentaCandy_14OR', N'0', N'0')
INSERT [dbo].[DV_43BO] ([NombreTabla_43BO], [DVH_43BO], [DVV_43BO]) VALUES (N'Venta_14OR', N'0', N'0')
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Familia_43BO])
BEGIN
SET IDENTITY_INSERT [dbo].[Familia_43BO] ON 

INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (4, N'PatentesVendedor')
INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (13, N'BasicoOperario')
INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (14, N'PatentesBasico')
INSERT [dbo].[Familia_43BO] ([IdFamilia_43BO], [NombreFamilia_43BO]) VALUES (16, N'PatentesGerente')
SET IDENTITY_INSERT [dbo].[Familia_43BO] OFF
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Familia_Familia])
BEGIN
INSERT [dbo].[Familia_Familia] ([IdFamiliaPadre_43BO], [IdFamiliaHijo_43BO]) VALUES (13, 14)
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO])
BEGIN
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
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_Familia])
BEGIN
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (4, 8)
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (13, 7)
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (16, 7)
INSERT [dbo].[Patente_Familia] ([IdFamilia_43BO], [IdPatente_43BO]) VALUES (16, 9)
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_43BO])
BEGIN
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
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente])
BEGIN
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
END
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Usuarios_43BO])
BEGIN
/* v3: base vacia, dejo un solo usuario pa entrar que es Sassaroli como administrador
   con la contraseña de fabrica (dni + apellido), al entrar el menu le pide cambiarla */
SET IDENTITY_INSERT [dbo].[Usuarios_43BO] ON 

INSERT [dbo].[Usuarios_43BO] ([IdUser_43BO], [DNI_43BO], [Nombre_43BO], [Apellido_43BO], [Bloqueado_43BO], [Email_43BO], [Activo_43BO], [Hash_43BO], [Rol_43BO], [Idioma_43BO]) VALUES (1, 46498814, N'Joaquin', N'Sassaroli', 0, N'hola.,com', 1, N'4d486479143cb4342e68a9bb77d327a6621a99e96c19b88089263759383c8961', 1, N'es')
SET IDENTITY_INSERT [dbo].[Usuarios_43BO] OFF
END
GO
/****** Objeto: Index [UQ_DNI] Fecha de script: 27/10/2026 18:42:37 ******/
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = N'UQ_DNI' AND parent_object_id = OBJECT_ID(N'[dbo].[Usuarios_43BO]'))
BEGIN
ALTER TABLE [dbo].[Usuarios_43BO] ADD  CONSTRAINT [UQ_DNI] UNIQUE NONCLUSTERED
(
	[DNI_43BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[AsientoFuncion_14OR]') AND c.name = N'Estado_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR] ADD  DEFAULT ('Libre') FOR [Estado_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[AsientoFuncion_14OR]') AND c.name = N'Ingreso_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR] ADD  DEFAULT ((0)) FOR [Ingreso_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Cliente_14OR]') AND c.name = N'Eliminado_14OR')
BEGIN
ALTER TABLE [dbo].[Cliente_14OR] ADD  CONSTRAINT [DF_Cliente_Eliminado_14OR]  DEFAULT ((0)) FOR [Eliminado_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Producto_14OR]') AND c.name = N'Activo_14OR')
BEGIN
ALTER TABLE [dbo].[Producto_14OR] ADD  CONSTRAINT [DF_Producto_14OR_Activo]  DEFAULT ((1)) FOR [Activo_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Producto_14OR]') AND c.name = N'PrecioCosto_14OR')
BEGIN
ALTER TABLE [dbo].[Producto_14OR] ADD  CONSTRAINT [DF_Producto_PrecioCosto]  DEFAULT ((0)) FOR [PrecioCosto_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Promocion_14OR]') AND c.name = N'Valor_14OR')
BEGIN
ALTER TABLE [dbo].[Promocion_14OR] ADD  CONSTRAINT [DF__Promocion__Valor__4F47C5E3]  DEFAULT ((0)) FOR [Valor_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Promocion_14OR]') AND c.name = N'Activa_14OR')
BEGIN
ALTER TABLE [dbo].[Promocion_14OR] ADD  CONSTRAINT [DF__Promocion__Activ__503BEA1C]  DEFAULT ((1)) FOR [Activa_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Proveedor_14OR]') AND c.name = N'Activo_14OR')
BEGIN
ALTER TABLE [dbo].[Proveedor_14OR] ADD  CONSTRAINT [DF_Proveedor_14OR_Activo]  DEFAULT ((1)) FOR [Activo_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Usuarios_43BO]') AND c.name = N'Bloqueado_43BO')
BEGIN
ALTER TABLE [dbo].[Usuarios_43BO] ADD  CONSTRAINT [DF_Usuarios_43BO_Bloqueado_43BO]  DEFAULT ((0)) FOR [Bloqueado_43BO]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Usuarios_43BO]') AND c.name = N'Activo_43BO')
BEGIN
ALTER TABLE [dbo].[Usuarios_43BO] ADD  CONSTRAINT [DF_Usuarios_43BO_Activo_43BO]  DEFAULT ((1)) FOR [Activo_43BO]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Usuarios_43BO]') AND c.name = N'Idioma_43BO')
BEGIN
ALTER TABLE [dbo].[Usuarios_43BO] ADD  DEFAULT ('es') FOR [Idioma_43BO]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.object_id = dc.parent_object_id AND c.column_id = dc.parent_column_id WHERE dc.parent_object_id = OBJECT_ID(N'[dbo].[Venta_14OR]') AND c.name = N'MontoDescuento_14OR')
BEGIN
ALTER TABLE [dbo].[Venta_14OR] ADD  DEFAULT ((0)) FOR [MontoDescuento_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_AF_Butaca_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_AF_Butaca_14OR] FOREIGN KEY([IdButaca_14OR])
REFERENCES [dbo].[Butaca_14OR] ([IdButaca_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_AF_Butaca_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR] CHECK CONSTRAINT [FK_AF_Butaca_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_AF_Funcion_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_AF_Funcion_14OR] FOREIGN KEY([IdFuncion_14OR])
REFERENCES [dbo].[Funcion_14OR] ([IdFuncion_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_AF_Funcion_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR] CHECK CONSTRAINT [FK_AF_Funcion_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_AF_Venta_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_AF_Venta_14OR] FOREIGN KEY([IdVenta_14OR])
REFERENCES [dbo].[Venta_14OR] ([IdVenta_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_AF_Venta_14OR')
BEGIN
ALTER TABLE [dbo].[AsientoFuncion_14OR] CHECK CONSTRAINT [FK_AF_Venta_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Bitacora_43BO_Usuarios_43BO')
BEGIN
ALTER TABLE [dbo].[Bitacora_43BO]  WITH CHECK ADD  CONSTRAINT [FK_Bitacora_43BO_Usuarios_43BO] FOREIGN KEY([DNIuser_43BO])
REFERENCES [dbo].[Usuarios_43BO] ([DNI_43BO])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Bitacora_43BO_Usuarios_43BO')
BEGIN
ALTER TABLE [dbo].[Bitacora_43BO] CHECK CONSTRAINT [FK_Bitacora_43BO_Usuarios_43BO]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Butaca_14OR_Sala_14OR')
BEGIN
ALTER TABLE [dbo].[Butaca_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Butaca_14OR_Sala_14OR] FOREIGN KEY([IdSala_14OR])
REFERENCES [dbo].[Sala_14OR] ([IdSala_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Butaca_14OR_Sala_14OR')
BEGIN
ALTER TABLE [dbo].[Butaca_14OR] CHECK CONSTRAINT [FK_Butaca_14OR_Sala_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetOrden_Orden')
BEGIN
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetOrden_Orden] FOREIGN KEY([IdOrdenCompra_14OR])
REFERENCES [dbo].[OrdenCompra_14OR] ([IdOrdenCompra_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetOrden_Orden')
BEGIN
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] CHECK CONSTRAINT [FK_DetOrden_Orden]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetOrden_Producto')
BEGIN
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetOrden_Producto] FOREIGN KEY([IdProducto_14OR])
REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetOrden_Producto')
BEGIN
ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] CHECK CONSTRAINT [FK_DetOrden_Producto]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetPresu_Presupuesto')
BEGIN
ALTER TABLE [dbo].[DetallePresupuesto_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetPresu_Presupuesto] FOREIGN KEY([IdPresupuesto_14OR])
REFERENCES [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetPresu_Presupuesto')
BEGIN
ALTER TABLE [dbo].[DetallePresupuesto_14OR] CHECK CONSTRAINT [FK_DetPresu_Presupuesto]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetPresu_Producto')
BEGIN
ALTER TABLE [dbo].[DetallePresupuesto_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetPresu_Producto] FOREIGN KEY([IdProducto_14OR])
REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetPresu_Producto')
BEGIN
ALTER TABLE [dbo].[DetallePresupuesto_14OR] CHECK CONSTRAINT [FK_DetPresu_Producto]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetVentaCandy_Producto')
BEGIN
ALTER TABLE [dbo].[DetalleVentaCandy_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetVentaCandy_Producto] FOREIGN KEY([IdProducto_14OR])
REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetVentaCandy_Producto')
BEGIN
ALTER TABLE [dbo].[DetalleVentaCandy_14OR] CHECK CONSTRAINT [FK_DetVentaCandy_Producto]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetVentaCandy_Venta')
BEGIN
ALTER TABLE [dbo].[DetalleVentaCandy_14OR]  WITH CHECK ADD  CONSTRAINT [FK_DetVentaCandy_Venta] FOREIGN KEY([IdVentaCandy_14OR])
REFERENCES [dbo].[VentaCandy_14OR] ([IdVentaCandy_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DetVentaCandy_Venta')
BEGIN
ALTER TABLE [dbo].[DetalleVentaCandy_14OR] CHECK CONSTRAINT [FK_DetVentaCandy_Venta]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Familia_F__IdFam__2BFE89A6')
BEGIN
ALTER TABLE [dbo].[Familia_Familia]  WITH CHECK ADD  CONSTRAINT [FK__Familia_F__IdFam__2BFE89A6] FOREIGN KEY([IdFamiliaPadre_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Familia_F__IdFam__2BFE89A6')
BEGIN
ALTER TABLE [dbo].[Familia_Familia] CHECK CONSTRAINT [FK__Familia_F__IdFam__2BFE89A6]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Familia_F__IdFam__2CF2ADDF')
BEGIN
ALTER TABLE [dbo].[Familia_Familia]  WITH CHECK ADD  CONSTRAINT [FK__Familia_F__IdFam__2CF2ADDF] FOREIGN KEY([IdFamiliaHijo_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Familia_F__IdFam__2CF2ADDF')
BEGIN
ALTER TABLE [dbo].[Familia_Familia] CHECK CONSTRAINT [FK__Familia_F__IdFam__2CF2ADDF]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Funcion_14OR_Pelicula_14OR')
BEGIN
ALTER TABLE [dbo].[Funcion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Funcion_14OR_Pelicula_14OR] FOREIGN KEY([IdPelicula_14OR])
REFERENCES [dbo].[Pelicula_14OR] ([IdPelicula_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Funcion_14OR_Pelicula_14OR')
BEGIN
ALTER TABLE [dbo].[Funcion_14OR] CHECK CONSTRAINT [FK_Funcion_14OR_Pelicula_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Funcion_14OR_Sala_14OR')
BEGIN
ALTER TABLE [dbo].[Funcion_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Funcion_14OR_Sala_14OR] FOREIGN KEY([IdSala_14OR])
REFERENCES [dbo].[Sala_14OR] ([IdSala_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Funcion_14OR_Sala_14OR')
BEGIN
ALTER TABLE [dbo].[Funcion_14OR] CHECK CONSTRAINT [FK_Funcion_14OR_Sala_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_OrdenCompra_Presupuesto')
BEGIN
ALTER TABLE [dbo].[OrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_OrdenCompra_Presupuesto] FOREIGN KEY([IdPresupuesto_14OR])
REFERENCES [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_OrdenCompra_Presupuesto')
BEGIN
ALTER TABLE [dbo].[OrdenCompra_14OR] CHECK CONSTRAINT [FK_OrdenCompra_Presupuesto]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_OrdenCompra_Proveedor')
BEGIN
ALTER TABLE [dbo].[OrdenCompra_14OR]  WITH CHECK ADD  CONSTRAINT [FK_OrdenCompra_Proveedor] FOREIGN KEY([IdProveedor_14OR])
REFERENCES [dbo].[Proveedor_14OR] ([IdProveedor_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_OrdenCompra_Proveedor')
BEGIN
ALTER TABLE [dbo].[OrdenCompra_14OR] CHECK CONSTRAINT [FK_OrdenCompra_Proveedor]
END
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
ALTER TABLE [dbo].[Patente_Familia]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Presupuesto_Proveedor')
BEGIN
ALTER TABLE [dbo].[Presupuesto_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Presupuesto_Proveedor] FOREIGN KEY([IdProveedor_14OR])
REFERENCES [dbo].[Proveedor_14OR] ([IdProveedor_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Presupuesto_Proveedor')
BEGIN
ALTER TABLE [dbo].[Presupuesto_14OR] CHECK CONSTRAINT [FK_Presupuesto_Proveedor]
END
GO
ALTER TABLE [dbo].[Rol_Familia]  WITH CHECK ADD FOREIGN KEY([IdFamilia_43BO])
REFERENCES [dbo].[Familia_43BO] ([IdFamilia_43BO])
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Rol_Famil__IdRol__245D67DE')
BEGIN
ALTER TABLE [dbo].[Rol_Familia]  WITH CHECK ADD  CONSTRAINT [FK__Rol_Famil__IdRol__245D67DE] FOREIGN KEY([IdRol_43BO])
REFERENCES [dbo].[Rol_43BO] ([IdRol_43BO])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Rol_Famil__IdRol__245D67DE')
BEGIN
ALTER TABLE [dbo].[Rol_Familia] CHECK CONSTRAINT [FK__Rol_Famil__IdRol__245D67DE]
END
GO
ALTER TABLE [dbo].[Rol_Patente]  WITH NOCHECK ADD FOREIGN KEY([IdPatente_43BO])
REFERENCES [dbo].[Patente_43BO] ([IdPatente_43BO])
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Rol_Paten__IdRol__1EA48E88')
BEGIN
ALTER TABLE [dbo].[Rol_Patente]  WITH NOCHECK ADD  CONSTRAINT [FK__Rol_Paten__IdRol__1EA48E88] FOREIGN KEY([IdRol_43BO])
REFERENCES [dbo].[Rol_43BO] ([IdRol_43BO])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK__Rol_Paten__IdRol__1EA48E88')
BEGIN
ALTER TABLE [dbo].[Rol_Patente] CHECK CONSTRAINT [FK__Rol_Paten__IdRol__1EA48E88]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Usuarios_43BO_Rol_43BO')
BEGIN
ALTER TABLE [dbo].[Usuarios_43BO]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_43BO_Rol_43BO] FOREIGN KEY([Rol_43BO])
REFERENCES [dbo].[Rol_43BO] ([IdRol_43BO])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Usuarios_43BO_Rol_43BO')
BEGIN
ALTER TABLE [dbo].[Usuarios_43BO] CHECK CONSTRAINT [FK_Usuarios_43BO_Rol_43BO]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Venta_14OR_Cliente_14OR')
BEGIN
ALTER TABLE [dbo].[Venta_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Venta_14OR_Cliente_14OR] FOREIGN KEY([IdCliente_14OR])
REFERENCES [dbo].[Cliente_14OR] ([IdCliente_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Venta_14OR_Cliente_14OR')
BEGIN
ALTER TABLE [dbo].[Venta_14OR] CHECK CONSTRAINT [FK_Venta_14OR_Cliente_14OR]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Venta_Promocion_14OR')
BEGIN
ALTER TABLE [dbo].[Venta_14OR]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Promocion_14OR] FOREIGN KEY([IdPromocion_14OR])
REFERENCES [dbo].[Promocion_14OR] ([IdPromocion_14OR])
END
GO
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_Venta_Promocion_14OR')
BEGIN
ALTER TABLE [dbo].[Venta_14OR] CHECK CONSTRAINT [FK_Venta_Promocion_14OR]
END
GO
/****** Objeto: StoredProcedure [dbo].[DesvincularComponente_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[DesvincularComponente_43BO]
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
/****** Objeto: StoredProcedure [dbo].[EliminarComponente_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[EliminarComponente_43BO]
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
/****** Objeto: StoredProcedure [dbo].[InsertarComponente_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[InsertarComponente_43BO]
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
/****** Objeto: StoredProcedure [dbo].[ListarTodo_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[ListarTodo_43BO]
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
/****** Objeto: StoredProcedure [dbo].[ModificarNombreComponente_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[ModificarNombreComponente_43BO]
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
/****** Objeto: StoredProcedure [dbo].[ObtenerComponentesHijos_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[ObtenerComponentesHijos_43BO]
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
/****** Objeto: StoredProcedure [dbo].[ObtenerIdsPermisosPorRol_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[ObtenerIdsPermisosPorRol_43BO]
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
/****** Objeto: StoredProcedure [dbo].[sp_RollbackPelicula_14OR] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_RollbackPelicula_14OR]
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
/****** Objeto: StoredProcedure [dbo].[VincularComponente_43BO] Fecha de script: 27/10/2026 18:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. CORRECCIÓN AL SP DE VINCULACIÓN
CREATE OR ALTER PROCEDURE [dbo].[VincularComponente_43BO]
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

/* Fin del bloque que se saltea en bases ya instaladas. De aca en adelante
   SIEMPRE se ejecuta (triggers y migraciones son idempotentes). */
SET NOEXEC OFF;
GO

/* ======================= TRIGGERS Bitacora de Cambios ======================= */
/* (no vienen en el export de SMO; se recrean siempre con DROP + CREATE) */

IF OBJECT_ID(N'[dbo].[trg_Pelicula_C_Insert_14OR]', N'TR') IS NOT NULL
    DROP TRIGGER [dbo].[trg_Pelicula_C_Insert_14OR]
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

IF OBJECT_ID(N'[dbo].[trg_Pelicula_C_Update_14OR]', N'TR') IS NOT NULL
    DROP TRIGGER [dbo].[trg_Pelicula_C_Update_14OR]
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

IF OBJECT_ID(N'[dbo].[trg_Pelicula_C_Delete_14OR]', N'TR') IS NOT NULL
    DROP TRIGGER [dbo].[trg_Pelicula_C_Delete_14OR]
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

/* ============================ MIGRACIONES ============================
   Cosas que deben existir SIEMPRE, aunque la base ya estuviera cargada
   de una version anterior. Aca van, a futuor:
     - columnas nuevas:  IF COL_LENGTH(N'[dbo].[Tabla]', N'Col') IS NULL
                         ALTER TABLE [dbo].[Tabla] ADD [Col] <tipo> ...;
     - datos de referencia nuevos: INSERT guardado por clave (como los de abajo)
   ==================================================================== */

/* -- Permisos (patentes) de PN2 / Candy / Auditoria y su asignacion al Admin -- */
SET IDENTITY_INSERT [dbo].[Patente_43BO] ON
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE IdPatente_43BO = 32) INSERT [dbo].[Patente_43BO] (IdPatente_43BO, NombrePatente_43BO) VALUES (32, N'Compra_Productos_Acceso');
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE IdPatente_43BO = 33) INSERT [dbo].[Patente_43BO] (IdPatente_43BO, NombrePatente_43BO) VALUES (33, N'Compra_Proveedores_Acceso');
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE IdPatente_43BO = 34) INSERT [dbo].[Patente_43BO] (IdPatente_43BO, NombrePatente_43BO) VALUES (34, N'Venta_CandyBar_Acceso');
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE IdPatente_43BO = 35) INSERT [dbo].[Patente_43BO] (IdPatente_43BO, NombrePatente_43BO) VALUES (35, N'Compra_Presupuestos_Acceso');
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE IdPatente_43BO = 36) INSERT [dbo].[Patente_43BO] (IdPatente_43BO, NombrePatente_43BO) VALUES (36, N'Compra_OrdenesCompra_Acceso');
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE IdPatente_43BO = 37) INSERT [dbo].[Patente_43BO] (IdPatente_43BO, NombrePatente_43BO) VALUES (37, N'Maestro_AuditoriaCambios_Acceso');
SET IDENTITY_INSERT [dbo].[Patente_43BO] OFF
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 1 AND IdPatente_43BO = 32) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (1, 32);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 1 AND IdPatente_43BO = 33) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (1, 33);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 1 AND IdPatente_43BO = 34) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (1, 34);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 1 AND IdPatente_43BO = 35) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (1, 35);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 1 AND IdPatente_43BO = 36) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (1, 36);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 1 AND IdPatente_43BO = 37) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (1, 37);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE IdRol_43BO = 9 AND IdPatente_43BO = 34) INSERT [dbo].[Rol_Patente] (IdRol_43BO, IdPatente_43BO) VALUES (9, 34);
GO

/* -- v2: CUN-011 Recibir mercaderia compara lo recibido contra la orden -- */
/* la columna arranca en NULL (= todavia no se recibio). No relleno datos viejos a proposito:
   una columna en NULL no cambia el digito verificador, asi la base no queda "inconsistente". */
IF COL_LENGTH(N'[dbo].[DetalleOrdenCompra_14OR]', N'CantidadRecibida_14OR') IS NULL
    ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] ADD [CantidadRecibida_14OR] INT NULL;
GO

PRINT 'DEPLOY_OK';
GO
