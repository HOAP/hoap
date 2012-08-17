using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.ComponentModel;

namespace Decryptor
{
    public class Configuration : INotifyPropertyChanged
    {
        private string dataPath;

        public Configuration()
        {
            dataPath = global::Decryptor.Properties.Settings.Default.DataPath;
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
                    dataPath = value;
                    SaveConfiguration();
                    OnPropertyChanged("DataPath");
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
