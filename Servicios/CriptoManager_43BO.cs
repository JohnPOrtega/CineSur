using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Servicios
{
    public class CriptoManager_43BO
    {
        // clave (32 bytes = AES-256) e IV (16 bytes) fijos del sistema.
        // se usan para el cifrado REVERSIBLE (ej: el email del cliente), distinto del hash de contraseñas.
        private static readonly byte[] Clave_43BO = Encoding.UTF8.GetBytes("CineSurClaveAES256_1234567890abc");
        private static readonly byte[] IV_43BO = Encoding.UTF8.GetBytes("CineSurIV_16byte");

        //generar un hash SHA256 de una cadena de texto (IRREVERSIBLE, para contraseñas)
        public static string GenerarHash_43BO(string texto)
        {


            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytesTexto = Encoding.UTF8.GetBytes(texto);
                byte[] hash = sha256.ComputeHash(bytesTexto);

                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash)
                {
                    sb.Append(b.ToString("x2"));
                }

                return sb.ToString();
            }
        }

        // cifra un texto con AES y lo devuelve en Base64. es REVERSIBLE (se puede volver al original
        // con Desencriptar_43BO). se usa para datos que hay que poder leer despues, como el email.
        public static string Encriptar_43BO(string texto)
        {
            if (string.IsNullOrEmpty(texto)) return texto;

            using (Aes aes = Aes.Create())
            {
                aes.Key = Clave_43BO;
                aes.IV = IV_43BO;

                using (ICryptoTransform enc = aes.CreateEncryptor())
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, enc, CryptoStreamMode.Write))
                    using (StreamWriter sw = new StreamWriter(cs))
                    {
                        sw.Write(texto);
                    }
                    return Convert.ToBase64String(ms.ToArray());
                }
            }
        }

        // devuelve el texto original a partir del Base64 cifrado. si el dato no estaba cifrado
        // (datos viejos) o no es un Base64 valido, lo devuelve tal cual para no romper.
        public static string Desencriptar_43BO(string textoCifrado)
        {
            if (string.IsNullOrEmpty(textoCifrado)) return textoCifrado;

            try
            {
                //ESTO puede ffalsl r si no 
                byte[] datos = Convert.FromBase64String(textoCifrado);

                using (Aes aes = Aes.Create())
                {
                    aes.Key = Clave_43BO;
                    aes.IV = IV_43BO;

                    using (ICryptoTransform dec = aes.CreateDecryptor())
                    using (MemoryStream ms = new MemoryStream(datos))
                    using (CryptoStream cs = new CryptoStream(ms, dec, CryptoStreamMode.Read))
                    using (StreamReader sr = new StreamReader(cs))
                    {
                        return sr.ReadToEnd();
                    }
                }
            }
            catch
            {
                return textoCifrado;
            }
        }
    }
}
