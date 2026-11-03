/*
 * ============================================================================
 *  Enterprise Architect - JScript
 *  Genera el Diagrama de Secuencia (DSS) del CUN-007
 *  "Generar solicitud de cotizacion"  (PN2 - CineSur)
 *
 *  ANTES DE EJECUTAR: cerra todos los diagramas abiertos en EA.
 *  Se puede volver a ejecutar: si ya existe el diagrama con el mismo nombre
 *  en el paquete seleccionado, lo borra y lo rehace (idempotente).
 *
 *  COMO USARLO:
 *   1. En el Browser, selecciona el PAQUETE donde queres el diagrama
 *      (por ejemplo "CUN-007 > DSS").
 *   2. Specialize > Scripting. Click derecho en un Script Group >
 *      New JScript Script. Pega TODO este archivo.
 *   3. Click derecho sobre el script > Run Script.
 *
 *  Patron (igual que tus DSS de CineSur_v2):
 *   Actor -> GUI(boundary) -> clases BLL -> DAL, metodos reales del codigo.
 *   Lecturas: la BLL llama a la DAL y la DAL hace Leer_43BO (autollamada).
 *   Escrituras: la DAL hace Escribir_43BO (autollamada).
 *   Retornos: SIEMPRE tipados y punteados -> :List<X>, :bool o :Message.
 *   Los ultimos pasos de cada escritura son Bitacora (GuardarLog_43BO) y
 *   DV (RecalcularTrasPersistir_43BO), SIN retorno.
 * ============================================================================
 */

!INC Local Scripts.EAConstants-JScript

// ===================== CONFIG =====================
var DIAG_NOMBRE = "DSS CUN-007 Generar solicitud de cotizacion";

// orden de las lineas de vida (izquierda a derecha)
// tipo: "actor" | "boundary" | "clase" | "dal"
var LIFELINES = [
    { key: "Sup",   nombre: "Supervisor",            tipo: "actor" },
    { key: "F",     nombre: "Presupuestos",          tipo: "boundary" },
    { key: "BProd", nombre: "BllProducto_14OR",      tipo: "clase" },
    { key: "BProv", nombre: "BllProveedor_14OR",     tipo: "clase" },
    { key: "BPre",  nombre: "BllPresupuesto_14OR",   tipo: "clase" },
    { key: "BBit",  nombre: "BllBitacora_43BO",      tipo: "clase" },
    { key: "BDV",   nombre: "BllDV_43BO",            tipo: "clase" },
    { key: "DAL",   nombre: "DAL",                   tipo: "dal" }
];

// mensajes de arriba hacia abajo.
//   from, to  : key de LIFELINES
//   label     : texto del mensaje (metodo). En retornos dejar "".
//   ret        : "" (llamada solida) | tipo (retorno punteado): "List<X>","bool","Message"
//   self       : true si es autollamada (DAL->DAL Leer/Escribir)
//   gap        : espacio extra ANTES de este mensaje (para separar bloques)
var MSGS = [
    { from:"Sup",  to:"F",    label:"SolicitarCotizacion()" },
    { from:"F",    to:"BProd",label:"ListarEnCritico_14OR()" },
    { from:"BProd",to:"DAL",  label:"ListarEnCritico_14OR()" },
    { from:"DAL",  to:"DAL",  label:"Leer_43BO(query, parametros)", self:true },
    { from:"DAL",  to:"BProd",ret:"List<Producto_14OR>" },
    { from:"BProd",to:"F",    ret:"List<Producto_14OR>" },

    { from:"F",    to:"BProv",label:"Listar_14OR()", gap:12 },
    { from:"BProv",to:"DAL",  label:"Listar_14OR()" },
    { from:"DAL",  to:"DAL",  label:"Leer_43BO(query, parametros)", self:true },
    { from:"DAL",  to:"BProv",ret:"List<Proveedor_14OR>" },
    { from:"BProv",to:"F",    ret:"List<Proveedor_14OR>" },
    { from:"F",    to:"Sup",  ret:"Presupuestos" },

    // --- loop: por cada producto a reponer ---
    { from:"Sup",  to:"F",    label:"AgregarRenglon(producto, cantidad)", gap:30 },
    { from:"F",    to:"F",    label:"new DetallePresupuesto_14OR()", self:true },

    { from:"Sup",  to:"F",    label:"PedirPresupuesto()", gap:30 },

    // --- alt: cantidad valida ( > 0 ) ---
    { from:"F",    to:"BPre", label:"PedirPresupuesto_14OR(idProveedor, renglones)", gap:30 },
    { from:"BPre", to:"DAL",  label:"PedirPresupuesto_14OR(presupuesto)" },
    { from:"DAL",  to:"DAL",  label:"Escribir_43BO(query, parametros)", self:true },
    { from:"DAL",  to:"BPre", ret:"bool" },
    // ultimos pasos: Bitacora y DV (sin retorno)
    { from:"BPre", to:"BBit", label:"GuardarLog_43BO(modulo, evento, criticidad)", gap:10 },
    { from:"BBit", to:"DAL",  label:"GuardarLog_43BO(bitacora)" },
    { from:"DAL",  to:"DAL",  label:"Escribir_43BO(query, parametros)", self:true },
    { from:"BPre", to:"BDV",  label:"RecalcularTrasPersistir_43BO()", gap:10 },
    { from:"BDV",  to:"DAL",  label:"RecalcularTrasPersistir(tabla, dvv, dvh)" },
    { from:"DAL",  to:"DAL",  label:"Escribir_43BO(query, parametros)", self:true },
    { from:"BPre", to:"F",    ret:"bool", gap:10 },
    { from:"F",    to:"Sup",  ret:"Message" },
    // --- else: cantidad invalida (esc. alt. 4.1) ---
    { from:"F",    to:"Sup",  ret:"Message", gap:24 }
];

