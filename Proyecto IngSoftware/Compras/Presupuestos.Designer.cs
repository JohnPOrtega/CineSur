namespace Proyecto_IngSoftware
{
    partial class Presupuestos
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
            this.lblNuevoTitulo = new System.Windows.Forms.Label();
            this.lblProveedor = new System.Windows.Forms.Label();
            this.cboProveedor = new System.Windows.Forms.ComboBox();
            this.btnNuevoProveedor = new System.Windows.Forms.Button();
            this.lblProducto = new System.Windows.Forms.Label();
            this.cboProducto = new System.Windows.Forms.ComboBox();
            this.lblCantidad = new System.Windows.Forms.Label();
            this.numCantidad = new System.Windows.Forms.NumericUpDown();
            this.btnAgregarItem = new System.Windows.Forms.Button();
            this.dgvNuevoDetalle = new System.Windows.Forms.DataGridView();
            this.btnQuitarItem = new System.Windows.Forms.Button();
            this.btnPedir = new System.Windows.Forms.Button();
            this.lblCriticos = new System.Windows.Forms.Label();
            this.lblListaTitulo = new System.Windows.Forms.Label();
            this.dgvPresupuestos = new System.Windows.Forms.DataGridView();
            this.lblDetalleTitulo = new System.Windows.Forms.Label();
            this.dgvDetalle = new System.Windows.Forms.DataGridView();
            this.lblTotalPresu = new System.Windows.Forms.Label();
            this.btnCargarPrecios = new System.Windows.Forms.Button();
            this.btnAceptar = new System.Windows.Forms.Button();
            this.btnRechazar = new System.Windows.Forms.Button();
            this.rbPendientes = new System.Windows.Forms.RadioButton();
            this.rbHistorial = new System.Windows.Forms.RadioButton();
            this.lblProximoPaso = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.numCantidad)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvNuevoDetalle)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPresupuestos)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDetalle)).BeginInit();
            this.SuspendLayout();
            //
            // lblNuevoTitulo
            //
            this.lblNuevoTitulo.AutoSize = true;
            this.lblNuevoTitulo.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblNuevoTitulo.ForeColor = System.Drawing.Color.White;
            this.lblNuevoTitulo.Location = new System.Drawing.Point(12, 12);
            this.lblNuevoTitulo.Name = "lblNuevoTitulo";
            this.lblNuevoTitulo.Size = new System.Drawing.Size(239, 20);
            this.lblNuevoTitulo.TabIndex = 0;
            this.lblNuevoTitulo.Text = "NUEVA SOLICITUD DE COTIZACION";
            //
            // lblProveedor
            //
            this.lblProveedor.AutoSize = true;
            this.lblProveedor.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblProveedor.Location = new System.Drawing.Point(12, 51);
            this.lblProveedor.Name = "lblProveedor";
            this.lblProveedor.Size = new System.Drawing.Size(63, 15);
            this.lblProveedor.TabIndex = 1;
            this.lblProveedor.Text = "Proveedor:";
            //
            // cboProveedor
            //
            this.cboProveedor.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboProveedor.Location = new System.Drawing.Point(110, 48);
            this.cboProveedor.Name = "cboProveedor";
            this.cboProveedor.Size = new System.Drawing.Size(155, 23);
            this.cboProveedor.TabIndex = 2;
            //
            // btnNuevoProveedor
            //
            this.btnNuevoProveedor.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnNuevoProveedor.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNuevoProveedor.ForeColor = System.Drawing.Color.White;
            this.btnNuevoProveedor.Location = new System.Drawing.Point(271, 46);
            this.btnNuevoProveedor.Name = "btnNuevoProveedor";
            this.btnNuevoProveedor.Size = new System.Drawing.Size(81, 27);
            this.btnNuevoProveedor.TabIndex = 3;
            this.btnNuevoProveedor.Text = "Nuevo";
            this.btnNuevoProveedor.UseVisualStyleBackColor = false;
            this.btnNuevoProveedor.Click += new System.EventHandler(this.btnNuevoProveedor_Click);
            //
            // lblProducto
            //
            this.lblProducto.AutoSize = true;
            this.lblProducto.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblProducto.Location = new System.Drawing.Point(12, 86);
            this.lblProducto.Name = "lblProducto";
            this.lblProducto.Size = new System.Drawing.Size(58, 15);
            this.lblProducto.TabIndex = 4;
            this.lblProducto.Text = "Producto:";
            //
            // cboProducto
            //
            this.cboProducto.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboProducto.Location = new System.Drawing.Point(110, 83);
            this.cboProducto.Name = "cboProducto";
            this.cboProducto.Size = new System.Drawing.Size(230, 23);
            this.cboProducto.TabIndex = 5;
            //
            // lblCantidad
            //
            this.lblCantidad.AutoSize = true;
            this.lblCantidad.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCantidad.Location = new System.Drawing.Point(12, 121);
            this.lblCantidad.Name = "lblCantidad";
            this.lblCantidad.Size = new System.Drawing.Size(58, 15);
            this.lblCantidad.TabIndex = 6;
            this.lblCantidad.Text = "Cantidad:";
            //
            // numCantidad
            //
            this.numCantidad.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numCantidad.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numCantidad.ForeColor = System.Drawing.Color.White;
            this.numCantidad.Location = new System.Drawing.Point(110, 118);
            this.numCantidad.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.numCantidad.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numCantidad.Name = "numCantidad";
            this.numCantidad.Size = new System.Drawing.Size(70, 23);
            this.numCantidad.TabIndex = 7;
            this.numCantidad.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            //
            // btnAgregarItem
            //
            this.btnAgregarItem.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnAgregarItem.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAgregarItem.ForeColor = System.Drawing.Color.White;
            this.btnAgregarItem.Location = new System.Drawing.Point(190, 116);
            this.btnAgregarItem.Name = "btnAgregarItem";
            this.btnAgregarItem.Size = new System.Drawing.Size(150, 28);
            this.btnAgregarItem.TabIndex = 8;
            this.btnAgregarItem.Text = "Agregar al pedido";
            this.btnAgregarItem.UseVisualStyleBackColor = false;
            this.btnAgregarItem.Click += new System.EventHandler(this.btnAgregarItem_Click);
            //
            // dgvNuevoDetalle
            //
            this.dgvNuevoDetalle.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvNuevoDetalle.Location = new System.Drawing.Point(12, 155);
            this.dgvNuevoDetalle.Name = "dgvNuevoDetalle";
            this.dgvNuevoDetalle.Size = new System.Drawing.Size(340, 150);
            this.dgvNuevoDetalle.TabIndex = 9;
            //
            // btnQuitarItem
            //
            this.btnQuitarItem.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(60)))), ((int)(((byte)(60)))));
            this.btnQuitarItem.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnQuitarItem.ForeColor = System.Drawing.Color.White;
            this.btnQuitarItem.Location = new System.Drawing.Point(12, 312);
            this.btnQuitarItem.Name = "btnQuitarItem";
            this.btnQuitarItem.Size = new System.Drawing.Size(150, 32);
            this.btnQuitarItem.TabIndex = 10;
            this.btnQuitarItem.Text = "Quitar item";
            this.btnQuitarItem.UseVisualStyleBackColor = false;
            this.btnQuitarItem.Click += new System.EventHandler(this.btnQuitarItem_Click);
            //
            // btnPedir
            //
            this.btnPedir.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(139)))), ((int)(((byte)(87)))));
            this.btnPedir.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPedir.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnPedir.ForeColor = System.Drawing.Color.White;
            this.btnPedir.Location = new System.Drawing.Point(172, 312);
            this.btnPedir.Name = "btnPedir";
            this.btnPedir.Size = new System.Drawing.Size(180, 32);
            this.btnPedir.TabIndex = 11;
            this.btnPedir.Text = "SOLICITAR COTIZACION";
            this.btnPedir.UseVisualStyleBackColor = false;
            this.btnPedir.Click += new System.EventHandler(this.btnPedir_Click);
            //
            // lblCriticos
            //
            this.lblCriticos.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(231)))), ((int)(((byte)(168)))), ((int)(((byte)(26)))));
            this.lblCriticos.Location = new System.Drawing.Point(12, 356);
            this.lblCriticos.Name = "lblCriticos";
            this.lblCriticos.Size = new System.Drawing.Size(340, 70);
            this.lblCriticos.TabIndex = 12;
            this.lblCriticos.Text = "";
            //
            // lblListaTitulo
            //
            this.lblListaTitulo.AutoSize = true;
            this.lblListaTitulo.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblListaTitulo.ForeColor = System.Drawing.Color.White;
            this.lblListaTitulo.Location = new System.Drawing.Point(370, 12);
            this.lblListaTitulo.Name = "lblListaTitulo";
            this.lblListaTitulo.Size = new System.Drawing.Size(123, 20);
            this.lblListaTitulo.TabIndex = 13;
            this.lblListaTitulo.Text = "COTIZACIONES";
            //
            // rbPendientes
            //
            this.rbPendientes.AutoSize = true;
            this.rbPendientes.Checked = true;
            this.rbPendientes.ForeColor = System.Drawing.Color.Gainsboro;
            this.rbPendientes.Location = new System.Drawing.Point(640, 13);
            this.rbPendientes.Name = "rbPendientes";
            this.rbPendientes.Size = new System.Drawing.Size(83, 19);
            this.rbPendientes.TabIndex = 21;
            this.rbPendientes.TabStop = true;
            this.rbPendientes.Text = "Pendientes";
            this.rbPendientes.UseVisualStyleBackColor = true;
            this.rbPendientes.CheckedChanged += new System.EventHandler(this.rbFiltro_CheckedChanged);
            //
            // rbHistorial
            //
            this.rbHistorial.AutoSize = true;
            this.rbHistorial.ForeColor = System.Drawing.Color.Gainsboro;
            this.rbHistorial.Location = new System.Drawing.Point(760, 13);
            this.rbHistorial.Name = "rbHistorial";
            this.rbHistorial.Size = new System.Drawing.Size(70, 19);
            this.rbHistorial.TabIndex = 22;
            this.rbHistorial.Text = "Historial";
            this.rbHistorial.UseVisualStyleBackColor = true;
            this.rbHistorial.CheckedChanged += new System.EventHandler(this.rbFiltro_CheckedChanged);
            //
            // dgvPresupuestos
            //
            this.dgvPresupuestos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPresupuestos.Location = new System.Drawing.Point(370, 40);
            this.dgvPresupuestos.Name = "dgvPresupuestos";
            this.dgvPresupuestos.ReadOnly = true;
            this.dgvPresupuestos.Size = new System.Drawing.Size(598, 170);
            this.dgvPresupuestos.TabIndex = 14;
            this.dgvPresupuestos.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvPresupuestos_CellClick);
            //
            // lblDetalleTitulo
            //
            this.lblDetalleTitulo.AutoSize = true;
            this.lblDetalleTitulo.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDetalleTitulo.Location = new System.Drawing.Point(370, 221);
            this.lblDetalleTitulo.Name = "lblDetalleTitulo";
            this.lblDetalleTitulo.Size = new System.Drawing.Size(230, 15);
            this.lblDetalleTitulo.TabIndex = 15;
            this.lblDetalleTitulo.Text = "Detalle de la cotizacion (precio unitario de cada producto):";
            //
            // dgvDetalle
            //
            this.dgvDetalle.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDetalle.Location = new System.Drawing.Point(370, 242);
            this.dgvDetalle.Name = "dgvDetalle";
            this.dgvDetalle.Size = new System.Drawing.Size(598, 150);
            this.dgvDetalle.TabIndex = 16;
            this.dgvDetalle.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvDetalle_CellEndEdit);
            //
            // lblTotalPresu
            //
            this.lblTotalPresu.AutoSize = true;
            this.lblTotalPresu.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblTotalPresu.ForeColor = System.Drawing.Color.White;
            this.lblTotalPresu.Location = new System.Drawing.Point(370, 398);
            this.lblTotalPresu.Name = "lblTotalPresu";
            this.lblTotalPresu.Size = new System.Drawing.Size(143, 19);
            this.lblTotalPresu.TabIndex = 17;
            this.lblTotalPresu.Text = "Total cotizado: $ 0.00";
            //
            // btnCargarPrecios
            //
            this.btnCargarPrecios.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnCargarPrecios.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCargarPrecios.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnCargarPrecios.ForeColor = System.Drawing.Color.White;
            this.btnCargarPrecios.Location = new System.Drawing.Point(370, 428);
            this.btnCargarPrecios.Name = "btnCargarPrecios";
            this.btnCargarPrecios.Size = new System.Drawing.Size(190, 36);
            this.btnCargarPrecios.TabIndex = 18;
            this.btnCargarPrecios.Text = "Registrar cotizacion";
            this.btnCargarPrecios.UseVisualStyleBackColor = false;
            this.btnCargarPrecios.Click += new System.EventHandler(this.btnCargarPrecios_Click);
            //
            // btnAceptar
            //
            this.btnAceptar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(139)))), ((int)(((byte)(87)))));
            this.btnAceptar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAceptar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnAceptar.ForeColor = System.Drawing.Color.White;
            this.btnAceptar.Location = new System.Drawing.Point(570, 428);
            this.btnAceptar.Name = "btnAceptar";
            this.btnAceptar.Size = new System.Drawing.Size(200, 36);
            this.btnAceptar.TabIndex = 19;
            this.btnAceptar.Text = "Comprar insumos";
            this.btnAceptar.UseVisualStyleBackColor = false;
            this.btnAceptar.Click += new System.EventHandler(this.btnAceptar_Click);
            //
            // btnRechazar
            //
            this.btnRechazar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(60)))), ((int)(((byte)(60)))));
            this.btnRechazar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRechazar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnRechazar.ForeColor = System.Drawing.Color.White;
            this.btnRechazar.Location = new System.Drawing.Point(778, 428);
            this.btnRechazar.Name = "btnRechazar";
            this.btnRechazar.Size = new System.Drawing.Size(120, 36);
            this.btnRechazar.TabIndex = 20;
            this.btnRechazar.Text = "Rechazar";
            this.btnRechazar.UseVisualStyleBackColor = false;
            this.btnRechazar.Click += new System.EventHandler(this.btnRechazar_Click);
            //
            // lblProximoPaso
            //
            this.lblProximoPaso.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblProximoPaso.Location = new System.Drawing.Point(370, 476);
            this.lblProximoPaso.Name = "lblProximoPaso";
            this.lblProximoPaso.Size = new System.Drawing.Size(598, 60);
            this.lblProximoPaso.TabIndex = 23;
            this.lblProximoPaso.Text = "";
            //
            // Presupuestos
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(24)))), ((int)(((byte)(24)))), ((int)(((byte)(24)))));
            this.ClientSize = new System.Drawing.Size(980, 660);
            this.Controls.Add(this.lblProximoPaso);
            this.Controls.Add(this.rbHistorial);
            this.Controls.Add(this.rbPendientes);
            this.Controls.Add(this.btnRechazar);
            this.Controls.Add(this.btnAceptar);
            this.Controls.Add(this.btnCargarPrecios);
            this.Controls.Add(this.lblTotalPresu);
            this.Controls.Add(this.dgvDetalle);
            this.Controls.Add(this.lblDetalleTitulo);
            this.Controls.Add(this.dgvPresupuestos);
            this.Controls.Add(this.lblListaTitulo);
            this.Controls.Add(this.lblCriticos);
            this.Controls.Add(this.btnPedir);
            this.Controls.Add(this.btnQuitarItem);
            this.Controls.Add(this.dgvNuevoDetalle);
            this.Controls.Add(this.btnAgregarItem);
            this.Controls.Add(this.numCantidad);
            this.Controls.Add(this.lblCantidad);
            this.Controls.Add(this.cboProducto);
            this.Controls.Add(this.lblProducto);
            this.Controls.Add(this.btnNuevoProveedor);
            this.Controls.Add(this.cboProveedor);
            this.Controls.Add(this.lblProveedor);
            this.Controls.Add(this.lblNuevoTitulo);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "Presupuestos";
            this.Text = "Cotizaciones";
            ((System.ComponentModel.ISupportInitialize)(this.numCantidad)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvNuevoDetalle)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPresupuestos)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDetalle)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblNuevoTitulo;
        private System.Windows.Forms.Label lblProveedor;
        private System.Windows.Forms.ComboBox cboProveedor;
        private System.Windows.Forms.Button btnNuevoProveedor;
        private System.Windows.Forms.Label lblProducto;
        private System.Windows.Forms.ComboBox cboProducto;
        private System.Windows.Forms.Label lblCantidad;
        private System.Windows.Forms.NumericUpDown numCantidad;
        private System.Windows.Forms.Button btnAgregarItem;
        private System.Windows.Forms.DataGridView dgvNuevoDetalle;
        private System.Windows.Forms.Button btnQuitarItem;
        private System.Windows.Forms.Button btnPedir;
        private System.Windows.Forms.Label lblCriticos;
        private System.Windows.Forms.RadioButton rbPendientes;
        private System.Windows.Forms.RadioButton rbHistorial;
        private System.Windows.Forms.Label lblProximoPaso;
        private System.Windows.Forms.Label lblListaTitulo;
        private System.Windows.Forms.DataGridView dgvPresupuestos;
        private System.Windows.Forms.Label lblDetalleTitulo;
        private System.Windows.Forms.DataGridView dgvDetalle;
        private System.Windows.Forms.Label lblTotalPresu;
        private System.Windows.Forms.Button btnCargarPrecios;
        private System.Windows.Forms.Button btnAceptar;
        private System.Windows.Forms.Button btnRechazar;
    }
}
