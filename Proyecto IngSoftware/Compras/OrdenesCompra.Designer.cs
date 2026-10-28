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
            // OrdenesCompra
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(24)))), ((int)(((byte)(24)))), ((int)(((byte)(24)))));
            this.ClientSize = new System.Drawing.Size(790, 520);
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
    }
}
