using System.Collections.Generic;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
    // ventanita pa ver como estan las butacas de una sala, se abre desde Salas y es solo de lectura
    // el mapa esta puesto en el designer, aca nomas le paso las butacas y los pasillos
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
