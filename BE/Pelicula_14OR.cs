using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Pelicula_14OR
    {
        private int _idPelicula;

        public int IdPelicula_14OR
        {
            get { return _idPelicula; }
            set { _idPelicula = value; }
        }

        private string _titulo;

        public string Titulo_14OR
        {
            get { return _titulo; }
            set { _titulo = value; }
        }

        private string _genero;

        public string Genero_14OR
        {
            get { return _genero; }
            set { _genero = value; }
        }

        private int _duracion;

        public int Duracion_14OR
        {
            get { return _duracion; }
            set { _duracion = value; }
        }

        private string _poster;

    //lo puse a iñltimto mmento espero que no rompa, es solo apra almacenar el nombre del archivo y see va  aguardar en la carpeta d epsoters
        public string Poster_14OR
        {
            get { return _poster; }
            set { _poster = value; }
        }

        public Pelicula_14OR()
        {

        }
    }
}
