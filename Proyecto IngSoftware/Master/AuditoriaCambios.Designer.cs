namespace Proyecto_IngSoftware
{
    partial class AuditoriaCambios
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
            this.lblBuscar = new System.Windows.Forms.Label();
            this.txtBuscar = new System.Windows.Forms.TextBox();
            this.chkDesde = new System.Windows.Forms.CheckBox();
            this.dtpDesde = new System.Windows.Forms.DateTimePicker();
            this.chkHasta = new System.Windows.Forms.CheckBox();
            this.dtpHasta = new System.Windows.Forms.DateTimePicker();
            this.btnAplicar = new System.Windows.Forms.Button();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.btnActivar = new System.Windows.Forms.Button();
            this.btnSalir = new System.Windows.Forms.Button();
            this.dgvCambios = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dgvCambios)).BeginInit();
            this.SuspendLayout();
            //
            // lblTitulo
            //
            this.lblTitulo.AutoSize = true;
            this.lblTitulo.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.lblTitulo.ForeColor = System.Drawing.Color.White;
            this.lblTitulo.Location = new System.Drawing.Point(12, 12);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(360, 21);
            this.lblTitulo.TabIndex = 0;
            this.lblTitulo.Text = "AUDITORIA DE CAMBIOS - PELICULAS";
            //
            // lblBuscar
            //
            this.lblBuscar.AutoSize = true;
            this.lblBuscar.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblBuscar.Location = new System.Drawing.Point(12, 53);
            this.lblBuscar.Name = "lblBuscar";
            this.lblBuscar.Size = new System.Drawing.Size(76, 15);
            this.lblBuscar.TabIndex = 1;
            this.lblBuscar.Text = "Buscar titulo:";
            //
            // txtBuscar
            //
            this.txtBuscar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtBuscar.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtBuscar.ForeColor = System.Drawing.Color.White;
            this.txtBuscar.Location = new System.Drawing.Point(95, 50);
            this.txtBuscar.Name = "txtBuscar";
            this.txtBuscar.Size = new System.Drawing.Size(210, 23);
            this.txtBuscar.TabIndex = 2;
            this.txtBuscar.TextChanged += new System.EventHandler(this.txtBuscar_TextChanged);
            //
            // chkDesde
            //
            this.chkDesde.AutoSize = true;
            this.chkDesde.ForeColor = System.Drawing.Color.Gainsboro;
            this.chkDesde.Location = new System.Drawing.Point(325, 52);
            this.chkDesde.Name = "chkDesde";
            this.chkDesde.Size = new System.Drawing.Size(60, 19);
            this.chkDesde.TabIndex = 3;
            this.chkDesde.Text = "Desde";
            this.chkDesde.UseVisualStyleBackColor = true;
            this.chkDesde.CheckedChanged += new System.EventHandler(this.Filtro_Changed_14OR);
            //
            // dtpDesde
            //
            this.dtpDesde.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpDesde.Location = new System.Drawing.Point(391, 50);
            this.dtpDesde.Name = "dtpDesde";
            this.dtpDesde.Size = new System.Drawing.Size(120, 23);
            this.dtpDesde.TabIndex = 4;
            this.dtpDesde.ValueChanged += new System.EventHandler(this.Filtro_Changed_14OR);
            //
            // chkHasta
            //
            this.chkHasta.AutoSize = true;
            this.chkHasta.ForeColor = System.Drawing.Color.Gainsboro;
            this.chkHasta.Location = new System.Drawing.Point(529, 52);
            this.chkHasta.Name = "chkHasta";
            this.chkHasta.Size = new System.Drawing.Size(56, 19);
            this.chkHasta.TabIndex = 5;
            this.chkHasta.Text = "Hasta";
            this.chkHasta.UseVisualStyleBackColor = true;
            this.chkHasta.CheckedChanged += new System.EventHandler(this.Filtro_Changed_14OR);
            //
            // dtpHasta
            //
            this.dtpHasta.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpHasta.Location = new System.Drawing.Point(591, 50);
            this.dtpHasta.Name = "dtpHasta";
            this.dtpHasta.Size = new System.Drawing.Size(120, 23);
            this.dtpHasta.TabIndex = 6;
            this.dtpHasta.ValueChanged += new System.EventHandler(this.Filtro_Changed_14OR);
            //
            // btnAplicar
            //
            this.btnAplicar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(139)))), ((int)(((byte)(87)))));
            this.btnAplicar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAplicar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnAplicar.ForeColor = System.Drawing.Color.White;
            this.btnAplicar.Location = new System.Drawing.Point(12, 88);
            this.btnAplicar.Name = "btnAplicar";
            this.btnAplicar.Size = new System.Drawing.Size(110, 34);
            this.btnAplicar.TabIndex = 7;
            this.btnAplicar.Text = "APLICAR";
            this.btnAplicar.UseVisualStyleBackColor = false;
            this.btnAplicar.Click += new System.EventHandler(this.btnAplicar_Click);
            //
            // btnLimpiar
            //
            this.btnLimpiar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(70)))), ((int)(((byte)(70)))), ((int)(((byte)(70)))));
            this.btnLimpiar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLimpiar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnLimpiar.ForeColor = System.Drawing.Color.White;
            this.btnLimpiar.Location = new System.Drawing.Point(132, 88);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(110, 34);
            this.btnLimpiar.TabIndex = 8;
            this.btnLimpiar.Text = "LIMPIAR";
            this.btnLimpiar.UseVisualStyleBackColor = false;
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click);
            //
            // btnActivar
            //
            this.btnActivar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnActivar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnActivar.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnActivar.ForeColor = System.Drawing.Color.White;
            this.btnActivar.Location = new System.Drawing.Point(252, 88);
            this.btnActivar.Name = "btnActivar";
            this.btnActivar.Size = new System.Drawing.Size(180, 34);
            this.btnActivar.TabIndex = 9;
            this.btnActivar.Text = "ACTIVAR (rollback)";
            this.btnActivar.UseVisualStyleBackColor = false;
            this.btnActivar.Click += new System.EventHandler(this.btnActivar_Click);
            //
            // btnSalir
            //
            this.btnSalir.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(60)))), ((int)(((byte)(60)))));
            this.btnSalir.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSalir.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.btnSalir.ForeColor = System.Drawing.Color.White;
            this.btnSalir.Location = new System.Drawing.Point(442, 88);
            this.btnSalir.Name = "btnSalir";
            this.btnSalir.Size = new System.Drawing.Size(110, 34);
            this.btnSalir.TabIndex = 10;
            this.btnSalir.Text = "SALIR";
            this.btnSalir.UseVisualStyleBackColor = false;
            this.btnSalir.Click += new System.EventHandler(this.btnSalir_Click);
            //
            // dgvCambios
            //
            this.dgvCambios.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvCambios.Location = new System.Drawing.Point(12, 134);
            this.dgvCambios.Name = "dgvCambios";
            this.dgvCambios.ReadOnly = true;
            this.dgvCambios.Size = new System.Drawing.Size(876, 440);
            this.dgvCambios.TabIndex = 11;
            //
            // AuditoriaCambios
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(24)))), ((int)(((byte)(24)))), ((int)(((byte)(24)))));
            this.ClientSize = new System.Drawing.Size(900, 590);
            this.Controls.Add(this.dgvCambios);
            this.Controls.Add(this.btnSalir);
            this.Controls.Add(this.btnActivar);
            this.Controls.Add(this.btnLimpiar);
            this.Controls.Add(this.btnAplicar);
            this.Controls.Add(this.dtpHasta);
            this.Controls.Add(this.chkHasta);
            this.Controls.Add(this.dtpDesde);
            this.Controls.Add(this.chkDesde);
            this.Controls.Add(this.txtBuscar);
            this.Controls.Add(this.lblBuscar);
            this.Controls.Add(this.lblTitulo);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "AuditoriaCambios";
            this.Text = "Auditoria de Cambios";
            ((System.ComponentModel.ISupportInitialize)(this.dgvCambios)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitulo;
        private System.Windows.Forms.Label lblBuscar;
        private System.Windows.Forms.TextBox txtBuscar;
        private System.Windows.Forms.CheckBox chkDesde;
        private System.Windows.Forms.DateTimePicker dtpDesde;
        private System.Windows.Forms.CheckBox chkHasta;
        private System.Windows.Forms.DateTimePicker dtpHasta;
        private System.Windows.Forms.Button btnAplicar;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.Button btnActivar;
        private System.Windows.Forms.Button btnSalir;
        private System.Windows.Forms.DataGridView dgvCambios;
    }
}
