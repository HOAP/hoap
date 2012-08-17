namespace Decryptor
{
    partial class DecryptorForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.decryptButton = new System.Windows.Forms.Button();
            this.gbDataFile = new System.Windows.Forms.GroupBox();
            this.fileButton = new System.Windows.Forms.Button();
            this.dataFileBox = new System.Windows.Forms.TextBox();
            this.gbDataFile.SuspendLayout();
            this.SuspendLayout();
            // 
            // decryptButton
            // 
            this.decryptButton.Location = new System.Drawing.Point(199, 74);
            this.decryptButton.Name = "decryptButton";
            this.decryptButton.Size = new System.Drawing.Size(75, 23);
            this.decryptButton.TabIndex = 0;
            this.decryptButton.Text = "Decrypt";
            this.decryptButton.UseVisualStyleBackColor = true;
            // 
            // gbDataFile
            // 
            this.gbDataFile.Controls.Add(this.dataFileBox);
            this.gbDataFile.Controls.Add(this.fileButton);
            this.gbDataFile.Location = new System.Drawing.Point(12, 12);
            this.gbDataFile.Name = "gbDataFile";
            this.gbDataFile.Size = new System.Drawing.Size(268, 56);
            this.gbDataFile.TabIndex = 1;
            this.gbDataFile.TabStop = false;
            this.gbDataFile.Text = "Data File";
            // 
            // fileButton
            // 
            this.fileButton.Location = new System.Drawing.Point(187, 18);
            this.fileButton.Name = "fileButton";
            this.fileButton.Size = new System.Drawing.Size(75, 23);
            this.fileButton.TabIndex = 0;
            this.fileButton.Text = "File...";
            this.fileButton.UseVisualStyleBackColor = true;
            // 
            // dataFileBox
            // 
            this.dataFileBox.Location = new System.Drawing.Point(7, 20);
            this.dataFileBox.Name = "dataFileBox";
            this.dataFileBox.Size = new System.Drawing.Size(174, 20);
            this.dataFileBox.TabIndex = 1;
            // 
            // DecryptorForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(292, 104);
            this.Controls.Add(this.gbDataFile);
            this.Controls.Add(this.decryptButton);
            this.Name = "DecryptorForm";
            this.Text = "HOAP Decryptor";
            this.gbDataFile.ResumeLayout(false);
            this.gbDataFile.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button decryptButton;
        private System.Windows.Forms.GroupBox gbDataFile;
        private System.Windows.Forms.Button fileButton;
        private System.Windows.Forms.TextBox dataFileBox;
    }
}

