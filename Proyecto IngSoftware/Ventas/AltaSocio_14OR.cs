using BE;
using System;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
  
    public partial class AltaSocio_14OR : Form, Servicios.IidiomaObserver.IdiomaObserver_43BO
    {
        private int _dni;

        public Cliente_14OR ClienteResultado { get; private set; }

        public AltaSocio_14OR(int dni)
        {
            _dni = dni;
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
            this.Text = "Alta de socio";
            lblDniVal.Text = dni.ToString();
        }

        private void BtnAceptar_Click_14OR(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text))
            {
                MessageBox.Show("Ingresa el nombre.", "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                MessageBox.Show("Ingresa el apellido.", "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            Cliente_14OR c = new Cliente_14OR();
            c.DNI_14OR = _dni;
            c.Nombre_14OR = txtNombre.Text.Trim();
            c.Apellido_14OR = txtApellido.Text.Trim();
            c.Email_14OR = txtEmail.Text.Trim();
            c.Telefono_14OR = txtTelefono.Text.Trim();
            c.Suscriptor_14OR = true;

            ClienteResultado = c;

            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void BtnCancelar_Click_14OR(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }
    
        // traduccion automatica: al cambiar idioma el gestor llama aca y se traducen
        // todos los controles estaticos que tengan clave en el JSON (patron observer).
        public void ActualizarIdioma_43BO(System.Collections.Generic.Dictionary<string, string> dic)
        {
            this.TraducirAuto_43BO(dic);
        }
}
}
