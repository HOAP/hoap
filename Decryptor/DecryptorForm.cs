using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Kent.Boogaart.KBCsv;

namespace Decryptor
{
    public partial class DecryptorForm : Form
    {
        private Configuration config;
        private Decryptor decryptor;

        public DecryptorForm(Configuration config, Decryptor decryptor)
        {
            InitializeComponent();

            this.config = config;
            this.decryptor = decryptor;
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

        private void decryptButton_Click(object sender, EventArgs e)
        {
            HeaderRecord header;
            List<string> data;
            List<IList<string>> rows = new List<IList<string>>();
            int idx;
            if (config.FilePath != null && config.FilePath != String.Empty)
            {
                using (CsvReader reader = new CsvReader(config.FilePath))
                {
                    header = reader.ReadHeaderRecord();
                    idx = header.IndexOf("Email");
                    DataRecord row;
                    while ((row = reader.ReadDataRecord()) != null)
                    {
                        data = row.Values.ToList();
                        if (data[idx] != null && data[idx] != String.Empty && !data[idx].Contains('@'))
                        {
                            data[idx] = decryptor.DecryptString(data[idx]);
                        }
                        rows.Add(data);
                    }
                }
                using (CsvWriter writer = new CsvWriter(config.FilePath))
                {
                    writer.WriteHeaderRecord(header);
                    foreach (IList<string> row in rows)
                    {
                        writer.WriteDataRecord(row);
                    }
                }
                MessageBox.Show("All done!", "Success", MessageBoxButtons.OK);
            }
        }
    }
}
