using System;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Ayuda en linea contextual: cada pantalla abre SU ayuda, no una ayuda general.
    // - F1 en cualquier formulario (MDI, dialogo o el Login) -> abre la ayuda parada en ese formulario.
    // - Menu > Ayuda -> abre la ayuda de la pantalla que esta activa adentro del menu.
    // La ventana de ayuda (Ayuda_43BO) solo muestra lo que el usuario tiene permitido.
    public static class AyudaContextual_43BO
    {
        private const int WM_KEYDOWN = 0x0100;

        // se llama una sola vez en Program.Main: engancha el F1 de toda la aplicacion
        public static void Activar_43BO()
        {
            Application.AddMessageFilter(new FiltroF1_43BO());
        }

        public static void Mostrar_43BO(Form origen)
        {
            if (origen == null || origen.IsDisposed) return;

            // si es el menu principal y hay una pantalla abierta adentro, la ayuda es de esa pantalla
            Form pantalla = origen;
            if (origen.IsMdiContainer && origen.ActiveMdiChild != null) pantalla = origen.ActiveMdiChild;

            // la clave es el nombre de la clase del form: Peliculas -> "peliculas", Funciones_14OR -> "funciones_14or"
            string clave = pantalla.GetType().Name.ToLowerInvariant();
            Form duenio = pantalla.MdiParent ?? pantalla;   // un hijo MDI no puede ser dueño de otra ventana
            Ayuda_43BO.Abrir_43BO(clave, duenio);
        }

        // ve pasar todas las teclas de la aplicacion antes que los controles: si es F1, abre la ayuda
        private class FiltroF1_43BO : IMessageFilter
        {
            public bool PreFilterMessage(ref Message m)
            {
                if (m.Msg != WM_KEYDOWN) return false;
                if (((Keys)(int)m.WParam & Keys.KeyCode) != Keys.F1) return false;
                if (Control.ModifierKeys != Keys.None) return false;

                Form activa = Form.ActiveForm;   // null si hay un MessageBox abierto: ahi no hago nada
                if (activa == null) return false;
                if (activa is Ayuda_43BO) return true;   // F1 dentro de la ayuda: ya esta abierta

                Mostrar_43BO(activa);
                return true;
            }
        }
    }
}
