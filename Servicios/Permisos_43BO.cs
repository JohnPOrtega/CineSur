using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicios
{
    
    public enum Permisos_43BO
    {
        GestionUsuarios_Acceso = 1,
        GestionUsuarios_Alta = 2,
        GestionUsuarios_Desbloquear = 3,
        GestionUsuarios_Modificar = 4,
        GestionUsuarios_ActivarDesactivar = 5,
        GestionUsuarios_Listar = 6,
        GestionUsuarios_Aplicar = 18,

        Auditoria_Acceso = 7,
        Auditoria_Consultar = 8,
        Auditoria_Imprimir = 9,


      
         Menu_SeccionAdmin = 10,
        Menu_SeccionMaster = 11,
        Menu_SeccionVenta = 12,
        Menu_SeccionCompra = 13,
        Menu_SeccionReporte = 14,

    
        GestionPerfiles_Acceso = 15,
        GestionPerfiles_AsignarRelaciones = 16, // Botones <<-- y -->>
        GestionPerfiles_ConfigurarEstructura = 17,
        Usuario_CambioContraseña = 19,
        Usuario_CambioIdioma = 20,

        Admin_Backup = 21,
        Admin_RecalcularDV = 22,
        Admin_Restore = 23,

        // --- Maestros del cine (acceso a cada ABM) ---
        Master_Peliculas_Acceso = 24,
        Master_Salas_Acceso = 25,
        Master_Funciones_Acceso = 26,
        Master_Promociones_Acceso = 27,
        Master_Clientes_Acceso = 28,

        // --- Venta / Control de acceso ---
        Venta_ReservarButacas_Acceso = 29,
        Venta_ControlAcceso_Acceso = 30,

        // --- Reportes ---
        Reporte_FuncionesOcupacion_Acceso = 31,

        // --- Compra / Candy Bar (PN2) ---
        Compra_Productos_Acceso = 32,
        Compra_Proveedores_Acceso = 33,

        // --- Venta del Candy Bar (PN2) ---
        Venta_CandyBar_Acceso = 34,

        // --- Compra: presupuestos y ordenes de compra (PN2) ---
        Compra_Presupuestos_Acceso = 35,
        Compra_OrdenesCompra_Acceso = 36,

        // --- Bitacora de cambios (auditoria del historico de peliculas) ---
        Maestro_AuditoriaCambios_Acceso = 37
    }
}