// fragmentos combinados (cajas alt/loop).
//   op     : "loop" | "alt" | "opt"
//   guard  : condicion (se muestra como  op [guard])
//   desde  : indice del PRIMER mensaje adentro (0-based sobre MSGS)
//   hasta  : indice del ULTIMO mensaje adentro
//   divisor: (solo alt)  indice del mensaje donde empieza el "else" (opcional)
//   elseGuard: texto del else (opcional)
var FRAGS = [
    { op:"loop", guard:"por cada producto a reponer", desde:12, hasta:13 },
    { op:"alt",  guard:"cantidad valida ( > 0 )",     desde:15, hasta:27,
      divisor:27, elseGuard:"cantidad invalida (esc. alt. 4.1)" }
];

// ===================== GEOMETRIA =====================
var X0        = 30;    // x del primer lifeline
var X_STEP    = 130;   // separacion horizontal entre lifelines
var LL_W      = 100;   // ancho de la cabecera del lifeline
var TOP       = -50;   // RectTop de los lifelines
var BOT       = -1100; // RectBottom de los lifelines (se ajusta al final)
var Y_FIRST   = -110;  // Y del primer mensaje
var Y_STEP    = 26;    // paso vertical entre mensajes
var SELF_H    = 16;    // alto extra de una autollamada
var FRAG_PADX = 16;    // margen lateral de la caja de fragmento
var FRAG_TOPH = 26;    // alto de la etiqueta del fragmento arriba del 1er msg

// ===================== HELPERS =====================
function log(s) { Session.Output("[DSS CUN-007] " + s); }

function sqlEsc(s) {
    // Jet SQL: escapar comillas simples duplicandolas
    var out = ""; var i;
    for (i = 0; i < s.length; i++) {
        var ch = s.charAt(i);
        if (ch == "'") out += "''"; else out += ch;
    }
    return out;
}

function exec(sql) { Repository.Execute(sql); }

