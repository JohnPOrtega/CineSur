using System.Collections.Generic;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // Ventana de solo lectura con la distribucion de butacas de una sala (se abre desde Salas).
    // El mapa esta puesto en el Designer; aca solo se le pasan las butacas y los pasillos.
    public partial class DistribucionSala_14OR : Form
    {
        public DistribucionSala_14OR(int idSala, List<CeldaMapa_14OR> celdas, List<int> pasillos)
        {
            InitializeComponent();
            this.Text = "Distribucion - Sala " + idSala;
            mapa.Cargar_14OR(celdas, false, pasillos); // false = solo lectura
        }
    }
}
