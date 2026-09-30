using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Proyecto_IngSoftware
{
   //utilice un UC porque lo usa tnato ventas como control de acceso 
    public partial class MapaButacas_14OR : UserControl
    {
        private bool _clickeable = false;

        // en modo diseno todas las butacas son clickeables (para elegir por donde va el pasillo),
        // 
        private bool _modoDiseno = false;

        //
        private bool _clickTodas = false;

        // cuadn se lo encesito se lo invoca
        public event EventHandler<CeldaMapa_14OR> ButacaClickeada;

        public MapaButacas_14OR()
        {
            InitializeComponent();
        }

        // dibuja todo el mapa.
 
        public void Cargar_14OR(List<CeldaMapa_14OR> celdas, bool clickeable, List<int> pasillosDespuesDe = null, bool modoDiseno = false, bool clickTodas = false)
        {
            _clickeable = clickeable;
            _modoDiseno = modoDiseno;
            _clickTodas = clickTodas;
            this.Controls.Clear();

            if (celdas == null || celdas.Count == 0) return;
            if (pasillosDespuesDe == null) pasillosDespuesDe = new List<int>();

            int tam = 26;          // tamano de cada butaca
            int gap = 4;           // separacion entre butacas
            int paso = tam + gap;
            int anchoPasillo = 18; // cuanto espacio deja cada pasillo
            int margenIzq = 28;    // lugar a la izquierda para el numero de fila
            int topPantalla = 6;
            int topNumeros = 28;   // fila de numeros de columna
            int topButacas = 46;   // las butacas arrancan debajo de los numeros

            int maxFila = celdas.Max(c => c.Fila);
            int maxAsiento = celdas.Max(c => c.Asiento);

            //
            Func<int, int> calcularX = (asiento) =>
            {
                int pasillosAntes = pasillosDespuesDe.Count(col => col < asiento);
                return margenIzq + (asiento - 1) * paso + pasillosAntes * anchoPasillo;
            };

            int anchoTotal = calcularX(maxAsiento) + tam - margenIzq;

            // cartel PANTALLA arriba, centrado sobre todo el ancho
            Label pantalla = new Label();
            pantalla.Text = "P A N T A L L A";
            pantalla.ForeColor = Color.Gainsboro;
            pantalla.Font = new Font("Segoe UI", 8F, FontStyle.Bold);
            pantalla.TextAlign = ContentAlignment.MiddleCenter;
            pantalla.BackColor = Color.FromArgb(60, 63, 72);
            pantalla.Location = new Point(margenIzq, topPantalla);
            pantalla.Size = new Size(anchoTotal, 18);
            this.Controls.Add(pantalla);

            // numero de las columnas del
            for (int a = 1; a <= maxAsiento; a++)
            {
                Label lblCol = new Label();
                lblCol.Text = a.ToString();
                lblCol.ForeColor = Color.Gray;
                lblCol.Font = new Font("Segoe UI", 7.5F);
                lblCol.TextAlign = ContentAlignment.MiddleCenter;
                lblCol.Location = new Point(calcularX(a), topNumeros);
                lblCol.Size = new Size(tam, 14);
                this.Controls.Add(lblCol);
            }

            //for para agregar la filas  de letras de l ziquierda 
            for (int f = 1; f <= maxFila; f++)
            {
                int y = topButacas + (f - 1) * paso;

                Label lblFila = new Label();
        
                //ojajla funncione ahora
                lblFila.Text = ((char)('A' + f - 1)).ToString();
                lblFila.ForeColor = Color.Gray;
                lblFila.Font = new Font("Segoe UI", 8F);
                lblFila.TextAlign = ContentAlignment.MiddleCenter;
                lblFila.Location = new Point(0, y);
                lblFila.Size = new Size(margenIzq - 4, tam);
                this.Controls.Add(lblFila);
            }

            // una butaca (boton) por cada celda
            foreach (CeldaMapa_14OR celda in celdas)
            {
                int x = calcularX(celda.Asiento);
                int y = topButacas + (celda.Fila - 1) * paso;

                Button b = new Button();
                b.Size = new Size(tam, tam);
                b.Location = new Point(x, y);
                b.FlatStyle = FlatStyle.Flat;
                b.FlatAppearance.BorderSize = 0;
                b.BackColor = ColorDeEstado_14OR(celda.Estado);
                b.ForeColor = Color.White;
                b.Font = new Font("Segoe UI", 6F);
                b.TabStop = false;
                b.Tag = celda; // me guardo la celda adentro del boton para saber cual se toco

                // en modo diseno todas son clickeables (elijo columnas para el pasillo).
                // en modo normal solo engancho el click si es clickeable y la butaca se puede elegir
                bool disponible = celda.Estado == "Libre" || celda.Estado == "Accesible" || celda.Estado == "Seleccionada";
                if (_modoDiseno || _clickTodas || (_clickeable && disponible))
                {
                    b.Click += Butaca_Click_14OR;
                }

                this.Controls.Add(b);
            }
        }

        private void Butaca_Click_14OR(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            CeldaMapa_14OR celda = (CeldaMapa_14OR)b.Tag;
            if (ButacaClickeada != null) ButacaClickeada(this, celda);
        }

        // el color de cada butaca segun su estado
        private Color ColorDeEstado_14OR(string estado)
        {
            switch (estado)
            {
                case "Seleccionada": return Color.FromArgb(231, 168, 26);   // ambar/amarillo son los que se seleccionan mientras se sta reservando los asintnos 
                case "Ocupada": return Color.FromArgb(120, 40, 40);         // rojo oscuro son los vendidos "ocuapdos"
                case "Reservada": return Color.FromArgb(200, 60, 55);       // rojo  estan bloqeuados temporalmeten
                case "Deshabilitada": return Color.FromArgb(60, 60, 60);    // casi negro 
                case "Accesible": return Color.FromArgb(62, 124, 168);      // azul son los normales
                case "Utilizada": return Color.FromArgb(150, 90, 200);      // violeta/morado (ya ingreso) - se distingue bien del rojo de ocupada
                default: return Color.FromArgb(76, 140, 90);                // verde = Libre
            }
        }
    }

    // esto es lo que le paso al control para dibujar cada butaca.
    
    public class CeldaMapa_14OR
    {
        public int Fila;
        public int Asiento;
        public string Estado;       // "Libre","Ocupada","Reservada","Deshabilitada","Accesible","Utilizada","Seleccionada"
        public object Referencia;   //esto lo pongo po si necesito guardar algo adicional
    }
}
