namespace Proyecto_IngSoftware
{
    partial class ReporteFunciones
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
            this.btnActualizar = new System.Windows.Forms.Button();
            this.btnExportarPdf = new System.Windows.Forms.Button();
            this.btnCerrar = new System.Windows.Forms.Button();
            this.lblTotales = new System.Windows.Forms.Label();
            this.dgvReporte = new System.Windows.Forms.DataGridView();
            this.btnLimpiarFiltros = new System.Windows.Forms.Button();
            this.lblDesde = new System.Windows.Forms.Label();
            this.dtpDesde = new System.Windows.Forms.DateTimePicker();
            this.lblHasta = new System.Windows.Forms.Label();
            this.dtpHasta = new System.Windows.Forms.DateTimePicker();
            this.lblPelicula = new System.Windows.Forms.Label();
            this.cboPelicula = new System.Windows.Forms.ComboBox();
            this.lblSala = new System.Windows.Forms.Label();
            this.cboSala = new System.Windows.Forms.ComboBox();
            this.pnlCard1 = new System.Windows.Forms.Panel();
            this.pnlCardMarca1 = new System.Windows.Forms.Panel();
            this.lblCardTitulo1 = new System.Windows.Forms.Label();
            this.lblCardValor1 = new System.Windows.Forms.Label();
            this.pnlCard2 = new System.Windows.Forms.Panel();
            this.pnlCardMarca2 = new System.Windows.Forms.Panel();
            this.lblCardTitulo2 = new System.Windows.Forms.Label();
            this.lblCardValor2 = new System.Windows.Forms.Label();
            this.pnlCard3 = new System.Windows.Forms.Panel();
            this.pnlCardMarca3 = new System.Windows.Forms.Panel();
            this.lblCardTitulo3 = new System.Windows.Forms.Label();
            this.lblCardValor3 = new System.Windows.Forms.Label();
            this.pnlCard4 = new System.Windows.Forms.Panel();
            this.pnlCardMarca4 = new System.Windows.Forms.Panel();
            this.lblCardTitulo4 = new System.Windows.Forms.Label();
            this.lblCardValor4 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReporte)).BeginInit();
            this.pnlCard1.SuspendLayout();
            this.pnlCard2.SuspendLayout();
            this.pnlCard3.SuspendLayout();
            this.pnlCard4.SuspendLayout();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 16F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(20, 14);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(560, 30);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "RF1 - Listado de Funciones y Ocupacion de Sala";
            //
            // btnActualizar
            //
            this.btnActualizar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnActualizar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnActualizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnActualizar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnActualizar.ForeColor = System.Drawing.Color.White;
            this.btnActualizar.Location = new System.Drawing.Point(24, 56);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(130, 32);
            this.btnActualizar.TabIndex = 1;
            this.btnActualizar.Text = "Actualizar";
            this.btnActualizar.UseVisualStyleBackColor = false;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            //
            // btnExportarPdf
            //
            this.btnExportarPdf.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnExportarPdf.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnExportarPdf.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnExportarPdf.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnExportarPdf.ForeColor = System.Drawing.Color.White;
            this.btnExportarPdf.Location = new System.Drawing.Point(164, 56);
            this.btnExportarPdf.Name = "btnExportarPdf";
            this.btnExportarPdf.Size = new System.Drawing.Size(130, 32);
            this.btnExportarPdf.TabIndex = 2;
            this.btnExportarPdf.Text = "Exportar PDF";
            this.btnExportarPdf.UseVisualStyleBackColor = false;
            this.btnExportarPdf.Click += new System.EventHandler(this.btnExportarPdf_Click);
            //
            // btnCerrar
            //
            this.btnCerrar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCerrar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.btnCerrar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(120)))), ((int)(((byte)(120)))));
            this.btnCerrar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCerrar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnCerrar.ForeColor = System.Drawing.Color.White;
            this.btnCerrar.Location = new System.Drawing.Point(864, 56);
            this.btnCerrar.Name = "btnCerrar";
            this.btnCerrar.Size = new System.Drawing.Size(106, 32);
            this.btnCerrar.TabIndex = 3;
            this.btnCerrar.Text = "Cerrar";
            this.btnCerrar.UseVisualStyleBackColor = false;
            this.btnCerrar.Click += new System.EventHandler(this.btnCerrar_Click);
            //
            // lblTotales
            //
            this.lblTotales.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.lblTotales.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblTotales.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblTotales.Location = new System.Drawing.Point(24, 540);
            this.lblTotales.Name = "lblTotales";
            this.lblTotales.Size = new System.Drawing.Size(946, 30);
            this.lblTotales.TabIndex = 5;
            this.lblTotales.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            //
            // dgvReporte
            //
            this.dgvReporte.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvReporte.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvReporte.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvReporte.AllowUserToAddRows = false;
            this.dgvReporte.ReadOnly = true;
            this.dgvReporte.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvReporte.EnableHeadersVisualStyles = false;
            this.dgvReporte.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(61)))), ((int)(((byte)(61)))), ((int)(((byte)(61)))));
            this.dgvReporte.Location = new System.Drawing.Point(24, 230);
            this.dgvReporte.Name = "dgvReporte";
            this.dgvReporte.RowHeadersVisible = false;
            this.dgvReporte.RowHeadersWidth = 51;
            this.dgvReporte.MultiSelect = false;
            this.dgvReporte.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvReporte.Size = new System.Drawing.Size(946, 300);
            this.dgvReporte.TabIndex = 4;
            this.dgvReporte.ColumnHeadersDefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(46)))));
            this.dgvReporte.ColumnHeadersDefaultCellStyle.ForeColor = System.Drawing.Color.Gainsboro;
            this.dgvReporte.ColumnHeadersDefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(46)))));
            this.dgvReporte.DefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvReporte.DefaultCellStyle.ForeColor = System.Drawing.Color.Gainsboro;
            this.dgvReporte.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(18)))), ((int)(((byte)(58)))), ((int)(((byte)(94)))));
            this.dgvReporte.DefaultCellStyle.SelectionForeColor = System.Drawing.Color.White;
            this.dgvReporte.AlternatingRowsDefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            //
            // btnLimpiarFiltros
            //
            this.btnLimpiarFiltros.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.btnLimpiarFiltros.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(120)))), ((int)(((byte)(120)))));
            this.btnLimpiarFiltros.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLimpiarFiltros.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnLimpiarFiltros.ForeColor = System.Drawing.Color.White;
            this.btnLimpiarFiltros.Location = new System.Drawing.Point(304, 56);
            this.btnLimpiarFiltros.Name = "btnLimpiarFiltros";
            this.btnLimpiarFiltros.Size = new System.Drawing.Size(130, 32);
            this.btnLimpiarFiltros.TabIndex = 6;
            this.btnLimpiarFiltros.Text = "Limpiar filtros";
            this.btnLimpiarFiltros.UseVisualStyleBackColor = false;
            this.btnLimpiarFiltros.Click += new System.EventHandler(this.btnLimpiarFiltros_Click);
            //
            // lblDesde
            //
            this.lblDesde.AutoSize = true;
            this.lblDesde.BackColor = System.Drawing.Color.Transparent;
            this.lblDesde.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblDesde.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDesde.Location = new System.Drawing.Point(24, 108);
            this.lblDesde.Name = "lblDesde";
            this.lblDesde.TabIndex = 7;
            this.lblDesde.Text = "Desde:";
            //
            // dtpDesde
            //
            this.dtpDesde.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpDesde.Location = new System.Drawing.Point(72, 104);
            this.dtpDesde.Name = "dtpDesde";
            this.dtpDesde.ShowCheckBox = true;
            this.dtpDesde.Checked = false;
            this.dtpDesde.Size = new System.Drawing.Size(130, 23);
            this.dtpDesde.TabIndex = 8;
            this.dtpDesde.ValueChanged += new System.EventHandler(this.Filtro_Changed);
            //
            // lblHasta
            //
            this.lblHasta.AutoSize = true;
            this.lblHasta.BackColor = System.Drawing.Color.Transparent;
            this.lblHasta.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblHasta.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblHasta.Location = new System.Drawing.Point(216, 108);
            this.lblHasta.Name = "lblHasta";
            this.lblHasta.TabIndex = 9;
            this.lblHasta.Text = "Hasta:";
            //
            // dtpHasta
            //
            this.dtpHasta.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpHasta.Location = new System.Drawing.Point(262, 104);
            this.dtpHasta.Name = "dtpHasta";
            this.dtpHasta.ShowCheckBox = true;
            this.dtpHasta.Checked = false;
            this.dtpHasta.Size = new System.Drawing.Size(130, 23);
            this.dtpHasta.TabIndex = 10;
            this.dtpHasta.ValueChanged += new System.EventHandler(this.Filtro_Changed);
            //
            // lblPelicula
            //
            this.lblPelicula.AutoSize = true;
            this.lblPelicula.BackColor = System.Drawing.Color.Transparent;
            this.lblPelicula.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblPelicula.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblPelicula.Location = new System.Drawing.Point(410, 108);
            this.lblPelicula.Name = "lblPelicula";
            this.lblPelicula.TabIndex = 11;
            this.lblPelicula.Text = "Película:";
            //
            // cboPelicula
            //
            this.cboPelicula.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.cboPelicula.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboPelicula.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cboPelicula.ForeColor = System.Drawing.Color.White;
            this.cboPelicula.Location = new System.Drawing.Point(472, 104);
            this.cboPelicula.Name = "cboPelicula";
            this.cboPelicula.Size = new System.Drawing.Size(230, 23);
            this.cboPelicula.TabIndex = 12;
            this.cboPelicula.SelectedIndexChanged += new System.EventHandler(this.Filtro_Changed);
            //
            // lblSala
            //
            this.lblSala.AutoSize = true;
            this.lblSala.BackColor = System.Drawing.Color.Transparent;
            this.lblSala.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblSala.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblSala.Location = new System.Drawing.Point(720, 108);
            this.lblSala.Name = "lblSala";
            this.lblSala.TabIndex = 13;
            this.lblSala.Text = "Sala:";
            //
            // cboSala
            //
            this.cboSala.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.cboSala.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboSala.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cboSala.ForeColor = System.Drawing.Color.White;
            this.cboSala.Location = new System.Drawing.Point(758, 104);
            this.cboSala.Name = "cboSala";
            this.cboSala.Size = new System.Drawing.Size(110, 23);
            this.cboSala.TabIndex = 14;
            this.cboSala.SelectedIndexChanged += new System.EventHandler(this.Filtro_Changed);
            //
            // pnlCard1
            //
            this.pnlCard1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.pnlCard1.Controls.Add(this.lblCardValor1);
            this.pnlCard1.Controls.Add(this.lblCardTitulo1);
            this.pnlCard1.Controls.Add(this.pnlCardMarca1);
            this.pnlCard1.Location = new System.Drawing.Point(24, 142);
            this.pnlCard1.Name = "pnlCard1";
            this.pnlCard1.Size = new System.Drawing.Size(226, 72);
            this.pnlCard1.TabIndex = 15;
            //
            // pnlCardMarca1
            //
            this.pnlCardMarca1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.pnlCardMarca1.Dock = System.Windows.Forms.DockStyle.Left;
            this.pnlCardMarca1.Name = "pnlCardMarca1";
            this.pnlCardMarca1.Size = new System.Drawing.Size(4, 72);
            this.pnlCardMarca1.TabIndex = 0;
            //
            // lblCardTitulo1
            //
            this.lblCardTitulo1.AutoSize = true;
            this.lblCardTitulo1.BackColor = System.Drawing.Color.Transparent;
            this.lblCardTitulo1.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblCardTitulo1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.lblCardTitulo1.Location = new System.Drawing.Point(16, 10);
            this.lblCardTitulo1.Name = "lblCardTitulo1";
            this.lblCardTitulo1.TabIndex = 1;
            this.lblCardTitulo1.Text = "Funciones";
            //
            // lblCardValor1
            //
            this.lblCardValor1.AutoSize = true;
            this.lblCardValor1.BackColor = System.Drawing.Color.Transparent;
            this.lblCardValor1.Font = new System.Drawing.Font("Segoe UI", 18F, System.Drawing.FontStyle.Bold);
            this.lblCardValor1.ForeColor = System.Drawing.Color.White;
            this.lblCardValor1.Location = new System.Drawing.Point(14, 30);
            this.lblCardValor1.Name = "lblCardValor1";
            this.lblCardValor1.TabIndex = 2;
            this.lblCardValor1.Text = "0";
            //
            // pnlCard2
            //
            this.pnlCard2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.pnlCard2.Controls.Add(this.lblCardValor2);
            this.pnlCard2.Controls.Add(this.lblCardTitulo2);
            this.pnlCard2.Controls.Add(this.pnlCardMarca2);
            this.pnlCard2.Location = new System.Drawing.Point(264, 142);
            this.pnlCard2.Name = "pnlCard2";
            this.pnlCard2.Size = new System.Drawing.Size(226, 72);
            this.pnlCard2.TabIndex = 16;
            //
            // pnlCardMarca2
            //
            this.pnlCardMarca2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.pnlCardMarca2.Dock = System.Windows.Forms.DockStyle.Left;
            this.pnlCardMarca2.Name = "pnlCardMarca2";
            this.pnlCardMarca2.Size = new System.Drawing.Size(4, 72);
            this.pnlCardMarca2.TabIndex = 0;
            //
            // lblCardTitulo2
            //
            this.lblCardTitulo2.AutoSize = true;
            this.lblCardTitulo2.BackColor = System.Drawing.Color.Transparent;
            this.lblCardTitulo2.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblCardTitulo2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.lblCardTitulo2.Location = new System.Drawing.Point(16, 10);
            this.lblCardTitulo2.Name = "lblCardTitulo2";
            this.lblCardTitulo2.TabIndex = 1;
            this.lblCardTitulo2.Text = "Tickets vendidos";
            //
            // lblCardValor2
            //
            this.lblCardValor2.AutoSize = true;
            this.lblCardValor2.BackColor = System.Drawing.Color.Transparent;
            this.lblCardValor2.Font = new System.Drawing.Font("Segoe UI", 18F, System.Drawing.FontStyle.Bold);
            this.lblCardValor2.ForeColor = System.Drawing.Color.White;
            this.lblCardValor2.Location = new System.Drawing.Point(14, 30);
            this.lblCardValor2.Name = "lblCardValor2";
            this.lblCardValor2.TabIndex = 2;
            this.lblCardValor2.Text = "0";
            //
            // pnlCard3
            //
            this.pnlCard3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.pnlCard3.Controls.Add(this.lblCardValor3);
            this.pnlCard3.Controls.Add(this.lblCardTitulo3);
            this.pnlCard3.Controls.Add(this.pnlCardMarca3);
            this.pnlCard3.Location = new System.Drawing.Point(504, 142);
            this.pnlCard3.Name = "pnlCard3";
            this.pnlCard3.Size = new System.Drawing.Size(226, 72);
            this.pnlCard3.TabIndex = 17;
            //
            // pnlCardMarca3
            //
            this.pnlCardMarca3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.pnlCardMarca3.Dock = System.Windows.Forms.DockStyle.Left;
            this.pnlCardMarca3.Name = "pnlCardMarca3";
            this.pnlCardMarca3.Size = new System.Drawing.Size(4, 72);
            this.pnlCardMarca3.TabIndex = 0;
            //
            // lblCardTitulo3
            //
            this.lblCardTitulo3.AutoSize = true;
            this.lblCardTitulo3.BackColor = System.Drawing.Color.Transparent;
            this.lblCardTitulo3.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblCardTitulo3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.lblCardTitulo3.Location = new System.Drawing.Point(16, 10);
            this.lblCardTitulo3.Name = "lblCardTitulo3";
            this.lblCardTitulo3.TabIndex = 1;
            this.lblCardTitulo3.Text = "Ocupación";
            //
            // lblCardValor3
            //
            this.lblCardValor3.AutoSize = true;
            this.lblCardValor3.BackColor = System.Drawing.Color.Transparent;
            this.lblCardValor3.Font = new System.Drawing.Font("Segoe UI", 18F, System.Drawing.FontStyle.Bold);
            this.lblCardValor3.ForeColor = System.Drawing.Color.White;
            this.lblCardValor3.Location = new System.Drawing.Point(14, 30);
            this.lblCardValor3.Name = "lblCardValor3";
            this.lblCardValor3.TabIndex = 2;
            this.lblCardValor3.Text = "0";
            //
            // pnlCard4
            //
            this.pnlCard4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(48)))));
            this.pnlCard4.Controls.Add(this.lblCardValor4);
            this.pnlCard4.Controls.Add(this.lblCardTitulo4);
            this.pnlCard4.Controls.Add(this.pnlCardMarca4);
            this.pnlCard4.Location = new System.Drawing.Point(744, 142);
            this.pnlCard4.Name = "pnlCard4";
            this.pnlCard4.Size = new System.Drawing.Size(226, 72);
            this.pnlCard4.TabIndex = 18;
            //
            // pnlCardMarca4
            //
            this.pnlCardMarca4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.pnlCardMarca4.Dock = System.Windows.Forms.DockStyle.Left;
            this.pnlCardMarca4.Name = "pnlCardMarca4";
            this.pnlCardMarca4.Size = new System.Drawing.Size(4, 72);
            this.pnlCardMarca4.TabIndex = 0;
            //
            // lblCardTitulo4
            //
            this.lblCardTitulo4.AutoSize = true;
            this.lblCardTitulo4.BackColor = System.Drawing.Color.Transparent;
            this.lblCardTitulo4.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblCardTitulo4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.lblCardTitulo4.Location = new System.Drawing.Point(16, 10);
            this.lblCardTitulo4.Name = "lblCardTitulo4";
            this.lblCardTitulo4.TabIndex = 1;
            this.lblCardTitulo4.Text = "Recaudación";
            //
            // lblCardValor4
            //
            this.lblCardValor4.AutoSize = true;
            this.lblCardValor4.BackColor = System.Drawing.Color.Transparent;
            this.lblCardValor4.Font = new System.Drawing.Font("Segoe UI", 18F, System.Drawing.FontStyle.Bold);
            this.lblCardValor4.ForeColor = System.Drawing.Color.White;
            this.lblCardValor4.Location = new System.Drawing.Point(14, 30);
            this.lblCardValor4.Name = "lblCardValor4";
            this.lblCardValor4.TabIndex = 2;
            this.lblCardValor4.Text = "0";
            //
            // ReporteFunciones
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(994, 588);
            this.Controls.Add(this.btnLimpiarFiltros);
            this.Controls.Add(this.lblDesde);
            this.Controls.Add(this.dtpDesde);
            this.Controls.Add(this.lblHasta);
            this.Controls.Add(this.dtpHasta);
            this.Controls.Add(this.lblPelicula);
            this.Controls.Add(this.cboPelicula);
            this.Controls.Add(this.lblSala);
            this.Controls.Add(this.cboSala);
            this.Controls.Add(this.pnlCard1);
            this.Controls.Add(this.pnlCard2);
            this.Controls.Add(this.pnlCard3);
            this.Controls.Add(this.pnlCard4);
            this.Controls.Add(this.lblTotales);
            this.Controls.Add(this.dgvReporte);
            this.Controls.Add(this.btnCerrar);
            this.Controls.Add(this.btnExportarPdf);
            this.Controls.Add(this.btnActualizar);
            this.Controls.Add(this.lblTitulo);
            this.Name = "ReporteFunciones";
            this.Text = "Reporte de Funciones";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            ((System.ComponentModel.ISupportInitialize)(this.dgvReporte)).EndInit();
            this.pnlCard1.ResumeLayout(false);
            this.pnlCard1.PerformLayout();
            this.pnlCard2.ResumeLayout(false);
            this.pnlCard2.PerformLayout();
            this.pnlCard3.ResumeLayout(false);
            this.pnlCard3.PerformLayout();
            this.pnlCard4.ResumeLayout(false);
            this.pnlCard4.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Button btnExportarPdf;
        private System.Windows.Forms.Button btnCerrar;
        private System.Windows.Forms.Label lblTotales;
        private System.Windows.Forms.DataGridView dgvReporte;
        private System.Windows.Forms.Button btnLimpiarFiltros;
        private System.Windows.Forms.Label lblDesde;
        private System.Windows.Forms.DateTimePicker dtpDesde;
        private System.Windows.Forms.Label lblHasta;
        private System.Windows.Forms.DateTimePicker dtpHasta;
        private System.Windows.Forms.Label lblPelicula;
        private System.Windows.Forms.ComboBox cboPelicula;
        private System.Windows.Forms.Label lblSala;
        private System.Windows.Forms.ComboBox cboSala;
        private System.Windows.Forms.Panel pnlCard1;
        private System.Windows.Forms.Panel pnlCardMarca1;
        private System.Windows.Forms.Label lblCardTitulo1;
        private System.Windows.Forms.Label lblCardValor1;
        private System.Windows.Forms.Panel pnlCard2;
        private System.Windows.Forms.Panel pnlCardMarca2;
        private System.Windows.Forms.Label lblCardTitulo2;
        private System.Windows.Forms.Label lblCardValor2;
        private System.Windows.Forms.Panel pnlCard3;
        private System.Windows.Forms.Panel pnlCardMarca3;
        private System.Windows.Forms.Label lblCardTitulo3;
        private System.Windows.Forms.Label lblCardValor3;
        private System.Windows.Forms.Panel pnlCard4;
        private System.Windows.Forms.Panel pnlCardMarca4;
        private System.Windows.Forms.Label lblCardTitulo4;
        private System.Windows.Forms.Label lblCardValor4;
    }
}
