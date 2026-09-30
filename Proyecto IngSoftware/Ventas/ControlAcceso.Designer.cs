namespace Proyecto_IngSoftware
{
    partial class ControlAcceso
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
            this.lblFuncionTit = new System.Windows.Forms.Label();
            this.cmbFuncion = new System.Windows.Forms.ComboBox();
            this.btnActualizar = new System.Windows.Forms.Button();
            this.lblLeyenda = new System.Windows.Forms.Label();
            this.lblContadores = new System.Windows.Forms.Label();
            this.panelMapa = new System.Windows.Forms.Panel();
            this.lblEstadoIngreso = new System.Windows.Forms.Label();
            this.btnCerrar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 16F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(20, 14);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(214, 30);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "Control de acceso";
            //
            // lblFuncionTit
            //
            this.lblFuncionTit.AutoSize = true;
            this.lblFuncionTit.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblFuncionTit.Location = new System.Drawing.Point(24, 60);
            this.lblFuncionTit.Name = "lblFuncionTit";
            this.lblFuncionTit.Size = new System.Drawing.Size(56, 15);
            this.lblFuncionTit.TabIndex = 1;
            this.lblFuncionTit.Text = "Funcion:";
            //
            // cmbFuncion
            //
            this.cmbFuncion.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.cmbFuncion.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbFuncion.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cmbFuncion.ForeColor = System.Drawing.Color.White;
            this.cmbFuncion.FormattingEnabled = true;
            this.cmbFuncion.Location = new System.Drawing.Point(90, 57);
            this.cmbFuncion.Name = "cmbFuncion";
            this.cmbFuncion.Size = new System.Drawing.Size(430, 23);
            this.cmbFuncion.TabIndex = 2;
            this.cmbFuncion.SelectedIndexChanged += new System.EventHandler(this.cmbFuncion_SelectedIndexChanged);
            //
            // btnActualizar
            //
            this.btnActualizar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnActualizar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnActualizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnActualizar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnActualizar.ForeColor = System.Drawing.Color.White;
            this.btnActualizar.Location = new System.Drawing.Point(540, 56);
            this.btnActualizar.Name = "btnActualizar";
            this.btnActualizar.Size = new System.Drawing.Size(110, 27);
            this.btnActualizar.TabIndex = 3;
            this.btnActualizar.Text = "Actualizar";
            this.btnActualizar.UseVisualStyleBackColor = false;
            this.btnActualizar.Click += new System.EventHandler(this.btnActualizar_Click);
            //
            // lblLeyenda
            //
            this.lblLeyenda.AutoSize = true;
            this.lblLeyenda.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(150)))), ((int)(((byte)(150)))));
            this.lblLeyenda.Location = new System.Drawing.Point(24, 92);
            this.lblLeyenda.Name = "lblLeyenda";
            this.lblLeyenda.Size = new System.Drawing.Size(520, 15);
            this.lblLeyenda.TabIndex = 4;
            this.lblLeyenda.Text = "Rojo = vendida (click para registrar ingreso)   |   Violeta = ya ingreso   |   Verde = libre";
            //
            // lblContadores
            //
            this.lblContadores.AutoSize = true;
            this.lblContadores.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblContadores.Location = new System.Drawing.Point(24, 114);
            this.lblContadores.Name = "lblContadores";
            this.lblContadores.Size = new System.Drawing.Size(0, 15);
            this.lblContadores.TabIndex = 5;
            //
            // panelMapa
            //
            this.panelMapa.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.panelMapa.AutoScroll = true;
            this.panelMapa.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.panelMapa.Location = new System.Drawing.Point(24, 140);
            this.panelMapa.Name = "panelMapa";
            this.panelMapa.Size = new System.Drawing.Size(946, 380);
            this.panelMapa.TabIndex = 6;
            //
            // lblEstadoIngreso
            //
            this.lblEstadoIngreso.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.lblEstadoIngreso.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblEstadoIngreso.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblEstadoIngreso.Location = new System.Drawing.Point(24, 532);
            this.lblEstadoIngreso.Name = "lblEstadoIngreso";
            this.lblEstadoIngreso.Size = new System.Drawing.Size(790, 40);
            this.lblEstadoIngreso.TabIndex = 7;
            this.lblEstadoIngreso.Text = "Elegi una funcion para ver la sala.";
            this.lblEstadoIngreso.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            //
            // btnCerrar
            //
            this.btnCerrar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCerrar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.btnCerrar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(120)))), ((int)(((byte)(120)))));
            this.btnCerrar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCerrar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnCerrar.ForeColor = System.Drawing.Color.White;
            this.btnCerrar.Location = new System.Drawing.Point(830, 530);
            this.btnCerrar.Name = "btnCerrar";
            this.btnCerrar.Size = new System.Drawing.Size(140, 42);
            this.btnCerrar.TabIndex = 8;
            this.btnCerrar.Text = "Cerrar";
            this.btnCerrar.UseVisualStyleBackColor = false;
            this.btnCerrar.Click += new System.EventHandler(this.btnCerrar_Click);
            //
            // ControlAcceso
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(25)))), ((int)(((byte)(27)))), ((int)(((byte)(34)))));
            this.ClientSize = new System.Drawing.Size(994, 588);
            this.Controls.Add(this.btnCerrar);
            this.Controls.Add(this.lblEstadoIngreso);
            this.Controls.Add(this.panelMapa);
            this.Controls.Add(this.lblContadores);
            this.Controls.Add(this.lblLeyenda);
            this.Controls.Add(this.btnActualizar);
            this.Controls.Add(this.cmbFuncion);
            this.Controls.Add(this.lblFuncionTit);
            this.Controls.Add(this.lblTitulo);
            this.Name = "ControlAcceso";
            this.Text = "Control de acceso";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Label lblFuncionTit;
        private System.Windows.Forms.ComboBox cmbFuncion;
        private System.Windows.Forms.Button btnActualizar;
        private System.Windows.Forms.Label lblLeyenda;
        private System.Windows.Forms.Label lblContadores;
        private System.Windows.Forms.Panel panelMapa;
        private System.Windows.Forms.Label lblEstadoIngreso;
        private System.Windows.Forms.Button btnCerrar;
    }
}
