namespace Proyecto_IngSoftware
{
    partial class Cartelera
    {
        // este es el archivo del disenador: aca viven los controles FIJOS de la ventana
        // (el titulo y el panel donde van las tarjetas). las tarjetas de cada peli se generan
        // por codigo en el .cs, adentro de flpPelis, porque no se sabe cuantas hay hasta ejecutar.
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
            this.flpPelis = new System.Windows.Forms.FlowLayoutPanel();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 16F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(20, 15);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(110, 30);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Cartelera";
            //
            // flpPelis
            //
            this.flpPelis.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.flpPelis.AutoScroll = true;
            this.flpPelis.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.flpPelis.Location = new System.Drawing.Point(20, 60);
            this.flpPelis.Name = "flpPelis";
            this.flpPelis.Size = new System.Drawing.Size(960, 520);
            this.flpPelis.TabIndex = 1;
            //
            // Cartelera
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(1000, 600);
            this.Controls.Add(this.flpPelis);
            this.Controls.Add(this.lblTitulo);
            this.Name = "Cartelera";
            this.Text = "Cartelera - Reservar butacas";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.FlowLayoutPanel flpPelis;
    }
}
