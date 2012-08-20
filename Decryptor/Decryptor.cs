using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Engines;
using Org.BouncyCastle.Crypto.Encodings;
using Org.BouncyCastle.OpenSsl;

namespace Decryptor
{
    /// <summary>
    /// This class does the actual decryption.
    /// I am using the Bouncy Castle crypto library (http://www.bouncycastle.org/csharp/)
    /// because it can read PEM format private certificates, unlike the .net system
    /// library.
    /// </summary>
    public class Decryptor
    {
        private AsymmetricCipherKeyPair keyPair;
        private Pkcs1Encoding decryptEngine;

        public Decryptor()
        {

            using (var reader = File.OpenText(@"private.pem"))
            {
                keyPair = (AsymmetricCipherKeyPair)new PemReader(reader).ReadObject();
            }
            decryptEngine = new Pkcs1Encoding(new RsaEngine());
            decryptEngine.Init(false, keyPair.Private);
        }

        public string DecryptString(string encText)
        {
            byte[] cypher = Convert.FromBase64String(encText);
            byte[] plain = decryptEngine.ProcessBlock(cypher, 0, cypher.Length);
            return Encoding.UTF8.GetString(plain);
        }
    }
}
