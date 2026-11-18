using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;
using DAL;

namespace BLL
{
    public class BllReporte_14OR
    {
        private DALReporte_14OR dal = new DALReporte_14OR();

        // RF1 - Listado de Funciones y Ocupacion de Sala
        public List<ReporteFuncionOcupacion_14OR> ListadoFuncionesOcupacion_14OR()
        {
            return dal.ListadoFuncionesOcupacion_14OR();
        }

        // ---- Panel Inteligente (reporte inteligente) ----
        public DashboardKpis_14OR ObtenerKpis_14OR()
        {
            return dal.ObtenerKpis_14OR();
        }

        public List<ProveedorConfiabilidad_14OR> ConfiabilidadProveedores_14OR()
        {
            return dal.ConfiabilidadProveedores_14OR();
        }

        public List<StockReponer_14OR> StockParaReponer_14OR()
        {
            return dal.StockParaReponer_14OR();
        }

        public DashboardGeneral_14OR ObtenerGeneral_14OR(DateTime desde, DateTime hasta)
        {
            return dal.ObtenerGeneral_14OR(desde, hasta);
        }

        // ================== Reporte inteligente: conclusiones y recomendaciones ==================
        // Cruza las tablas de los dos procesos (funciones, butacas, ventas, clientes, candy,
        // productos, ordenes de compra y proveedores) y devuelve lo que el gerente tendria que
        // mirar, ordenado por urgencia. La regla de cada aviso esta aca; la DAL solo trae datos.

        private const double OCUPACION_ALTA = 60;    // % desde el que una pelicula "se llena"
        private const double OCUPACION_BAJA = 30;    // % por debajo del cual una pelicula rinde poco
        private const int DIAS_ALERTA_STOCK = 7;     // si el stock alcanza para menos de esto, aviso
        private const int DIAS_COBERTURA = 14;       // lo que sugiero comprar pa cubrir 2 semanas
        private const int DIAS_ORDEN_ATRASADA = 3;   // dias pagada sin llegar pa considerarla atrasada
        private const double SOCIOS_MINIMO = 30;     // % de ventas a socios que considero bajo

        public List<Recomendacion_14OR> GenerarRecomendaciones_14OR(DateTime desde, DateTime hasta)
        {
            List<Recomendacion_14OR> lista = new List<Recomendacion_14OR>();
            int dias = Math.Max(1, (hasta.Date - desde.Date).Days + 1);

            AnalizarCartelera_14OR(lista, desde, hasta);
            AnalizarCandyYStock_14OR(lista, desde, hasta, dias);
            AnalizarCompras_14OR(lista);
            AnalizarSocios_14OR(lista, desde, hasta);

            if (lista.Count == 0)
                lista.Add(Rec_14OR(3, "panelinteligente_area_general", "General",
                    "panelinteligente_rec_todobien", "Todo en orden: no encontré nada para avisarte en este período."));

            // primero lo urgente; dentro de la misma prioridad queda el orden en que se analizo
            return lista.Select((r, i) => new { r, i })
                        .OrderBy(x => x.r.Prioridad_14OR).ThenBy(x => x.i)
                        .Select(x => x.r).ToList();
        }

        // peliculas que se llenan / que rinden poco, y la franja horaria que mas vende
        private void AnalizarCartelera_14OR(List<Recomendacion_14OR> lista, DateTime desde, DateTime hasta)
        {
            const string AREA = "panelinteligente_area_cartelera", AREA_DEF = "Cartelera";
            List<OcupacionGrupo_14OR> pelis = dal.OcupacionPorPelicula_14OR(desde, hasta)
                                                 .Where(p => p.Capacidad_14OR > 0).ToList();
            if (pelis.Count == 0)
            {
                lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_sinfunciones",
                    "No hubo funciones en este período, así que no hay datos de la cartelera para analizar."));
                return;
            }

