using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    // DTOs del Panel Inteligente (reporte inteligente). Son solo de lectura, los arma la DAL
    // cruzando ventas (RF1) con compras (RF2). No se guardan en ninguna tabla.

    // numeros grandes de las tarjetas KPI de arriba
    public class DashboardKpis_14OR
    {
        public int EspectadoresIngresados_14OR { get; set; }   // asientos en 'Utilizada'
        public double VentasCandy_14OR { get; set; }           // plata vendida en el candy
        public double TasaConsumo_14OR { get; set; }           // candy / espectador
        public double TotalComprado_14OR { get; set; }         // plata en ordenes de compra
        public int ProductosCriticos_14OR { get; set; }        // productos bajo el stock critico
    }

    // una fila por proveedor: cuantas ordenes tiene y cuantas cerro (cumplio)
    public class ProveedorConfiabilidad_14OR
    {
        public string Proveedor_14OR { get; set; }
        public int TotalOrdenes_14OR { get; set; }
        public int OrdenesCerradas_14OR { get; set; }
        public double Porcentaje_14OR { get; set; }            // cerradas / total * 100
    }

    // numeros de la solapa General del Panel de Control, calculados para un rango de fechas
    public class DashboardGeneral_14OR
    {
        public int FuncionesPeriodo_14OR { get; set; }       // funciones con fecha en el rango
        public int TicketsVendidos_14OR { get; set; }         // butacas vendidas de esas funciones
        public double RecaudacionEntradas_14OR { get; set; }  // plata de las ventas de entradas del rango
        public double VentasCandy_14OR { get; set; }          // plata del candy en el rango
        public double TicketPromedio_14OR { get; set; }       // recaudacion / cantidad de ventas
        public double TasaOcupacion_14OR { get; set; }        // vendidas / capacidad de las funciones (%)
    }

    // producto que conviene reponer + cuanto sugiere comprar el sistema
    public class StockReponer_14OR
    {
        public string Producto_14OR { get; set; }
        public int Stock_14OR { get; set; }
        public int StockCritico_14OR { get; set; }
        public int SugeridoComprar_14OR { get; set; }          // lo que falta pa llegar a 2x el critico
    }

    // ===== parte "inteligente": datos crudos que cruza la BLL pa sacar conclusiones =====

    // ocupacion agrupada (por pelicula o por franja horaria): funciones, butacas y vendidas
    public class OcupacionGrupo_14OR
    {
        public string Nombre_14OR { get; set; }
        public int Funciones_14OR { get; set; }
        public int Capacidad_14OR { get; set; }
        public int Vendidas_14OR { get; set; }
        public double Porcentaje_14OR
        {
            get { return Capacidad_14OR > 0 ? (double)Vendidas_14OR * 100.0 / Capacidad_14OR : 0; }
        }
    }

    // un producto del candy con su stock y cuanto se vendio en el periodo
    public class ConsumoProducto_14OR
    {
        public string Producto_14OR { get; set; }
        public int Stock_14OR { get; set; }
        public int StockCritico_14OR { get; set; }
        public int UnidadesVendidas_14OR { get; set; }
    }

    // orden de compra pagada que el proveedor todavia no entrego
    public class OrdenPendiente_14OR
    {
        public int NumeroOrden_14OR { get; set; }
        public string Proveedor_14OR { get; set; }
        public double Importe_14OR { get; set; }
        public DateTime? FechaPago_14OR { get; set; }
    }

    // ventas de entradas del periodo separadas en socios / no socios
    public class VentasSocios_14OR
    {
        public int TotalVentas_14OR { get; set; }
        public int VentasSocio_14OR { get; set; }
        public double Monto_14OR { get; set; }
        public double MontoSocio_14OR { get; set; }
    }

    // una conclusion del reporte inteligente. El texto no viene armado: viene la clave del json
    // + el texto por defecto + los datos, asi la GUI lo traduce al idioma elegido.
    // Prioridad: 1 = urgente (rojo), 2 = conviene mirarlo (amarillo), 3 = dato util (azul)
    public class Recomendacion_14OR
    {
        public int Prioridad_14OR { get; set; }
        public string ClaveArea_14OR { get; set; }
        public string AreaPorDefecto_14OR { get; set; }
        public string Clave_14OR { get; set; }
        public string TextoPorDefecto_14OR { get; set; }
        public string[] Datos_14OR { get; set; }
    }
}
