-- agrega la columna donde guardo la distribucion de pasillos de cada sala.
-- guardo las columnas que tienen pasillo a la derecha, separadas por coma (ej "4,12").
-- puede quedar en null si la sala no tiene pasillos.
-- (sin IDENTITY ni nada raro, es solo una columna de texto)

ALTER TABLE Sala_14OR ADD Pasillos_14OR VARCHAR(100) NULL;
