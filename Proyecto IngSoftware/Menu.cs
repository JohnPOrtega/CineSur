using BLL;
using GUI_43BO;
using Servicios;
using Servicios.IidiomaObserver;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    public partial class Menu : Form, IdiomaObserver_43BO
    {
        private GestionUs Gu_43BO;
        private CambioContraseña CC_43BO;
        private Auditoria Aud_43BO;
        private BllUser_43BO bll = new BLL.BllUser_43BO();
        private GestionPerfiles Gperfiles;
        private Dictionary<string, string> _dic;

        // 1. Agregamos los submenús al diccionario mapeador de patentes
        private readonly Dictionary<string, Permisos_43BO> _mapaMenu = new Dictionary<string, Permisos_43BO>
        {
            { "AdminToolStripMenuItem", Permisos_43BO.Menu_SeccionAdmin },
            { "masterToolStripMenuItem", Permisos_43BO.Menu_SeccionMaster },
            { "ventaToolStripMenuItem", Permisos_43BO.Menu_SeccionVenta },
            { "CompraToolStripMenuItem", Permisos_43BO.Menu_SeccionCompra },
            { "reporteToolStripMenuItem", Permisos_43BO.Menu_SeccionReporte },
            
            // Reemplazá acá por el "Name" exacto que tengan tus ToolStripMenuItems en el diseñador:
            { "cambiarContraseñaToolStripMenuItem", Permisos_43BO.Usuario_CambioContraseña },
            { "cambiarIdiomaToolStripMenuItem", Permisos_43BO.Usuario_CambioIdioma }
        };

        public Menu()
        {
            InitializeComponent();
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
        }

        private void Menu_Load(object sender, EventArgs e)
        {
            // logo de CineSur como marca de agua en el fondo + icono de la app
            CargarBranding_14OR();

            try
            {
                var usuarioLogueado = SessionManager_43BO.Instancia.Usuario;
                if (usuarioLogueado != null)
                {
                    // el filtro de permisos del menu va SIEMPRE, tenga o no la contra de fabrica
                    // sino el usuario ve submenus que no le corresponden
                    AsignadorPermisos_43BO.AplicarMenu(this.menuStrip1, _mapaMenu);

                    if (bll.EsContraseñaDeFabrica_43BO(usuarioLogueado))
                    {
                        MessageBox.Show(ObtenerTexto("menu_msg_cambiar_contra_fabrica"), ObtenerTexto("titulo_atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        // abro directo el cambio de contraseña (antes por error se abria el de idioma)
                        // al abrirlo por codigo no pasa por el permiso del menu, asi que funciona
                        // aunque el usuario no tenga la patente Usuario_CambioContraseña
                        CambioContraseña frmCambio = new CambioContraseña();
                        frmCambio.MdiParent = this;
                        frmCambio.Show();
                        TraducirFormulario(frmCambio);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ObtenerTexto(ex.Message), ObtenerTexto("titulo_error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void TraducirMenu(ToolStripItemCollection items)
        {
            foreach (ToolStripItem item in items)
            {
                string clave = "menu." + item.Name.ToLower().Replace("toolstripmenuitem", "");

                if (_dic != null && _dic.ContainsKey(clave))
                {
                    item.Text = _dic[clave];
                }

                if (item is ToolStripMenuItem dropDown)
                {
                    TraducirMenu(dropDown.DropDownItems);
                }
            }
        }

        public void TraducirFormulario(Form formulario)
        {
            if (_dic == null) return;

            if (_dic.ContainsKey(formulario.Name.ToLower() + "_titulo"))
            {
                formulario.Text = _dic[formulario.Name.ToLower() + "_titulo"];
            }

            TraducirControlesInternos(formulario.Controls);
        }

        private void TraducirControlesInternos(Control.ControlCollection controles)
        {
            foreach (Control c in controles)
            {
                string clave = c.Name.ToLower();
                if (_dic.ContainsKey(clave))
                {
                    c.Text = _dic[clave];
                }

                if (c is DataGridView dgv)
                {
                    foreach (DataGridViewColumn col in dgv.Columns)
                    {
                        string claveCol = col.Name.ToLower();
                        if (_dic.ContainsKey(claveCol))
                        {
                            col.HeaderText = _dic[claveCol];
                        }
                    }
                }

                if (c.Controls.Count > 0)
                {
                    TraducirControlesInternos(c.Controls);
                }
            }
        }

        private void gestionUsuarioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!SessionManager_43BO.Instancia.Permisos.Contains("GestionUsuarios_Acceso"))
            {
                MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"));
                return;
            }
            Gu_43BO = new GestionUs();
            Gu_43BO.MdiParent = this;
            Gu_43BO.Show();
            TraducirFormulario(Gu_43BO);
        }

        private void bitacoraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!SessionManager_43BO.Instancia.Permisos.Contains("Auditoria_Acceso"))
            {
                MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"));
                return;
            }
            Aud_43BO = new Auditoria();
            Aud_43BO.MdiParent = this;
            Aud_43BO.Show();
            TraducirFormulario(Aud_43BO);
        }

        private void gestionPerfilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!SessionManager_43BO.Instancia.Permisos.Contains("GestionPerfiles_Acceso"))
            {
                MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"));
                return;
            }
            Gperfiles = new GestionPerfiles();
            Gperfiles.MdiParent = this;
            Gperfiles.Show();
            TraducirFormulario(Gperfiles);
        }

        // backup bd, solo lo puede abrir el admin
        private void backupBDToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var usuario = SessionManager_43BO.Instancia.Usuario;

            if (usuario == null || usuario.Rol == null || usuario.Rol.Nombre_43BO == null ||
                !usuario.Rol.Nombre_43BO.Trim().Equals("Administrador", StringComparison.OrdinalIgnoreCase))
            {
                MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"), ObtenerTexto("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            BackupBD_43BO frmBackup = new BackupBD_43BO();
            frmBackup.MdiParent = this;
            frmBackup.Show();
            TraducirFormulario(frmBackup);
        }

        // abre el abm de peliculas desde Master -> Peliculas
        private void peliculasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Master_Peliculas_Acceso")) return;
            Peliculas frm = new Peliculas();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre el abm de funciones desde Master -> Funcion
        private void funcionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Master_Funciones_Acceso")) return;
            Funciones_14OR frm = new Funciones_14OR();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre el abm de salas desde Master -> Salas (al dar de alta genera las butacas)
        private void salasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Master_Salas_Acceso")) return;
            Salas frm = new Salas();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

 

        

        public void ActualizarIdioma_43BO(Dictionary<string, string> dic)
        {
            _dic = dic;
            TraducirMenu(menuStrip1.Items);

            foreach (Form hijo in this.MdiChildren)
            {
                TraducirFormulario(hijo);
            }
        }

        // unico punto de traduccion: todo pasa por el gestor
        private string ObtenerTexto(string clave, string porDefecto = null)
            => GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto ?? clave);

        // pone el logo tenue de CineSur como marca de agua en el fondo + el icono de la app
        private void CargarBranding_14OR()
        {
            try
            {
                string baseDir = System.IO.Path.Combine(Application.StartupPath, "Recursos");

                string wm = System.IO.Path.Combine(baseDir, "logo_watermark.png");
                if (System.IO.File.Exists(wm))
                {
                    using (var fs = new System.IO.FileStream(wm, System.IO.FileMode.Open, System.IO.FileAccess.Read))
                        this.BackgroundImage = System.Drawing.Image.FromStream(fs);
                    this.BackgroundImageLayout = ImageLayout.Center;
                }

                string ico = System.IO.Path.Combine(baseDir, "cinesur.ico");
                if (System.IO.File.Exists(ico))
                    this.Icon = new System.Drawing.Icon(ico);
            }
            catch
            {
                // si falta el archivo, el menu funcina igual
            }
        }

        // control de patente por accion: si el usuario no tiene el permiso, avisa y corta.
        // el nombre de la patente es el mismo del enum Permisos_43BO.
        private bool VerificarPermiso_43BO(string patente)
        {
            if (SessionManager_43BO.Instancia.Permisos != null &&
                SessionManager_43BO.Instancia.Permisos.Contains(patente))
                return true;

            MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"),
                ObtenerTexto("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
            return false;
        }

        private void cerrarSesiobnToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show(ObtenerTexto("menu_msg_confirmar_cerrar_sesion"), ObtenerTexto("titulo_confirmar", "Confirmar"), MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                bll.CerrarSesion_43BO();
                new Login().Show();
                this.Close();
            }
        }

        // 2. Controlamos por seguridad el clic de Cambio de Contraseña
        private void cambiarContraseñaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!SessionManager_43BO.Instancia.Permisos.Contains("Usuario_CambioContraseña"))
            {
                MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"), ObtenerTexto("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            CC_43BO = new CambioContraseña();
            CC_43BO.MdiParent = this;
            CC_43BO.Show();
            TraducirFormulario(CC_43BO);
        }

        // 3. Controlamos por seguridad el clic de Cambio de Idioma
        private void cambiarIdiomaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!SessionManager_43BO.Instancia.Permisos.Contains("Usuario_CambioIdioma"))
            {
                MessageBox.Show(ObtenerTexto("menu.msg_acceso_denegado"), ObtenerTexto("titulo_error", "Error"), MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            new CambiarIdioma().ShowDialog(this);
        }

        private void reLoginToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (Login frmLogin = new Login())
            {
                if (frmLogin.ShowDialog() == DialogResult.OK)
                {
                    foreach (Form hijo in this.MdiChildren)
                    {
                        hijo.Close();
                    }
                    var usuarioLogueado = SessionManager_43BO.Instancia.Usuario;

                    if (usuarioLogueado != null)
                    {
                        // reevaluo el menu con las patentes del nuevo usuario, siempre
                        AsignadorPermisos_43BO.AplicarMenu(this.menuStrip1, _mapaMenu);

                        if (bll.EsContraseñaDeFabrica_43BO(usuarioLogueado))
                        {
                            MessageBox.Show(ObtenerTexto("menu_msg_cambiar_contra_fabrica"), ObtenerTexto("titulo_atencion"), MessageBoxButtons.OK, MessageBoxIcon.Warning);

                            // aca tambien va el cambio de contraseña, no el de idioma
                            CambioContraseña frmCambio = new CambioContraseña();
                            frmCambio.MdiParent = this;
                            frmCambio.Show();
                            TraducirFormulario(frmCambio);
                        }
                    }
                }
            }
        }

       
        private void reservarButacasToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Venta_ReservarButacas_Acceso")) return;
             Cartelera frm = new Cartelera();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        private void promocionesToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Master_Promociones_Acceso")) return;
            Promociones frm = new Promociones();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

       
   
        


        private void clientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Master_Clientes_Acceso")) return;
            Clientes frm = new Clientes();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // aber la Auditoria de la bitacora de cambios desde Maestros -> Auditoria de Cambios
        private void auditoriaCambiosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Maestro_AuditoriaCambios_Acceso")) return;
            AuditoriaCambios frm = new AuditoriaCambios();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

      
        private void controlAccesoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Venta_ControlAcceso_Acceso")) return;
            ControlAcceso frm = new ControlAcceso();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

       

        private void reporteDeVentasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Reporte_FuncionesOcupacion_Acceso")) return;
            ReporteFunciones frm = new ReporteFunciones();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre el abm de productos del Candy Bar edsde Compra -> Productos (PN2)
        private void productosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Compra_Productos_Acceso")) return;
            Productos frm = new Productos();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre el abm de proveedores desde Compra -> Proveedores (PN2)
        private void proveedoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Compra_Proveedores_Acceso")) return;
            Proveedores frm = new Proveedores();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre la pantalla de venta del Candy Bar desde Venta -> Candy Bar (PN2)
        private void candyBarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Venta_CandyBar_Acceso")) return;
            VentaCandy frm = new VentaCandy();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre la pantalla de presupuestos/cotizaciones desde Compra -> Presupuestos (PN2)
        private void presupuestosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Compra_Presupuestos_Acceso")) return;
            Presupuestos frm = new Presupuestos();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }

        // abre la lista de ordenes de compra desde Compra -> Ordenes de Compra (PN2)
        private void ordenesCompraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!VerificarPermiso_43BO("Compra_OrdenesCompra_Acceso")) return;
            OrdenesCompra frm = new OrdenesCompra();
            frm.MdiParent = this;
            frm.Show();
            TraducirFormulario(frm);
        }
    }
}