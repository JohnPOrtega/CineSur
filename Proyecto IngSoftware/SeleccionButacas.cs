using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Pantalla 3 del CUN-001 (el corazon): el mapa de butacas de la funcion + el resumen.
    // el resumen (labels y botones) y el panel del mapa estan en el disenador (SeleccionButacas.Designer.cs).
    // el mapa en si (MapaButacas_14OR) se crea aca por codigo adentro de panelMapa, porque sus botones
    // son dinamicos (uno por butaca) y hay que engancharle el evento de click.
    public partial class SeleccionButacas : Form
    {
        private BllAsientoFuncion_14OR bllAF = new BllAsientoFuncion_14OR();
        private BllVenta_14OR bllVenta = new BllVenta_14OR();
        private BllFuncion_14OR bllFuncion = new BllFuncion_14OR();
        private BllSala_14OR bllSala = new BllSala_14OR();

        private Funcion_14OR funcion;
        private double precioUnit;
        private List<int> pasillos = new List<int>();

        // las celdas que le paso al mapa (las mantengo en memoria para ir prendiendo/apagando la seleccion)
        private List<CeldaMapa_14OR> celdas = new List<CeldaMapa_14OR>();

        // el mapa NO va en el disenador: se crea aca y se mete adentro de panelMapa
        private MapaButacas_14OR mapa;

        public SeleccionButacas(Funcion_14OR f)
        {
            this.funcion = f;
            this.precioUnit = bllFuncion.CalcularPrecioFinal_14OR(f);

            InitializeComponent();

            // titulo de la ventana y precio unitario salen de la funcion (datos en runtime)
            this.Text = "Butacas - " + funcion.Pelicula.Titulo_14OR + " - Sala " + funcion.Sala.Numero_14OR +
                        " - " + funcion.Fecha_14OR.ToString("dd/MM") + " " + funcion.Horario_14OR.ToString("HH:mm");
            lblPrecioUnit.Text = "Precio unitario: $ " + precioUnit.ToString("0");

            // creo el mapa por codigo y lo meto en el panel que esta en el disenador
            mapa = new MapaButacas_14OR();
            mapa.Dock = DockStyle.Fill;
            mapa.AutoScroll = true;
            mapa.BackColor = Color.FromArgb(25, 27, 34);
            mapa.ButacaClickeada += Mapa_ButacaClickeada_14OR;
            panelMapa.Controls.Add(mapa);

            CargarPasillos_14OR();
            RecargarMapa_14OR();
        }

        // los pasillos son propios de la sala; los busco para dibujar el mapa igual que en "Ver distribucion"
        private void CargarPasillos_14OR()
        {
            try
            {
                Sala_14OR sala = bllSala.Listar_14OR().FirstOrDefault(s => s.IdSala_14OR == funcion.Sala.IdSala_14OR);
                if (sala != null && !string.IsNullOrWhiteSpace(sala.Pasillos_14OR))
                {
                    foreach (string parte in sala.Pasillos_14OR.Split(','))
                    {
                        int n;
                        if (int.TryParse(parte.Trim(), out n) && n > 0)
                            pasillos.Add(n);
                    }
                }
            }
            catch { }
        }

        // trae el mapa de la funcion (generando los asientos si es la primera vez) y lo dibuja.
        // lo llamo al abrir y despues de reservar o de un conflicto (para ver el estado fresco).
        private void RecargarMapa_14OR()
        {
            try
            {
                List<AsientoFuncion_14OR> asientos = bllAF.ObtenerMapa_14OR(funcion.IdFuncion_14OR, funcion.Sala.IdSala_14OR);

                celdas = asientos.Select(af => new CeldaMapa_14OR
                {
                    Fila = af.Butaca.NumeroFila_14OR,
                    Asiento = af.Butaca.NumeroAsiento_14OR,
                    Estado = af.Estado_14OR,
                    Referencia = af   // me guardo el asiento original (para saber su estado real al deseleccionar)
                }).ToList();

                DibujarMapa_14OR();
                ActualizarResumen_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar el mapa: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void DibujarMapa_14OR()
        {
            // clickeable=true asi el vendedor puede elegir; le paso los pasillos de la sala
            mapa.Cargar_14OR(celdas, true, pasillos);
        }

        // cada vez que tocan una butaca: si estaba elegida la suelto, si estaba libre la elijo (hasta 8)
        private void Mapa_ButacaClickeada_14OR(object sender, CeldaMapa_14OR celda)
        {
            if (celda.Estado == "Seleccionada")
            {
                // vuelvo al estado real que tenia (Libre o Accesible)
                AsientoFuncion_14OR af = celda.Referencia as AsientoFuncion_14OR;
                celda.Estado = af != null ? af.Estado_14OR : "Libre";
            }
            else
            {
                int elegidas = celdas.Count(c => c.Estado == "Seleccionada");
                if (elegidas >= 8)
                {
                    MessageBox.Show("Maximo 8 butacas por venta.", "Atencion",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                celda.Estado = "Seleccionada";
            }

            DibujarMapa_14OR();
            ActualizarResumen_14OR();
        }

        private void ActualizarResumen_14OR()
        {
            List<CeldaMapa_14OR> elegidas = celdas.Where(c => c.Estado == "Seleccionada")
                                                  .OrderBy(c => c.Fila).ThenBy(c => c.Asiento).ToList();

            lblCantidad.Text = "Cantidad: " + elegidas.Count + " (max 8)";
            lblTotal.Text = "Total: $ " + (elegidas.Count * precioUnit).ToString("0");

            // dibujo los codigos tipo A1, B5, ... como chips
            flpCodigos.Controls.Clear();
            foreach (CeldaMapa_14OR c in elegidas)
            {
                Label chip = new Label();
                chip.Text = Codigo_14OR(c.Fila, c.Asiento);
                chip.ForeColor = Color.White;
                chip.BackColor = Color.FromArgb(231, 168, 26);
                chip.Font = new Font("Segoe UI", 9F, FontStyle.Bold);
                chip.TextAlign = ContentAlignment.MiddleCenter;
                chip.Size = new Size(44, 26);
                chip.Margin = new Padding(4);
                flpCodigos.Controls.Add(chip);
            }

            btnReservar.Enabled = elegidas.Count > 0;
        }

        // paso fila+asiento al codigo de butaca tipo "A1" (fila 1 = A, fila 2 = B, ...)
        private string Codigo_14OR(int fila, int asiento)
        {
            char letra = (char)('A' + fila - 1);
            return letra.ToString() + asiento;
        }

        private void BtnReservar_Click_14OR(object sender, EventArgs e)
        {
            List<Butaca_14OR> butacas = celdas
                .Where(c => c.Estado == "Seleccionada")
                .Select(c => ((AsientoFuncion_14OR)c.Referencia).Butaca)
                .ToList();

            if (butacas.Count == 0)
            {
                MessageBox.Show("Elegi al menos una butaca.", "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                ResultadoReserva_14OR res = bllVenta.ReservarButacas_14OR(funcion.IdFuncion_14OR, butacas);

                if (res == ResultadoReserva_14OR.Conflicto)
                {
                    MessageBox.Show("Alguna de las butacas ya fue tomada por otra venta. Refrescamos la sala.",
                        "Ups", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    RecargarMapa_14OR();   // vuelvo a leer el estado real y redibujo (se pierde la seleccion)
                    return;
                }

                MessageBox.Show("Listo! Se reservaron " + butacas.Count + " butaca(s).\n" +
                                "El siguiente paso seria cobrar (CUN-002).",
                    "Reserva ok", MessageBoxButtons.OK, MessageBoxIcon.Information);

                RecargarMapa_14OR();   // ahora se ven en rojo (Reservada)
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BtnCerrar_Click_14OR(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
