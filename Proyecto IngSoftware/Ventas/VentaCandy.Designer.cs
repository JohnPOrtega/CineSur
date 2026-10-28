namespace Proyecto_IngSoftware
{
    partial class VentaCandy
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
            this.dgvPedido = new System.Windows.Forms.DataGridView();
            this.lblTotal = new System.Windows.Forms.Label();
            this.btnQuitarUno = new System.Windows.Forms.Button();
            this.btnEliminar = new System.Windows.Forms.Button();
            this.gbCobro = new System.Windows.Forms.GroupBox();
            this.rbEfectivo = new System.Windows.Forms.RadioButton();
            this.rbTarjeta = new System.Windows.Forms.RadioButton();
            this.panelEfectivo = new System.Windows.Forms.Panel();
            this.lblPaga = new System.Windows.Forms.Label();
            this.txtPaga = new System.Windows.Forms.TextBox();
            this.lblVuelto = new System.Windows.Forms.Label();
            this.panelTarjeta = new System.Windows.Forms.Panel();
            this.lblNumero = new System.Windows.Forms.Label();
            this.txtNumero = new System.Windows.Forms.TextBox();
            this.lblVenc = new System.Windows.Forms.Label();
            this.txtVenc = new System.Windows.Forms.TextBox();
            this.lblCvv = new System.Windows.Forms.Label();
            this.txtCvv = new System.Windows.Forms.TextBox();
            this.btnCobrar = new System.Windows.Forms.Button();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.flpProductos = new System.Windows.Forms.FlowLayoutPanel();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPedido)).BeginInit();
            this.gbCobro.SuspendLayout();
            this.panelEfectivo.SuspendLayout();
            this.panelTarjeta.SuspendLayout();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(12, 12);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(141, 21);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "PEDIDO ACTUAL";
            //
            // dgvPedido
            //
            this.dgvPedido.AllowUserToAddRows = false;
            this.dgvPedido.AllowUserToDeleteRows = false;
            this.dgvPedido.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(36)))), ((int)(((byte)(36)))), ((int)(((byte)(36)))));
            this.dgvPedido.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPedido.Location = new System.Drawing.Point(12, 40);
            this.dgvPedido.MultiSelect = false;
            this.dgvPedido.Name = "dgvPedido";
            this.dgvPedido.ReadOnly = true;
            this.dgvPedido.RowHeadersVisible = false;
            this.dgvPedido.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvPedido.Size = new System.Drawing.Size(288, 215);
            this.dgvPedido.TabIndex = 1;
            //
            // lblTotal
            //
            this.lblTotal.AutoSize = true;
            this.lblTotal.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblTotal.ForeColor = System.Drawing.Color.White;
            this.lblTotal.Location = new System.Drawing.Point(12, 262);
            this.lblTotal.Name = "lblTotal";
            this.lblTotal.Size = new System.Drawing.Size(93, 21);
            this.lblTotal.TabIndex = 2;
            this.lblTotal.Text = "Total: $ 0.00";
            //
            // btnQuitarUno
            //
            this.btnQuitarUno.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnQuitarUno.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnQuitarUno.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnQuitarUno.ForeColor = System.Drawing.Color.White;
            this.btnQuitarUno.Location = new System.Drawing.Point(12, 292);
            this.btnQuitarUno.Name = "btnQuitarUno";
            this.btnQuitarUno.Size = new System.Drawing.Size(138, 34);
            this.btnQuitarUno.TabIndex = 3;
            this.btnQuitarUno.Text = "QUITAR UNO";
            this.btnQuitarUno.UseVisualStyleBackColor = false;
            this.btnQuitarUno.Click += new System.EventHandler(this.btnQuitarUno_Click);
            //
            // btnEliminar
            //
            this.btnEliminar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(60)))), ((int)(((byte)(60)))));
            this.btnEliminar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEliminar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnEliminar.ForeColor = System.Drawing.Color.White;
            this.btnEliminar.Location = new System.Drawing.Point(162, 292);
            this.btnEliminar.Name = "btnEliminar";
            this.btnEliminar.Size = new System.Drawing.Size(138, 34);
            this.btnEliminar.TabIndex = 4;
            this.btnEliminar.Text = "ELIMINAR";
            this.btnEliminar.UseVisualStyleBackColor = false;
            this.btnEliminar.Click += new System.EventHandler(this.btnEliminar_Click);
            //
            // gbCobro
            //
            this.gbCobro.Controls.Add(this.rbEfectivo);
            this.gbCobro.Controls.Add(this.rbTarjeta);
            this.gbCobro.Controls.Add(this.panelEfectivo);
            this.gbCobro.Controls.Add(this.panelTarjeta);
            this.gbCobro.Controls.Add(this.btnCobrar);
            this.gbCobro.Controls.Add(this.btnLimpiar);
            this.gbCobro.ForeColor = System.Drawing.Color.Gainsboro;
            this.gbCobro.Location = new System.Drawing.Point(12, 336);
            this.gbCobro.Name = "gbCobro";
            this.gbCobro.Size = new System.Drawing.Size(288, 258);
            this.gbCobro.TabIndex = 5;
            this.gbCobro.TabStop = false;
            this.gbCobro.Text = "Cobro";
            //
            // rbEfectivo
            //
            this.rbEfectivo.AutoSize = true;
            this.rbEfectivo.Checked = true;
            this.rbEfectivo.ForeColor = System.Drawing.Color.Gainsboro;
            this.rbEfectivo.Location = new System.Drawing.Point(15, 25);
            this.rbEfectivo.Name = "rbEfectivo";
            this.rbEfectivo.Size = new System.Drawing.Size(70, 19);
            this.rbEfectivo.TabIndex = 0;
            this.rbEfectivo.TabStop = true;
            this.rbEfectivo.Text = "Efectivo";
            this.rbEfectivo.UseVisualStyleBackColor = true;
            this.rbEfectivo.CheckedChanged += new System.EventHandler(this.Actualizar_14OR);
            //
            // rbTarjeta
            //
            this.rbTarjeta.AutoSize = true;
            this.rbTarjeta.ForeColor = System.Drawing.Color.Gainsboro;
            this.rbTarjeta.Location = new System.Drawing.Point(150, 25);
            this.rbTarjeta.Name = "rbTarjeta";
            this.rbTarjeta.Size = new System.Drawing.Size(64, 19);
            this.rbTarjeta.TabIndex = 1;
            this.rbTarjeta.Text = "Tarjeta";
            this.rbTarjeta.UseVisualStyleBackColor = true;
            this.rbTarjeta.CheckedChanged += new System.EventHandler(this.Actualizar_14OR);
            //
            // panelEfectivo
            //
            this.panelEfectivo.Controls.Add(this.lblPaga);
            this.panelEfectivo.Controls.Add(this.txtPaga);
            this.panelEfectivo.Controls.Add(this.lblVuelto);
            this.panelEfectivo.Location = new System.Drawing.Point(10, 55);
            this.panelEfectivo.Name = "panelEfectivo";
            this.panelEfectivo.Size = new System.Drawing.Size(270, 85);
            this.panelEfectivo.TabIndex = 2;
            //
            // lblPaga
            //
            this.lblPaga.AutoSize = true;
            this.lblPaga.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblPaga.Location = new System.Drawing.Point(5, 12);
            this.lblPaga.Name = "lblPaga";
            this.lblPaga.Size = new System.Drawing.Size(63, 15);
            this.lblPaga.TabIndex = 0;
            this.lblPaga.Text = "Paga con:";
            //
            // txtPaga
            //
            this.txtPaga.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtPaga.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtPaga.ForeColor = System.Drawing.Color.White;
            this.txtPaga.Location = new System.Drawing.Point(90, 9);
            this.txtPaga.Name = "txtPaga";
            this.txtPaga.Size = new System.Drawing.Size(120, 23);
            this.txtPaga.TabIndex = 1;
            this.txtPaga.TextChanged += new System.EventHandler(this.Actualizar_14OR);
            //
            // lblVuelto
            //
            this.lblVuelto.AutoSize = true;
            this.lblVuelto.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.lblVuelto.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblVuelto.Location = new System.Drawing.Point(5, 48);
            this.lblVuelto.Name = "lblVuelto";
            this.lblVuelto.Size = new System.Drawing.Size(93, 19);
            this.lblVuelto.TabIndex = 2;
            this.lblVuelto.Text = "Vuelto: $ 0.00";
            //
            // panelTarjeta
            //
            this.panelTarjeta.Controls.Add(this.lblNumero);
            this.panelTarjeta.Controls.Add(this.txtNumero);
            this.panelTarjeta.Controls.Add(this.lblVenc);
            this.panelTarjeta.Controls.Add(this.txtVenc);
            this.panelTarjeta.Controls.Add(this.lblCvv);
            this.panelTarjeta.Controls.Add(this.txtCvv);
            this.panelTarjeta.Location = new System.Drawing.Point(10, 55);
            this.panelTarjeta.Name = "panelTarjeta";
            this.panelTarjeta.Size = new System.Drawing.Size(270, 110);
            this.panelTarjeta.TabIndex = 3;
            //
            // lblNumero
            //
            this.lblNumero.AutoSize = true;
            this.lblNumero.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblNumero.Location = new System.Drawing.Point(5, 10);
            this.lblNumero.Name = "lblNumero";
            this.lblNumero.Size = new System.Drawing.Size(52, 15);
            this.lblNumero.TabIndex = 0;
            this.lblNumero.Text = "Numero:";
            //
            // txtNumero
            //
            this.txtNumero.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtNumero.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtNumero.ForeColor = System.Drawing.Color.White;
            this.txtNumero.Location = new System.Drawing.Point(90, 7);
            this.txtNumero.MaxLength = 19;
            this.txtNumero.Name = "txtNumero";
            this.txtNumero.Size = new System.Drawing.Size(165, 23);
            this.txtNumero.TabIndex = 1;
            //
            // lblVenc
            //
            this.lblVenc.AutoSize = true;
            this.lblVenc.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblVenc.Location = new System.Drawing.Point(5, 43);
            this.lblVenc.Name = "lblVenc";
            this.lblVenc.Size = new System.Drawing.Size(79, 15);
            this.lblVenc.TabIndex = 2;
            this.lblVenc.Text = "Venc. (MM/AA):";
            //
            // txtVenc
            //
            this.txtVenc.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtVenc.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtVenc.ForeColor = System.Drawing.Color.White;
            this.txtVenc.Location = new System.Drawing.Point(90, 40);
            this.txtVenc.MaxLength = 5;
            this.txtVenc.Name = "txtVenc";
            this.txtVenc.Size = new System.Drawing.Size(70, 23);
            this.txtVenc.TabIndex = 3;
            //
            // lblCvv
            //
            this.lblCvv.AutoSize = true;
            this.lblCvv.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCvv.Location = new System.Drawing.Point(5, 76);
            this.lblCvv.Name = "lblCvv";
            this.lblCvv.Size = new System.Drawing.Size(31, 15);
            this.lblCvv.TabIndex = 4;
            this.lblCvv.Text = "CVV:";
            //
            // txtCvv
            //
            this.txtCvv.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtCvv.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtCvv.ForeColor = System.Drawing.Color.White;
            this.txtCvv.Location = new System.Drawing.Point(90, 73);
            this.txtCvv.MaxLength = 3;
            this.txtCvv.Name = "txtCvv";
            this.txtCvv.Size = new System.Drawing.Size(60, 23);
            this.txtCvv.TabIndex = 5;
            //
            // btnCobrar
            //
            this.btnCobrar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(139)))), ((int)(((byte)(87)))));
            this.btnCobrar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCobrar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnCobrar.ForeColor = System.Drawing.Color.White;
            this.btnCobrar.Location = new System.Drawing.Point(10, 210);
            this.btnCobrar.Name = "btnCobrar";
            this.btnCobrar.Size = new System.Drawing.Size(160, 38);
            this.btnCobrar.TabIndex = 4;
            this.btnCobrar.Text = "COBRAR";
            this.btnCobrar.UseVisualStyleBackColor = false;
            this.btnCobrar.Click += new System.EventHandler(this.btnCobrar_Click);
            //
            // btnLimpiar
            //
            this.btnLimpiar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(70)))), ((int)(((byte)(70)))), ((int)(((byte)(70)))));
            this.btnLimpiar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLimpiar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnLimpiar.ForeColor = System.Drawing.Color.White;
            this.btnLimpiar.Location = new System.Drawing.Point(180, 210);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(98, 38);
            this.btnLimpiar.TabIndex = 6;
            this.btnLimpiar.Text = "LIMPIAR";
            this.btnLimpiar.UseVisualStyleBackColor = false;
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click);
            //
            // flpProductos
            //
            this.flpProductos.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
            | System.Windows.Forms.AnchorStyles.Left)
            | System.Windows.Forms.AnchorStyles.Right)));
            this.flpProductos.AutoScroll = true;
            this.flpProductos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(30)))), ((int)(((byte)(30)))), ((int)(((byte)(30)))));
            this.flpProductos.Location = new System.Drawing.Point(315, 40);
            this.flpProductos.Name = "flpProductos";
            this.flpProductos.Size = new System.Drawing.Size(610, 554);
            this.flpProductos.TabIndex = 6;
            //
            // VentaCandy
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(24)))), ((int)(((byte)(24)))), ((int)(((byte)(24)))));
            this.ClientSize = new System.Drawing.Size(940, 610);
            this.Controls.Add(this.flpProductos);
            this.Controls.Add(this.gbCobro);
            this.Controls.Add(this.btnEliminar);
            this.Controls.Add(this.btnQuitarUno);
            this.Controls.Add(this.lblTotal);
            this.Controls.Add(this.dgvPedido);
            this.Controls.Add(this.lblTitulo);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "VentaCandy";
            this.Text = "Venta Candy Bar";
            ((System.ComponentModel.ISupportInitialize)(this.dgvPedido)).EndInit();
            this.gbCobro.ResumeLayout(false);
            this.gbCobro.PerformLayout();
            this.panelEfectivo.ResumeLayout(false);
            this.panelEfectivo.PerformLayout();
            this.panelTarjeta.ResumeLayout(false);
            this.panelTarjeta.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.DataGridView dgvPedido;
        private System.Windows.Forms.Label lblTotal;
        private System.Windows.Forms.Button btnQuitarUno;
        private System.Windows.Forms.Button btnEliminar;
        private System.Windows.Forms.GroupBox gbCobro;
        private System.Windows.Forms.RadioButton rbEfectivo;
        private System.Windows.Forms.RadioButton rbTarjeta;
        private System.Windows.Forms.Panel panelEfectivo;
        private System.Windows.Forms.Label lblPaga;
        private System.Windows.Forms.TextBox txtPaga;
        private System.Windows.Forms.Label lblVuelto;
        private System.Windows.Forms.Panel panelTarjeta;
        private System.Windows.Forms.Label lblNumero;
        private System.Windows.Forms.TextBox txtNumero;
        private System.Windows.Forms.Label lblVenc;
        private System.Windows.Forms.TextBox txtVenc;
        private System.Windows.Forms.Label lblCvv;
        private System.Windows.Forms.TextBox txtCvv;
        private System.Windows.Forms.Button btnCobrar;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.FlowLayoutPanel flpProductos;
    }
}
