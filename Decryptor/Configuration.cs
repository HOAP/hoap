using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.ComponentModel;
using System.IO;

namespace Decryptor
{
    public class Configuration : INotifyPropertyChanged
    {
        private string dataPath;
        private string filePath;

        public Configuration()
        {
            dataPath = global::Decryptor.Properties.Settings.Default.DataPath;
            filePath = String.Empty;
            if (this.dataPath == null || this.dataPath == String.Empty)
            {
                this.dataPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
                SaveConfiguration();
            }
        }

        public string DataPath
        {
            get { lock (this) { return dataPath; } }
            set
            {
                lock (this)
                {
                    dataPath = Path.GetDirectoryName(value);
                    SaveConfiguration();
                    OnPropertyChanged("DataPath");
                }
            }
        }

        public string FilePath
        {
            get { lock (this) { return filePath; } }
            set
            {
                lock (this)
                {
                    filePath = value;
                    DataPath = value;
                    OnPropertyChanged("FilePath");
                }
            }
        }

        private void SaveConfiguration()
        {
            global::Decryptor.Properties.Settings.Default.DataPath = dataPath;
            global::Decryptor.Properties.Settings.Default.Save();
        }

        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;

        // Create the OnPropertyChanged method to raise the event
        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }

        #endregion
    }
}
