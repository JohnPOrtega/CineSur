namespace Proyecto_IngSoftware
{
    partial class DistribucionSala_14OR
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
            this.mapa = new Proyecto_IngSoftware.MapaButacas_14OR();
            this.SuspendLayout();
            //
            // mapa
            //
            this.mapa.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mapa.Location = new System.Drawing.Point(0, 0);
            this.mapa.Name = "mapa";
            this.mapa.Size = new System.Drawing.Size(624, 481);
            this.mapa.TabIndex = 0;
            //
            // DistribucionSala_14OR
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(624, 481);
            this.Controls.Add(this.mapa);
            this.Name = "DistribucionSala_14OR";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Distribucion de la sala";
            this.ResumeLayout(false);

        }

        #endregion

        private Proyecto_IngSoftware.MapaButacas_14OR mapa;
    }
}
