using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace Decryptor
{
    public class Decryptor
    {
        private RSACryptoServiceProvider rsa;

        public Decryptor()
        {
            rsa = new RSACryptoServiceProvider();
            rsa.FromXmlString(File.ReadAllText(@"private.xml"));
        }

        public string DecryptString(string encText)
        {
            byte[] plain = rsa.Decrypt(Convert.FromBase64String(encText), false);
            return Encoding.UTF8.GetString(plain);
        }
    }
}
