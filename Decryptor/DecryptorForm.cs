using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

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
    }
}
