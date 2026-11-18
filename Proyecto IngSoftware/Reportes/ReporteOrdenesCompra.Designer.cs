namespace Proyecto_IngSoftware
{
    partial class ReporteOrdenesCompra
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
            this.lblOrdenes = new System.Windows.Forms.Label();
            this.dgvOrdenes = new System.Windows.Forms.DataGridView();
            this.lblDetalle = new System.Windows.Forms.Label();
            this.dgvDetalle = new System.Windows.Forms.DataGridView();
            this.lblTotales = new System.Windows.Forms.Label();
            this.btnLimpiarFiltros = new System.Windows.Forms.Button();
            this.lblDesde = new System.Windows.Forms.Label();
            this.dtpDesde = new System.Windows.Forms.DateTimePicker();
            this.lblHasta = new System.Windows.Forms.Label();
            this.dtpHasta = new System.Windows.Forms.DateTimePicker();
            this.lblEstado = new System.Windows.Forms.Label();
            this.cboEstado = new System.Windows.Forms.ComboBox();
            this.lblProveedor = new System.Windows.Forms.Label();
            this.cboProveedor = new System.Windows.Forms.ComboBox();
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
            ((System.ComponentModel.ISupportInitialize)(this.dgvOrdenes)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDetalle)).BeginInit();
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
            this.lblTitulo.Size = new System.Drawing.Size(620, 30);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "RF2 - Detalle de Orden de Compra y Recepcion";
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
            // lblOrdenes
            //
            this.lblOrdenes.AutoSize = true;
            this.lblOrdenes.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblOrdenes.Location = new System.Drawing.Point(24, 224);
            this.lblOrdenes.Name = "lblOrdenes";
            this.lblOrdenes.Size = new System.Drawing.Size(120, 15);
            this.lblOrdenes.TabIndex = 4;
            this.lblOrdenes.Text = "Ordenes de compra:";
            //
            // dgvOrdenes
            //
            this.dgvOrdenes.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.dgvOrdenes.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvOrdenes.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvOrdenes.AllowUserToAddRows = false;
            this.dgvOrdenes.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvOrdenes.EnableHeadersVisualStyles = false;
            this.dgvOrdenes.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(61)))), ((int)(((byte)(61)))), ((int)(((byte)(61)))));
            this.dgvOrdenes.MultiSelect = false;
            this.dgvOrdenes.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvOrdenes.ColumnHeadersDefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(46)))));
            this.dgvOrdenes.ColumnHeadersDefaultCellStyle.ForeColor = System.Drawing.Color.Gainsboro;
            this.dgvOrdenes.ColumnHeadersDefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(46)))));
            this.dgvOrdenes.DefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvOrdenes.DefaultCellStyle.ForeColor = System.Drawing.Color.Gainsboro;
            this.dgvOrdenes.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(18)))), ((int)(((byte)(58)))), ((int)(((byte)(94)))));
            this.dgvOrdenes.DefaultCellStyle.SelectionForeColor = System.Drawing.Color.White;
            this.dgvOrdenes.AlternatingRowsDefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.dgvOrdenes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvOrdenes.Location = new System.Drawing.Point(24, 244);
            this.dgvOrdenes.Name = "dgvOrdenes";
            this.dgvOrdenes.ReadOnly = true;
            this.dgvOrdenes.RowHeadersVisible = false;
            this.dgvOrdenes.Size = new System.Drawing.Size(946, 150);
            this.dgvOrdenes.TabIndex = 5;
            this.dgvOrdenes.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvOrdenes_CellClick);
            //
            // lblDetalle
            //
            this.lblDetalle.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.lblDetalle.AutoSize = true;
            this.lblDetalle.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDetalle.Location = new System.Drawing.Point(24, 402);
            this.lblDetalle.Name = "lblDetalle";
            this.lblDetalle.Size = new System.Drawing.Size(200, 15);
            this.lblDetalle.TabIndex = 6;
            this.lblDetalle.Text = "Detalle de la orden seleccionada:";
            //
            // dgvDetalle
            //
            this.dgvDetalle.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right))));
            this.dgvDetalle.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvDetalle.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvDetalle.AllowUserToAddRows = false;
            this.dgvDetalle.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvDetalle.EnableHeadersVisualStyles = false;
            this.dgvDetalle.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(61)))), ((int)(((byte)(61)))), ((int)(((byte)(61)))));
            this.dgvDetalle.MultiSelect = false;
            this.dgvDetalle.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvDetalle.ColumnHeadersDefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(46)))));
            this.dgvDetalle.ColumnHeadersDefaultCellStyle.ForeColor = System.Drawing.Color.Gainsboro;
            this.dgvDetalle.ColumnHeadersDefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(46)))));
            this.dgvDetalle.DefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvDetalle.DefaultCellStyle.ForeColor = System.Drawing.Color.Gainsboro;
            this.dgvDetalle.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(18)))), ((int)(((byte)(58)))), ((int)(((byte)(94)))));
            this.dgvDetalle.DefaultCellStyle.SelectionForeColor = System.Drawing.Color.White;
            this.dgvDetalle.AlternatingRowsDefaultCellStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.dgvDetalle.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDetalle.Location = new System.Drawing.Point(24, 422);
            this.dgvDetalle.Name = "dgvDetalle";
            this.dgvDetalle.ReadOnly = true;
            this.dgvDetalle.RowHeadersVisible = false;
            this.dgvDetalle.Size = new System.Drawing.Size(946, 108);
            this.dgvDetalle.TabIndex = 7;
            //
            // lblTotales
            //
            this.lblTotales.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.lblTotales.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblTotales.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblTotales.Location = new System.Drawing.Point(24, 538);
            this.lblTotales.Name = "lblTotales";
            this.lblTotales.Size = new System.Drawing.Size(946, 30);
            this.lblTotales.TabIndex = 8;
            this.lblTotales.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
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
            this.btnLimpiarFiltros.TabIndex = 9;
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
            this.lblDesde.TabIndex = 10;
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
            this.dtpDesde.TabIndex = 11;
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
            this.lblHasta.TabIndex = 12;
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
            this.dtpHasta.TabIndex = 13;
            this.dtpHasta.ValueChanged += new System.EventHandler(this.Filtro_Changed);
            //
            // lblEstado
            //
            this.lblEstado.AutoSize = true;
            this.lblEstado.BackColor = System.Drawing.Color.Transparent;
            this.lblEstado.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblEstado.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblEstado.Location = new System.Drawing.Point(410, 108);
            this.lblEstado.Name = "lblEstado";
            this.lblEstado.TabIndex = 14;
            this.lblEstado.Text = "Estado:";
            //
            // cboEstado
            //
            this.cboEstado.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.cboEstado.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboEstado.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cboEstado.ForeColor = System.Drawing.Color.White;
            this.cboEstado.Location = new System.Drawing.Point(462, 104);
            this.cboEstado.Name = "cboEstado";
            this.cboEstado.Size = new System.Drawing.Size(130, 23);
            this.cboEstado.TabIndex = 15;
            this.cboEstado.Items.AddRange(new object[] {
            "(Todos)",
            "Abierta",
            "Pagada",
            "Cerrada"});
            this.cboEstado.SelectedIndexChanged += new System.EventHandler(this.Filtro_Changed);
            //
            // lblProveedor
            //
            this.lblProveedor.AutoSize = true;
            this.lblProveedor.BackColor = System.Drawing.Color.Transparent;
            this.lblProveedor.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.lblProveedor.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblProveedor.Location = new System.Drawing.Point(610, 108);
            this.lblProveedor.Name = "lblProveedor";
            this.lblProveedor.TabIndex = 16;
            this.lblProveedor.Text = "Proveedor:";
            //
            // cboProveedor
            //
            this.cboProveedor.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.cboProveedor.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboProveedor.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cboProveedor.ForeColor = System.Drawing.Color.White;
            this.cboProveedor.Location = new System.Drawing.Point(690, 104);
            this.cboProveedor.Name = "cboProveedor";
            this.cboProveedor.Size = new System.Drawing.Size(180, 23);
            this.cboProveedor.TabIndex = 17;
            this.cboProveedor.SelectedIndexChanged += new System.EventHandler(this.Filtro_Changed);
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
            this.pnlCard1.TabIndex = 18;
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
            this.lblCardTitulo1.Text = "Órdenes";
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
            this.pnlCard2.TabIndex = 19;
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
            this.lblCardTitulo2.Text = "Pendientes";
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
            this.pnlCard3.TabIndex = 20;
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
            this.lblCardTitulo3.Text = "Cerradas";
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
            this.pnlCard4.TabIndex = 21;
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
            this.lblCardTitulo4.Text = "Total comprado";
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
            // ReporteOrdenesCompra
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
            this.Controls.Add(this.lblEstado);
            this.Controls.Add(this.cboEstado);
            this.Controls.Add(this.lblProveedor);
            this.Controls.Add(this.cboProveedor);
            this.Controls.Add(this.pnlCard1);
            this.Controls.Add(this.pnlCard2);
            this.Controls.Add(this.pnlCard3);
            this.Controls.Add(this.pnlCard4);
            this.Controls.Add(this.lblTotales);
            this.Controls.Add(this.dgvDetalle);
            this.Controls.Add(this.lblDetalle);
            this.Controls.Add(this.dgvOrdenes);
            this.Controls.Add(this.lblOrdenes);
            this.Controls.Add(this.btnCerrar);
            this.Controls.Add(this.btnExportarPdf);
            this.Controls.Add(this.btnActualizar);
            this.Controls.Add(this.lblTitulo);
            this.Name = "ReporteOrdenesCompra";
            this.Text = "Reporte de Ordenes de Compra";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            ((System.ComponentModel.ISupportInitialize)(this.dgvOrdenes)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDetalle)).EndInit();
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
        private System.Windows.Forms.Label lblOrdenes;
        private System.Windows.Forms.DataGridView dgvOrdenes;
        private System.Windows.Forms.Label lblDetalle;
        private System.Windows.Forms.DataGridView dgvDetalle;
        private System.Windows.Forms.Label lblTotales;
        private System.Windows.Forms.Button btnLimpiarFiltros;
        private System.Windows.Forms.Label lblDesde;
        private System.Windows.Forms.DateTimePicker dtpDesde;
        private System.Windows.Forms.Label lblHasta;
        private System.Windows.Forms.DateTimePicker dtpHasta;
        private System.Windows.Forms.Label lblEstado;
        private System.Windows.Forms.ComboBox cboEstado;
        private System.Windows.Forms.Label lblProveedor;
        private System.Windows.Forms.ComboBox cboProveedor;
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
