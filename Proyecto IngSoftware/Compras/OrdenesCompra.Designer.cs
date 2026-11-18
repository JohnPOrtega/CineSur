namespace Proyecto_IngSoftware
{
    partial class OrdenesCompra
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
            this.dgvOrdenes = new System.Windows.Forms.DataGridView();
            this.lblDetalle = new System.Windows.Forms.Label();
            this.dgvDetalleOrden = new System.Windows.Forms.DataGridView();
            this.btnPagar = new System.Windows.Forms.Button();
            this.btnRegistrarRecepcion = new System.Windows.Forms.Button();
            this.lblRemito = new System.Windows.Forms.Label();
            this.txtRemito = new System.Windows.Forms.TextBox();
            this.lblProximoPaso = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvOrdenes)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDetalleOrden)).BeginInit();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(12, 12);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(179, 20);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "ORDENES DE COMPRA";
            //
            // dgvOrdenes
            //
            this.dgvOrdenes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvOrdenes.Location = new System.Drawing.Point(12, 40);
            this.dgvOrdenes.Name = "dgvOrdenes";
            this.dgvOrdenes.ReadOnly = true;
            this.dgvOrdenes.Size = new System.Drawing.Size(760, 230);
            this.dgvOrdenes.TabIndex = 1;
            this.dgvOrdenes.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvOrdenes_CellClick);
            //
            // lblDetalle
            //
            this.lblDetalle.AutoSize = true;
            this.lblDetalle.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblDetalle.Location = new System.Drawing.Point(12, 285);
            this.lblDetalle.Name = "lblDetalle";
            this.lblDetalle.Size = new System.Drawing.Size(140, 15);
            this.lblDetalle.TabIndex = 2;
            this.lblDetalle.Text = "Detalle de la orden elegida:";
            //
            // dgvDetalleOrden
            //
            this.dgvDetalleOrden.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDetalleOrden.Location = new System.Drawing.Point(12, 308);
            this.dgvDetalleOrden.Name = "dgvDetalleOrden";
            this.dgvDetalleOrden.ReadOnly = true;
            this.dgvDetalleOrden.Size = new System.Drawing.Size(760, 190);
            this.dgvDetalleOrden.TabIndex = 3;
            //
            // lblRemito
            //
            this.lblRemito.AutoSize = true;
            this.lblRemito.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblRemito.Location = new System.Drawing.Point(12, 512);
            this.lblRemito.Name = "lblRemito";
            this.lblRemito.Size = new System.Drawing.Size(63, 15);
            this.lblRemito.TabIndex = 4;
            this.lblRemito.Text = "N° remito:";
            //
            // txtRemito
            //
            this.txtRemito.Location = new System.Drawing.Point(90, 509);
            this.txtRemito.Name = "txtRemito";
            this.txtRemito.Size = new System.Drawing.Size(150, 23);
            this.txtRemito.TabIndex = 5;
            //
            // btnPagar
            //
            this.btnPagar.Location = new System.Drawing.Point(260, 507);
            this.btnPagar.Name = "btnPagar";
            this.btnPagar.Size = new System.Drawing.Size(130, 27);
            this.btnPagar.TabIndex = 6;
            this.btnPagar.Text = "Pagar orden";
            this.btnPagar.UseVisualStyleBackColor = true;
            this.btnPagar.Click += new System.EventHandler(this.btnPagar_Click);
            //
            // btnRegistrarRecepcion
            //
            this.btnRegistrarRecepcion.Location = new System.Drawing.Point(400, 507);
            this.btnRegistrarRecepcion.Name = "btnRegistrarRecepcion";
            this.btnRegistrarRecepcion.Size = new System.Drawing.Size(180, 27);
            this.btnRegistrarRecepcion.TabIndex = 7;
            this.btnRegistrarRecepcion.Text = "Registrar recepción";
            this.btnRegistrarRecepcion.UseVisualStyleBackColor = true;
            this.btnRegistrarRecepcion.Click += new System.EventHandler(this.btnRegistrarRecepcion_Click);
            //
            // lblProximoPaso
            //
            this.lblProximoPaso.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblProximoPaso.Location = new System.Drawing.Point(12, 545);
            this.lblProximoPaso.Name = "lblProximoPaso";
            this.lblProximoPaso.Size = new System.Drawing.Size(760, 45);
            this.lblProximoPaso.TabIndex = 8;
            this.lblProximoPaso.Text = "";
            //
            // OrdenesCompra
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(24)))), ((int)(((byte)(24)))), ((int)(((byte)(24)))));
            this.ClientSize = new System.Drawing.Size(790, 600);
            this.Controls.Add(this.lblProximoPaso);
            this.Controls.Add(this.btnRegistrarRecepcion);
            this.Controls.Add(this.btnPagar);
            this.Controls.Add(this.txtRemito);
            this.Controls.Add(this.lblRemito);
            this.Controls.Add(this.dgvDetalleOrden);
            this.Controls.Add(this.lblDetalle);
            this.Controls.Add(this.dgvOrdenes);
            this.Controls.Add(this.lblTitulo);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "OrdenesCompra";
            this.Text = "Ordenes de Compra";
            ((System.ComponentModel.ISupportInitialize)(this.dgvOrdenes)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDetalleOrden)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.DataGridView dgvOrdenes;
        private System.Windows.Forms.Label lblDetalle;
        private System.Windows.Forms.DataGridView dgvDetalleOrden;
        private System.Windows.Forms.Button btnPagar;
        private System.Windows.Forms.Button btnRegistrarRecepcion;
        private System.Windows.Forms.Label lblRemito;
        private System.Windows.Forms.TextBox txtRemito;
        private System.Windows.Forms.Label lblProximoPaso;
    }
}
