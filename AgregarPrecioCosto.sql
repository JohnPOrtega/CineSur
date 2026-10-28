/* ============================================================================
   PN2 - Precio de costo de referencia en Producto (para cotizaciones con sentido)
   Agrega la columna PrecioCosto_14OR y le pone un costo de referencia a los
   productos de ejemplo (siempre menor al precio de venta).

   Ejecutar UNA sloa vez sobre Ing.Software. Idempotente.
   Ctrl+A antes de F5 para correr TODO.

   DV: tras correrlo, en el proximo login la app avisa que el DV quedo
   desactualizado (cambio la tabla Producto). Es lo esperado: Admin -> Recalcular DV.
   ============================================================================ */

USE [Ing.Software]
GO

/* columna nueva (default 0 para los que ya existen) */
IF NOT EXISTS (SELECT * FROM sys.columns
               WHERE object_id = OBJECT_ID(N'[dbo].[Producto_14OR]') AND name = 'PrecioCosto_14OR')
BEGIN
    ALTER TABLE [dbo].[Producto_14OR]
        ADD [PrecioCosto_14OR] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Producto_PrecioCosto] DEFAULT (0)
END
GO

/* costos de referencia pa los productos de ejemplo (menores al precio de venta).
   Solo pisa los que todavia estan en 0, asi no te cambio costos que ya hayas cargado a mano. */
UPDATE [dbo].[Producto_14OR] SET [PrecioCosto_14OR] = 1200 WHERE [Nombre_14OR] = N'Pochoclos grande'          AND [PrecioCosto_14OR] = 0
UPDATE [dbo].[Producto_14OR] SET [PrecioCosto_14OR] =  700 WHERE [Nombre_14OR] = N'Pochoclos chico'           AND [PrecioCosto_14OR] = 0
UPDATE [dbo].[Producto_14OR] SET [PrecioCosto_14OR] =  900 WHERE [Nombre_14OR] = N'Gaseosa 500ml'             AND [PrecioCosto_14OR] = 0
UPDATE [dbo].[Producto_14OR] SET [PrecioCosto_14OR] = 2000 WHERE [Nombre_14OR] = N'Combo pochoclos + gaseosa' AND [PrecioCosto_14OR] = 0
GO
