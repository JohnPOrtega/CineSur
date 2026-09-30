using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    public partial class Salas : Form
    {
        // la gui solo habla con la bll
        private BllSala_14OR bll = new BllSala_14OR();
        // lo uso para traer las butacas de la sala y dibujar la distribucion
        private BllButaca_14OR bllButaca = new BllButaca_14OR();

        private List<Sala_14OR> salasActuales_14OR = new List<Sala_14OR>();
        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        // columnas despues de las cuales va un pasillo en la sala que estoy cargando/editando.
        // se define a mano con el boton "Definir pasillos" (se abre la ventana con el mapa)
        private List<int> pasillosSala_14OR = new List<int>();

        public Salas()
        {
            InitializeComponent();
            EstiloGrilla_14OR();
            CargarGrilla_14OR();
            ActualizarCapacidad_14OR();
            ModoInicial_14OR();
        }

        // ---- grilla ----

        private void CargarGrilla_14OR()
        {
            try
            {
                salasActuales_14OR = bll.Listar_14OR();
                var lista = salasActuales_14OR.Select(s => new
                {
                    s.IdSala_14OR,
                    s.Numero_14OR,
                    s.Capacidad_14OR
                }).ToList();

                dgvSalas.DataSource = lista;

                if (dgvSalas.Columns.Count > 0)
                {
                    dgvSalas.Columns["IdSala_14OR"].HeaderText = "ID";
                    dgvSalas.Columns["Numero_14OR"].HeaderText = "Numero";
                    dgvSalas.Columns["Capacidad_14OR"].HeaderText = "Capacidad";
                    dgvSalas.Columns["IdSala_14OR"].FillWeight = 30;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar las salas: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void EstiloGrilla_14OR()
        {
            dgvSalas.EnableHeadersVisualStyles = false;
            dgvSalas.BackgroundColor = Color.FromArgb(36, 36, 36);
            dgvSalas.BorderStyle = BorderStyle.None;
            dgvSalas.GridColor = Color.FromArgb(61, 61, 61);
            dgvSalas.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvSalas.MultiSelect = false;
            dgvSalas.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvSalas.RowTemplate.Height = 28;
            dgvSalas.ColumnHeadersHeight = 30;

            dgvSalas.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(46, 46, 46);
            dgvSalas.ColumnHeadersDefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvSalas.ColumnHeadersDefaultCellStyle.SelectionBackColor = Color.FromArgb(46, 46, 46);
            dgvSalas.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI", 9.5F, FontStyle.Bold);

            dgvSalas.DefaultCellStyle.BackColor = Color.FromArgb(36, 36, 36);
            dgvSalas.DefaultCellStyle.ForeColor = Color.Gainsboro;
            dgvSalas.DefaultCellStyle.SelectionBackColor = Color.FromArgb(18, 58, 94);
            dgvSalas.DefaultCellStyle.SelectionForeColor = Color.White;
            dgvSalas.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(40, 40, 40);
        }

        // la capacidad no se carga: se calcula sola con filas por asientos
        private void ActualizarCapacidad_14OR()
        {
            int cap = (int)numFilas.Value * (int)numAsientos.Value;
            lblCapacidadValor.Text = cap.ToString();
        }

        private void numGrilla_ValueChanged(object sender, EventArgs e)
        {
            ActualizarCapacidad_14OR();
        }

        // ---- modos ----

        private void ModoInicial_14OR()
        {
            modo_14OR = "";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(true);
            EstadoBotones_14OR("inicial");
            lblEstado.Text = "Toca NUEVO para crear una sala (se generan las butacas solas), o elegi una de la lista.";
        }

        // prende y apaga los botones segun en que estoy parado.
        // asi los botones que no tienen sentido en cada momento quedan "apagados" (grises).
        // estados: "inicial" (nada seleccionado), "seleccion" (elegi una sala de la lista),
        //          "nuevo" (dando de alta), "modif" (modificando la sala elegida)
        private void EstadoBotones_14OR(string estado)
        {
            bool inicial = estado == "inicial";
            bool seleccion = estado == "seleccion";
            bool nuevo = estado == "nuevo";
            bool modif = estado == "modif";
            bool editando = nuevo || modif;

            // Nuevo solo cuando no estoy editando ni tengo una sala elegida.
            // si queres crear otra teniendo una elegida, primero CANCELAR (vuelve al inicio)
            btnNuevo.Enabled = inicial;
            // Modificar/Eliminar solo con una sala elegida
            btnModificar.Enabled = seleccion;
            btnEliminar.Enabled = seleccion;
            // Guardar y Cancelar solo mientras estoy cargando/editando
            btnGuardar.Enabled = editando;
            btnCancelar.Enabled = editando;
            // Definir pasillos solo tiene sentido en alta o modificacion
            btnDefinirPasillos.Enabled = editando;
            // Ver distribucion necesita una sala ya creada (elegida o modificando), no en alta
            btnVerDistribucion.Enabled = seleccion || modif;
        }

        private void LimpiarCampos_14OR()
        {
            numNumero.Value = 1;
            numFilas.Value = 8;
            numAsientos.Value = 10;
            pasillosSala_14OR = new List<int>();
            ActualizarCapacidad_14OR();
        }

        // paso el string guardado ("4,12") a lista de int. si viene vacio devuelvo lista vacia
        private List<int> ParsearPasillos_14OR(string texto)
        {
            List<int> lista = new List<int>();
            if (string.IsNullOrWhiteSpace(texto)) return lista;

            foreach (string parte in texto.Split(','))
            {
                int n;
                if (int.TryParse(parte.Trim(), out n) && n > 0)
                    lista.Add(n);
            }
            return lista;
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            numNumero.Enabled = !bloquear;
            numFilas.Enabled = !bloquear;
            numAsientos.Enabled = !bloquear;
        }

        // pone en los numericos las filas y asientos reales de la sala, sacados de sus butacas.
        // la fila mas alta = cantidad de filas, el asiento mas alto = asientos por fila.
        // si algo falla no rompo nada: dejo los valores que haya
        private void CargarDimensionesReales_14OR(int idSala)
        {
            try
            {
                List<Butaca_14OR> butacas = bllButaca.ListarPorSala_14OR(idSala);
                if (butacas == null || butacas.Count == 0) return;

                int filasReales = butacas.Max(b => b.NumeroFila_14OR);
                int asientosReales = butacas.Max(b => b.NumeroAsiento_14OR);

                // no me paso del maximo del control (por si algun control tiene tope)
                numFilas.Value = Math.Min(filasReales, (int)numFilas.Maximum);
                numAsientos.Value = Math.Min(asientosReales, (int)numAsientos.Maximum);
            }
            catch
            {
                // si no pude leer las butacas, no pasa nada: se usan los valores actuales
            }
        }

        // ---- eventos ----

        private void dgvSalas_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvSalas.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvSalas.CurrentRow.Cells["IdSala_14OR"].Value);
            Sala_14OR s = salasActuales_14OR.FirstOrDefault(x => x.IdSala_14OR == idSeleccionado_14OR);
            if (s == null) return;

            numNumero.Value = s.Numero_14OR;
            // me traigo las dimensiones REALES de la sala mirando sus butacas (max fila y max asiento).
            // esto es importante: la grilla no se guarda en la tabla Sala, se deduce de las butacas,
            // asi cuando abro "Definir pasillos" o modifico veo la sala de verdad y no la de por defecto
            CargarDimensionesReales_14OR(idSeleccionado_14OR);
            // la capacidad ya esta guardada (las butacas ya existen), la muestro tal cual
            lblCapacidadValor.Text = s.Capacidad_14OR.ToString();
            // me traigo los pasillos que ya tenia esta sala por si la modifican
            pasillosSala_14OR = ParsearPasillos_14OR(s.Pasillos_14OR);

            modo_14OR = "";
            BloquearCampos_14OR(true);
            EstadoBotones_14OR("seleccion");
            lblEstado.Text = "Sala " + idSeleccionado_14OR + " seleccionada. Podes MODIFICAR o ELIMINAR.";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            modo_14OR = "nuevo";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(false);
            EstadoBotones_14OR("nuevo");
            lblEstado.Text = "Modo ALTA: elegi numero, filas y asientos por fila. Al guardar se crean las butacas.";
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            // en la modificacion solo dejo cambiar el numero y los pasillos: la grilla de butacas ya esta creada
            modo_14OR = "modif";
            BloquearCampos_14OR(false);
            numFilas.Enabled = false;
            numAsientos.Enabled = false;
            EstadoBotones_14OR("modif");
            lblEstado.Text = "Modo MODIFICACION: podes cambiar el numero o los pasillos de la sala " + idSeleccionado_14OR + ".";
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (modo_14OR == "nuevo")
                {
                    Sala_14OR s = new Sala_14OR();
                    s.Numero_14OR = (int)numNumero.Value;
                    // guardo la distribucion de pasillos como texto ("4,12")
                    s.Pasillos_14OR = string.Join(",", pasillosSala_14OR);

                    int filas = (int)numFilas.Value;
                    int asientos = (int)numAsientos.Value;

                    bll.Alta_14OR(s, filas, asientos);
                    MessageBox.Show("Sala creada. Se generaron " + (filas * asientos) + " butacas.",
                        "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    Sala_14OR s = new Sala_14OR();
                    s.IdSala_14OR = idSeleccionado_14OR;
                    s.Numero_14OR = (int)numNumero.Value;
                    // dejo actualizar tambien los pasillos en la modificacion
                    s.Pasillos_14OR = string.Join(",", pasillosSala_14OR);
                    bll.Modificar_14OR(s);
                    MessageBox.Show("Sala modificada.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    return;
                }

                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;

            DialogResult r = MessageBox.Show("Seguro que queres eliminar la sala " + idSeleccionado_14OR + "? Se borran tambien sus butacas.",
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (r != DialogResult.Yes) return;

            try
            {
                bll.Baja_14OR(idSeleccionado_14OR);
                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                // la BLL manda una clave de mensaje traducible (sin SQL): la muestro con el gestor de idioma
                MessageBox.Show(Servicios.GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(ex.Message, ex.Message),
                    "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        // handler del boton Cancelar: agregas el boton en el disenador y le enganchas
        // este metodo en su evento Click. descarta lo que estabas cargando y vuelve al inicio.
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }

        // handler del boton "Ver distribucion": agregas el boton en el disenador y le
        // enganchas este metodo en el Click. muestra el mapa de butacas de la sala elegida.
        private void btnVerDistribucion_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0)
            {
                MessageBox.Show("Elegi una sala de la lista primero.", "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                // traigo las butacas de la sala y las convierto en celdas para el mapa.
                // en la vista de sala todas van iguales (Libre): es solo la distribucion fisica
                List<Butaca_14OR> butacas = bllButaca.ListarPorSala_14OR(idSeleccionado_14OR);
                List<CeldaMapa_14OR> celdas = butacas.Select(b => new CeldaMapa_14OR
                {
                    Fila = b.NumeroFila_14OR,
                    Asiento = b.NumeroAsiento_14OR,
                    Estado = "Libre"
                }).ToList();

                if (celdas.Count == 0)
                {
                    MessageBox.Show("Esta sala no tiene butacas generadas.", "Atencion",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // armo una ventanita al vuelo con el mapa adentro, solo para ver (no clickeable)
                Form ventana = new Form();
                ventana.Text = "Distribucion - Sala " + idSeleccionado_14OR;
                ventana.StartPosition = FormStartPosition.CenterParent;
                ventana.Size = new Size(640, 520);
                ventana.BackColor = Color.FromArgb(25, 27, 34);

                MapaButacas_14OR mapa = new MapaButacas_14OR();
                mapa.Dock = DockStyle.Fill;
                ventana.Controls.Add(mapa);

                // uso los pasillos que tiene guardados esta sala (los definio el usuario al crearla)
                Sala_14OR salaSel = salasActuales_14OR.FirstOrDefault(x => x.IdSala_14OR == idSeleccionado_14OR);
                List<int> pasillos = ParsearPasillos_14OR(salaSel != null ? salaSel.Pasillos_14OR : "");
                mapa.Cargar_14OR(celdas, false, pasillos); // false = solo lectura

                ventana.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude mostrar la distribucion: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // handler del boton "Definir pasillos": agregas el boton en el disenador y le
        // enganchas este metodo en el Click. abre la ventana con el mapa de la sala para
        // que elijas a mano por donde van los pasillos (clickeando las butacas).
        // solo tiene sentido en modo alta o modificacion (cuando estas cargando la sala).
        private void btnDefinirPasillos_Click(object sender, EventArgs e)
        {
            if (modo_14OR != "nuevo" && modo_14OR != "modif")
            {
                MessageBox.Show("Toca NUEVO o MODIFICAR primero para definir los pasillos.", "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int filas = (int)numFilas.Value;
            int asientos = (int)numAsientos.Value;

            // abro la ventana pasandole la grilla actual y los pasillos que ya venia teniendo
            DisenarPasillos_14OR ventana = new DisenarPasillos_14OR(filas, asientos, pasillosSala_14OR);
            if (ventana.ShowDialog() == DialogResult.OK)
            {
                // si guardo, me quedo con lo que eligio
                pasillosSala_14OR = ventana.Pasillos;
                lblEstado.Text = "Pasillos definidos: " +
                    (pasillosSala_14OR.Count == 0 ? "ninguno" : "despues de las columnas " + string.Join(", ", pasillosSala_14OR)) + ".";
            }
        }
    }
}
