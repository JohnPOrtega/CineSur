namespace Proyecto_IngSoftware
{
    partial class Salas
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
            this.lblNumero = new System.Windows.Forms.Label();
            this.lblFilas = new System.Windows.Forms.Label();
            this.lblAsientos = new System.Windows.Forms.Label();
            this.lblCapacidad = new System.Windows.Forms.Label();
            this.lblCapacidadValor = new System.Windows.Forms.Label();
            this.numNumero = new System.Windows.Forms.NumericUpDown();
            this.numFilas = new System.Windows.Forms.NumericUpDown();
            this.numAsientos = new System.Windows.Forms.NumericUpDown();
            this.btnNuevo = new System.Windows.Forms.Button();
            this.btnModificar = new System.Windows.Forms.Button();
            this.btnEliminar = new System.Windows.Forms.Button();
            this.btnGuardar = new System.Windows.Forms.Button();
            this.lblEstado = new System.Windows.Forms.Label();
            this.dgvSalas = new System.Windows.Forms.DataGridView();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.btnVerDistribucion = new System.Windows.Forms.Button();
            this.btnDefinirPasillos = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.numNumero)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numFilas)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numAsientos)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSalas)).BeginInit();
            this.SuspendLayout();
            // 
            // lblNumero
            // 
            this.lblNumero.AutoSize = true;
            this.lblNumero.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblNumero.Location = new System.Drawing.Point(24, 43);
            this.lblNumero.Name = "lblNumero";
            this.lblNumero.Size = new System.Drawing.Size(93, 15);
            this.lblNumero.TabIndex = 0;
            this.lblNumero.Text = "Numero de sala:";
            // 
            // lblFilas
            // 
            this.lblFilas.AutoSize = true;
            this.lblFilas.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblFilas.Location = new System.Drawing.Point(24, 87);
            this.lblFilas.Name = "lblFilas";
            this.lblFilas.Size = new System.Drawing.Size(33, 15);
            this.lblFilas.TabIndex = 1;
            this.lblFilas.Text = "Filas:";
            // 
            // lblAsientos
            // 
            this.lblAsientos.AutoSize = true;
            this.lblAsientos.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblAsientos.Location = new System.Drawing.Point(24, 131);
            this.lblAsientos.Name = "lblAsientos";
            this.lblAsientos.Size = new System.Drawing.Size(95, 15);
            this.lblAsientos.TabIndex = 2;
            this.lblAsientos.Text = "Asientos por fila:";
            // 
            // lblCapacidad
            // 
            this.lblCapacidad.AutoSize = true;
            this.lblCapacidad.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCapacidad.Location = new System.Drawing.Point(24, 174);
            this.lblCapacidad.Name = "lblCapacidad";
            this.lblCapacidad.Size = new System.Drawing.Size(101, 15);
            this.lblCapacidad.TabIndex = 3;
            this.lblCapacidad.Text = "Capacidad (auto):";
            // 
            // lblCapacidadValor
            // 
            this.lblCapacidadValor.AutoSize = true;
            this.lblCapacidadValor.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold);
            this.lblCapacidadValor.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(230)))));
            this.lblCapacidadValor.Location = new System.Drawing.Point(168, 170);
            this.lblCapacidadValor.Name = "lblCapacidadValor";
            this.lblCapacidadValor.Size = new System.Drawing.Size(27, 20);
            this.lblCapacidadValor.TabIndex = 4;
            this.lblCapacidadValor.Text = "80";
            // 
            // numNumero
            // 
            this.numNumero.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numNumero.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numNumero.ForeColor = System.Drawing.Color.White;
            this.numNumero.Location = new System.Drawing.Point(170, 41);
            this.numNumero.Maximum = new decimal(new int[] {
            999,
            0,
            0,
            0});
            this.numNumero.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numNumero.Name = "numNumero";
            this.numNumero.Size = new System.Drawing.Size(90, 23);
            this.numNumero.TabIndex = 5;
            this.numNumero.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // numFilas
            // 
            this.numFilas.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numFilas.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numFilas.ForeColor = System.Drawing.Color.White;
            this.numFilas.Location = new System.Drawing.Point(170, 85);
            this.numFilas.Maximum = new decimal(new int[] {
            50,
            0,
            0,
            0});
            this.numFilas.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numFilas.Name = "numFilas";
            this.numFilas.Size = new System.Drawing.Size(90, 23);
            this.numFilas.TabIndex = 6;
            this.numFilas.Value = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.numFilas.ValueChanged += new System.EventHandler(this.numGrilla_ValueChanged);
            // 
            // numAsientos
            // 
            this.numAsientos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numAsientos.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numAsientos.ForeColor = System.Drawing.Color.White;
            this.numAsientos.Location = new System.Drawing.Point(170, 129);
            this.numAsientos.Maximum = new decimal(new int[] {
            50,
            0,
            0,
            0});
            this.numAsientos.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numAsientos.Name = "numAsientos";
            this.numAsientos.Size = new System.Drawing.Size(90, 23);
            this.numAsientos.TabIndex = 7;
            this.numAsientos.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numAsientos.ValueChanged += new System.EventHandler(this.numGrilla_ValueChanged);
            // 
            // btnNuevo
            // 
            this.btnNuevo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnNuevo.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnNuevo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNuevo.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnNuevo.ForeColor = System.Drawing.Color.White;
            this.btnNuevo.Location = new System.Drawing.Point(27, 220);
            this.btnNuevo.Name = "btnNuevo";
            this.btnNuevo.Size = new System.Drawing.Size(98, 44);
            this.btnNuevo.TabIndex = 8;
            this.btnNuevo.Text = "NUEVO";
            this.btnNuevo.UseVisualStyleBackColor = false;
            this.btnNuevo.Click += new System.EventHandler(this.btnNuevo_Click);
            // 
            // btnModificar
            // 
            this.btnModificar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnModificar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnModificar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnModificar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnModificar.ForeColor = System.Drawing.Color.White;
            this.btnModificar.Location = new System.Drawing.Point(172, 220);
            this.btnModificar.Name = "btnModificar";
            this.btnModificar.Size = new System.Drawing.Size(96, 44);
            this.btnModificar.TabIndex = 9;
            this.btnModificar.Text = "MODIFICAR";
            this.btnModificar.UseVisualStyleBackColor = false;
            this.btnModificar.Click += new System.EventHandler(this.btnModificar_Click);
            // 
            // btnEliminar
            // 
            this.btnEliminar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnEliminar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnEliminar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEliminar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnEliminar.ForeColor = System.Drawing.Color.White;
            this.btnEliminar.Location = new System.Drawing.Point(170, 290);
            this.btnEliminar.Name = "btnEliminar";
            this.btnEliminar.Size = new System.Drawing.Size(96, 45);
            this.btnEliminar.TabIndex = 10;
            this.btnEliminar.Text = "ELIMINAR";
            this.btnEliminar.UseVisualStyleBackColor = false;
            this.btnEliminar.Click += new System.EventHandler(this.btnEliminar_Click);
            // 
            // btnGuardar
            // 
            this.btnGuardar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnGuardar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnGuardar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnGuardar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnGuardar.ForeColor = System.Drawing.Color.White;
            this.btnGuardar.Location = new System.Drawing.Point(30, 290);
            this.btnGuardar.Name = "btnGuardar";
            this.btnGuardar.Size = new System.Drawing.Size(98, 45);
            this.btnGuardar.TabIndex = 11;
            this.btnGuardar.Text = "GUARDAR";
            this.btnGuardar.UseVisualStyleBackColor = false;
            this.btnGuardar.Click += new System.EventHandler(this.btnGuardar_Click);
            // 
            // lblEstado
            // 
            this.lblEstado.AutoSize = true;
            this.lblEstado.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(150)))), ((int)(((byte)(150)))));
            this.lblEstado.Location = new System.Drawing.Point(24, 350);
            this.lblEstado.MaximumSize = new System.Drawing.Size(340, 0);
            this.lblEstado.Name = "lblEstado";
            this.lblEstado.Size = new System.Drawing.Size(0, 15);
            this.lblEstado.TabIndex = 12;
            // 
            // dgvSalas
            // 
            this.dgvSalas.AllowUserToAddRows = false;
            this.dgvSalas.AllowUserToDeleteRows = false;
            this.dgvSalas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSalas.Location = new System.Drawing.Point(413, 12);
            this.dgvSalas.Name = "dgvSalas";
            this.dgvSalas.ReadOnly = true;
            this.dgvSalas.RowHeadersVisible = false;
            this.dgvSalas.Size = new System.Drawing.Size(320, 360);
            this.dgvSalas.TabIndex = 13;
            this.dgvSalas.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSalas_CellClick);
            // 
            // btnCancelar
            // 
            this.btnCancelar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(90)))), ((int)(((byte)(90)))), ((int)(((byte)(90)))));
            this.btnCancelar.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(120)))), ((int)(((byte)(120)))));
            this.btnCancelar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnCancelar.ForeColor = System.Drawing.Color.White;
            this.btnCancelar.Location = new System.Drawing.Point(30, 379);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(98, 45);
            this.btnCancelar.TabIndex = 14;
            this.btnCancelar.Text = "CANCELAR";
            this.btnCancelar.UseVisualStyleBackColor = false;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // btnVerDistribucion
            // 
            this.btnVerDistribucion.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnVerDistribucion.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnVerDistribucion.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnVerDistribucion.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnVerDistribucion.ForeColor = System.Drawing.Color.White;
            this.btnVerDistribucion.Location = new System.Drawing.Point(610, 379);
            this.btnVerDistribucion.Name = "btnVerDistribucion";
            this.btnVerDistribucion.Size = new System.Drawing.Size(123, 49);
            this.btnVerDistribucion.TabIndex = 15;
            this.btnVerDistribucion.Text = "Ver distribucion";
            this.btnVerDistribucion.UseVisualStyleBackColor = false;
            this.btnVerDistribucion.Click += new System.EventHandler(this.btnVerDistribucion_Click);
            // 
            // btnDefinirPasillos
            // 
            this.btnDefinirPasillos.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnDefinirPasillos.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(91)))), ((int)(((byte)(144)))), ((int)(((byte)(200)))));
            this.btnDefinirPasillos.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDefinirPasillos.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnDefinirPasillos.ForeColor = System.Drawing.Color.White;
            this.btnDefinirPasillos.Location = new System.Drawing.Point(413, 379);
            this.btnDefinirPasillos.Name = "btnDefinirPasillos";
            this.btnDefinirPasillos.Size = new System.Drawing.Size(123, 49);
            this.btnDefinirPasillos.TabIndex = 16;
            this.btnDefinirPasillos.Text = "Definir pasillos";
            this.btnDefinirPasillos.UseVisualStyleBackColor = false;
            this.btnDefinirPasillos.Click += new System.EventHandler(this.btnDefinirPasillos_Click);
            // 
            // Salas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(59)))), ((int)(((byte)(59)))), ((int)(((byte)(59)))));
            this.ClientSize = new System.Drawing.Size(745, 440);
            this.Controls.Add(this.btnDefinirPasillos);
            this.Controls.Add(this.btnVerDistribucion);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.dgvSalas);
            this.Controls.Add(this.lblEstado);
            this.Controls.Add(this.btnGuardar);
            this.Controls.Add(this.btnEliminar);
            this.Controls.Add(this.btnModificar);
            this.Controls.Add(this.btnNuevo);
            this.Controls.Add(this.lblCapacidadValor);
            this.Controls.Add(this.numAsientos);
            this.Controls.Add(this.numFilas);
            this.Controls.Add(this.numNumero);
            this.Controls.Add(this.lblCapacidad);
            this.Controls.Add(this.lblAsientos);
            this.Controls.Add(this.lblFilas);
            this.Controls.Add(this.lblNumero);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "Salas";
            this.Text = "Salas";
            ((System.ComponentModel.ISupportInitialize)(this.numNumero)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numFilas)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numAsientos)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSalas)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblNumero;
        private System.Windows.Forms.Label lblFilas;
        private System.Windows.Forms.Label lblAsientos;
        private System.Windows.Forms.Label lblCapacidad;
        private System.Windows.Forms.Label lblCapacidadValor;
        private System.Windows.Forms.NumericUpDown numNumero;
        private System.Windows.Forms.NumericUpDown numFilas;
        private System.Windows.Forms.NumericUpDown numAsientos;
        private System.Windows.Forms.Button btnNuevo;
        private System.Windows.Forms.Button btnModificar;
        private System.Windows.Forms.Button btnEliminar;
        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Label lblEstado;
        private System.Windows.Forms.DataGridView dgvSalas;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Button btnVerDistribucion;
        private System.Windows.Forms.Button btnDefinirPasillos;
    }
}
