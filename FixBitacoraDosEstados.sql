/* ============================================================================
   FIX Bitacora de Cambios: guardar SOLO 2 estados por pelicula
   (el anterior -> Act=0, y el actual -> Act=1). Las versiones mas viejas se
   descartan en cada cambio.

   - Reescribe los triggers de UPDATE y DELETE para que, antes de registrar la
     nueva version, borren la version vieja que ya estaba en Act=0.
   - Limpia las filas de mas que ya quedaron (deja, por pelicula, la vigente +
     la ultima no-vigente).

   Ejecutar UNA vez sobre Ing.Software. Ctrl+A -> F5.
   DV: despues, Admin -> Recalcular DV (cambiaron filas del historico).
   ============================================================================ */

USE [Ing.Software]
GO

/* -------- Trigger de MODIFICACION: deja solo anterior + actual -------- */
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

    -- borro la version vieja anterior (la que ya estaba en Act=0), para quedarme con 2 estados
    DELETE c
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN inserted i ON i.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 0;

    -- la que estaba vigente pasa a ser la "anterior"
    UPDATE c SET c.Act_14OR = 0
    FROM [dbo].[Pelicula_C_14OR] c
    INNER JOIN inserted i ON i.IdPelicula_14OR = c.IdPelicula_14OR
    WHERE c.Act_14OR = 1;

    -- registro la nueva version vigente
    INSERT INTO [dbo].[Pelicula_C_14OR]
        (IdPelicula_14OR, Titulo_14OR, Genero_14OR, Duracion_14OR, Poster_14OR, Act_14OR, TipoCambio_14OR, FechaHora_14OR)
    SELECT i.IdPelicula_14OR, i.Titulo_14OR, i.Genero_14OR, i.Duracion_14OR, i.Poster_14OR, 1, N'Modificacion', GETDATE()
    FROM inserted i;
END
GO

/* -------- Trigger de BAJA: deja 1 registro recuperable (Act=0) -------- */
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

    -- borro la evrsion vieja anterior
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

/* -------- Limpieza de lo que ya quedaba de mas (deja vigente + la ultima no-vigente) -------- */
;WITH viejos AS (
    SELECT IdCambio_14OR,
           ROW_NUMBER() OVER (PARTITION BY IdPelicula_14OR ORDER BY IdCambio_14OR DESC) AS rn
    FROM [dbo].[Pelicula_C_14OR]
    WHERE Act_14OR = 0
)
DELETE FROM [dbo].[Pelicula_C_14OR]
WHERE IdCambio_14OR IN (SELECT IdCambio_14OR FROM viejos WHERE rn > 1);
GO
