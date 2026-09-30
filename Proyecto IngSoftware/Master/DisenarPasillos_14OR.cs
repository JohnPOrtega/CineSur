using BE;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
        public partial class DisenarPasillos_14OR : Form
    {
      
        private MapaButacas_14OR mapa;

        private int filas;
        private int asientos;
        // columnas despues de las cuales hay pasillo 
        private List<int> pasillos = new List<int>();

        // el afuera lee esto despues de que la ventana cierra con Guardar
        public List<int> Pasillos
        {
            get { return pasillos; }
        }

        // filas y asientos = la grilla que eligio en el abm 
        // pasillosIniciales = si esta modificando, le paso los que ya tenia guardados.
        public DisenarPasillos_14OR(int filas, int asientos, List<int> pasillosIniciales)
        {
            this.filas = filas;
            this.asientos = asientos;
            if (pasillosIniciales != null)
                this.pasillos = pasillosIniciales.Where(p => p >= 1 && p < asientos).Distinct().OrderBy(p => p).ToList();

            InitializeComponent();

            // creo el mapa por codigo y lo meto en el panel que esta en el disenador
            mapa = new MapaButacas_14OR();
            mapa.Dock = DockStyle.Fill;
            mapa.AutoScroll = true;
            mapa.BackColor = Color.FromArgb(25, 27, 34);
            mapa.ButacaClickeada += Mapa_ButacaClickeada_14OR;
            panelMapa.Controls.Add(mapa);

            RedibujarMapa_14OR();
        }

        // vuelvo a dibujar la sala completa con los pasillos actuales.
        // armo las celdas al vuelo (todas Libre): es solo para ver la distribucion.
        private void RedibujarMapa_14OR()
        {
            List<CeldaMapa_14OR> celdas = new List<CeldaMapa_14OR>();
            for (int f = 1; f <= filas; f++)
            {
                for (int a = 1; a <= asientos; a++)
                {
                    celdas.Add(new CeldaMapa_14OR { Fila = f, Asiento = a, Estado = "Libre" });
                }
            }

            // clickeable=false pero modoDiseno=true -> todas responden al click
            mapa.Cargar_14OR(celdas, false, pasillos, true);
        }

        private void Mapa_ButacaClickeada_14OR(object sender, CeldaMapa_14OR celda)
        {
            int col = celda.Asiento;

            // no tiene sentido poner un pasillo despues de la ultima columna
            if (col >= asientos) return;

            if (pasillos.Contains(col))
                pasillos.Remove(col);   // ya habia pasillo aca -> lo saco
            else
                pasillos.Add(col);      // no habia -> lo pongo

            pasillos = pasillos.OrderBy(p => p).ToList();
            RedibujarMapa_14OR();
        }

        private void BtnGuardar_Click_14OR(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void BtnCancelar_Click_14OR(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }
    }
}
