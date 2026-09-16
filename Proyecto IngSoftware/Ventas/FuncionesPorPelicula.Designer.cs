namespace Proyecto_IngSoftware
{
    partial class FuncionesPorPelicula
    {
        // disenador: controles fijos (titulo, subtitulo y el panel de funciones).
        // el titulo se completa con el nombre de la peli en el .cs; las tarjetas de cada
        // funcion se generan por codigo adentro de flpFunciones.
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
            this.lblTitulo = new System.Windows.Forms.Label();
            this.lblSub = new System.Windows.Forms.Label();
            this.flpFunciones = new System.Windows.Forms.FlowLayoutPanel();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 15F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(18, 14);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(85, 28);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Pelicula";
            //
            // lblSub
            //
            this.lblSub.AutoSize = true;
            this.lblSub.Font = new System.Drawing.Font("Segoe UI", 9.5F);
            this.lblSub.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblSub.Location = new System.Drawing.Point(20, 48);
            this.lblSub.Name = "lblSub";
            this.lblSub.Size = new System.Drawing.Size(105, 17);
            this.lblSub.TabIndex = 1;
            this.lblSub.Text = "Elegi una funcion:";
            //
            // flpFunciones
            //
            this.flpFunciones.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.flpFunciones.AutoScroll = true;
            this.flpFunciones.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.flpFunciones.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.flpFunciones.Location = new System.Drawing.Point(18, 74);
            this.flpFunciones.Name = "flpFunciones";
            this.flpFunciones.Size = new System.Drawing.Size(628, 431);
            this.flpFunciones.TabIndex = 2;
            this.flpFunciones.WrapContents = false;
            //
            // FuncionesPorPelicula
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(664, 521);
            this.Controls.Add(this.flpFunciones);
            this.Controls.Add(this.lblSub);
            this.Controls.Add(this.lblTitulo);
            this.Name = "FuncionesPorPelicula";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Funciones";
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Label lblSub;
        private System.Windows.Forms.FlowLayoutPanel flpFunciones;
    }
}
