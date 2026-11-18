namespace Proyecto_IngSoftware
{
    partial class Ayuda_43BO
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
            this.arbol = new System.Windows.Forms.TreeView();
            this.pnlContenido = new System.Windows.Forms.Panel();
            this.txt = new System.Windows.Forms.RichTextBox();
            this.lblDonde = new System.Windows.Forms.Label();
            this.lblTitulo = new System.Windows.Forms.Label();
            this.pnlPie = new System.Windows.Forms.Panel();
            this.btnCerrar = new System.Windows.Forms.Button();
            this.pnlContenido.SuspendLayout();
            this.pnlPie.SuspendLayout();
            this.SuspendLayout();
            //
            // arbol
            //
            this.arbol.Dock = System.Windows.Forms.DockStyle.Left;
            this.arbol.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.arbol.FullRowSelect = true;
            this.arbol.HideSelection = false;
            this.arbol.ItemHeight = 24;
            this.arbol.Location = new System.Drawing.Point(0, 0);
            this.arbol.Name = "arbol";
            this.arbol.ShowLines = false;
            this.arbol.Size = new System.Drawing.Size(250, 495);
            this.arbol.TabIndex = 0;
            this.arbol.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.arbol_AfterSelect);
            //
            // pnlContenido
            //
            this.pnlContenido.BackColor = System.Drawing.Color.White;
            this.pnlContenido.Controls.Add(this.txt);
            this.pnlContenido.Controls.Add(this.lblDonde);
            this.pnlContenido.Controls.Add(this.lblTitulo);
            this.pnlContenido.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlContenido.Location = new System.Drawing.Point(250, 0);
            this.pnlContenido.Name = "pnlContenido";
            this.pnlContenido.Padding = new System.Windows.Forms.Padding(18, 12, 18, 6);
            this.pnlContenido.Size = new System.Drawing.Size(614, 495);
            this.pnlContenido.TabIndex = 1;
            //
            // txt
            //
            this.txt.BackColor = System.Drawing.Color.White;
            this.txt.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txt.DetectUrls = false;
            this.txt.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txt.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.txt.Location = new System.Drawing.Point(18, 76);
            this.txt.Name = "txt";
            this.txt.ReadOnly = true;
            this.txt.Size = new System.Drawing.Size(578, 413);
            this.txt.TabIndex = 2;
            this.txt.TabStop = false;
            this.txt.Text = "";
            //
            // lblDonde
            //
            this.lblDonde.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblDonde.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Italic);
            this.lblDonde.ForeColor = System.Drawing.Color.DimGray;
            this.lblDonde.Location = new System.Drawing.Point(18, 48);
            this.lblDonde.Name = "lblDonde";
            this.lblDonde.Size = new System.Drawing.Size(578, 28);
            this.lblDonde.TabIndex = 1;
            //
            // lblTitulo
            //
            this.lblTitulo.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 15F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.Location = new System.Drawing.Point(18, 12);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(578, 36);
            this.lblTitulo.TabIndex = 0;
            //
            // pnlPie
            //
            this.pnlPie.Controls.Add(this.btnCerrar);
            this.pnlPie.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pnlPie.Location = new System.Drawing.Point(0, 495);
            this.pnlPie.Name = "pnlPie";
            this.pnlPie.Size = new System.Drawing.Size(864, 46);
            this.pnlPie.TabIndex = 2;
            //
            // btnCerrar
            //
            this.btnCerrar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCerrar.Location = new System.Drawing.Point(752, 8);
            this.btnCerrar.Name = "btnCerrar";
            this.btnCerrar.Size = new System.Drawing.Size(100, 30);
            this.btnCerrar.TabIndex = 0;
            this.btnCerrar.Text = "Cerrar";
            this.btnCerrar.UseVisualStyleBackColor = true;
            this.btnCerrar.Click += new System.EventHandler(this.btnCerrar_Click);
            //
            // Ayuda_43BO
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCerrar;
            this.ClientSize = new System.Drawing.Size(864, 541);
            this.Controls.Add(this.pnlContenido);
            this.Controls.Add(this.arbol);
            this.Controls.Add(this.pnlPie);
            this.KeyPreview = true;
            this.MinimumSize = new System.Drawing.Size(640, 420);
            this.Name = "Ayuda_43BO";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Ayuda - CineSur";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Ayuda_43BO_KeyDown);
            this.pnlContenido.ResumeLayout(false);
            this.pnlPie.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TreeView arbol;
        private System.Windows.Forms.Panel pnlContenido;
        private System.Windows.Forms.RichTextBox txt;
        private System.Windows.Forms.Label lblDonde;
        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Panel pnlPie;
        private System.Windows.Forms.Button btnCerrar;
    }
}
