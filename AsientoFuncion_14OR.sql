-- OJO: AsientoFuncion_14OR NO lleva IDENTITY en ninguna columna.
-- su clave primaria es la combinacion (IdFuncion_14OR + IdButaca_14OR), y esos dos son
-- claves foraneas (apuntan a una funcion y una butaca que YA existen), no numeros que genera
-- la base. si alguna de esas dos quedo marcada como IDENTITY, al generar los asientos salta
-- "Cannot insert explicit value for identity column ... when IDENTITY_INSERT is set to OFF".
--
-- como la tabla esta vacia, la borro y la recreo bien (sin identity).

IF OBJECT_ID('AsientoFuncion_14OR', 'U') IS NOT NULL
    DROP TABLE AsientoFuncion_14OR;

CREATE TABLE AsientoFuncion_14OR (
    IdFuncion_14OR  INT NOT NULL,
    IdButaca_14OR   INT NOT NULL,
    IdVenta_14OR    INT NULL,               -- una reserva sin cobrar todavia no tiene venta => NULL
    Estado_14OR     VARCHAR(15) NOT NULL DEFAULT 'Libre',
    Ingreso_14OR    BIT NOT NULL DEFAULT 0,
    CONSTRAINT PK_AsientoFuncion_14OR PRIMARY KEY (IdFuncion_14OR, IdButaca_14OR),
    CONSTRAINT FK_AF_Funcion_14OR FOREIGN KEY (IdFuncion_14OR) REFERENCES Funcion_14OR(IdFuncion_14OR),
    CONSTRAINT FK_AF_Butaca_14OR  FOREIGN KEY (IdButaca_14OR)  REFERENCES Butaca_14OR(IdButaca_14OR),
    CONSTRAINT FK_AF_Venta_14OR   FOREIGN KEY (IdVenta_14OR)   REFERENCES Venta_14OR(IdVenta_14OR)
);
