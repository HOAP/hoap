using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace Decryptor
{
    public partial class DecryptorForm : Form
    {
        private Configuration config;

        public DecryptorForm(Configuration config)
        {
            InitializeComponent();

            this.config = config;
            dataFileBox.DataBindings.Add(new Binding("Text", config, "FilePath"));
        }

        private void fileButton_Click(object sender, EventArgs e)
        {
            OpenFileDialog fb = new OpenFileDialog();
            fb.Filter = "Comma Separated Values File (*.csv)|*.csv";
            fb.InitialDirectory = config.DataPath;
            if (fb.ShowDialog() == DialogResult.OK)
            {
                config.FilePath = fb.FileName;
            }
        }

        private void dataFileBox_DragDrop(object sender, DragEventArgs e)
        {
            string[] files = (string[])e.Data.GetData(DataFormats.FileDrop, false);
            for (int i = 0; i <= files.Length; i++)
            {
                if (Path.GetExtension(files[i]) == ".csv")
                {
                    config.FilePath = files[i];
                    break;
                }
            }
        }

        private void dataFileBox_DragEnter(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop))
            {
                e.Effect = DragDropEffects.All;
            }
            else
            {
                e.Effect = DragDropEffects.None;
            }
        }
    }
}
