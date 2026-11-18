using Newtonsoft.Json;
using Servicios;
using Servicios.IidiomaObserver;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Ventana de ayuda en linea. Se abre parada en la pantalla desde donde se pidio (F1 o Menu > Ayuda)
    // y el arbol de la izquierda solo muestra las secciones y pantallas que el usuario tiene permitidas:
    // si no tiene la patente de una pantalla (o de su seccion del menu), tampoco ve su ayuda.
    // El contenido sale de Ayuda\ayuda_es.json / ayuda_en.json / ayuda_pr.json segun el idioma elegido,
    // y si el usuario cambia de idioma con la ayuda abierta, se recarga en el nuevo idioma (Observer).
    public partial class Ayuda_43BO : Form, IdiomaObserver_43BO
    {
        private static Ayuda_43BO _abierta;

        // los controles (arbol, titulo, texto, boton) estan en Ayuda_43BO.Designer.cs
        private readonly Font fNormal = new Font("Segoe UI", 10F);
        private readonly Font fNegrita = new Font("Segoe UI", 10F, FontStyle.Bold);
        private string _claveActual;

        // abre la ayuda (o la trae al frente si ya estaba abierta) parada en la pantalla 'clave'
        public static void Abrir_43BO(string clave, Form duenio)
        {
            if (_abierta == null || _abierta.IsDisposed)
            {
                AyudaDoc_43BO doc = Cargar_43BO();
                if (doc == null)
                {
                    MessageBox.Show(T("ayuda_sin_archivo", "No se encontró el archivo de ayuda (Ayuda\\ayuda_es.json)."),
                        T("ayuda_titulo", "Ayuda"), MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                _abierta = new Ayuda_43BO(doc);
                if (duenio != null && !duenio.IsDisposed) _abierta.Show(duenio); else _abierta.Show();
            }
            _abierta.Seleccionar_43BO(clave);
            _abierta.Activate();
        }

        private Ayuda_43BO(AyudaDoc_43BO doc)
        {
            InitializeComponent();
            try
            {
                string ico = Path.Combine(Application.StartupPath, "Recursos", "cinesur.ico");
                if (File.Exists(ico)) Icon = new Icon(ico);
            }
            catch { }

            PonerTextos_43BO();
            ArmarArbol_43BO(doc);
            GestorIdioma_43BO.Instancia.Suscribir_43BO(this);
        }

        // al elegir una pantalla muestro su ayuda; si es una seccion, salto a su primera pantalla
        private void arbol_AfterSelect(object sender, TreeViewEventArgs e)
        {
            if (e.Node.Tag is AyudaPantalla_43BO p) { _claveActual = e.Node.Name; Mostrar_43BO(p); }
            else if (e.Node.Nodes.Count > 0) arbol.SelectedNode = e.Node.Nodes[0];
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void Ayuda_43BO_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape) Close();
        }

        private void PonerTextos_43BO()
        {
            Text = T("ayuda_titulo", "Ayuda") + " - CineSur";
            btnCerrar.Text = T("ayuda_cerrar", "Cerrar");
        }

        // el usuario cambio de idioma con la ayuda abierta: recargo el contenido en el idioma nuevo
        public void ActualizarIdioma_43BO(Dictionary<string, string> diccionario)
        {
            if (IsDisposed) return;
            AyudaDoc_43BO doc = Cargar_43BO();
            if (doc == null) return;
            string clave = _claveActual;
            PonerTextos_43BO();
            ArmarArbol_43BO(doc);
            Seleccionar_43BO(clave);
        }

        // ---------------------------------------------------------------- permisos

        private static bool TienePermiso_43BO(string patente)
        {
            if (string.IsNullOrWhiteSpace(patente)) return true;
            List<string> permisos = null;
            try { permisos = SessionManager_43BO.Instancia?.Permisos; } catch { permisos = null; }
            return permisos != null && permisos.Contains(patente);
        }

        private void ArmarArbol_43BO(AyudaDoc_43BO doc)
        {
            arbol.BeginUpdate();
            arbol.Nodes.Clear();
            foreach (AyudaSeccion_43BO sec in doc.secciones ?? new List<AyudaSeccion_43BO>())
            {
                if (!TienePermiso_43BO(sec.permiso)) continue;   // sin la seccion del menu no ve nada de ella

                TreeNode nodoSec = new TreeNode(sec.titulo) { NodeFont = fNegrita };
                foreach (AyudaPantalla_43BO p in sec.pantallas ?? new List<AyudaPantalla_43BO>())
                {
                    if (!TienePermiso_43BO(p.permiso)) continue;
                    nodoSec.Nodes.Add(new TreeNode(p.titulo) { Tag = p, Name = (p.form ?? "").ToLowerInvariant() });
                }
                if (nodoSec.Nodes.Count > 0) arbol.Nodes.Add(nodoSec);
            }
            arbol.ExpandAll();
            arbol.EndUpdate();
        }

        public void Seleccionar_43BO(string clave)
        {
            TreeNode[] encontrados = arbol.Nodes.Find((clave ?? "").ToLowerInvariant(), true);
            if (encontrados.Length > 0) arbol.SelectedNode = encontrados[0];
            else if (arbol.SelectedNode == null && arbol.Nodes.Count > 0 && arbol.Nodes[0].Nodes.Count > 0)
                arbol.SelectedNode = arbol.Nodes[0].Nodes[0];
            arbol.SelectedNode?.EnsureVisible();
        }

        // ---------------------------------------------------------------- contenido

        private void Mostrar_43BO(AyudaPantalla_43BO p)
        {
            lblTitulo.Text = p.titulo;
            lblDonde.Text = string.IsNullOrWhiteSpace(p.donde) ? "" : T("ayuda_donde", "Dónde está:") + " " + p.donde;

            txt.Clear();
            Escribir_43BO(p.descripcion, fNormal);
            Escribir_43BO("\n", fNormal);

            if (p.pasos != null && p.pasos.Count > 0)
            {
                Escribir_43BO("\n" + T("ayuda_pasos", "Cómo se usa") + "\n", fNegrita);
                for (int i = 0; i < p.pasos.Count; i++)
                    Escribir_43BO("   " + (i + 1) + ". " + p.pasos[i] + "\n", fNormal);
            }

            var campos = new List<AyudaCampo_43BO>();
            foreach (AyudaCampo_43BO c in p.campos ?? new List<AyudaCampo_43BO>())
                if (TienePermiso_43BO(c.permiso)) campos.Add(c);   // ej: en el menu no lista secciones que no tiene
            if (campos.Count > 0)
            {
                Escribir_43BO("\n" + T("ayuda_campos", "Botones y campos") + "\n", fNegrita);
                foreach (AyudaCampo_43BO c in campos)
                {
                    Escribir_43BO("   " + c.nombre + ": ", fNegrita);
                    Escribir_43BO(c.texto + "\n", fNormal);
                }
            }

            if (p.notas != null && p.notas.Count > 0)
            {
                Escribir_43BO("\n" + T("ayuda_notas", "Tené en cuenta") + "\n", fNegrita);
                foreach (string n in p.notas)
                    Escribir_43BO("   • " + n + "\n", fNormal);
            }

            txt.SelectionStart = 0;
            txt.ScrollToCaret();
        }

        private void Escribir_43BO(string texto, Font fuente)
        {
            txt.SelectionStart = txt.TextLength;
            txt.SelectionLength = 0;
            txt.SelectionFont = fuente;
            txt.AppendText(texto ?? "");
        }

        // ---------------------------------------------------------------- archivo

        private static AyudaDoc_43BO Cargar_43BO()
        {
            string carpeta = Path.Combine(Application.StartupPath, "Ayuda");

            // cada archivo de idioma (Idiomas\xx.json) dice cual es su ayuda en la clave "ayuda_archivo";
            // si no la tiene, uso el idioma guardado en el usuario; y si no, español
            string archivo = T("ayuda_archivo", null);
            if (string.IsNullOrWhiteSpace(archivo))
            {
                string idioma = null;
                try { idioma = SessionManager_43BO.Instancia?.Usuario?.Idioma_43BO; } catch { idioma = null; }
                if (!string.IsNullOrWhiteSpace(idioma)) archivo = "ayuda_" + idioma.Trim().ToLowerInvariant() + ".json";
            }

            string ruta = string.IsNullOrWhiteSpace(archivo) ? null : Path.Combine(carpeta, archivo);
            if (ruta == null || !File.Exists(ruta)) ruta = Path.Combine(carpeta, "ayuda_es.json");
            if (!File.Exists(ruta)) return null;

            try { return JsonConvert.DeserializeObject<AyudaDoc_43BO>(File.ReadAllText(ruta, Encoding.UTF8)); }
            catch { return null; }
        }

        private static string T(string clave, string porDefecto)
        {
            try { return GestorIdioma_43BO.Instancia.ObtenerTexto_43BO(clave, porDefecto); }
            catch { return porDefecto; }
        }

        protected override void OnFormClosed(FormClosedEventArgs e)
        {
            if (_abierta == this) _abierta = null;
            try { GestorIdioma_43BO.Instancia.Desuscribir_43BO(this); } catch { }
            base.OnFormClosed(e);
        }
    }

    // estructura del ayuda_xx.json
    public class AyudaDoc_43BO { public List<AyudaSeccion_43BO> secciones { get; set; } }
    public class AyudaSeccion_43BO
    {
        public string titulo { get; set; }
        public string permiso { get; set; }
        public List<AyudaPantalla_43BO> pantallas { get; set; }
    }
    public class AyudaPantalla_43BO
    {
        public string form { get; set; }
        public string titulo { get; set; }
        public string permiso { get; set; }
        public string donde { get; set; }
        public string descripcion { get; set; }
        public List<string> pasos { get; set; }
        public List<AyudaCampo_43BO> campos { get; set; }
        public List<string> notas { get; set; }
    }
    public class AyudaCampo_43BO
    {
        public string nombre { get; set; }
        public string texto { get; set; }
        public string permiso { get; set; }
    }
}
