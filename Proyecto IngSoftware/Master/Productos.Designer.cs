namespace Proyecto_IngSoftware
{
    partial class Productos
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
            this.lblNombre = new System.Windows.Forms.Label();
            this.lblPrecio = new System.Windows.Forms.Label();
            this.lblCosto = new System.Windows.Forms.Label();
            this.lblStock = new System.Windows.Forms.Label();
            this.lblCritico = new System.Windows.Forms.Label();
            this.txtNombre = new System.Windows.Forms.TextBox();
            this.numPrecio = new System.Windows.Forms.NumericUpDown();
            this.numCosto = new System.Windows.Forms.NumericUpDown();
            this.numStock = new System.Windows.Forms.NumericUpDown();
            this.numCritico = new System.Windows.Forms.NumericUpDown();
            this.lblImagen = new System.Windows.Forms.Label();
            this.btnImagen = new System.Windows.Forms.Button();
            this.pbImagen = new System.Windows.Forms.PictureBox();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.btnNuevo = new System.Windows.Forms.Button();
            this.btnModificar = new System.Windows.Forms.Button();
            this.btnEliminar = new System.Windows.Forms.Button();
            this.btnGuardar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.lblEstado = new System.Windows.Forms.Label();
            this.dgvProductos = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.numPrecio)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCosto)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numStock)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCritico)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbImagen)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProductos)).BeginInit();
            this.SuspendLayout();
            //
            // lblNombre
            //
            this.lblNombre.AutoSize = true;
            this.lblNombre.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblNombre.Location = new System.Drawing.Point(24, 43);
            this.lblNombre.Name = "lblNombre";
            this.lblNombre.Size = new System.Drawing.Size(52, 15);
            this.lblNombre.TabIndex = 0;
            this.lblNombre.Text = "Producto:";
            //
            // lblPrecio
            //
            this.lblPrecio.AutoSize = true;
            this.lblPrecio.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblPrecio.Location = new System.Drawing.Point(24, 87);
            this.lblPrecio.Name = "lblPrecio";
            this.lblPrecio.Size = new System.Drawing.Size(80, 15);
            this.lblPrecio.TabIndex = 1;
            this.lblPrecio.Text = "Precio venta:";
            //
            // lblCosto
            //
            this.lblCosto.AutoSize = true;
            this.lblCosto.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCosto.Location = new System.Drawing.Point(24, 131);
            this.lblCosto.Name = "lblCosto";
            this.lblCosto.Size = new System.Drawing.Size(110, 15);
            this.lblCosto.TabIndex = 2;
            this.lblCosto.Text = "Precio costo (ref.):";
            //
            // lblStock
            //
            this.lblStock.AutoSize = true;
            this.lblStock.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblStock.Location = new System.Drawing.Point(24, 175);
            this.lblStock.Name = "lblStock";
            this.lblStock.Size = new System.Drawing.Size(40, 15);
            this.lblStock.TabIndex = 3;
            this.lblStock.Text = "Stock:";
            //
            // lblCritico
            //
            this.lblCritico.AutoSize = true;
            this.lblCritico.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblCritico.Location = new System.Drawing.Point(24, 219);
            this.lblCritico.Name = "lblCritico";
            this.lblCritico.Size = new System.Drawing.Size(74, 15);
            this.lblCritico.TabIndex = 4;
            this.lblCritico.Text = "Stock critico:";
            //
            // txtNombre
            //
            this.txtNombre.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.txtNombre.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtNombre.ForeColor = System.Drawing.Color.White;
            this.txtNombre.Location = new System.Drawing.Point(170, 40);
            this.txtNombre.Name = "txtNombre";
            this.txtNombre.Size = new System.Drawing.Size(185, 23);
            this.txtNombre.TabIndex = 5;
            //
            // numPrecio
            //
            this.numPrecio.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numPrecio.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numPrecio.DecimalPlaces = 2;
            this.numPrecio.ForeColor = System.Drawing.Color.White;
            this.numPrecio.Location = new System.Drawing.Point(170, 84);
            this.numPrecio.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.numPrecio.Name = "numPrecio";
            this.numPrecio.Size = new System.Drawing.Size(120, 23);
            this.numPrecio.TabIndex = 6;
            //
            // numCosto
            //
            this.numCosto.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numCosto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numCosto.DecimalPlaces = 2;
            this.numCosto.ForeColor = System.Drawing.Color.White;
            this.numCosto.Location = new System.Drawing.Point(170, 128);
            this.numCosto.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.numCosto.Name = "numCosto";
            this.numCosto.Size = new System.Drawing.Size(120, 23);
            this.numCosto.TabIndex = 7;
            //
            // numStock
            //
            this.numStock.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numStock.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numStock.ForeColor = System.Drawing.Color.White;
            this.numStock.Location = new System.Drawing.Point(170, 172);
            this.numStock.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.numStock.Name = "numStock";
            this.numStock.Size = new System.Drawing.Size(120, 23);
            this.numStock.TabIndex = 8;
            //
            // numCritico
            //
            this.numCritico.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.numCritico.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.numCritico.ForeColor = System.Drawing.Color.White;
            this.numCritico.Location = new System.Drawing.Point(170, 216);
            this.numCritico.Maximum = new decimal(new int[] {
            1000000,
            0,
            0,
            0});
            this.numCritico.Name = "numCritico";
            this.numCritico.Size = new System.Drawing.Size(120, 23);
            this.numCritico.TabIndex = 9;
            //
            // lblImagen
            //
            this.lblImagen.AutoSize = true;
            this.lblImagen.ForeColor = System.Drawing.Color.Gainsboro;
            this.lblImagen.Location = new System.Drawing.Point(24, 263);
            this.lblImagen.Name = "lblImagen";
            this.lblImagen.Size = new System.Drawing.Size(49, 15);
            this.lblImagen.TabIndex = 10;
            this.lblImagen.Text = "Imagen:";
            //
            // btnImagen
            //
            this.btnImagen.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnImagen.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnImagen.ForeColor = System.Drawing.Color.White;
            this.btnImagen.Location = new System.Drawing.Point(170, 259);
            this.btnImagen.Name = "btnImagen";
            this.btnImagen.Size = new System.Drawing.Size(150, 30);
            this.btnImagen.TabIndex = 11;
            this.btnImagen.Text = "Seleccionar imagen...";
            this.btnImagen.UseVisualStyleBackColor = false;
            this.btnImagen.Click += new System.EventHandler(this.btnImagen_Click);
            //
            // pbImagen
            //
            this.pbImagen.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(42)))), ((int)(((byte)(42)))));
            this.pbImagen.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pbImagen.Location = new System.Drawing.Point(170, 296);
            this.pbImagen.Name = "pbImagen";
            this.pbImagen.Size = new System.Drawing.Size(150, 110);
            this.pbImagen.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbImagen.TabIndex = 12;
            this.pbImagen.TabStop = false;
            //
            // openFileDialog1
            //
            this.openFileDialog1.Filter = "Imagenes|*.jpg;*.jpeg;*.png;*.bmp";
            //
            // btnNuevo
            //
            this.btnNuevo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnNuevo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNuevo.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnNuevo.ForeColor = System.Drawing.Color.White;
            this.btnNuevo.Location = new System.Drawing.Point(27, 425);
            this.btnNuevo.Name = "btnNuevo";
            this.btnNuevo.Size = new System.Drawing.Size(160, 44);
            this.btnNuevo.TabIndex = 13;
            this.btnNuevo.Text = "NUEVO";
            this.btnNuevo.UseVisualStyleBackColor = false;
            this.btnNuevo.Click += new System.EventHandler(this.btnNuevo_Click);
            //
            // btnModificar
            //
            this.btnModificar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnModificar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnModificar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnModificar.ForeColor = System.Drawing.Color.White;
            this.btnModificar.Location = new System.Drawing.Point(195, 425);
            this.btnModificar.Name = "btnModificar";
            this.btnModificar.Size = new System.Drawing.Size(160, 44);
            this.btnModificar.TabIndex = 14;
            this.btnModificar.Text = "MODIFICAR";
            this.btnModificar.UseVisualStyleBackColor = false;
            this.btnModificar.Click += new System.EventHandler(this.btnModificar_Click);
            //
            // btnEliminar
            //
            this.btnEliminar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnEliminar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEliminar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnEliminar.ForeColor = System.Drawing.Color.White;
            this.btnEliminar.Location = new System.Drawing.Point(27, 475);
            this.btnEliminar.Name = "btnEliminar";
            this.btnEliminar.Size = new System.Drawing.Size(160, 44);
            this.btnEliminar.TabIndex = 15;
            this.btnEliminar.Text = "ELIMINAR";
            this.btnEliminar.UseVisualStyleBackColor = false;
            this.btnEliminar.Click += new System.EventHandler(this.btnEliminar_Click);
            //
            // btnGuardar
            //
            this.btnGuardar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnGuardar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnGuardar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnGuardar.ForeColor = System.Drawing.Color.White;
            this.btnGuardar.Location = new System.Drawing.Point(195, 475);
            this.btnGuardar.Name = "btnGuardar";
            this.btnGuardar.Size = new System.Drawing.Size(160, 44);
            this.btnGuardar.TabIndex = 16;
            this.btnGuardar.Text = "GUARDAR";
            this.btnGuardar.UseVisualStyleBackColor = false;
            this.btnGuardar.Click += new System.EventHandler(this.btnGuardar_Click);
            //
            // btnCancelar
            //
            this.btnCancelar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(58)))), ((int)(((byte)(114)))), ((int)(((byte)(176)))));
            this.btnCancelar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCancelar.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold);
            this.btnCancelar.ForeColor = System.Drawing.Color.White;
            this.btnCancelar.Location = new System.Drawing.Point(111, 525);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(160, 44);
            this.btnCancelar.TabIndex = 17;
            this.btnCancelar.Text = "CANCELAR";
            this.btnCancelar.UseVisualStyleBackColor = false;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            //
            // lblEstado
            //
            this.lblEstado.AutoSize = true;
            this.lblEstado.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(150)))), ((int)(((byte)(150)))));
            this.lblEstado.Location = new System.Drawing.Point(24, 580);
            this.lblEstado.MaximumSize = new System.Drawing.Size(340, 0);
            this.lblEstado.Name = "lblEstado";
            this.lblEstado.Size = new System.Drawing.Size(0, 15);
            this.lblEstado.TabIndex = 18;
            //
            // dgvProductos
            //
            this.dgvProductos.AllowUserToAddRows = false;
            this.dgvProductos.AllowUserToDeleteRows = false;
            this.dgvProductos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvProductos.Location = new System.Drawing.Point(380, 36);
            this.dgvProductos.Name = "dgvProductos";
            this.dgvProductos.ReadOnly = true;
            this.dgvProductos.RowHeadersVisible = false;
            this.dgvProductos.Size = new System.Drawing.Size(420, 560);
            this.dgvProductos.TabIndex = 19;
            this.dgvProductos.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvProductos_CellClick);
            //
            // Productos
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(59)))), ((int)(((byte)(59)))), ((int)(((byte)(59)))));
            this.ClientSize = new System.Drawing.Size(824, 615);
            this.Controls.Add(this.dgvProductos);
            this.Controls.Add(this.lblEstado);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnGuardar);
            this.Controls.Add(this.btnEliminar);
            this.Controls.Add(this.btnModificar);
            this.Controls.Add(this.btnNuevo);
            this.Controls.Add(this.pbImagen);
            this.Controls.Add(this.btnImagen);
            this.Controls.Add(this.lblImagen);
            this.Controls.Add(this.numCritico);
            this.Controls.Add(this.numStock);
            this.Controls.Add(this.numCosto);
            this.Controls.Add(this.numPrecio);
            this.Controls.Add(this.txtNombre);
            this.Controls.Add(this.lblCritico);
            this.Controls.Add(this.lblStock);
            this.Controls.Add(this.lblCosto);
            this.Controls.Add(this.lblPrecio);
            this.Controls.Add(this.lblNombre);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.Name = "Productos";
            this.Text = "Productos (Candy Bar)";
            ((System.ComponentModel.ISupportInitialize)(this.numPrecio)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCosto)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numStock)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numCritico)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbImagen)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProductos)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblNombre;
        private System.Windows.Forms.Label lblPrecio;
        private System.Windows.Forms.Label lblCosto;
        private System.Windows.Forms.Label lblStock;
        private System.Windows.Forms.Label lblCritico;
        private System.Windows.Forms.TextBox txtNombre;
        private System.Windows.Forms.NumericUpDown numPrecio;
        private System.Windows.Forms.NumericUpDown numCosto;
        private System.Windows.Forms.NumericUpDown numStock;
        private System.Windows.Forms.NumericUpDown numCritico;
        private System.Windows.Forms.Label lblImagen;
        private System.Windows.Forms.Button btnImagen;
        private System.Windows.Forms.PictureBox pbImagen;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Button btnNuevo;
        private System.Windows.Forms.Button btnModificar;
        private System.Windows.Forms.Button btnEliminar;
        private System.Windows.Forms.Button btnGuardar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Label lblEstado;
        private System.Windows.Forms.DataGridView dgvProductos;
    }
}
