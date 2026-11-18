using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BE;

namespace DAL
{
    public class DALReporte_14OR
    {
        private AccesoBD_43BO acceso = new AccesoBD_43BO();

        // RF1 - Listado de Funciones y Ocupacion de Sala.
        // Por cada funcion trae: pelicula, sala, fecha/hora, tickets vendidos, butacas disponibles
        // y recaudacion parcial (suma real de las ventas de esa funcion).
        //  - Vendidos     = asientos en 'Ocupada' o 'Utilizada' (Utilizada es el que ya ingreso).
        //  - Disponibles  = capacidad de la sala menos los vendidos (asi es correcto aunque la
        //                   funcion todavia no haya "materializado" sus asientos).
        //  - Recaudacion  = suma de MontoTotal de las ventas ligadas a esa funcion.
        public List<ReporteFuncionOcupacion_14OR> ListadoFuncionesOcupacion_14OR()
        {
            string query = @"
                SELECT
                    F.IdFuncion_14OR,
                    P.Titulo_14OR,
                    S.Numero_14OR,
                    F.Fecha_14OR,
                    F.Horario_14OR,
                    S.Capacidad_14OR,
                    (SELECT COUNT(*) FROM AsientoFuncion_14OR af
                       WHERE af.IdFuncion_14OR = F.IdFuncion_14OR
                         AND af.Estado_14OR IN ('Ocupada','Utilizada')) AS Vendidos,
                    ISNULL((SELECT SUM(v.MontoTotal_14OR)
                            FROM Venta_14OR v
                            WHERE v.IdVenta_14OR IN (
                                SELECT DISTINCT af2.IdVenta_14OR
                                FROM AsientoFuncion_14OR af2
                                WHERE af2.IdFuncion_14OR = F.IdFuncion_14OR
                                  AND af2.IdVenta_14OR IS NOT NULL)), 0) AS Recaudacion
                FROM Funcion_14OR F
                INNER JOIN Pelicula_14OR P ON F.IdPelicula_14OR = P.IdPelicula_14OR
                INNER JOIN Sala_14OR S ON F.IdSala_14OR = S.IdSala_14OR
                ORDER BY F.Fecha_14OR, F.Horario_14OR";

            DataTable tabla = acceso.Leer_43BO(query);
            List<ReporteFuncionOcupacion_14OR> lista = new List<ReporteFuncionOcupacion_14OR>();

            foreach (DataRow fila in tabla.Rows)
            {
                int capacidad = Convert.ToInt32(fila["Capacidad_14OR"]);
                int vendidos = Convert.ToInt32(fila["Vendidos"]);

                ReporteFuncionOcupacion_14OR r = new ReporteFuncionOcupacion_14OR();
                r.IdFuncion_14OR = Convert.ToInt32(fila["IdFuncion_14OR"]);
                r.Pelicula_14OR = fila["Titulo_14OR"].ToString();
                r.Sala_14OR = Convert.ToInt32(fila["Numero_14OR"]);
                r.Fecha_14OR = Convert.ToDateTime(fila["Fecha_14OR"]);
                r.Horario_14OR = Convert.ToDateTime(fila["Horario_14OR"]);
                r.TicketsVendidos_14OR = vendidos;
                r.ButacasDisponibles_14OR = capacidad - vendidos;
                r.RecaudacionParcial_14OR = Convert.ToDouble(fila["Recaudacion"]);
                lista.Add(r);
            }

            return lista;
        }

        // ===================== Panel Inteligente (reporte inteligente) =====================

