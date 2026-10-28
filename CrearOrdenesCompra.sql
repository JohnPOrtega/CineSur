/* ============================================================================
   PN2 - Presupuestos y Ordenes de Compra (Tanda A)
   Tablas: Presupuesto_14OR + DetallePresupuesto_14OR,
           OrdenCompra_14OR + DetalleOrdenCompra_14OR.
   Patentes: acceso a Presupuestos (35) y a Ordenes de Compra (36).

   Ejecutar UNA sola vez sobre Ing.Software. Idempotente (IF NOT EXISTS).
   IMPORTANTE: Ctrl+A para seleccionar TODO antes de F5 (si no, corre solo lo seleccionado).

   DV: despues de correrlo, en el proximo login la app avisa que el digito verificador
   quedo desactualizado (tablas nuevas). Es lo esperado: entra como Administrador y Recalcular DV.
   ============================================================================ */

USE [Ing.Software]
GO

/* -------------------- Presupuesto (cotizacion) -------------------- */
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Presupuesto_14OR]') AND type = N'U')
BEGIN
    CREATE TABLE [dbo].[Presupuesto_14OR](
        [IdPresupuesto_14OR]     [int] IDENTITY(1,1) NOT NULL,
        [NumeroPresupuesto_14OR] [int] NOT NULL,
        [IdProveedor_14OR]       [int] NOT NULL,
        [FechaPedido_14OR]       [date] NOT NULL,
        [Estado_14OR]            [nvarchar](20) NOT NULL,
        CONSTRAINT [PK_Presupuesto_14OR] PRIMARY KEY CLUSTERED ([IdPresupuesto_14OR] ASC)
    ) ON [PRIMARY]

    ALTER TABLE [dbo].[Presupuesto_14OR] WITH CHECK ADD CONSTRAINT [FK_Presupuesto_Proveedor]
        FOREIGN KEY([IdProveedor_14OR]) REFERENCES [dbo].[Proveedor_14OR] ([IdProveedor_14OR])
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DetallePresupuesto_14OR]') AND type = N'U')
BEGIN
    CREATE TABLE [dbo].[DetallePresupuesto_14OR](
        [IdDetallePresupuesto_14OR] [int] IDENTITY(1,1) NOT NULL,
        [IdPresupuesto_14OR]        [int] NOT NULL,
        [IdProducto_14OR]           [int] NOT NULL,
        [NombreProducto_14OR]       [nvarchar](100) NOT NULL,
        [Cantidad_14OR]             [int] NOT NULL,
        [PrecioCotizado_14OR]       [decimal](18, 2) NOT NULL,
        CONSTRAINT [PK_DetallePresupuesto_14OR] PRIMARY KEY CLUSTERED ([IdDetallePresupuesto_14OR] ASC)
    ) ON [PRIMARY]

    ALTER TABLE [dbo].[DetallePresupuesto_14OR] WITH CHECK ADD CONSTRAINT [FK_DetPresu_Presupuesto]
        FOREIGN KEY([IdPresupuesto_14OR]) REFERENCES [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR])

    ALTER TABLE [dbo].[DetallePresupuesto_14OR] WITH CHECK ADD CONSTRAINT [FK_DetPresu_Producto]
        FOREIGN KEY([IdProducto_14OR]) REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
END
GO

/* -------------------- Orden de Compra -------------------- */
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrdenCompra_14OR]') AND type = N'U')
BEGIN
    CREATE TABLE [dbo].[OrdenCompra_14OR](
        [IdOrdenCompra_14OR] [int] IDENTITY(1,1) NOT NULL,
        [NumeroOrden_14OR]   [int] NOT NULL,
        [IdProveedor_14OR]   [int] NOT NULL,
        [IdPresupuesto_14OR] [int] NOT NULL,
        [FechaEmision_14OR]  [date] NOT NULL,
        [Estado_14OR]        [nvarchar](20) NOT NULL,
        [Importe_14OR]       [decimal](18, 2) NOT NULL,
        [FechaPago_14OR]     [datetime] NULL,
        [NumeroRemito_14OR]  [nvarchar](50) NULL,
        [FechaRecepcion_14OR][datetime] NULL,
        CONSTRAINT [PK_OrdenCompra_14OR] PRIMARY KEY CLUSTERED ([IdOrdenCompra_14OR] ASC)
    ) ON [PRIMARY]

    ALTER TABLE [dbo].[OrdenCompra_14OR] WITH CHECK ADD CONSTRAINT [FK_OrdenCompra_Proveedor]
        FOREIGN KEY([IdProveedor_14OR]) REFERENCES [dbo].[Proveedor_14OR] ([IdProveedor_14OR])

    ALTER TABLE [dbo].[OrdenCompra_14OR] WITH CHECK ADD CONSTRAINT [FK_OrdenCompra_Presupuesto]
        FOREIGN KEY([IdPresupuesto_14OR]) REFERENCES [dbo].[Presupuesto_14OR] ([IdPresupuesto_14OR])
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DetalleOrdenCompra_14OR]') AND type = N'U')
BEGIN
    CREATE TABLE [dbo].[DetalleOrdenCompra_14OR](
        [IdDetalleOrdenCompra_14OR] [int] IDENTITY(1,1) NOT NULL,
        [IdOrdenCompra_14OR]        [int] NOT NULL,
        [IdProducto_14OR]           [int] NOT NULL,
        [NombreProducto_14OR]       [nvarchar](100) NOT NULL,
        [Cantidad_14OR]             [int] NOT NULL,
        [PrecioCosto_14OR]          [decimal](18, 2) NOT NULL,
        CONSTRAINT [PK_DetalleOrdenCompra_14OR] PRIMARY KEY CLUSTERED ([IdDetalleOrdenCompra_14OR] ASC)
    ) ON [PRIMARY]

    ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] WITH CHECK ADD CONSTRAINT [FK_DetOrden_Orden]
        FOREIGN KEY([IdOrdenCompra_14OR]) REFERENCES [dbo].[OrdenCompra_14OR] ([IdOrdenCompra_14OR])

    ALTER TABLE [dbo].[DetalleOrdenCompra_14OR] WITH CHECK ADD CONSTRAINT [FK_DetOrden_Producto]
        FOREIGN KEY([IdProducto_14OR]) REFERENCES [dbo].[Producto_14OR] ([IdProducto_14OR])
END
GO

/* -------------------- Patentes (35 Presupuestos, 36 Ordenes) -------------------- */
SET IDENTITY_INSERT [dbo].[Patente_43BO] ON

IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE [IdPatente_43BO] = 35)
    INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (35, N'Compra_Presupuestos_Acceso')

IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE [IdPatente_43BO] = 36)
    INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (36, N'Compra_OrdenesCompra_Acceso')

SET IDENTITY_INSERT [dbo].[Patente_43BO] OFF
GO

/* -------------------- Asignacion al Administrador (rol 1) -------------------- */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE [IdRol_43BO] = 1 AND [IdPatente_43BO] = 35)
    INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 35)

IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE [IdRol_43BO] = 1 AND [IdPatente_43BO] = 36)
    INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 36)
GO
