using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace Proyecto_IngSoftware
{
    public static class UIExtension_43BO
    {
        public static void Traducir(this Control control, Dictionary<string, string> dict, string key)
        {
            if (dict != null && dict.ContainsKey(key))
            {
                control.Text = dict[key];
            }
            else
            {

                control.Text = $"[{key}]";
            }
        }

        // Traduccion automatica de un formulario completo.
        public static void TraducirAuto_43BO(this Form form, Dictionary<string, string> dic)
        {
            if (dic == null || form == null || form.IsDisposed) return;
            try
            {
                TraducirControlesAuto_43BO(form.Controls, dic, form.Name.ToLower());
            }
            catch
            {
                // si el form se esta cerrando/disponiendo no quiero que el cambio de idioma tire excepcion
            }
        }

        private static void TraducirControlesAuto_43BO(Control.ControlCollection controles, Dictionary<string, string> dic, string prefijo)
        {
            foreach (Control c in controles)
            {
                if (c is Label || c is Button || c is CheckBox || c is RadioButton || c is GroupBox)
                {
                    string clave = prefijo + "_" + c.Name.ToLower();
                    if (dic.ContainsKey(clave)) c.Text = dic[clave];
                }

                if (c.Controls.Count > 0)
                    TraducirControlesAuto_43BO(c.Controls, dic, prefijo);
            }
        }
    }
}
