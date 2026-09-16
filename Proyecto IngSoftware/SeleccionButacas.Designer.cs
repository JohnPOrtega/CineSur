namespace Proyecto_IngSoftware
{
    partial class SeleccionButacas
    {
        // disenador: todo el "chrome" fijo (el panel donde va el mapa + el panel de resumen de la derecha
        // con labels y botones). el mapa de butacas en si se crea por codigo adentro de panelMapa, porque
        // sus botones son dinamicos (uno por butaca) y hay que engancharle el evento de click.
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.panelMapa = new System.Windows.Forms.Panel();
            this.lblResumen = new System.Windows.Forms.Label();
            this.lblPrecioUnit = new System.Windows.Forms.Label();
            this.lblCantidad = new System.Windows.Forms.Label();
            this.lblCodTit = new System.Windows.Forms.Label();
            this.flpCodigos = new System.Windows.Forms.FlowLayoutPanel();
            this.lblTotal = new System.Windows.Forms.Label();
            this.btnReservar = new System.Windows.Forms.Button();
            this.btnCerrar = new System.Windows.Forms.Button();
            this.lblRef = new System.Windows.Forms.Label();
            this.SuspendLayout();
            //
            // panelMapa
            //
            this.panelMapa.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.panelMapa.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.panelMapa.Location = new System.Drawing.Point(12, 12);
            this.panelMapa.Name = "panelMapa";
            this.panelMapa.Size = new System.Drawing.Size(600, 580);
            this.panelMapa.TabIndex = 0;
            //
            // lblResumen
            //
            this.lblResumen.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblResumen.AutoSize = true;
            this.lblResumen.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold);
            this.lblResumen.ForeColor = System.Drawing.Color.White;
            this.lblResumen.Location = new System.Drawing.Point(636, 16);
            this.lblResumen.Name = "lblResumen";
            this.lblResumen.Size = new System.Drawing.Size(88, 25);
            this.lblResumen.TabIndex = 1;
            this.lblResumen.Text = "Resumen";
            //
            // lblPrecioUnit
            //
            this.lblPrecioUnit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblPrecioUnit.AutoSize = true;
            this.lblPrecioUnit.Font = new System.Drawing.Font("Segoe UI", 9.5F);
            this.lblPrecioUnit.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblPrecioUnit.Location = new System.Drawing.Point(638, 54);
            this.lblPrecioUnit.Name = "lblPrecioUnit";
            this.lblPrecioUnit.Size = new System.Drawing.Size(95, 17);
            this.lblPrecioUnit.TabIndex = 2;
            this.lblPrecioUnit.Text = "Precio unitario:";
            //
            // lblCantidad
            //
            this.lblCantidad.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblCantidad.AutoSize = true;
            this.lblCantidad.Font = new System.Drawing.Font("Segoe UI", 9.5F);
            this.lblCantidad.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCantidad.Location = new System.Drawing.Point(638, 78);
            this.lblCantidad.Name = "lblCantidad";
            this.lblCantidad.Size = new System.Drawing.Size(64, 17);
            this.lblCantidad.TabIndex = 3;
            this.lblCantidad.Text = "Cantidad:";
            //
            // lblCodTit
            //
            this.lblCodTit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblCodTit.AutoSize = true;
            this.lblCodTit.Font = new System.Drawing.Font("Segoe UI", 9.5F);
            this.lblCodTit.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCodTit.Location = new System.Drawing.Point(638, 108);
            this.lblCodTit.Name = "lblCodTit";
            this.lblCodTit.Size = new System.Drawing.Size(105, 17);
            this.lblCodTit.TabIndex = 4;
            this.lblCodTit.Text = "Butacas elegidas:";
            //
            // flpCodigos
            //
            this.flpCodigos.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.flpCodigos.AutoScroll = true;
            this.flpCodigos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(30)))), ((int)(((byte)(32)))), ((int)(((byte)(40)))));
            this.flpCodigos.Location = new System.Drawing.Point(638, 130);
            this.flpCodigos.Name = "flpCodigos";
            this.flpCodigos.Size = new System.Drawing.Size(280, 220);
            this.flpCodigos.TabIndex = 5;
            //
            // lblTotal
            //
            this.lblTotal.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblTotal.AutoSize = true;
            this.lblTotal.Font = new System.Drawing.Font("Segoe UI", 15F, System.Drawing.FontStyle.Bold);
            this.lblTotal.ForeColor = System.Drawing.Color.White;
            this.lblTotal.Location = new System.Drawing.Point(638, 360);
            this.lblTotal.Name = "lblTotal";
            this.lblTotal.Size = new System.Drawing.Size(72, 28);
            this.lblTotal.TabIndex = 6;
            this.lblTotal.Text = "Total:";
            //
            // btnReservar
            //
            this.btnReservar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnReservar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(18)))), ((int)(((byte)(58)))), ((int)(((byte)(94)))));
            this.btnReservar.FlatAppearance.BorderSize = 0;
            this.btnReservar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnReservar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnReservar.ForeColor = System.Drawing.Color.White;
            this.btnReservar.Location = new System.Drawing.Point(638, 410);
            this.btnReservar.Name = "btnReservar";
            this.btnReservar.Size = new System.Drawing.Size(280, 44);
            this.btnReservar.TabIndex = 7;
            this.btnReservar.Text = "Reservar butacas";
            this.btnReservar.UseVisualStyleBackColor = false;
            this.btnReservar.Click += new System.EventHandler(this.BtnReservar_Click_14OR);
            //
            // btnCerrar
            //
            this.btnCerrar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCerrar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(60)))), ((int)(((byte)(63)))), ((int)(((byte)(72)))));
            this.btnCerrar.FlatAppearance.BorderSize = 0;
            this.btnCerrar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCerrar.ForeColor = System.Drawing.Color.White;
            this.btnCerrar.Location = new System.Drawing.Point(638, 462);
            this.btnCerrar.Name = "btnCerrar";
            this.btnCerrar.Size = new System.Drawing.Size(280, 34);
            this.btnCerrar.TabIndex = 8;
            this.btnCerrar.Text = "Cerrar";
            this.btnCerrar.UseVisualStyleBackColor = false;
            this.btnCerrar.Click += new System.EventHandler(this.BtnCerrar_Click_14OR);
            //
            // lblRef
            //
            this.lblRef.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblRef.Font = new System.Drawing.Font("Segoe UI", 7.5F);
            this.lblRef.ForeColor = System.Drawing.Color.Gray;
            this.lblRef.Location = new System.Drawing.Point(638, 510);
            this.lblRef.Name = "lblRef";
            this.lblRef.Size = new System.Drawing.Size(280, 40);
            this.lblRef.TabIndex = 9;
            this.lblRef.Text = "Verde=Libre   Amarillo=Elegida   Rojo=Reservada/Ocupada   Azul=Accesible";
            //
            // SeleccionButacas
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(924, 601);
            this.Controls.Add(this.lblRef);
            this.Controls.Add(this.btnCerrar);
            this.Controls.Add(this.btnReservar);
            this.Controls.Add(this.lblTotal);
            this.Controls.Add(this.flpCodigos);
            this.Controls.Add(this.lblCodTit);
            this.Controls.Add(this.lblCantidad);
            this.Controls.Add(this.lblPrecioUnit);
            this.Controls.Add(this.lblResumen);
            this.Controls.Add(this.panelMapa);
            this.Name = "SeleccionButacas";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Butacas";
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        private System.Windows.Forms.Panel panelMapa;
        private System.Windows.Forms.Label lblResumen;
        private System.Windows.Forms.Label lblPrecioUnit;
        private System.Windows.Forms.Label lblCantidad;
        private System.Windows.Forms.Label lblCodTit;
        private System.Windows.Forms.FlowLayoutPanel flpCodigos;
        private System.Windows.Forms.Label lblTotal;
        private System.Windows.Forms.Button btnReservar;
        private System.Windows.Forms.Button btnCerrar;
        private System.Windows.Forms.Label lblRef;
    }
}
