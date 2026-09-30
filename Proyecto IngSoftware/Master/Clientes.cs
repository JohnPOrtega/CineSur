using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // ABM de Clientes / Socios (Master). El diseno esta en Clientes.Designer.cs.
    // desde aca se administran los clientes; en el cobro tambien se puede dar de alta uno rapido.
    public partial class Clientes : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private BllCliente_14OR bll = new BllCliente_14OR();
        private List<Cliente_14OR> clientesActuales_14OR = new List<Cliente_14OR>();
        private int idSeleccionado_14OR = 0;
        private string modo_14OR = "";

        public Clientes()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            CargarGrilla_14OR();
            ModoInicial_14OR();
        }

        private void CargarGrilla_14OR()
        {
            try
            {
                clientesActuales_14OR = bll.Listar_14OR();
                MostrarEnGrilla_14OR(clientesActuales_14OR);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No pude cargar los clientes: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // dibuja en la grilla la lista que le pase (la de la BD o la que viene de un XML des-serializado)
        private void MostrarEnGrilla_14OR(List<Cliente_14OR> clientes)
        {
            var lista = clientes.Select(c => new
            {
                c.IdCliente_14OR,
                c.DNI_14OR,
                c.Nombre_14OR,
                c.Apellido_14OR,
                c.Email_14OR,
                c.Telefono_14OR,
                Socio = (c.Suscriptor_14OR ? "Si" : "No")
            }).ToList();

            dgvClientes.DataSource = lista;

            if (dgvClientes.Columns.Count > 0)
            {
                dgvClientes.Columns["IdCliente_14OR"].HeaderText = "ID";
                dgvClientes.Columns["DNI_14OR"].HeaderText = "DNI";
                dgvClientes.Columns["Nombre_14OR"].HeaderText = "Nombre";
                dgvClientes.Columns["Apellido_14OR"].HeaderText = "Apellido";
                dgvClientes.Columns["Email_14OR"].HeaderText = "Email";
                dgvClientes.Columns["Telefono_14OR"].HeaderText = "Telefono";
                dgvClientes.Columns["IdCliente_14OR"].FillWeight = 25;
                dgvClientes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            }
        }

        // ---- modos ----

        private void ModoInicial_14OR()
        {
            modo_14OR = "";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(true);
            btnNuevo.Enabled = true;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            btnGuardar.Enabled = false;
            btnCancelar.Enabled = false;
            lblEstado.Text = "Toca NUEVO para crear un cliente, o elegi uno de la lista.";
        }

        private void LimpiarCampos_14OR()
        {
            txtDni.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtEmail.Text = "";
            txtTelefono.Text = "";
        }

        private void BloquearCampos_14OR(bool bloquear)
        {
            txtDni.Enabled = !bloquear;
            txtNombre.Enabled = !bloquear;
            txtApellido.Enabled = !bloquear;
            txtEmail.Enabled = !bloquear;
            txtTelefono.Enabled = !bloquear;
        }

        // ---- eventos ----

        private void dgvClientes_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvClientes.CurrentRow == null) return;

            idSeleccionado_14OR = Convert.ToInt32(dgvClientes.CurrentRow.Cells["IdCliente_14OR"].Value);
            Cliente_14OR c = clientesActuales_14OR.FirstOrDefault(x => x.IdCliente_14OR == idSeleccionado_14OR);
            if (c == null) return;

            txtDni.Text = c.DNI_14OR.ToString();
            txtNombre.Text = c.Nombre_14OR;
            txtApellido.Text = c.Apellido_14OR;
            txtEmail.Text = c.Email_14OR;
            txtTelefono.Text = c.Telefono_14OR;

            modo_14OR = "";
            BloquearCampos_14OR(true);
            btnModificar.Enabled = true;
            btnEliminar.Enabled = true;
            btnGuardar.Enabled = false;
            btnCancelar.Enabled = false;
            btnNuevo.Enabled = true;
            lblEstado.Text = "Cliente " + idSeleccionado_14OR + " seleccionado. Podes MODIFICAR o ELIMINAR.";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            modo_14OR = "nuevo";
            idSeleccionado_14OR = 0;
            LimpiarCampos_14OR();
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnCancelar.Enabled = true;
            btnNuevo.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo ALTA: carga el cliente y toca GUARDAR.";
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            if (idSeleccionado_14OR <= 0) return;
            modo_14OR = "modif";
            BloquearCampos_14OR(false);
            btnGuardar.Enabled = true;
            btnCancelar.Enabled = true;
            btnNuevo.Enabled = false;
            btnModificar.Enabled = false;
            btnEliminar.Enabled = false;
            lblEstado.Text = "Modo MODIFICACION del cliente " + idSeleccionado_14OR + ".";
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                int dni;
                if (!int.TryParse(txtDni.Text.Trim(), out dni))
                    throw new Exception("El DNI tiene que ser un numero valido.");

                Cliente_14OR c = new Cliente_14OR();
                c.DNI_14OR = dni;
                c.Nombre_14OR = txtNombre.Text.Trim();
                c.Apellido_14OR = txtApellido.Text.Trim();
                c.Email_14OR = txtEmail.Text.Trim();
                c.Telefono_14OR = txtTelefono.Text.Trim();

                if (modo_14OR == "nuevo")
                {
                    // el cliente se crea NO socio: la suscripcion es un beneficio que se gana
                    // en la venta (CUN-003), no se asigna a mano desde el maestro.
                    c.Suscriptor_14OR = false;
                    bll.Alta_14OR(c);
                    MessageBox.Show("Cliente creado.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else if (modo_14OR == "modif")
                {
                    c.IdCliente_14OR = idSeleccionado_14OR;
                    // conservo el estado de socio que ya tenia (no se cambia desde el maestro)
                    Cliente_14OR existente = clientesActuales_14OR.FirstOrDefault(x => x.IdCliente_14OR == idSeleccionado_14OR);
                    c.Suscriptor_14OR = existente != null && existente.Suscriptor_14OR;
                    bll.Modificar_14OR(c);
                    MessageBox.Show("Cliente modificado.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
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

            DialogResult r = MessageBox.Show(
                GestorIdioma_43BO.Instancia.ObtenerTexto_43BO("clientes_msg_confirmareliminar", "Seguro que queres eliminar el cliente seleccionado?"),
                "Confirmar", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (r != DialogResult.Yes) return;

            try
            {
                // baja logica: no se borra fisicamente, se marca como eliminado (conserva el historial de ventas)
                bll.Baja_14OR(idSeleccionado_14OR);
                CargarGrilla_14OR();
                ModoInicial_14OR();
            }
            catch (Exception ex)
            {
                // sin mensajes de SQL: se traduce la clave del mensaje si existe
                MessageBox.Show(GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(ex.Message, ex.Message),
                    "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            ModoInicial_14OR();
        }

        // ---- Serializacion XML (TP Serializacion) ----

        // 1-3) elijo la ubicacion/nombre del XML y serializo la matriz de clientes de la pantalla.
        private void btnSerializar_Click(object sender, EventArgs e)
        {
            if (clientesActuales_14OR == null || clientesActuales_14OR.Count == 0)
            {
                MessageBox.Show("No hay clientes en la matriz para serializar.", "Atencion",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            using (SaveFileDialog sfd = new SaveFileDialog())
            {
                sfd.Title = "Elegi donde guardar el XML de clientes";
                sfd.Filter = "Archivo XML (*.xml)|*.xml";
                sfd.FileName = "Clientes.xml";

                if (sfd.ShowDialog() != DialogResult.OK) return;

                try
                {
                    bll.SerializarXml_14OR(clientesActuales_14OR, sfd.FileName);
                    lblEstado.Text = "Serializados " + clientesActuales_14OR.Count + " clientes en: " + sfd.FileName;
                    MessageBox.Show("Serializacion completada.\nArchivo: " + sfd.FileName, "Listo",
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("No se pudo serializar: " + ex.Message, "Error",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        //
        private void btnDeserializar_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog ofd = new OpenFileDialog())
            {
                ofd.Title = "Elegi el XML de clientes a des-serializar";
                ofd.Filter = "Archivo XML (*.xml)|*.xml";

                if (ofd.ShowDialog() != DialogResult.OK) return;

                try
                {
                    List<Cliente_14OR> desde = bll.DeserializarXml_14OR(ofd.FileName);
                    clientesActuales_14OR = desde;
                    MostrarEnGrilla_14OR(clientesActuales_14OR);
                    ModoInicial_14OR();
                    lblEstado.Text = "Des-serializados " + desde.Count + " clientes desde el XML (en pantalla, sin guardar en BD).";
                    MessageBox.Show("Des-serializacion completada. Se cargaron " + desde.Count +
                        " clientes en la matriz.", "Listo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("No se pudo des-serializar: " + ex.Message, "Error",
                        MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    
        // traduccion automatica: al cambiar idioma el gestor llama aca y se traducen
        // todos los controles estaticos que tengan clave en el JSON (patron observer).
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}
