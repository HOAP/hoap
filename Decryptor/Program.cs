using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace Decryptor
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Configuration config = new Configuration();

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new DecryptorForm());
        }
    }
}
