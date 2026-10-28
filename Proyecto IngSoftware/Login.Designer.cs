namespace Proyecto_IngSoftware
{
    partial class Login
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

        #region Código generado por el Diseñador de Windows Forms

        private void InitializeComponent()
        {
            this.panelIzq = new System.Windows.Forms.Panel();
            this.pbLogo = new System.Windows.Forms.PictureBox();
            this.lblLogin = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panelUser = new System.Windows.Forms.Panel();
            this.lblIconUser = new System.Windows.Forms.Label();
            this.txtUser = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.panelPass = new System.Windows.Forms.Panel();
            this.lblIconLock = new System.Windows.Forms.Label();
            this.txtContra = new System.Windows.Forms.TextBox();
            this.btnVerClave = new System.Windows.Forms.Button();
            this.btnAceptar = new System.Windows.Forms.Button();
            this.panelIzq.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbLogo)).BeginInit();
            this.panelUser.SuspendLayout();
            this.panelPass.SuspendLayout();
            this.SuspendLayout();
            //
            // panelIzq
            //
            this.panelIzq.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(34)))), ((int)(((byte)(37)))), ((int)(((byte)(46)))));
            this.panelIzq.Controls.Add(this.pbLogo);
            this.panelIzq.Dock = System.Windows.Forms.DockStyle.Left;
            this.panelIzq.Location = new System.Drawing.Point(0, 0);
            this.panelIzq.Name = "panelIzq";
            this.panelIzq.Size = new System.Drawing.Size(300, 470);
            this.panelIzq.TabIndex = 0;
            //
            // pbLogo
            //
            this.pbLogo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pbLogo.Location = new System.Drawing.Point(0, 0);
            this.pbLogo.Name = "pbLogo";
            this.pbLogo.Padding = new System.Windows.Forms.Padding(25);
            this.pbLogo.Size = new System.Drawing.Size(300, 470);
            this.pbLogo.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbLogo.TabIndex = 0;
            this.pbLogo.TabStop = false;
            //
            // lblLogin
            //
            this.lblLogin.AutoSize = true;
            this.lblLogin.Font = new System.Drawing.Font("Segoe UI", 34F, System.Drawing.FontStyle.Bold);
            this.lblLogin.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(41)))), ((int)(((byte)(128)))), ((int)(((byte)(215)))));
            this.lblLogin.Location = new System.Drawing.Point(344, 45);
            this.lblLogin.Name = "lblLogin";
            this.lblLogin.Size = new System.Drawing.Size(150, 61);
            this.lblLogin.TabIndex = 1;
            this.lblLogin.Text = "Login";
            //
            // label1
            //
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.Color.Gainsboro;
            this.label1.Location = new System.Drawing.Point(352, 140);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(49, 15);
            this.label1.TabIndex = 2;
            this.label1.Text = "Usuario";
            //
            // panelUser
            //
            this.panelUser.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(46)))), ((int)(((byte)(56)))));
            this.panelUser.Controls.Add(this.lblIconUser);
            this.panelUser.Controls.Add(this.txtUser);
            this.panelUser.Location = new System.Drawing.Point(352, 160);
            this.panelUser.Name = "panelUser";
            this.panelUser.Size = new System.Drawing.Size(330, 42);
            this.panelUser.TabIndex = 3;
            //
            // lblIconUser
            //
            this.lblIconUser.AutoSize = true;
            this.lblIconUser.Font = new System.Drawing.Font("Segoe MDL2 Assets", 12F);
            this.lblIconUser.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(255)))));
            this.lblIconUser.Location = new System.Drawing.Point(10, 10);
            this.lblIconUser.Name = "lblIconUser";
            this.lblIconUser.Size = new System.Drawing.Size(22, 21);
            this.lblIconUser.TabIndex = 0;
            this.lblIconUser.Text = "";
            //
            // txtUser
            //
            this.txtUser.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(46)))), ((int)(((byte)(56)))));
            this.txtUser.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txtUser.Font = new System.Drawing.Font("Segoe UI", 11F);
            this.txtUser.ForeColor = System.Drawing.Color.White;
            this.txtUser.Location = new System.Drawing.Point(44, 9);
            this.txtUser.Name = "txtUser";
            this.txtUser.Size = new System.Drawing.Size(276, 20);
            this.txtUser.TabIndex = 0;
            //
            // label2
            //
            this.label2.AutoSize = true;
            this.label2.ForeColor = System.Drawing.Color.Gainsboro;
            this.label2.Location = new System.Drawing.Point(352, 215);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(70, 15);
            this.label2.TabIndex = 4;
            this.label2.Text = "Contraseña";
            //
            // panelPass
            //
            this.panelPass.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(46)))), ((int)(((byte)(56)))));
            this.panelPass.Controls.Add(this.lblIconLock);
            this.panelPass.Controls.Add(this.txtContra);
            this.panelPass.Controls.Add(this.btnVerClave);
            this.panelPass.Location = new System.Drawing.Point(352, 235);
            this.panelPass.Name = "panelPass";
            this.panelPass.Size = new System.Drawing.Size(330, 42);
            this.panelPass.TabIndex = 5;
            //
            // lblIconLock
            //
            this.lblIconLock.AutoSize = true;
            this.lblIconLock.Font = new System.Drawing.Font("Segoe MDL2 Assets", 12F);
            this.lblIconLock.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(120)))), ((int)(((byte)(170)))), ((int)(((byte)(255)))));
            this.lblIconLock.Location = new System.Drawing.Point(10, 10);
            this.lblIconLock.Name = "lblIconLock";
            this.lblIconLock.Size = new System.Drawing.Size(22, 21);
            this.lblIconLock.TabIndex = 0;
            this.lblIconLock.Text = "";
            //
            // txtContra
            //
            this.txtContra.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(46)))), ((int)(((byte)(56)))));
            this.txtContra.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txtContra.Font = new System.Drawing.Font("Segoe UI", 11F);
            this.txtContra.ForeColor = System.Drawing.Color.White;
            this.txtContra.Location = new System.Drawing.Point(44, 9);
            this.txtContra.Name = "txtContra";
            this.txtContra.PasswordChar = '●';
            this.txtContra.Size = new System.Drawing.Size(240, 20);
            this.txtContra.TabIndex = 1;
            //
            // btnVerClave
            //
            this.btnVerClave.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(42)))), ((int)(((byte)(46)))), ((int)(((byte)(56)))));
            this.btnVerClave.FlatAppearance.BorderSize = 0;
            this.btnVerClave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnVerClave.Font = new System.Drawing.Font("Segoe MDL2 Assets", 11F);
            this.btnVerClave.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(150)))), ((int)(((byte)(160)))), ((int)(((byte)(180)))));
            this.btnVerClave.Location = new System.Drawing.Point(292, 5);
            this.btnVerClave.Name = "btnVerClave";
            this.btnVerClave.Size = new System.Drawing.Size(32, 32);
            this.btnVerClave.TabIndex = 2;
            this.btnVerClave.TabStop = false;
            this.btnVerClave.Text = "";
            this.btnVerClave.UseVisualStyleBackColor = false;
            this.btnVerClave.Click += new System.EventHandler(this.btnVerClave_Click);
            //
            // btnAceptar
            //
            this.btnAceptar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(41)))), ((int)(((byte)(128)))), ((int)(((byte)(215)))));
            this.btnAceptar.FlatAppearance.BorderSize = 0;
            this.btnAceptar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAceptar.Font = new System.Drawing.Font("Segoe UI", 14F, System.Drawing.FontStyle.Bold);
            this.btnAceptar.ForeColor = System.Drawing.Color.White;
            this.btnAceptar.Location = new System.Drawing.Point(352, 300);
            this.btnAceptar.Name = "btnAceptar";
            this.btnAceptar.Size = new System.Drawing.Size(330, 50);
            this.btnAceptar.TabIndex = 6;
            this.btnAceptar.Text = "Ingresar";
            this.btnAceptar.UseVisualStyleBackColor = false;
            this.btnAceptar.Click += new System.EventHandler(this.btn1_Click);
            //
            // Login
            //
            this.AcceptButton = this.btnAceptar;
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(24)))), ((int)(((byte)(24)))), ((int)(((byte)(24)))));
            this.ClientSize = new System.Drawing.Size(720, 470);
            this.Controls.Add(this.btnAceptar);
            this.Controls.Add(this.panelPass);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.panelUser);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.lblLogin);
            this.Controls.Add(this.panelIzq);
            this.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "Login";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "CineSur";
            this.panelIzq.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pbLogo)).EndInit();
            this.panelUser.ResumeLayout(false);
            this.panelUser.PerformLayout();
            this.panelPass.ResumeLayout(false);
            this.panelPass.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panelIzq;
        private System.Windows.Forms.PictureBox pbLogo;
        private System.Windows.Forms.Label lblLogin;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel panelUser;
        private System.Windows.Forms.Label lblIconUser;
        private System.Windows.Forms.TextBox txtUser;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Panel panelPass;
        private System.Windows.Forms.Label lblIconLock;
        private System.Windows.Forms.TextBox txtContra;
        private System.Windows.Forms.Button btnVerClave;
        private System.Windows.Forms.Button btnAceptar;
    }
}
