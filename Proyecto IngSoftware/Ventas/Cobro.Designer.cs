namespace Proyecto_IngSoftware
{
    partial class Cobro
    {
        // disenador del cobro (CUN-002 + CUN-003). controles fijos: resumen, identificacion del
        // socio por DNI, metodo de pago, panel de efectivo (paga/vuelto) y los botones.
        // los calculos (promo/descuento/total) van en Cobro.cs.
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
            this.lblResumen = new System.Windows.Forms.Label();
            this.lblButacasTit = new System.Windows.Forms.Label();
            this.lblButacas = new System.Windows.Forms.Label();
            this.gbCliente = new System.Windows.Forms.GroupBox();
            this.lblDni = new System.Windows.Forms.Label();
            this.txtDni = new System.Windows.Forms.TextBox();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.lblEstadoCliente = new System.Windows.Forms.Label();
            this.btnAsociar = new System.Windows.Forms.Button();
            this.lblSubtotalTit = new System.Windows.Forms.Label();
            this.lblSubtotal = new System.Windows.Forms.Label();
            this.lblDescuentoTit = new System.Windows.Forms.Label();
            this.lblDescuento = new System.Windows.Forms.Label();
            this.lblPromo = new System.Windows.Forms.Label();
            this.lblTotal = new System.Windows.Forms.Label();
            this.gbPago = new System.Windows.Forms.GroupBox();
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
            this.btnConfirmar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.gbPromo = new System.Windows.Forms.GroupBox();
            this.lstPromos = new System.Windows.Forms.ListBox();
            this.gbCliente.SuspendLayout();
            this.gbPago.SuspendLayout();
            this.panelEfectivo.SuspendLayout();
            this.panelTarjeta.SuspendLayout();
            this.gbPromo.SuspendLayout();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 16F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(18, 14);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(76, 30);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Cobro";
            //
            // lblResumen
            //
            this.lblResumen.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblResumen.Location = new System.Drawing.Point(20, 52);
            this.lblResumen.Name = "lblResumen";
            this.lblResumen.Size = new System.Drawing.Size(400, 40);
            this.lblResumen.TabIndex = 1;
            this.lblResumen.Text = "Pelicula - Sala - Fecha";
            //
            // lblButacasTit
            //
            this.lblButacasTit.AutoSize = true;
            this.lblButacasTit.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblButacasTit.Location = new System.Drawing.Point(20, 96);
            this.lblButacasTit.Name = "lblButacasTit";
            this.lblButacasTit.Size = new System.Drawing.Size(52, 15);
            this.lblButacasTit.TabIndex = 2;
            this.lblButacasTit.Text = "Butacas:";
            //
            // lblButacas
            //
            this.lblButacas.ForeColor = System.Drawing.Color.White;
            this.lblButacas.Location = new System.Drawing.Point(90, 96);
            this.lblButacas.Name = "lblButacas";
            this.lblButacas.Size = new System.Drawing.Size(330, 26);
            this.lblButacas.TabIndex = 3;
            this.lblButacas.Text = "A1, A2";
            //
            // gbCliente
            //
            this.gbCliente.Controls.Add(this.lblDni);
            this.gbCliente.Controls.Add(this.txtDni);
            this.gbCliente.Controls.Add(this.btnBuscar);
            this.gbCliente.Controls.Add(this.lblEstadoCliente);
            this.gbCliente.Controls.Add(this.btnAsociar);
            this.gbCliente.ForeColor = System.Drawing.Color.Gainsboro;
            this.gbCliente.Location = new System.Drawing.Point(20, 128);
            this.gbCliente.Name = "gbCliente";
            this.gbCliente.Size = new System.Drawing.Size(400, 126);
            this.gbCliente.TabIndex = 4;
            this.gbCliente.TabStop = false;
            this.gbCliente.Text = "Cliente / Socio";
            //
            // lblDni
            //
            this.lblDni.AutoSize = true;
            this.lblDni.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDni.Location = new System.Drawing.Point(15, 30);
            this.lblDni.Name = "lblDni";
            this.lblDni.Size = new System.Drawing.Size(31, 15);
            this.lblDni.TabIndex = 0;
            this.lblDni.Text = "DNI:";
            //
            // txtDni
            //
            this.txtDni.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtDni.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtDni.ForeColor = System.Drawing.Color.White;
            this.txtDni.Location = new System.Drawing.Point(55, 27);
            this.txtDni.Name = "txtDni";
            this.txtDni.Size = new System.Drawing.Size(150, 23);
            this.txtDni.TabIndex = 1;
            //
            // btnBuscar
            //
            this.btnBuscar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnBuscar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnBuscar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnBuscar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnBuscar.ForeColor = System.Drawing.Color.White;
            this.btnBuscar.Location = new System.Drawing.Point(215, 25);
            this.btnBuscar.Name = "btnBuscar";
            this.btnBuscar.Size = new System.Drawing.Size(90, 27);
            this.btnBuscar.TabIndex = 2;
            this.btnBuscar.Text = "Buscar";
            this.btnBuscar.UseVisualStyleBackColor = false;
            this.btnBuscar.Click += new System.EventHandler(this.BtnBuscar_Click_14OR);
            //
            // lblEstadoCliente
            //
            this.lblEstadoCliente.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblEstadoCliente.Location = new System.Drawing.Point(15, 58);
            this.lblEstadoCliente.Name = "lblEstadoCliente";
            this.lblEstadoCliente.Size = new System.Drawing.Size(375, 32);
            this.lblEstadoCliente.TabIndex = 3;
            this.lblEstadoCliente.Text = "Consumidor final (sin descuento)";
            //
            // btnAsociar
            //
            this.btnAsociar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnAsociar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnAsociar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAsociar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnAsociar.ForeColor = System.Drawing.Color.White;
            this.btnAsociar.Location = new System.Drawing.Point(15, 92);
            this.btnAsociar.Name = "btnAsociar";
            this.btnAsociar.Size = new System.Drawing.Size(180, 28);
            this.btnAsociar.TabIndex = 4;
            this.btnAsociar.Text = "Hacer socio";
            this.btnAsociar.UseVisualStyleBackColor = false;
            this.btnAsociar.Visible = false;
            this.btnAsociar.Click += new System.EventHandler(this.BtnAsociar_Click_14OR);
            //
            // lblSubtotalTit
            //
            this.lblSubtotalTit.AutoSize = true;
            this.lblSubtotalTit.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblSubtotalTit.Location = new System.Drawing.Point(20, 366);
            this.lblSubtotalTit.Name = "lblSubtotalTit";
            this.lblSubtotalTit.Size = new System.Drawing.Size(55, 15);
            this.lblSubtotalTit.TabIndex = 5;
            this.lblSubtotalTit.Text = "Subtotal:";
            //
            // lblSubtotal
            //
            this.lblSubtotal.ForeColor = System.Drawing.Color.White;
            this.lblSubtotal.Location = new System.Drawing.Point(250, 366);
            this.lblSubtotal.Name = "lblSubtotal";
            this.lblSubtotal.Size = new System.Drawing.Size(170, 18);
            this.lblSubtotal.TabIndex = 6;
            this.lblSubtotal.Text = "$ 0";
            this.lblSubtotal.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            //
            // lblDescuentoTit
            //
            this.lblDescuentoTit.AutoSize = true;
            this.lblDescuentoTit.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDescuentoTit.Location = new System.Drawing.Point(20, 392);
            this.lblDescuentoTit.Name = "lblDescuentoTit";
            this.lblDescuentoTit.Size = new System.Drawing.Size(67, 15);
            this.lblDescuentoTit.TabIndex = 7;
            this.lblDescuentoTit.Text = "Descuento:";
            //
            // lblDescuento
            //
            this.lblDescuento.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(200)))), ((int)(((byte)(130)))));
            this.lblDescuento.Location = new System.Drawing.Point(250, 392);
            this.lblDescuento.Name = "lblDescuento";
            this.lblDescuento.Size = new System.Drawing.Size(170, 18);
            this.lblDescuento.TabIndex = 8;
            this.lblDescuento.Text = "- $ 0";
            this.lblDescuento.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            //
            // lblPromo
            //
            this.lblPromo.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(231)))), ((int)(((byte)(168)))), ((int)(((byte)(26)))));
            this.lblPromo.Location = new System.Drawing.Point(20, 414);
            this.lblPromo.Name = "lblPromo";
            this.lblPromo.Size = new System.Drawing.Size(400, 18);
            this.lblPromo.TabIndex = 9;
            this.lblPromo.Text = "";
            //
            // lblTotal
            //
            this.lblTotal.Font = new System.Drawing.Font("Segoe UI", 16F, System.Drawing.FontStyle.Bold);
            this.lblTotal.ForeColor = System.Drawing.Color.White;
            this.lblTotal.Location = new System.Drawing.Point(18, 436);
            this.lblTotal.Name = "lblTotal";
            this.lblTotal.Size = new System.Drawing.Size(402, 34);
            this.lblTotal.TabIndex = 10;
            this.lblTotal.Text = "Total: $ 0";
            this.lblTotal.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            //
            // gbPromo
            //
            this.gbPromo.Controls.Add(this.lstPromos);
            this.gbPromo.ForeColor = System.Drawing.Color.Gainsboro;
            this.gbPromo.Location = new System.Drawing.Point(20, 258);
            this.gbPromo.Name = "gbPromo";
            this.gbPromo.Size = new System.Drawing.Size(400, 92);
            this.gbPromo.TabIndex = 16;
            this.gbPromo.TabStop = false;
            this.gbPromo.Text = "Promocion disponible (socios)";
            this.gbPromo.Visible = false;
            //
            // lstPromos
            //
            this.lstPromos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.lstPromos.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lstPromos.ForeColor = System.Drawing.Color.White;
            this.lstPromos.FormattingEnabled = true;
            this.lstPromos.ItemHeight = 15;
            this.lstPromos.Location = new System.Drawing.Point(15, 24);
            this.lstPromos.Name = "lstPromos";
            this.lstPromos.Size = new System.Drawing.Size(370, 60);
            this.lstPromos.TabIndex = 0;
            this.lstPromos.SelectedIndexChanged += new System.EventHandler(this.LstPromos_SelectedIndexChanged_14OR);
            //
            // gbPago
            //
            this.gbPago.Controls.Add(this.rbEfectivo);
            this.gbPago.Controls.Add(this.rbTarjeta);
            this.gbPago.ForeColor = System.Drawing.Color.Gainsboro;
            this.gbPago.Location = new System.Drawing.Point(20, 480);
            this.gbPago.Name = "gbPago";
            this.gbPago.Size = new System.Drawing.Size(400, 66);
            this.gbPago.TabIndex = 11;
            this.gbPago.TabStop = false;
            this.gbPago.Text = "Metodo de pago";
            //
            // rbEfectivo
            //
            this.rbEfectivo.AutoSize = true;
            this.rbEfectivo.Checked = true;
            this.rbEfectivo.ForeColor = System.Drawing.Color.Gainsboro;
            this.rbEfectivo.Location = new System.Drawing.Point(25, 28);
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
            this.rbTarjeta.Location = new System.Drawing.Point(190, 28);
            this.rbTarjeta.Name = "rbTarjeta";
            this.rbTarjeta.Size = new System.Drawing.Size(63, 19);
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
            this.panelEfectivo.Location = new System.Drawing.Point(20, 552);
            this.panelEfectivo.Name = "panelEfectivo";
            this.panelEfectivo.Size = new System.Drawing.Size(400, 76);
            this.panelEfectivo.TabIndex = 12;
            //
            // lblPaga
            //
            this.lblPaga.AutoSize = true;
            this.lblPaga.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblPaga.Location = new System.Drawing.Point(3, 12);
            this.lblPaga.Name = "lblPaga";
            this.lblPaga.Size = new System.Drawing.Size(69, 15);
            this.lblPaga.TabIndex = 0;
            this.lblPaga.Text = "Paga con: $";
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
            this.lblVuelto.Location = new System.Drawing.Point(3, 46);
            this.lblVuelto.Name = "lblVuelto";
            this.lblVuelto.Size = new System.Drawing.Size(80, 19);
            this.lblVuelto.TabIndex = 2;
            this.lblVuelto.Text = "Vuelto: $ 0";
            //
            // panelTarjeta
            //
            this.panelTarjeta.Controls.Add(this.lblNumero);
            this.panelTarjeta.Controls.Add(this.txtNumero);
            this.panelTarjeta.Controls.Add(this.lblVenc);
            this.panelTarjeta.Controls.Add(this.txtVenc);
            this.panelTarjeta.Controls.Add(this.lblCvv);
            this.panelTarjeta.Controls.Add(this.txtCvv);
            this.panelTarjeta.Location = new System.Drawing.Point(20, 552);
            this.panelTarjeta.Name = "panelTarjeta";
            this.panelTarjeta.Size = new System.Drawing.Size(400, 76);
            this.panelTarjeta.TabIndex = 15;
            this.panelTarjeta.Visible = false;
            //
            // lblNumero
            //
            this.lblNumero.AutoSize = true;
            this.lblNumero.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblNumero.Location = new System.Drawing.Point(3, 12);
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
            this.txtNumero.Location = new System.Drawing.Point(90, 9);
            this.txtNumero.MaxLength = 19;
            this.txtNumero.Name = "txtNumero";
            this.txtNumero.Size = new System.Drawing.Size(230, 23);
            this.txtNumero.TabIndex = 1;
            //
            // lblVenc
            //
            this.lblVenc.AutoSize = true;
            this.lblVenc.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblVenc.Location = new System.Drawing.Point(3, 46);
            this.lblVenc.Name = "lblVenc";
            this.lblVenc.Size = new System.Drawing.Size(78, 15);
            this.lblVenc.TabIndex = 2;
            this.lblVenc.Text = "Vto (MM/AA):";
            //
            // txtVenc
            //
            this.txtVenc.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtVenc.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtVenc.ForeColor = System.Drawing.Color.White;
            this.txtVenc.Location = new System.Drawing.Point(90, 43);
            this.txtVenc.MaxLength = 5;
            this.txtVenc.Name = "txtVenc";
            this.txtVenc.Size = new System.Drawing.Size(70, 23);
            this.txtVenc.TabIndex = 3;
            //
            // lblCvv
            //
            this.lblCvv.AutoSize = true;
            this.lblCvv.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCvv.Location = new System.Drawing.Point(200, 46);
            this.lblCvv.Name = "lblCvv";
            this.lblCvv.Size = new System.Drawing.Size(34, 15);
            this.lblCvv.TabIndex = 4;
            this.lblCvv.Text = "CVV:";
            //
            // txtCvv
            //
            this.txtCvv.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtCvv.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtCvv.ForeColor = System.Drawing.Color.White;
            this.txtCvv.Location = new System.Drawing.Point(250, 43);
            this.txtCvv.MaxLength = 3;
            this.txtCvv.Name = "txtCvv";
            this.txtCvv.Size = new System.Drawing.Size(70, 23);
            this.txtCvv.TabIndex = 5;
            this.txtCvv.UseSystemPasswordChar = true;
            //
            // btnConfirmar
            //
            this.btnConfirmar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnConfirmar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnConfirmar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnConfirmar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnConfirmar.ForeColor = System.Drawing.Color.White;
            this.btnConfirmar.Location = new System.Drawing.Point(20, 638);
            this.btnConfirmar.Name = "btnConfirmar";
            this.btnConfirmar.Size = new System.Drawing.Size(190, 42);
            this.btnConfirmar.TabIndex = 13;
            this.btnConfirmar.Text = "Confirmar venta";
            this.btnConfirmar.UseVisualStyleBackColor = false;
            this.btnConfirmar.Click += new System.EventHandler(this.BtnConfirmar_Click_14OR);
            //
            // btnCancelar
            //
            this.btnCancelar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.btnCancelar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(120)))), ((int)(((byte)(120)))));
            this.btnCancelar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnCancelar.ForeColor = System.Drawing.Color.White;
            this.btnCancelar.Location = new System.Drawing.Point(230, 638);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(190, 42);
            this.btnCancelar.TabIndex = 14;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = false;
            this.btnCancelar.Click += new System.EventHandler(this.BtnCancelar_Click_14OR);
            //
            // Cobro
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(440, 698);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnConfirmar);
            this.Controls.Add(this.panelTarjeta);
            this.Controls.Add(this.panelEfectivo);
            this.Controls.Add(this.gbPago);
            this.Controls.Add(this.gbPromo);
            this.Controls.Add(this.lblTotal);
            this.Controls.Add(this.lblPromo);
            this.Controls.Add(this.lblDescuento);
            this.Controls.Add(this.lblDescuentoTit);
            this.Controls.Add(this.lblSubtotal);
            this.Controls.Add(this.lblSubtotalTit);
            this.Controls.Add(this.gbCliente);
            this.Controls.Add(this.lblButacas);
            this.Controls.Add(this.lblButacasTit);
            this.Controls.Add(this.lblResumen);
            this.Controls.Add(this.lblTitulo);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Cobro";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Cobro";
            this.gbCliente.ResumeLayout(false);
            this.gbCliente.PerformLayout();
            this.gbPago.ResumeLayout(false);
            this.gbPago.PerformLayout();
            this.panelEfectivo.ResumeLayout(false);
            this.panelEfectivo.PerformLayout();
            this.panelTarjeta.ResumeLayout(false);
            this.panelTarjeta.PerformLayout();
            this.gbPromo.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Label lblResumen;
        private System.Windows.Forms.Label lblButacasTit;
        private System.Windows.Forms.Label lblButacas;
        private System.Windows.Forms.GroupBox gbCliente;
        private System.Windows.Forms.Label lblDni;
        private System.Windows.Forms.TextBox txtDni;
        private System.Windows.Forms.Button btnBuscar;
        private System.Windows.Forms.Label lblEstadoCliente;
        private System.Windows.Forms.Button btnAsociar;
        private System.Windows.Forms.Label lblSubtotalTit;
        private System.Windows.Forms.Label lblSubtotal;
        private System.Windows.Forms.Label lblDescuentoTit;
        private System.Windows.Forms.Label lblDescuento;
        private System.Windows.Forms.Label lblPromo;
        private System.Windows.Forms.Label lblTotal;
        private System.Windows.Forms.GroupBox gbPago;
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
        private System.Windows.Forms.GroupBox gbPromo;
        private System.Windows.Forms.ListBox lstPromos;
        private System.Windows.Forms.Button btnConfirmar;
        private System.Windows.Forms.Button btnCancelar;
    }
}
