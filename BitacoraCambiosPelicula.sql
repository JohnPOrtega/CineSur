/* ============================================================================
   BITACORA DE CAMBIOS sobre la tabla Pelicula_14OR
   (distinta de la Bitacora de EVENTOS; esta guarda el HISTORICO de los datos).

   Modelo (como el PRODUCTOS / PRODUCTOS_C del enunciado):
   - Pelicula_14OR  = tabla "viva": solo el estado actual de cada pelicula.
   - Pelicula_C_14OR = tbala espejo: TODAS las versiones por las que paso cada
     pelicula. El atributo Act_14OR marca la version vigente (solo una en 1 por
     pelicula). Mantenida 100% por TRIGGERS.
   - El Rollback (reactivar una version historica como ACTIVA) lo hace el SP
     sp_RollbackPelicula_14OR, que suprime los triggers con SESSION_CONTEXT para
     no duplicar filas y deja el historico consistente.

   Ejecutar UNA sola vez sobre Ing.Software. Idempotente. Ctrl+A -> F5.
   DV: tras correrlo, en el proximo login la app avisa DV desactualizado
   (tabla nueva + backfill). Es lo esperado: Admin -> Recalcular DV.
   ============================================================================ */

USE [Ing.Software]
GO

/* -------------------- Tabla espjeo (historico de cambios) -------------------- */
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pelicula_C_14OR]') AND type = N'U')
BEGIN
    CREATE TABLE [dbo].[Pelicula_C_14OR](
        [IdCambio_14OR]    [int] IDENTITY(1,1) NOT NULL,   -- id de la fila de historico
        [IdPelicula_14OR]  [int] NOT NULL,                 -- clave de negocio (la pelicula)
        [Titulo_14OR]      [nvarchar](200) NULL,
        [Genero_14OR]      [nvarchar](200) NULL,
        [Duracion_14OR]    [int] NULL,
        [Poster_14OR]      [nvarchar](260) NULL,
        [Act_14OR]         [bit] NOT NULL,                 -- 1 = version vigente, 0 = historica
        [TipoCambio_14OR]  [nvarchar](20) NOT NULL,        -- Alta / Modificacion / Baja
        [FechaHora_14OR]   [datetime] NOT NULL,            -- cuando ocurrio el cambio
        CONSTRAINT [PK_Pelicula_C_14OR] PRIMARY KEY CLUSTERED ([IdCambio_14OR] ASC)
    ) ON [PRIMARY]
END
GO

/* -------------------- Backfill: version inicial de las pelis que ya existen -------------------- */
/* asi cada pelicula actual arranca con una version vigente en el historico */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Pelicula_C_14OR])
BEGIN
    INSERT INTO [dbo].[Pelicula_C_14OR]
        (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR)
    SELECT IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, 1, N'Alta', GETDATE()
    FROM [dbo].[Pelicula_14OR]
END
GO

/* -------------------- Trigger de ALTA -------------------- */
IF OBJECT_ID(N'[dbo].[trg_Pelicula_C_Insert_14OR]', N'TR') IS NOT NULL
    DROP TRIGGER [dbo].[trg_Pelicula_C_Insert_14OR]
GO
CREATE TRIGGER [dbo].[trg_Pelicula_C_Insert_14OR]
ON [dbo].[Pelicula_14OR]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- si estamos dentro de un rollback, el SP maneja el historico a mano: no hago nada
    IF SESSION_CONTEXT(N'rollback') = 1 RETURN;

    INSERT INTO [dbo].[Pelicula_C_14OR]
        (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR)
    SELECT i.IdPelicula_14OR, i.Titulo_14OR, i.Genero_14OR, i.Duracion_14OR, i.Poster_14OR, 1, N'Alta', GETDATE()
    FROM inserted i;
END
GO

/* -------------------- Trigger de MODIFICACION -------------------- */
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

    -- solo guardo 2 estados: borro la version vieja anterior (la que ya estaba en Act=0)
    DELETE c
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN inserted i ON i.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 0;

    -- la version que estaba vigente pasa a ser la "anterior"
    UPDATE c SET c.Act_14OR = 0
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN inserted i ON i.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 1;

    -- queda registrada la nueva vesrion como vigente
    INSERT INTO [dbo].[Pelicula_C_14OR]
        (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR)
    SELECT i.IdPelicula_14OR, i.Titulo_14OR, i.Genero_14OR, i.Duracion_14OR, i.Poster_14OR, 1, N'Modificacion', GETDATE()
    FROM inserted i;
END
GO

/* -------------------- Trigger de BAJA -------------------- */
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

    -- solo guardo 2 estados: borro la version vieja anterior
    DELETE c
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN deleted d ON d.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 0;

    -- la que estaba vigente queda como UNICO registro recuperable (Act=0, marcada Baja)
    UPDATE c SET c.Act_14OR = 0, c.TipoCambio_14OR = N'Baja', c.FechaHora_14OR = GETDATE()
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN deleted d ON d.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 1;
END
GO

/* -------------------- SP de Rollback (reactivar una version historica) -------------------- */
IF OBJECT_ID(N'[dbo].[sp_RollbackPelicula_14OR]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_RollbackPelicula_14OR]
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

        -- en el historico: todsa las versiones de esta pelicula pasan a 0, y la elegida a 1
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

/* -------------------- Patente de acceso a la Auditoria de Cambios (37) -------------------- */
SET IDENTITY_INSERT [dbo].[Patente_43BO] ON

IF NOT EXISTS (SELECT 1 FROM [dbo].[Patente_43BO] WHERE [IdPatente_43BO] = 37)
    INSERT [dbo].[Patente_43BO] ([IdPatente_43BO], [NombrePatente_43BO]) VALUES (37, N'Maestro_AuditoriaCambios_Acceso')

SET IDENTITY_INSERT [dbo].[Patente_43BO] OFF
GO

/* al Administrador (1) y, si queres, al rol de Supervisor que uses, se asigna desde Gestion de Perfiles */
IF NOT EXISTS (SELECT 1 FROM [dbo].[Rol_Patente] WHERE [IdRol_43BO] = 1 AND [IdPatente_43BO] = 37)
    INSERT [dbo].[Rol_Patente] ([IdRol_43BO], [IdPatente_43BO]) VALUES (1, 37)
GO
