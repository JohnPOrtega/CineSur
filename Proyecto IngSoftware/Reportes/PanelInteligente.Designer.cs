namespace Proyecto_IngSoftware
{
    partial class PanelInteligente
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            this.lblTitulo = new System.Windows.Forms.Label();
            this.lblSubtitulo = new System.Windows.Forms.Label();
            this.lblPeriodo = new System.Windows.Forms.Label();
            this.cboPeriodo = new System.Windows.Forms.ComboBox();
            this.lblDesde = new System.Windows.Forms.Label();
            this.dtpDesde = new System.Windows.Forms.DateTimePicker();
            this.lblHasta = new System.Windows.Forms.Label();
            this.dtpHasta = new System.Windows.Forms.DateTimePicker();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.btnExportar = new System.Windows.Forms.Button();
            this.pnlGeneral = new System.Windows.Forms.Panel();
            this.lblTituloResumen = new System.Windows.Forms.Label();
            this.pnlResumen = new System.Windows.Forms.Panel();
            this.lblTituloOcupacion = new System.Windows.Forms.Label();
            this.pnlOcupacion = new System.Windows.Forms.Panel();
            this.lblOcupacionValor = new System.Windows.Forms.Label();
            this.lblOcupacionDetalle = new System.Windows.Forms.Label();
            this.pnlOcupacionBarra = new System.Windows.Forms.Panel();
            this.lblTituloOrigen = new System.Windows.Forms.Label();
            this.chartIngresos = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.lblTituloRecomendaciones = new System.Windows.Forms.Label();
            this.lblLeyenda = new System.Windows.Forms.Label();
            this.pnlRecomendaciones = new System.Windows.Forms.Panel();
            this.pnlGeneral.SuspendLayout();
            this.pnlOcupacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.chartIngresos)).BeginInit();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 17F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(20, 12);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(196, 31);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Panel de Control";
            //
            // lblSubtitulo
            //
            this.lblSubtitulo.AutoSize = true;
            this.lblSubtitulo.Font = new System.Drawing.Font("Segoe UI", 9.5F);
            this.lblSubtitulo.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblSubtitulo.Location = new System.Drawing.Point(24, 50);
            this.lblSubtitulo.Name = "lblSubtitulo";
            this.lblSubtitulo.Size = new System.Drawing.Size(0, 17);
            this.lblSubtitulo.TabIndex = 1;
            //
            // lblPeriodo
            //
            this.lblPeriodo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblPeriodo.AutoSize = true;
            this.lblPeriodo.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblPeriodo.Location = new System.Drawing.Point(560, 25);
            this.lblPeriodo.Name = "lblPeriodo";
            this.lblPeriodo.Size = new System.Drawing.Size(51, 15);
            this.lblPeriodo.TabIndex = 2;
            this.lblPeriodo.Text = "Período:";
            //
            // cboPeriodo
            //
            this.cboPeriodo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.cboPeriodo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.cboPeriodo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboPeriodo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cboPeriodo.ForeColor = System.Drawing.Color.White;
            this.cboPeriodo.Location = new System.Drawing.Point(616, 21);
            this.cboPeriodo.Name = "cboPeriodo";
            this.cboPeriodo.Size = new System.Drawing.Size(160, 23);
            this.cboPeriodo.TabIndex = 3;
            this.cboPeriodo.SelectedIndexChanged += new System.EventHandler(this.cboPeriodo_SelectedIndexChanged);
            //
            // lblDesde
            //
            this.lblDesde.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblDesde.AutoSize = true;
            this.lblDesde.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDesde.Location = new System.Drawing.Point(792, 25);
            this.lblDesde.Name = "lblDesde";
            this.lblDesde.Size = new System.Drawing.Size(42, 15);
            this.lblDesde.TabIndex = 4;
            this.lblDesde.Text = "Desde:";
            //
            // dtpDesde
            //
            this.dtpDesde.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpDesde.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpDesde.Location = new System.Drawing.Point(838, 21);
            this.dtpDesde.Name = "dtpDesde";
            this.dtpDesde.Size = new System.Drawing.Size(110, 23);
            this.dtpDesde.TabIndex = 5;
            //
            // lblHasta
            //
            this.lblHasta.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblHasta.AutoSize = true;
            this.lblHasta.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblHasta.Location = new System.Drawing.Point(958, 25);
            this.lblHasta.Name = "lblHasta";
            this.lblHasta.Size = new System.Drawing.Size(40, 15);
            this.lblHasta.TabIndex = 6;
            this.lblHasta.Text = "Hasta:";
            //
            // dtpHasta
            //
            this.dtpHasta.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.dtpHasta.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpHasta.Location = new System.Drawing.Point(1002, 21);
            this.dtpHasta.Name = "dtpHasta";
            this.dtpHasta.Size = new System.Drawing.Size(110, 23);
            this.dtpHasta.TabIndex = 7;
            //
            // btnActualizar
            //
            this.btnActualizar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnActualizar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnActualizar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnActualizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnActualizar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnActualizar.ForeColor = System.Drawing.Color.White;
            this.btnActualizar.Location = new System.Drawing.Point(838, 54);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(130, 30);
            this.btnActualizar.TabIndex = 8;
            this.btnActualizar.Text = "Actualizar";
            this.btnActualizar.UseVisualStyleBackColor = false;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            //
            // btnExportar
            //
            this.btnExportar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnExportar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.btnExportar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(120)))), ((int)(((byte)(120)))));
            this.btnExportar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnExportar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnExportar.ForeColor = System.Drawing.Color.White;
            this.btnExportar.Location = new System.Drawing.Point(978, 54);
            this.btnExportar.Name = "btnExportar";
            this.btnExportar.Size = new System.Drawing.Size(134, 30);
            this.btnExportar.TabIndex = 9;
            this.btnExportar.Text = "Exportar PDF";
            this.btnExportar.UseVisualStyleBackColor = false;
            this.btnExportar.Click += new System.EventHandler(this.btnExportar_Click);
            //
            // pnlGeneral
            //
            this.pnlGeneral.AutoScroll = true;
            this.pnlGeneral.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlGeneral.Controls.Add(this.pnlRecomendaciones);
            this.pnlGeneral.Controls.Add(this.lblLeyenda);
            this.pnlGeneral.Controls.Add(this.lblTituloRecomendaciones);
            this.pnlGeneral.Controls.Add(this.chartIngresos);
            this.pnlGeneral.Controls.Add(this.lblTituloOrigen);
            this.pnlGeneral.Controls.Add(this.pnlOcupacion);
            this.pnlGeneral.Controls.Add(this.lblTituloOcupacion);
            this.pnlGeneral.Controls.Add(this.pnlResumen);
            this.pnlGeneral.Controls.Add(this.lblTituloResumen);
            this.pnlGeneral.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.pnlGeneral.Location = new System.Drawing.Point(16, 100);
            this.pnlGeneral.Name = "pnlGeneral";
            this.pnlGeneral.Size = new System.Drawing.Size(1168, 620);
            this.pnlGeneral.TabIndex = 10;
            //
            // lblTituloResumen
            //
            this.lblTituloResumen.AutoSize = true;
            this.lblTituloResumen.BackColor = System.Drawing.Color.Transparent;
            this.lblTituloResumen.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTituloResumen.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblTituloResumen.Location = new System.Drawing.Point(8, 8);
            this.lblTituloResumen.Name = "lblTituloResumen";
            this.lblTituloResumen.TabIndex = 0;
            this.lblTituloResumen.Tag = "panelinteligente_resumen";
            this.lblTituloResumen.Text = "RESUMEN DEL PERÍODO";
            //
            // pnlResumen
            //
            this.pnlResumen.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.pnlResumen.Location = new System.Drawing.Point(8, 36);
            this.pnlResumen.Name = "pnlResumen";
            this.pnlResumen.Size = new System.Drawing.Size(390, 306);
            this.pnlResumen.TabIndex = 1;
            //
            // lblTituloOcupacion
            //
            this.lblTituloOcupacion.AutoSize = true;
            this.lblTituloOcupacion.BackColor = System.Drawing.Color.Transparent;
            this.lblTituloOcupacion.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTituloOcupacion.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblTituloOcupacion.Location = new System.Drawing.Point(420, 8);
            this.lblTituloOcupacion.Name = "lblTituloOcupacion";
            this.lblTituloOcupacion.TabIndex = 2;
            this.lblTituloOcupacion.Tag = "panelinteligente_ocupacion_titulo";
            this.lblTituloOcupacion.Text = "OCUPACIÓN DE LAS SALAS";
            //
            // pnlOcupacion
            //
            this.pnlOcupacion.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.pnlOcupacion.Controls.Add(this.pnlOcupacionBarra);
            this.pnlOcupacion.Controls.Add(this.lblOcupacionDetalle);
            this.pnlOcupacion.Controls.Add(this.lblOcupacionValor);
            this.pnlOcupacion.Location = new System.Drawing.Point(420, 36);
            this.pnlOcupacion.Name = "pnlOcupacion";
            this.pnlOcupacion.Size = new System.Drawing.Size(724, 110);
            this.pnlOcupacion.TabIndex = 3;
            //
            // lblOcupacionValor
            //
            this.lblOcupacionValor.AutoSize = true;
            this.lblOcupacionValor.BackColor = System.Drawing.Color.Transparent;
            this.lblOcupacionValor.Font = new System.Drawing.Font("Segoe UI", 22F, System.Drawing.FontStyle.Bold);
            this.lblOcupacionValor.ForeColor = System.Drawing.Color.White;
            this.lblOcupacionValor.Location = new System.Drawing.Point(16, 10);
            this.lblOcupacionValor.Name = "lblOcupacionValor";
            this.lblOcupacionValor.TabIndex = 0;
            this.lblOcupacionValor.Text = "0,0 %";
            //
            // lblOcupacionDetalle
            //
            this.lblOcupacionDetalle.AutoSize = true;
            this.lblOcupacionDetalle.BackColor = System.Drawing.Color.Transparent;
            this.lblOcupacionDetalle.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblOcupacionDetalle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.lblOcupacionDetalle.Location = new System.Drawing.Point(20, 52);
            this.lblOcupacionDetalle.Name = "lblOcupacionDetalle";
            this.lblOcupacionDetalle.TabIndex = 1;
            this.lblOcupacionDetalle.Text = "";
            //
            // pnlOcupacionBarra
            //
            this.pnlOcupacionBarra.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.pnlOcupacionBarra.Location = new System.Drawing.Point(16, 78);
            this.pnlOcupacionBarra.Name = "pnlOcupacionBarra";
            this.pnlOcupacionBarra.Size = new System.Drawing.Size(692, 16);
            this.pnlOcupacionBarra.TabIndex = 2;
            this.pnlOcupacionBarra.Paint += new System.Windows.Forms.PaintEventHandler(this.PintarBarraOcupacion_14OR);
            //
            // lblTituloOrigen
            //
            this.lblTituloOrigen.AutoSize = true;
            this.lblTituloOrigen.BackColor = System.Drawing.Color.Transparent;
            this.lblTituloOrigen.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTituloOrigen.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblTituloOrigen.Location = new System.Drawing.Point(420, 158);
            this.lblTituloOrigen.Name = "lblTituloOrigen";
            this.lblTituloOrigen.TabIndex = 4;
            this.lblTituloOrigen.Tag = "panelinteligente_origen";
            this.lblTituloOrigen.Text = "INGRESOS POR ORIGEN";
            //
            // chartIngresos
            //
            this.chartIngresos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.chartIngresos.Location = new System.Drawing.Point(420, 184);
            this.chartIngresos.Name = "chartIngresos";
            this.chartIngresos.Size = new System.Drawing.Size(724, 158);
            this.chartIngresos.TabIndex = 5;
            //
            // lblTituloRecomendaciones
            //
            this.lblTituloRecomendaciones.AutoSize = true;
            this.lblTituloRecomendaciones.BackColor = System.Drawing.Color.Transparent;
            this.lblTituloRecomendaciones.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTituloRecomendaciones.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblTituloRecomendaciones.Location = new System.Drawing.Point(8, 360);
            this.lblTituloRecomendaciones.Name = "lblTituloRecomendaciones";
            this.lblTituloRecomendaciones.TabIndex = 6;
            this.lblTituloRecomendaciones.Tag = "panelinteligente_recomendaciones";
            this.lblTituloRecomendaciones.Text = "LO QUE EL SISTEMA DETECTÓ";
            //
            // lblLeyenda
            //
            this.lblLeyenda.AutoSize = true;
            this.lblLeyenda.BackColor = System.Drawing.Color.Transparent;
            this.lblLeyenda.Font = new System.Drawing.Font("Segoe UI", 8.5F);
            this.lblLeyenda.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.lblLeyenda.Location = new System.Drawing.Point(300, 363);
            this.lblLeyenda.Name = "lblLeyenda";
            this.lblLeyenda.TabIndex = 7;
            this.lblLeyenda.Tag = "panelinteligente_leyenda";
            this.lblLeyenda.Text = "Rojo: urgente · Amarillo: conviene revisarlo · Azul: dato útil";
            //
            // pnlRecomendaciones
            //
            this.pnlRecomendaciones.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.pnlRecomendaciones.Location = new System.Drawing.Point(8, 388);
            this.pnlRecomendaciones.Name = "pnlRecomendaciones";
            this.pnlRecomendaciones.Size = new System.Drawing.Size(1136, 60);
            this.pnlRecomendaciones.TabIndex = 8;
            //
            // PanelInteligente
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(1200, 736);
            this.Controls.Add(this.pnlGeneral);
            this.Controls.Add(this.btnExportar);
            this.Controls.Add(this.btnActualizar);
            this.Controls.Add(this.dtpHasta);
            this.Controls.Add(this.lblHasta);
            this.Controls.Add(this.dtpDesde);
            this.Controls.Add(this.lblDesde);
            this.Controls.Add(this.cboPeriodo);
            this.Controls.Add(this.lblPeriodo);
            this.Controls.Add(this.lblSubtitulo);
            this.Controls.Add(this.lblTitulo);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "PanelInteligente";
            this.Text = "Panel de Control";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.pnlGeneral.ResumeLayout(false);
            this.pnlGeneral.PerformLayout();
            this.pnlOcupacion.ResumeLayout(false);
            this.pnlOcupacion.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.chartIngresos)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Label lblSubtitulo;
        private System.Windows.Forms.Label lblPeriodo;
        private System.Windows.Forms.ComboBox cboPeriodo;
        private System.Windows.Forms.Label lblDesde;
        private System.Windows.Forms.DateTimePicker dtpDesde;
        private System.Windows.Forms.Label lblHasta;
        private System.Windows.Forms.DateTimePicker dtpHasta;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Button btnExportar;
        private System.Windows.Forms.Panel pnlGeneral;
        private System.Windows.Forms.Label lblTituloResumen;
        private System.Windows.Forms.Panel pnlResumen;
        private System.Windows.Forms.Label lblTituloOcupacion;
        private System.Windows.Forms.Panel pnlOcupacion;
        private System.Windows.Forms.Label lblOcupacionValor;
        private System.Windows.Forms.Label lblOcupacionDetalle;
        private System.Windows.Forms.Panel pnlOcupacionBarra;
        private System.Windows.Forms.Label lblTituloOrigen;
        private System.Windows.Forms.DataVisualization.Charting.Chart chartIngresos;
        private System.Windows.Forms.Label lblTituloRecomendaciones;
        private System.Windows.Forms.Label lblLeyenda;
        private System.Windows.Forms.Panel pnlRecomendaciones;
    }
}