            OcupacionGrupo_14OR mejor = pelis.OrderByDescending(p => p.Porcentaje_14OR).First();
            if (mejor.Porcentaje_14OR >= OCUPACION_ALTA)
                lista.Add(Rec_14OR(2, AREA, AREA_DEF, "panelinteligente_rec_pelimejor",
                    "\"{0}\" llenó el {1} de sus butacas en {2} funciones: conviene sumarle funciones o pasarla a una sala más grande.",
                    mejor.Nombre_14OR, Pct_14OR(mejor.Porcentaje_14OR), mejor.Funciones_14OR.ToString()));
            else
                lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_pelimas",
                    "La película que más vende es \"{0}\", con el {1} de ocupación.",
                    mejor.Nombre_14OR, Pct_14OR(mejor.Porcentaje_14OR)));

            OcupacionGrupo_14OR peor = pelis.OrderBy(p => p.Porcentaje_14OR).First();
            if (pelis.Count > 1 && peor != mejor && peor.Porcentaje_14OR < OCUPACION_BAJA)
                lista.Add(Rec_14OR(2, AREA, AREA_DEF, "panelinteligente_rec_pelipeor",
                    "\"{0}\" solo ocupó el {1} de sus butacas: revisá sus horarios o bajale funciones.",
                    peor.Nombre_14OR, Pct_14OR(peor.Porcentaje_14OR)));

            List<OcupacionGrupo_14OR> franjas = dal.OcupacionPorFranja_14OR(desde, hasta)
                                                   .Where(f => f.Capacidad_14OR > 0).ToList();
            if (franjas.Count > 1)
            {
                OcupacionGrupo_14OR f = franjas.OrderByDescending(x => x.Porcentaje_14OR).First();
                lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_franja",
                    "Las funciones de {0} son las que más se llenan ({1}): ahí conviene programar los estrenos.",
                    NombreFranja_14OR(f.Nombre_14OR), Pct_14OR(f.Porcentaje_14OR)));
            }
        }

        // stock contra lo que se vende por dia: que reponer ya y que se va a agotar pronto
        private void AnalizarCandyYStock_14OR(List<Recomendacion_14OR> lista, DateTime desde, DateTime hasta, int dias)
        {
            const string AREA = "panelinteligente_area_candy", AREA_DEF = "Candy Bar y stock";
            List<ConsumoProducto_14OR> productos = dal.ConsumoProductos_14OR(desde, hasta);

            foreach (ConsumoProducto_14OR p in productos)
            {
                double porDia = (double)p.UnidadesVendidas_14OR / dias;

                if (p.Stock_14OR <= p.StockCritico_14OR)
                {
                    int sugerido = Math.Max(p.StockCritico_14OR * 2 - p.Stock_14OR,
                                            (int)Math.Ceiling(porDia * DIAS_COBERTURA) - p.Stock_14OR);
                    if (sugerido < 1) sugerido = Math.Max(1, p.StockCritico_14OR);
                    lista.Add(Rec_14OR(1, AREA, AREA_DEF, "panelinteligente_rec_stockcritico",
                        "Reponé {0}: quedan {1} unidades y el mínimo es {2}. Te sugiero pedir {3} (Compras > Cotizaciones).",
                        p.Producto_14OR, p.Stock_14OR.ToString(), p.StockCritico_14OR.ToString(), sugerido.ToString()));
                }
                else if (porDia > 0 && p.Stock_14OR / porDia < DIAS_ALERTA_STOCK)
                {
                    lista.Add(Rec_14OR(2, AREA, AREA_DEF, "panelinteligente_rec_stockseagota",
                        "{0} se termina en unos {1} días al ritmo actual ({2} por día): pedí cotización antes de llegar al mínimo.",
                        p.Producto_14OR, Math.Max(1, (int)Math.Floor(p.Stock_14OR / porDia)).ToString(), porDia.ToString("0.#")));
                }
            }

            ConsumoProducto_14OR top = productos.Where(p => p.UnidadesVendidas_14OR > 0)
                                                .OrderByDescending(p => p.UnidadesVendidas_14OR).FirstOrDefault();
            if (top != null)
                lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_masvendido",
                    "Lo más vendido del Candy Bar fue {0} ({1} unidades).",
                    top.Producto_14OR, top.UnidadesVendidas_14OR.ToString()));

            // cruce entradas vendidas vs plata del candy
            DashboardGeneral_14OR g = dal.ObtenerGeneral_14OR(desde, hasta);
            if (g.TicketsVendidos_14OR > 0)
            {
                if (g.VentasCandy_14OR <= 0)
                    lista.Add(Rec_14OR(2, AREA, AREA_DEF, "panelinteligente_rec_sincandy",
                        "Se vendieron {0} entradas pero nada en el Candy Bar: ofrecé un combo al cobrar la entrada.",
                        g.TicketsVendidos_14OR.ToString()));
                else
                    lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_candyespectador",
                        "Cada espectador gastó en promedio $ {0} en el Candy Bar.",
                        (g.VentasCandy_14OR / g.TicketsVendidos_14OR).ToString("N0")));
            }
        }

        // ordenes pagadas que no llegan y proveedores que cumplen poco
        private void AnalizarCompras_14OR(List<Recomendacion_14OR> lista)
        {
            const string AREA = "panelinteligente_area_compras", AREA_DEF = "Compras";

            foreach (OrdenPendiente_14OR o in dal.OrdenesPagadasSinRecibir_14OR())
            {
                int espera = o.FechaPago_14OR.HasValue ? (DateTime.Today - o.FechaPago_14OR.Value.Date).Days : 0;
                if (espera >= DIAS_ORDEN_ATRASADA)
                    lista.Add(Rec_14OR(1, AREA, AREA_DEF, "panelinteligente_rec_ordenatrasada",
                        "La orden N° {0} de {1} se pagó hace {2} días ($ {3}) y todavía no llegó: reclamale al proveedor.",
                        o.NumeroOrden_14OR.ToString(), o.Proveedor_14OR, espera.ToString(), o.Importe_14OR.ToString("N0")));
                else
                    lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_ordenencamino",
                        "La orden N° {0} de {1} ya está pagada y en camino.",
                        o.NumeroOrden_14OR.ToString(), o.Proveedor_14OR));
            }

            foreach (ProveedorConfiabilidad_14OR p in dal.ConfiabilidadProveedores_14OR())
            {
                if (p.TotalOrdenes_14OR >= 2 && p.Porcentaje_14OR < 50)
                    lista.Add(Rec_14OR(2, AREA, AREA_DEF, "panelinteligente_rec_proveedor",
                        "{0} cumplió solo {1} de {2} órdenes: pedile cotización también a otro proveedor.",
                        p.Proveedor_14OR, p.OrdenesCerradas_14OR.ToString(), p.TotalOrdenes_14OR.ToString()));
            }
        }

        // cuanto pesan los socios en las ventas de entradas (solo totales, sin datos personales)
        private void AnalizarSocios_14OR(List<Recomendacion_14OR> lista, DateTime desde, DateTime hasta)
        {
            const string AREA = "panelinteligente_area_clientes", AREA_DEF = "Clientes";
            VentasSocios_14OR v = dal.ObtenerVentasSocios_14OR(desde, hasta);
            if (v.TotalVentas_14OR == 0) return;

            double pct = (double)v.VentasSocio_14OR * 100.0 / v.TotalVentas_14OR;
            if (pct < SOCIOS_MINIMO)
                lista.Add(Rec_14OR(2, AREA, AREA_DEF, "panelinteligente_rec_pocossocios",
                    "Solo el {0} de las ventas fue a socios: ofrecé la suscripción al cobrar.",
                    Pct_14OR(pct)));
            else
                lista.Add(Rec_14OR(3, AREA, AREA_DEF, "panelinteligente_rec_socios",
                    "Los socios hicieron el {0} de las ventas ($ {1}).",
                    Pct_14OR(pct), v.MontoSocio_14OR.ToString("N0")));
        }

        private Recomendacion_14OR Rec_14OR(int prioridad, string area, string areaDef, string clave, string texto, params string[] datos)
        {
            return new Recomendacion_14OR
            {
                Prioridad_14OR = prioridad,
                ClaveArea_14OR = area,
                AreaPorDefecto_14OR = areaDef,
                Clave_14OR = clave,
                TextoPorDefecto_14OR = texto,
                Datos_14OR = datos
            };
        }

        private string Pct_14OR(double v)
        {
            return v.ToString("0") + " %";
        }

        // la franja viaja como "@clave|texto por defecto" pa que la GUI la traduzca
        private string NombreFranja_14OR(string codigo)
        {
            if (codigo == "M") return "@panelinteligente_franja_m|la matiné (antes de las 16 h)";
            if (codigo == "T") return "@panelinteligente_franja_t|la tarde (de 16 a 20 h)";
            return "@panelinteligente_franja_n|la noche (desde las 20 h)";
        }
    }
}