// ===================== MAIN =====================
function main()
{
    var pkg as EA.Package;
    pkg = Repository.GetTreeSelectedPackage();
    if (pkg == null) {
        Session.Prompt("Primero selecciona en el arbol el paquete donde crear el diagrama.", promptOK);
        return;
    }

    try {
        // ---- idempotencia: borrar el diagrama si ya existe ----
        var k;
        for (k = 0; k < pkg.Diagrams.Count; k++) {
            var dx as EA.Diagram;
            dx = pkg.Diagrams.GetAt(k);
            if (dx.Name == DIAG_NOMBRE) {
                pkg.Diagrams.DeleteAt(k, false);
                pkg.Diagrams.Refresh();
                log("Diagrama previo borrado (re-ejecucion).");
                break;
            }
        }

        // ---- 1) crear el diagrama ----
        var dia as EA.Diagram;
        dia = pkg.Diagrams.AddNew(DIAG_NOMBRE, "Sequence");
        dia.Update();
        pkg.Diagrams.Refresh();
        var DID = dia.DiagramID;
        log("Diagrama creado, ID=" + DID);

        // ---- 2) crear lifelines (elementos) ----
        var elem = {};   // key -> ElementID
        var i;
        for (i = 0; i < LIFELINES.length; i++) {
            var L = LIFELINES[i];
            var eType = "Sequence";
            if (L.tipo == "actor") eType = "Actor";
            var e as EA.Element;
            e = pkg.Elements.AddNew(L.nombre, eType);
            if (L.tipo == "boundary") e.Stereotype = "boundary";
            e.Update();
            pkg.Elements.Refresh();
            elem[L.key] = e.ElementID;

            // ubicar la linea de vida en el diagrama
            var xL = X0 + i * X_STEP;
            var xR = xL + LL_W;
            var dob as EA.DiagramObject;
            dob = dia.DiagramObjects.AddNew("l=" + xL + ";r=" + xR + ";t=" + TOP + ";b=" + BOT + ";", "");
            dob.ElementID = e.ElementID;
            dob.Update();
        }
        dia.DiagramObjects.Refresh();
        log("Lifelines creados: " + LIFELINES.length);

        // centro x de cada lifeline (para calcular ancho de fragmentos)
        function cx(key) {
            var j;
            for (j = 0; j < LIFELINES.length; j++) {
                if (LIFELINES[j].key == key) return X0 + j * X_STEP + LL_W / 2;
            }
            return X0;
        }

        // ---- 3) crear mensajes y fijar orden/geometria por SQL ----
        var y = Y_FIRST;
        var yOf = [];   // Y de cada mensaje (para los fragmentos)
        for (i = 0; i < MSGS.length; i++) {
            var m = MSGS[i];
            if (m.gap) y -= m.gap;
            yOf[i] = y;

            var srcId = elem[m.from];
            var dstId = elem[m.to];

            // crear el conector via API (Start = origen)
            var srcEl as EA.Element;
            srcEl = Repository.GetElementByID(srcId);
            var c as EA.Connector;
            c = srcEl.Connectors.AddNew(m.label ? m.label : "", "Sequence");
            c.SupplierID = dstId;
            c.Update();
            srcEl.Connectors.Refresh();
            var CID = c.ConnectorID;

            // tipo de retorno / llamada
            var pdata4 = "0";                 // 0 = llamada (solida)
            var retval = "retval=void;";
            var nameSql = m.label ? sqlEsc(m.label) : "";
            if (m.ret) {
                pdata4 = "1";                 // 1 = retorno (punteado)
                retval = "retval=" + m.ret + ";";
                nameSql = "";                 // los retornos no llevan label
            }

            // geometria vertical
            var y0 = y;
            var y1 = m.self ? (y - SELF_H) : y;

            var sql = "UPDATE t_connector SET "
                + "DiagramID=" + DID + ", "
                + "SeqNo=" + (i + 1) + ", "
                + "PtStartY=" + y0 + ", PtEndY=" + y1 + ", "
                + "Name='" + nameSql + "', "
                + "PDATA1='Synchronous', "
                + "PDATA2='" + retval + "', "
                + "PDATA3='Call', "
                + "PDATA4='" + pdata4 + "' "
                + "WHERE Connector_ID=" + CID + ";";
            exec(sql);

            y -= Y_STEP;
            if (m.self) y -= SELF_H;
        }
        log("Mensajes creados: " + MSGS.length);

        // ---- 4) crear fragmentos combinados (cajas alt/loop) ----
        for (i = 0; i < FRAGS.length; i++) {
            var fr = FRAGS[i];
            var label = fr.op + " [" + fr.guard + "]";
            var fe as EA.Element;
            fe = pkg.Elements.AddNew(fr.op, "InteractionFragment");
            fe.Update();
            pkg.Elements.Refresh();
            // guardar el operador y guarda en una tagged value (EA lo lee)
            var tagged = fe.TaggedValues;
            // nombre visible del fragmento = operador
            // (la guarda se agrega como nota del primer operando)

            // caja: abarca de la primer lifeline usada a la ultima, y
            // del 1er al ultimo mensaje adentro
            var yTop = yOf[fr.desde] + FRAG_TOPH;
            var yBot = yOf[fr.hasta] - Y_STEP;
            // ancho: usar todas las lifelines involucradas en el rango
            var minX = 999999, maxX = -999999;
            var r;
            for (r = fr.desde; r <= fr.hasta; r++) {
                var a = cx(MSGS[r].from), b = cx(MSGS[r].to);
                if (a < minX) minX = a; if (b < minX) minX = b;
                if (a > maxX) maxX = a; if (b > maxX) maxX = b;
            }
            var boxL = minX - FRAG_PADX;
            var boxR = maxX + FRAG_PADX;

            var fdo as EA.DiagramObject;
            fdo = dia.DiagramObjects.AddNew("l=" + boxL + ";r=" + boxR + ";t=" + yTop + ";b=" + yBot + ";", "");
            fdo.ElementID = fe.ElementID;
            fdo.Update();

            // fijar NType=4 (fragmento combinado) y vincular al diagrama
            exec("UPDATE t_object SET NType=4, PDATA1='" + DID + "', Name='" + sqlEsc(fr.op) + "' WHERE Object_ID=" + fe.ElementID + ";");

            // divisor del else (linea punteada): se agrega como nota en el diag.
            log("Fragmento " + fr.op + " [" + fr.guard + "] creado.");
        }
        dia.DiagramObjects.Refresh();

        // ---- 5) ajustar alto de los lifelines al ultimo mensaje ----
        var yEnd = y - 40;
        exec("UPDATE t_diagramobjects SET RectBottom=" + yEnd + " WHERE Diagram_ID=" + DID
             + " AND Object_ID IN (SELECT Object_ID FROM t_object WHERE Object_Type IN ('Sequence','Actor'));");

        // ---- 6) recargar y abrir ----
        Repository.ReloadDiagram(DID);
        Repository.OpenDiagram(DID);
        log("LISTO. Diagrama abierto en el paquete: " + pkg.Name);
    }
    catch (err) {
        Session.Output("ERROR: " + err.description);
    }
}

main();