        // KPIs de arriba: espectadores que ingresaron, plata del candy, plata en ordenes
        // y cuantos productos estan en critico. La tasa de consumo la calculo aca mismo.
        public DashboardKpis_14OR ObtenerKpis_14OR()
        {
            DashboardKpis_14OR k = new DashboardKpis_14OR();

            DataTable t = acceso.Leer_43BO(@"
                SELECT
                  (SELECT COUNT(*) FROM AsientoFuncion_14OR WHERE Estado_14OR = 'Utilizada') AS Ingresados,
                  (SELECT ISNULL(SUM(MontoTotal_14OR),0) FROM VentaCandy_14OR) AS Candy,
                  (SELECT ISNULL(SUM(Importe_14OR),0) FROM OrdenCompra_14OR) AS Comprado,
                  (SELECT COUNT(*) FROM Producto_14OR WHERE Activo_14OR = 1 AND Stock_14OR <= StockCritico_14OR) AS Criticos");

            if (t.Rows.Count > 0)
            {
                DataRow f = t.Rows[0];
                k.EspectadoresIngresados_14OR = Convert.ToInt32(f["Ingresados"]);
                k.VentasCandy_14OR = Convert.ToDouble(f["Candy"]);
                k.TotalComprado_14OR = Convert.ToDouble(f["Comprado"]);
                k.ProductosCriticos_14OR = Convert.ToInt32(f["Criticos"]);
                k.TasaConsumo_14OR = k.EspectadoresIngresados_14OR > 0
                    ? k.VentasCandy_14OR / k.EspectadoresIngresados_14OR : 0;
            }
            return k;
        }

        // confiabilidad por proveedor: total de ordenes y cuantas llegaron a 'Cerrada'
        public List<ProveedorConfiabilidad_14OR> ConfiabilidadProveedores_14OR()
        {
            List<ProveedorConfiabilidad_14OR> lista = new List<ProveedorConfiabilidad_14OR>();

            DataTable t = acceso.Leer_43BO(@"
                SELECT pv.Nombre_14OR AS Proveedor,
                       COUNT(*) AS Total,
                       SUM(CASE WHEN oc.Estado_14OR = 'Cerrada' THEN 1 ELSE 0 END) AS Cerradas
                FROM OrdenCompra_14OR oc
                INNER JOIN Proveedor_14OR pv ON pv.IdProveedor_14OR = oc.IdProveedor_14OR
                GROUP BY pv.Nombre_14OR
                ORDER BY pv.Nombre_14OR");

            foreach (DataRow f in t.Rows)
            {
                ProveedorConfiabilidad_14OR p = new ProveedorConfiabilidad_14OR();
                p.Proveedor_14OR = f["Proveedor"].ToString();
                p.TotalOrdenes_14OR = Convert.ToInt32(f["Total"]);
                p.OrdenesCerradas_14OR = Convert.ToInt32(f["Cerradas"]);
                p.Porcentaje_14OR = p.TotalOrdenes_14OR > 0
                    ? (double)p.OrdenesCerradas_14OR * 100.0 / p.TotalOrdenes_14OR : 0;
                lista.Add(p);
            }
            return lista;
        }

        // productos en o por debajo del critico, con la cantidad sugerida pa reponer (apunta a 2x el critico)
        public List<StockReponer_14OR> StockParaReponer_14OR()
        {
            List<StockReponer_14OR> lista = new List<StockReponer_14OR>();

            DataTable t = acceso.Leer_43BO(@"
                SELECT Nombre_14OR, Stock_14OR, StockCritico_14OR
                FROM Producto_14OR
                WHERE Activo_14OR = 1 AND Stock_14OR <= StockCritico_14OR
                ORDER BY Stock_14OR");

            foreach (DataRow f in t.Rows)
            {
                StockReponer_14OR s = new StockReponer_14OR();
                s.Producto_14OR = f["Nombre_14OR"].ToString();
                s.Stock_14OR = Convert.ToInt32(f["Stock_14OR"]);
                s.StockCritico_14OR = Convert.ToInt32(f["StockCritico_14OR"]);
                int objetivo = s.StockCritico_14OR * 2;
                s.SugeridoComprar_14OR = objetivo - s.Stock_14OR > 0 ? objetivo - s.Stock_14OR : s.StockCritico_14OR;
                lista.Add(s);
            }
            return lista;
        }

        // ===== solapa General del Panel de Control (numeros de un rango de fechas) =====
        public DashboardGeneral_14OR ObtenerGeneral_14OR(DateTime desde, DateTime hasta)
        {
            DashboardGeneral_14OR g = new DashboardGeneral_14OR();

            // ventas de entradas del periodo: cuantas y cuanta plata (por fecha de la venta)
            SqlParameter[] p1 = { new SqlParameter("@d", desde.Date), new SqlParameter("@h", hasta.Date) };
            DataTable tv = acceso.Leer_43BO(
                @"SELECT COUNT(*) AS NVentas, ISNULL(SUM(MontoTotal_14OR),0) AS Recaudacion
                  FROM Venta_14OR
                  WHERE CAST(Fecha_14OR AS date) BETWEEN @d AND @h", p1);
            int nVentas = 0;
            if (tv.Rows.Count > 0)
            {
                nVentas = Convert.ToInt32(tv.Rows[0]["NVentas"]);
                g.RecaudacionEntradas_14OR = Convert.ToDouble(tv.Rows[0]["Recaudacion"]);
            }

            // funciones del periodo + butacas vendidas + capacidad total (pa la tasa de ocupacion)
            SqlParameter[] p2 = { new SqlParameter("@d", desde.Date), new SqlParameter("@h", hasta.Date) };
            DataTable tf = acceso.Leer_43BO(
                @"SELECT
                    (SELECT COUNT(*) FROM Funcion_14OR WHERE CAST(Fecha_14OR AS date) BETWEEN @d AND @h) AS Funciones,
                    (SELECT ISNULL(SUM(S.Capacidad_14OR),0) FROM Funcion_14OR F
                       INNER JOIN Sala_14OR S ON S.IdSala_14OR = F.IdSala_14OR
                       WHERE CAST(F.Fecha_14OR AS date) BETWEEN @d AND @h) AS Capacidad,
                    (SELECT COUNT(*) FROM AsientoFuncion_14OR af
                       INNER JOIN Funcion_14OR F ON F.IdFuncion_14OR = af.IdFuncion_14OR
                       WHERE CAST(F.Fecha_14OR AS date) BETWEEN @d AND @h
                         AND af.Estado_14OR IN ('Ocupada','Utilizada')) AS Vendidas", p2);
            int capacidad = 0;
            if (tf.Rows.Count > 0)
            {
                g.FuncionesPeriodo_14OR = Convert.ToInt32(tf.Rows[0]["Funciones"]);
                capacidad = Convert.ToInt32(tf.Rows[0]["Capacidad"]);
                g.TicketsVendidos_14OR = Convert.ToInt32(tf.Rows[0]["Vendidas"]);
            }

            // candy del periodo
            SqlParameter[] p3 = { new SqlParameter("@d", desde.Date), new SqlParameter("@h", hasta.Date) };
            DataTable tc = acceso.Leer_43BO(
                @"SELECT ISNULL(SUM(MontoTotal_14OR),0) AS Candy
                  FROM VentaCandy_14OR
                  WHERE CAST(Fecha_14OR AS date) BETWEEN @d AND @h", p3);
            if (tc.Rows.Count > 0) g.VentasCandy_14OR = Convert.ToDouble(tc.Rows[0]["Candy"]);

            g.TicketPromedio_14OR = nVentas > 0 ? g.RecaudacionEntradas_14OR / nVentas : 0;
            g.TasaOcupacion_14OR = capacidad > 0 ? (double)g.TicketsVendidos_14OR * 100.0 / capacidad : 0;

            return g;
        }

        // ===================== Reporte inteligente: datos que cruza la BLL =====================

        private SqlParameter[] Rango_14OR(DateTime desde, DateTime hasta)
        {
            return new SqlParameter[] { new SqlParameter("@d", desde.Date), new SqlParameter("@h", hasta.Date) };
        }

        // por cada pelicula con funciones en el rango: cuantas funciones, butacas y vendidas
        // (Funcion + Pelicula + Sala + AsientoFuncion)
        public List<OcupacionGrupo_14OR> OcupacionPorPelicula_14OR(DateTime desde, DateTime hasta)
        {
            return LeerOcupacion_14OR(@"
                SELECT X.Grupo, COUNT(*) AS Funciones, SUM(X.Capacidad) AS Capacidad, SUM(X.Vendidas) AS Vendidas
                FROM (
                    SELECT P.Titulo_14OR AS Grupo, S.Capacidad_14OR AS Capacidad,
                           (SELECT COUNT(*) FROM AsientoFuncion_14OR af
                              WHERE af.IdFuncion_14OR = F.IdFuncion_14OR
                                AND af.Estado_14OR IN ('Ocupada','Utilizada')) AS Vendidas
                    FROM Funcion_14OR F
                    INNER JOIN Pelicula_14OR P ON P.IdPelicula_14OR = F.IdPelicula_14OR
                    INNER JOIN Sala_14OR S ON S.IdSala_14OR = F.IdSala_14OR
                    WHERE CAST(F.Fecha_14OR AS date) BETWEEN @d AND @h
                ) X
                GROUP BY X.Grupo", desde, hasta);
        }

        // lo mismo pero agrupado por franja horaria de la funcion: M = antes de las 16,
        // T = de 16 a 20, N = desde las 20 (la BLL/GUI le pone el nombre lindo)
        public List<OcupacionGrupo_14OR> OcupacionPorFranja_14OR(DateTime desde, DateTime hasta)
        {
            return LeerOcupacion_14OR(@"
                SELECT X.Grupo, COUNT(*) AS Funciones, SUM(X.Capacidad) AS Capacidad, SUM(X.Vendidas) AS Vendidas
                FROM (
                    SELECT CASE WHEN DATEPART(HOUR, F.Horario_14OR) < 16 THEN 'M'
                                WHEN DATEPART(HOUR, F.Horario_14OR) < 20 THEN 'T'
                                ELSE 'N' END AS Grupo,
                           S.Capacidad_14OR AS Capacidad,
                           (SELECT COUNT(*) FROM AsientoFuncion_14OR af
                              WHERE af.IdFuncion_14OR = F.IdFuncion_14OR
                                AND af.Estado_14OR IN ('Ocupada','Utilizada')) AS Vendidas
                    FROM Funcion_14OR F
                    INNER JOIN Sala_14OR S ON S.IdSala_14OR = F.IdSala_14OR
                    WHERE CAST(F.Fecha_14OR AS date) BETWEEN @d AND @h
                ) X
                GROUP BY X.Grupo", desde, hasta);
        }

        private List<OcupacionGrupo_14OR> LeerOcupacion_14OR(string query, DateTime desde, DateTime hasta)
        {
            List<OcupacionGrupo_14OR> lista = new List<OcupacionGrupo_14OR>();
            DataTable t = acceso.Leer_43BO(query, Rango_14OR(desde, hasta));
            foreach (DataRow f in t.Rows)
            {
                OcupacionGrupo_14OR o = new OcupacionGrupo_14OR();
                o.Nombre_14OR = f["Grupo"].ToString();
                o.Funciones_14OR = Convert.ToInt32(f["Funciones"]);
                o.Capacidad_14OR = Convert.ToInt32(f["Capacidad"]);
                o.Vendidas_14OR = Convert.ToInt32(f["Vendidas"]);
                lista.Add(o);
            }
            return lista;
        }

        // cada producto activo con su stock y las unidades vendidas en el candy dentro del rango
        // (Producto + DetalleVentaCandy + VentaCandy)
        public List<ConsumoProducto_14OR> ConsumoProductos_14OR(DateTime desde, DateTime hasta)
        {
            List<ConsumoProducto_14OR> lista = new List<ConsumoProducto_14OR>();
            DataTable t = acceso.Leer_43BO(@"
                SELECT pr.Nombre_14OR, pr.Stock_14OR, pr.StockCritico_14OR,
                       ISNULL(SUM(CASE WHEN CAST(vc.Fecha_14OR AS date) BETWEEN @d AND @h
                                       THEN dv.Cantidad_14OR ELSE 0 END), 0) AS Vendidas
                FROM Producto_14OR pr
                LEFT JOIN DetalleVentaCandy_14OR dv ON dv.IdProducto_14OR = pr.IdProducto_14OR
                LEFT JOIN VentaCandy_14OR vc ON vc.IdVentaCandy_14OR = dv.IdVentaCandy_14OR
                WHERE pr.Activo_14OR = 1
                GROUP BY pr.IdProducto_14OR, pr.Nombre_14OR, pr.Stock_14OR, pr.StockCritico_14OR", Rango_14OR(desde, hasta));
            foreach (DataRow f in t.Rows)
            {
                ConsumoProducto_14OR c = new ConsumoProducto_14OR();
                c.Producto_14OR = f["Nombre_14OR"].ToString();
                c.Stock_14OR = Convert.ToInt32(f["Stock_14OR"]);
                c.StockCritico_14OR = Convert.ToInt32(f["StockCritico_14OR"]);
                c.UnidadesVendidas_14OR = Convert.ToInt32(f["Vendidas"]);
                lista.Add(c);
            }
            return lista;
        }

        // ordenes ya pagadas que el proveedor no entrego (OrdenCompra + Proveedor)
        public List<OrdenPendiente_14OR> OrdenesPagadasSinRecibir_14OR()
        {
            List<OrdenPendiente_14OR> lista = new List<OrdenPendiente_14OR>();
            DataTable t = acceso.Leer_43BO(@"
                SELECT oc.NumeroOrden_14OR, pv.Nombre_14OR AS Proveedor, oc.Importe_14OR, oc.FechaPago_14OR
                FROM OrdenCompra_14OR oc
                INNER JOIN Proveedor_14OR pv ON pv.IdProveedor_14OR = oc.IdProveedor_14OR
                WHERE oc.Estado_14OR = 'Pagada'
                ORDER BY oc.FechaPago_14OR");
            foreach (DataRow f in t.Rows)
            {
                OrdenPendiente_14OR o = new OrdenPendiente_14OR();
                o.NumeroOrden_14OR = Convert.ToInt32(f["NumeroOrden_14OR"]);
                o.Proveedor_14OR = f["Proveedor"].ToString();
                o.Importe_14OR = f["Importe_14OR"] == DBNull.Value ? 0 : Convert.ToDouble(f["Importe_14OR"]);
                o.FechaPago_14OR = f["FechaPago_14OR"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(f["FechaPago_14OR"]);
                lista.Add(o);
            }
            return lista;
        }

        // ventas de entradas del rango, cuantas fueron a socios (Venta + Cliente). Solo totales:
        // no traigo ningun dato personal del cliente.
        public VentasSocios_14OR ObtenerVentasSocios_14OR(DateTime desde, DateTime hasta)
        {
            VentasSocios_14OR v = new VentasSocios_14OR();
            DataTable t = acceso.Leer_43BO(@"
                SELECT COUNT(*) AS Total,
                       ISNULL(SUM(CASE WHEN c.Suscriptor_14OR = 1 THEN 1 ELSE 0 END), 0) AS Socio,
                       ISNULL(SUM(v.MontoTotal_14OR), 0) AS Monto,
                       ISNULL(SUM(CASE WHEN c.Suscriptor_14OR = 1 THEN v.MontoTotal_14OR ELSE 0 END), 0) AS MontoSocio
                FROM Venta_14OR v
                LEFT JOIN Cliente_14OR c ON c.IdCliente_14OR = v.IdCliente_14OR
                WHERE CAST(v.Fecha_14OR AS date) BETWEEN @d AND @h", Rango_14OR(desde, hasta));
            if (t.Rows.Count > 0)
            {
                DataRow f = t.Rows[0];
                v.TotalVentas_14OR = Convert.ToInt32(f["Total"]);
                v.VentasSocio_14OR = Convert.ToInt32(f["Socio"]);
                v.Monto_14OR = Convert.ToDouble(f["Monto"]);
                v.MontoSocio_14OR = Convert.ToDouble(f["MontoSocio"]);
            }
            return v;
        }
    }
}
