%%
%% This is file `factura.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% factura.dtx  (with options: `class')
%% 
%% Copyright 2016 Emilio Lazo Zaia <emiliolazozaia@gmail.com>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3c of this license or (at your option) any later
%% version. This version of this license is in
%%  http://www.latex-project.org/lppl/lppl-1-3c.{html|txt|tex|pdf}
%% and the latest version of this license is in
%%  http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of
%% LaTeX version 2008/05/04 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Emilio Lazo Zaia.
%% 
%% This work consists of the files README and factura.dtx
%% with its derived files factura.ins, factura.cls, factura.def,
%% factura-ejemplo-firma.tex, factura-ejemplo-fondo.tex,
%% factura-ejemplo-membrete.tex, factura-ejemplo-cotizacion.tex,
%% factura-ejemplo-prefactura.tex, factura-ejemplo-factura1.tex
%% factura-ejemplo-factura2.tex, factura-ejemplo-factura3.tex,
%% factura-ejemplo-factura4.tex, factura-ejemplo-factura5.tex,
%% factura-ejemplo-factura6.tex, factura-ejemplo-factura7.tex,
%% factura-ejemplo-factura8.tex, factura-ejemplo-reporte1.tex,
%% factura-ejemplo-reporte2.tex, factura-ejemplo-reporte3.tex,
%% and factura-beispiel-rechnung.tex.
%% 
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{factura}
[2016/06/25 v2.82
Clase para elaborar facturas legales
en la República Bolivariana de Venezuela.
]

\newif\if@prefactura
\newif\if@cotizacion
\newif\if@spanish \@spanishtrue
\newif\if@ivaexpresado \@ivaexpresadotrue
\newif\if@todosiva
\newif\if@confirmas \@confirmastrue
\newif\if@unafirma \@unafirmafalse
\newif\if@concondiciones \@concondicionestrue
\newif\if@filas
\newif\if@agrupado
\newif\if@centrado
\newif\if@descuentos
\newif\if@denom
\newif\if@sinnumero
\newif\if@conlineasha
\newif\if@linea
\newif\if@lineacompleta
\newif\if@lineahastatotal
\newif\if@lineadesdeinicio
\newif\if@G
\newif\if@BIR
\newif\if@BIA
\newif\if@Exento
\newif\if@DescG
\newif\if@DescR
\newif\if@DescA
\newif\if@DescE
\newif\if@DescGnum
\newif\if@DescRnum
\newif\if@DescAnum
\newif\if@DescEnum
\newif\if@Descuentos
\newif\if@csv
\newif\if@cdu \@cdutrue
\newif\if@dcu
\newif\if@duc
\newif\if@exparriba
\newif\if@fondofactura
\newif\if@fondoreporte
\newif\if@fondoreportestar
\newif\if@factura \@facturatrue
\newif\if@reporte
\newif\if@nombre
\newif\if@pagado
\newif\if@impdesc
\newif\if@pruebaref

\RequirePackage{etoolbox}%  'etoolbox' para los condicionales binarios.

\newbool{Descuentos}
\newbool{SinCantidad}
\newbool{SinLineasVertInt}
\newbool{SinLineasVertExt}
\newbool{SinLineasHoriInt}
\newbool{SinLineasHoriExt}
\newbool{DCU}
\newbool{DUC}
\newbool{NumItem}
\newbool{PrimeroDescrip}
\newbool{ExpAbajo}\booltrue{ExpAbajo}

%% Condicionales auxiliares para la posición de los objetos fijos cuando son medidos desde la derecha, o desde abajo.
\newbool{FechaXnegativo}
\newbool{FechaYnegativo}
\newbool{CondYnegativo}% no hay CondXnegativo.
\newbool{DenomXnegativo}
\newbool{DenomYnegativo}
\newbool{ControlXnegativo}
\newbool{ControlYnegativo}
\newbool{FirmasYnegativo}% no hay FirmasXnegativo; hay X_inicial y X_final para las firmas.

\DeclareOption{prefactura}{\@prefacturatrue\@denomtrue\@confirmasfalse}%  La prefactura; con el diseño de la forma libre... para enviar por correo electrónico, fax o imprimir preliminarmente.
\DeclareOption{cotizacion}{\@cotizaciontrue\@denomtrue\@unafirmatrue}%  Cambia la denominación a 'COTIZACIÓN' y no 'FACTURA'.
\DeclareOption{nospanish}{\@spanishfalse}%  No carga babel en castellano ni la codificación T1 de las letras.
\DeclareOption{sinfirmas}{\@confirmasfalse}%  No agrega los espacios para firmar.
\DeclareOption{unafirma}{\@unafirmatrue\@confirmastrue}%  No agrega el espacio para que firme quien recibe.
\DeclareOption{dosfirmas}{\@unafirmafalse\@confirmastrue}%  Pone las dos firmas para firmar.
\DeclareOption{descuentos}{\booltrue{Descuentos}\@descuentostrue}%  Para los descuentos individuales.
\DeclareOption{sincondiciones}{\@concondicionesfalse}%  No agrega el texto con las condiciones del documento.
\DeclareOption{denom}{\@denomtrue}%  Agrega el texto con la denominación del documento, para las formas libres que no tienen el número de factura.
\DeclareOption{sinnumero}{\@sinnumerotrue\@denomtrue}%  Escribir el texto de la denominación del documento pero sin escribir el número.
\DeclareOption{G}{\@Gtrue}%  Con esta opción sale la letra 'G' en los items con IVA general, y sale el porcentaje en la base imponible general.
\DeclareOption{filas}{\@filastrue}%  Estilo de totalización en filas.
\DeclareOption{centrado}{%  Total y exento 'centrado'; sólo para estilo 'filas'
 \if@filas
  \@centradotrue
 \else
  \ClassWarning{factura}{La opción 'centrado' no es compatible con el modo de totalización en columnas. Sin efecto opción 'centrado'.}{}
 \fi}
\DeclareOption{agrupado}{%  Agrupados los elementos totalizadores en el modo en columnas.
 \if@filas
  \ClassWarning{factura}{La opción 'agrupado' no es compatible con el modo de totalización en filas. Sin efecto opción 'agrupado'.}{}
 \else
  \@agrupadotrue
 \fi}
\DeclareOption{impdesc}{\@impdesctrue}%  Para el tipo de impuesto en la descripción y no en el precio unitario y total.
\DeclareOption{numitem}{\booltrue{NumItem}}%  Para poner una columna extra al principio con el número del ítem.
\DeclareOption{dcu}{%  Descripción, luego cantidad y luego precio unitario.
 \@dcutrue\@cdufalse\@ducfalse
 \booltrue{DCU}\boolfalse{DUC}
 \booltrue{PrimeroDescrip}}
\DeclareOption{duc}{%  Descripción, luego precio unitario y luego cantidad.
 \if@dcu
  \ClassWarning{factura}{Las opciones 'duc' y 'dcu' no son compatibles. Sin efecto ambas opciones}{}
  \boolfalse{PrimeroDescrip}\boolfalse{DCU}\@dcufalse\@cdutrue
 \else
  \@ductrue\@cdufalse\@dcufalse
  \booltrue{DUC}\boolfalse{DCU}
  \booltrue{PrimeroDescrip}
 \fi}
\DeclareOption{siniva}{\AtBeginDocument{\gdef\@ImpuestoG{0}\gdef\@ImpuestoR{0}\gdef\@ImpuestoA{0}}}%  No cobra IVA.
\DeclareOption{todosiva}{\@todosivatrue}%  Con esta opción salen todos los IVA así valgan cero.
\DeclareOption{sinivaexpresado}{%  Cuando no se cobra IVA y tampoco se quiere que aparezca la totalización del IVA.
 \@ivaexpresadofalse
 \if@filas
  \ClassWarning{factura}{La opción 'sinivaexpresado' no es compatible con la opción 'filas'. Sin efecto la opción 'filas'}{}
  \@filasfalse
 \else
  \AtBeginDocument{\gdef\@ImpuestoG{0}\gdef\@ImpuestoR{0}\gdef\@ImpuestoA{0}}
 \fi}
\DeclareOption{sincantidad}{%  Para no poner el campo de la cantidad.
 \booltrue{SinCantidad}
 \if@dcu
  \ClassWarning{factura}{La opción 'sincantidad' no es compatible con 'dcu' . Sin efecto opción 'dcu'}{}
  \@dcufalse\@cdutrue\boolfalse{DCU}\boolfalse{PrimeroDescrip}
 \fi
 \if@duc
  \ClassWarning{factura}{La opción 'sincantidad' no es compatible con 'duc' . Sin efecto opción 'duc'}{}
  \@ducfalse\@cdutrue\boolfalse{DUC}\boolfalse{PrimeroDescrip}
 \fi}

\DeclareOption{conlineasha}{\@conlineashatrue}%  Una línea horizontal para cada ítem, como las facturas a mano.
\DeclareOption{sinlineasv}{%  Estilo 'sinlineasv'.
 \booltrue{SinLineasVertExt}\booltrue{SinLineasVertInt}}
\DeclareOption{sinlineasvi}{\booltrue{SinLineasVertInt}}%  Estilo 'sinlineasvi'.
\DeclareOption{sinlineasve}{\booltrue{SinLineasVertExt}}%  Estilo 'sinlineasve'.
\DeclareOption{sinlineash}{%  Estilo 'sinlineash'.
 \booltrue{SinLineasHoriExt}\booltrue{SinLineasHoriInt}}
\DeclareOption{sinlineashi}{\booltrue{SinLineasHoriInt}}%  Estilo 'sinlineashi'.
\DeclareOption{sinlineashe}{\booltrue{SinLineasHoriExt}}%  Estilo 'sinlineashe'.
\DeclareOption{exparriba}{\@exparribatrue\boolfalse{ExpAbajo}}%  Para rellenar con líneas en blanco de manera automática.
\DeclareOption{sinexpandir}{\boolfalse{ExpAbajo}\@exparribafalse}%  No expande ninguna de las dos partes de la factura.
\DeclareOption{linea}{%  Para la línea que protege el espacio en blanco.
 \if@exparriba
  \@lineatrue
 \else
  \ClassWarning{factura}{La opción 'linea' requiere la opción 'exparriba'. Sin efecto opción 'linea'.}{}
 \fi}
\DeclareOption{conreporte}{\@reportetrue}%  Para imprimir factura y reporte.
\DeclareOption{soloreporte}{\@reportetrue\@facturafalse}%  Para imprimir sólo el reporte.
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{article}}%  Opción 'twoside' de article para los reportes.
\DeclareOption{csv}{%  Para la salida en modo csv también.
 \if@factura
  \@csvtrue
  \AtEndDocument{\@EscribeTotalesEnCSV}
 \else
  \ClassWarning{factura}{La opción 'csv' require generar la factura. Sin efecto opción 'csv'.}{}
 \fi}

\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage{xparse}%  Algunos comandos los definimos con \NewDocumentCommand.
\RequirePackage[absolute]{textpos}%  Es necesario 'textpos' para colocar texto en ubicaciones arbitrarias.
\RequirePackage{geometry}%  'geometry' para ajustar todos los márgenes.
\RequirePackage{xstring}%  Lo usamos sólo para tomar el menos al principio de una longitud.
\RequirePackage{calc}%  'calc' para hacer aritmética con las dimensiones.
\RequirePackage{fp-upn}%  Fundamental el paquete 'fp-upn' para todos los cálculos.
\RequirePackage{numprint}%  Con 'numprint' expresamos los totales en el formato requerido.
\RequirePackage{tikz}%  Para los recuadros del encabezado de la factura,
 \usetikzlibrary{shadows}%  y para el de la descripción.
\RequirePackage{tabularx}%  Con 'tabularx' hacemos la tabla.
\RequirePackage{environ}%  Con 'environ' podemos usar tabularx dentro del ambiente de la factura y escribir texto en el enddef.
\RequirePackage{fancyhdr}%  Las cabeceras fancy; así se use solamente en reporte, hay que cargarlo siempre.

\AtBeginDocument{%  Da error si algún campo necesario no está definido.
 \if@reporte
  \ifdefvoid{\@Fecha}{\ClassWarning{factura}{** No se especificó una fecha. Puede dar error si el título del reporte no se especifica que aparezca en las cabeceras **}{}}{}%
  \ifdefvoid{\@Num}{\ClassWarning{factura}{** No se especificó el número de la factura. Puede dar error si el título del reporte no se especifica que aparezca en las cabeceras **}{}}{}%
  \ifdefvoid{\@Proveedor}{%
   \ifdefvoid{\@Emisor}
    {\ClassError{factura}{** Hay que definir el nombre del proveedor cuando se emite un reporte **}{}}%
    {\ClassWarning{factura}{** Se toma el emisor como el proveedor por no haberse especificado este último **}{}%
    \let\@Proveedor=\@Emisor}}
   {}%
 \fi
 \ifdefvoid{\@RazonSocial}{\ClassError{factura}{** Hay que definir la razón social **}{}}{}%
 \if@factura
  \ifdefvoid{\@RIF}{\ClassError{factura}{** Hay que definir el R.I.F. **}{}}{}%
  \ifdefvoid{\@Direccion}{\ClassError{factura}{** Hay que definir la dirección fiscal **}{}}{}%
  \ifdefvoid{\@Telefono}{\ClassError{factura}{** Hay que definir un número telefónico **}{}}{}%
  \ifdefvoid{\@Email}{\ClassWarning{factura}{** Pudiera definirse una dirección de correo electrónico **}{}}{}%
  \ifdefvoid{\@Fecha}{\ClassError{factura}{** Hay que definir la fecha de emisión **}{}}{}%
  \if@concondiciones
   \ifdefvoid{\@Condiciones}{\ClassError{factura}{** Hay que definir las condiciones del documento o usar la opción 'sincondiciones' **}{}}{}%
  \fi
  \if@cotizacion
   \ifdefvoid{\@FondoFactura}{\ClassWarning{factura}{** En la opción para cotizacion se recomienda agregar el fondo **}{}}{}%
  \fi
  \if@prefactura
   \ifdefvoid{\@FondoFactura}{\ClassWarning{factura}{** En la opción para prefactura se recomienda agregar el fondo **}{}}{}%
  \fi
  \if@sinnumero
   \if@cotizacion
   \else
    \ClassError{factura}{** La opción para no poner el número sólo es compatible con las cotizaciones **}{}%
   \fi
  \fi
  \if@denom
   \if@sinnumero
   \else
    \ifdefvoid{\@Num}{\ClassError{factura}{** Hay que definir el número de la factura **}{}}{}%
   \fi
  \fi
 \fi
 \ifdefvoid{\@Contacto}{\if@nombre\else\ClassWarning{factura}{** Pudiera definirse una persona de contacto **}{}\fi}{}%
}

%% Escribimos el total como comentario en el .log, y avisamos cuando la fecha no sea la de hoy.
\AtEndDocument{%
 \edef\@Hoy{\ifnum\number\day<10 0\fi\the\day-\ifnum\number\month<10 0\fi\the\month-\the\year}%
 \ifx\undefined\@Fecha
 \else
  \edef\@Fecha{\@Fecha}%
  \ifx\@Fecha\@Hoy
  \else
   \ClassWarning{factura}{** Fecha del documento\space \@Fecha\space distinta de la fecha de hoy. **}{}%
  \fi
 \fi
 \if@factura\ClassInfo{factura}{\@@Total: \space\space\space \Moneda \Total}{}\fi}

%% La geometría en formato de factura y de reporte.
%% El margen superior está definido desde el encabezado con los datos del cliente.
%% El margen inferior está definido hasta el final de la descripción (o del cuadro de la factura si no hay descripción).
%% Hay elementos que salen fuera de estos márgenes, como las firmas, las condiciones del documento, la numeración y la fecha.
\def\GeometriaFactura#1{\gdef\@GeometriaFactura{#1}}
\def\GeometriaReporte#1{\gdef\@GeometriaReporte{#1}}

%% Se utiliza '\@Impuesto' como el factor del impuesto, el cual viene predefinido en '\@Alicuota'.
\def\@ImpuestoG{\@AlicuotaG}
\def\@ImpuestoR{\@AlicuotaR}
\def\@ImpuestoA{\@AlicuotaA}

%% Fijamos en cero los descuentos totales (necesario).
\def\@DescuentoGporc{0}
\def\@DescuentoRporc{0}
\def\@DescuentoAporc{0}
\def\@DescuentoEporc{0}
\def\@DescuentoGnum{0}
\def\@DescuentoRnum{0}
\def\@DescuentoAnum{0}
\def\@DescuentoEnum{0}

%% \Fecha, \RazonSocial, \Nombre, \RIF, \CI, \Contacto, \Dirección, \Telefono, \Email, \Emisor, \Proveedor.
\def\Fecha#1{\gdef\@Fecha{#1}}
\def\RazonSocial#1{\gdef\@RazonSocial{#1}}
\def\Nombre#1{\gdef\@RazonSocial{#1}\@nombretrue}
\def\RIF#1{\gdef\@RIF{#1}}
\def\CI#1{\gdef\@RIF{#1}\let\@@RIF\@@CI\let\@CI\@RIF}
\def\Contacto#1{\gdef\@Contacto{#1}}
\def\Direccion#1{\gdef\@Direccion{#1}}
\def\Telefono#1{\gdef\@Telefono{#1}}
\def\Email#1{\gdef\@Email{#1}}
\def\Conforme#1{\gdef\@Conforme{#1}}
\def\Emisor#1{\gdef\@Emisor{#1}}
\def\Proveedor#1{\gdef\@Proveedor{#1}}

%% Los descuentos totales.
\NewDocumentCommand{\Descuento}{s m}{%
 \IfBooleanTF{#1}
  {\@DescGnumtrue\@DescRnumtrue\@DescAnumtrue\@DescEnumtrue
  \gdef\@DescuentoGnum{#2}\gdef\@DescuentoRnum{#2}\gdef\@DescuentoAnum{#2}\gdef\@DescuentoEnum{#2}}
  {\@DescGnumfalse\@DescRnumfalse\@DescAnumfalse\@DescEnumfalse
  \gdef\@DescuentoGporc{#2}\gdef\@DescuentoRporc{#2}\gdef\@DescuentoAporc{#2}\gdef\@DescuentoEporc{#2}}%
 \@DescGtrue\@DescRtrue\@DescAtrue\@DescEtrue\@Descuentostrue}

\NewDocumentCommand{\DescuentoG}{s m}{%
 \IfBooleanTF{#1}{\@DescGnumtrue\gdef\@DescuentoGnum{#2}}{\@DescGnumfalse\gdef\@DescuentoGporc{#2}}%
 \@DescGtrue\@Descuentostrue}

\NewDocumentCommand{\DescuentoR}{s m}{%
 \IfBooleanTF{#1}{\@DescRnumtrue\gdef\@DescuentoRnum{#2}}{\@DescRnumfalse\gdef\@DescuentoRporc{#2}}%
 \@DescRtrue\@Descuentostrue}

\NewDocumentCommand{\DescuentoA}{s m}{%
 \IfBooleanTF{#1}{\@DescAnumtrue\gdef\@DescuentoAnum{#2}}{\@DescAnumfalse\gdef\@DescuentoAporc{#2}}%
 \@DescAtrue\@Descuentostrue}

\NewDocumentCommand{\DescuentoE}{s m}{%
 \IfBooleanTF{#1}{\@DescEnumtrue\gdef\@DescuentoEnum{#2}}{\@DescEnumfalse\gdef\@DescuentoEporc{#2}}%
 \@DescEtrue\@Descuentostrue}

\def\Denom#1{\gdef\@Denominacion{#1}}%  La denominación puede ser 'FACTURA', 'COTIZACIÓN' u otra. Se predetermina una de estas dos según las opciones de la clase.

%% Número de la factura con \Num, número de control con \NumControl, y número de serie de control \NumSerieControl.
\def\Num#1{\gdef\@Num{\nplpadding{\@DigitosNumeracion}\npthousandsep{}\numprint{#1}}}
\def\NumControl#1{\gdef\@NumControl{\nplpadding{\@DigitosNumeracion}\npthousandsep{}\numprint{#1}}}%  Si el número de control no se especifica, toma el mismo que el de la factura
\def\NumSerieControl#1{\gdef\@NumSerieControl{#1}}%  Si el número de serie de control no se especifica, toma '00'.

%% Información de página: cabeceras de páginas o piés de página.
\def\InfoPagina#1{\gdef\@InfoPagina{#1}}

%% Texto que esclarece las condiciones del documento.
\NewDocumentCommand{\Condiciones}{+m}{\gdef\@Condiciones{#1}}

%% Resumen opcional que va a la derecha de los datos del cliente.
\NewDocumentCommand{\Resumen}{+m}{\gdef\@Resumen{#1}}

\AtBeginDocument{%
 \ifx\@undefined\@NumControl\let\@NumControl\@Num\fi
 \ifx\@undefined\@NumSerieControl\gdef\@NumSerieControl{00}\fi
 % Establecemos los porcentajes de las alícuotas, y redondeamos los descuentos.
 \FPupn\@AlicuotaGporc{\@AlicuotaG{} 100 * \@DigitosPorc{} round clip}%
 \FPupn\@AlicuotaRporc{\@AlicuotaR{} 100 * \@DigitosPorc{} round clip}%
 \FPupn\@AlicuotaAporc{\@AlicuotaA{} 100 * \@DigitosPorc{} round clip}%
 \FPupn\@DescuentoGporc{\@DescuentoGporc{} \@DigitosPorc{} round clip}%
 \FPupn\@DescuentoRporc{\@DescuentoRporc{} \@DigitosPorc{} round clip}%
 \FPupn\@DescuentoAporc{\@DescuentoAporc{} \@DigitosPorc{} round clip}%
 \FPupn\@DescuentoEporc{\@DescuentoEporc{} \@DigitosPorc{} round clip}%
 \FPupn\@DescuentoGfactor{100 \@DescuentoGporc{} /}%
 \FPupn\@DescuentoRfactor{100 \@DescuentoRporc{} /}%
 \FPupn\@DescuentoAfactor{100 \@DescuentoAporc{} /}%
 \FPupn\@DescuentoEfactor{100 \@DescuentoEporc{} /}}

%% Posiciones (X,Y) de los objetos: i) fecha, ii) denominación, iii) condiciones, iv) número de control, v) firmas.
\def\PosFecha#1#2{%
 \IfBeginWith{#1}{-}
  {\StrBehind{#1}{-}[\templeng]\setlength{\@PosFechaX}{-\templeng}\booltrue{FechaXnegativo}}
  {\boolfalse{FechaXnegativo}\setlength{\@PosFechaX}{#1}}
 \IfBeginWith{#2}{-}
  {\StrBehind{#2}{-}[\templeng]\setlength{\@PosFechaY}{-\templeng}\booltrue{FechaYnegativo}}
  {\boolfalse{FechaYnegativo}\setlength{\@PosFechaY}{#2}}}

\def\PosDenom#1#2{%
 \IfBeginWith{#1}{-}
  {\StrBehind{#1}{-}[\templeng]\setlength{\@PosDenomX}{-\templeng}\booltrue{DenomXnegativo}}
  {\boolfalse{DenomXnegativo}\setlength{\@PosDenomX}{#1}}
 \IfBeginWith{#2}{-}
  {\StrBehind{#2}{-}[\templeng]\setlength{\@PosDenomY}{-\templeng}\booltrue{DenomYnegativo}}
  {\boolfalse{DenomYnegativo}\setlength{\@PosDenomY}{#2}}}

\def\PosControl#1#2{%
 \IfBeginWith{#1}{-}
  {\StrBehind{#1}{-}[\templeng]\setlength{\@PosControlX}{-\templeng}\booltrue{ControlXnegativo}}
  {\boolfalse{ControlXnegativo}\setlength{\@PosControlX}{#1}}
 \IfBeginWith{#2}{-}
  {\StrBehind{#2}{-}[\templeng]\setlength{\@PosControlY}{-\templeng}\booltrue{ControlYnegativo}}
  {\boolfalse{ControlYnegativo}\setlength{\@PosControlY}{#2}}}

\def\PosCond#1#2{%
 \setlength{\@PosCondX}{#1}%
 \IfBeginWith{#2}{-}
  {\StrBehind{#2}{-}[\templeng]\setlength{\@PosCondY}{-\templeng}\booltrue{CondYnegativo}}
  {\boolfalse{CondYnegativo}\setlength{\@PosCondY}{#2}}}
%% 'X' no acepta valores negativos en \PosCond.

\def\PosFirmas#1#2#3{%
 \setlength{\@PosFirmasXuno}{#1}%
 \setlength{\@PosFirmasXdos}{#2}%
 \IfBeginWith{#3}{-}
  {\StrBehind{#3}{-}[\templeng]\setlength{\@PosFirmasY}{-\templeng}\booltrue{FirmasYnegativo}}
  {\boolfalse{FirmasYnegativo}\setlength{\@PosFirmasY}{#3}}}
%% La firma se define con un X_inicial, un X_final y un Y_inicial (Xo,Xf,Y)

%% Tamaño y grosor de la línea de las firmas.
\def\LineaFirmas#1#2{%
 \setlength{\@TamLineaFirmas}{#1}%
 \setlength{\@GrosorLineaFirmas}{#2}}

%% Separación mínima horizontal entre los totales en modo de filas y distancia vertical entre esas líneas, fija.
\def\SepFilas#1#2{\setlength{\@SeparaMinTotales}{#1}\setlength{\@SeparaFilas}{#2}}

%% Separación vertical entre los elementos de la factura (entre el encabezado y el cuadro de la 'factura', luego desde dicho cuadro hasta la descripción, o hasta los totales en modo de filas).
\def\SepElementos#1{\setlength{\@SeparaElementos}{#1}}

%% Separación horizontal entre las cajas del encabezado y separación interna entre la línea y el texto.
\def\SepEncabez#1#2{\setlength{\@SeparaEncabez}{#1}\setlength{\@SeparaInternaEncabez}{#2}}

%% Separación interna entre la línea y el texto de la descripción.
\def\SepDescrip#1{\setlength{\@SeparaInternaDescrip}{#1}}

%% Grosor de la línea de las cajas del encabezado, curvatura de la esquina y sombra.
\def\LineaEncabez#1#2#3{\setlength{\@GrosorLineaEncabez}{#1}\setlength{\@EsquinaLineaEncabez}{#2}\setlength{\@SombraEncabez}{#3}}

%% Grosor de la línea de la descripción, curvatura de la esquina y sombra.
\def\LineaDescrip#1#2#3{\setlength{\@GrosorLineaDescrip}{#1}\setlength{\@EsquinaLineaDescrip}{#2}\setlength{\@SombraDescrip}{#3}}

%% El espacio vertical que hay que avanzar sólo en la primera página del reporte antes de empezar a escribir sobre él. Usable cuando la primera página tiene un membrete y las demás no, es decir, cuando se usa \FondoReporte y no \FondoReporte*.
\def\InicioReporte#1{\setlength{\@InicioReporte}{#1}}

%% Tipos de letra para cada elemento posible:
%% Esta es la letra de la descripción de los items; y el espacio \baselineskip de *toda* la tabla de la factura se fija en este comando únicamente (se predeterminó 18pt).
\def\LetraItems#1{\gdef\@LetraItems{#1\selectfont}}

%% Con este comando se cambia la etra del título de la tabla, es decir, los textos 'Cantidad, 'Descripción', etc...
\def\LetraTitCuadro#1{\gdef\@LetraTitCuadro{#1\selectfont}}

%% Tipo de letra de los títulos de los totales, por ejemplo los textos: 'B.I. G', 'IVA G'.
\def\LetraTitTotales#1{\gdef\@LetraTitTotales{#1\selectfont}}

%% Letra con la que salen los totales parciales, es decir, los números, exceptuando el total general.
\def\LetraNumTotales#1{\gdef\@LetraNumTotales{#1\selectfont}}

%% Letra con la que sale la palabra 'TOTAL'.
\def\LetraTitTotal#1{\gdef\@LetraTitTotal{#1\selectfont}}

%% Letra para el total general, el monto.
\def\LetraNumTotal#1{\gdef\@LetraNumTotal{#1\selectfont}}

%% Tipo de letra para los títulos de las cajas del encabezado, por ejemplo: 'Datos del cliente'.
\def\LetraTitEnc#1{\gdef\@LetraTitEnc{#1\selectfont}}

%% Tipo de letra para el texto en el encabezado de la factura.
\def\LetraEncFactura#1{\gdef\@LetraEncFactura{#1\selectfont}}

%% Tipo de letra para el texto en el encabezado del reporte.
\def\LetraEncReporte#1{\gdef\@LetraEncReporte{#1\selectfont}}

%% Letra para los montos individuales de la factura y las cantidades.
\def\LetraNumeros#1{\gdef\@LetraNumeros{#1\selectfont}}

%% El tipo de IVA ('G', 'R', 'A' o '(E)') también tiene su tipo de letra.
\def\LetraTipoIVA#1{\gdef\@LetraTipoIVA{#1\selectfont}}

%% Letra para la descripción larga (comando \Descripcion).
\def\LetraDescripcion#1{\gdef\@LetraDescripcion{#1\selectfont}}

%% Tipo de letra para el texto bajo las líneas para firmar.
\def\LetraFirmas#1{\gdef\@LetraFirmas{#1\selectfont}}

%% Tipo de letra para las condiciones del documento.
\def\LetraCondiciones#1{\gdef\@LetraCondiciones{#1\selectfont}}

%% Letra para la denominación del documento ('FACTURA', 'COTIZACIÓN',...).
\def\LetraDenom#1{\gdef\@LetraDenom{#1\selectfont}}

%% Letra para la numeración de la factura.
\def\LetraNumeracion#1{\gdef\@LetraNumeracion{#1\selectfont}}

%% Letra para la fecha de emisión.
\def\LetraFecha#1{\gdef\@LetraFecha{#1\selectfont}}

%% Letra para el título del reporte.
\def\LetraTitReporte#1{\gdef\@LetraTitReporte{#1\selectfont}}

%% Letra para las cabeceras de las páginas en el modo reporte.
\def\LetraInfoPagina#1{\gdef\@LetraInfoPagina{#1\selectfont}}

%% Letra para el reporte.
\def\LetraReporte#1{\gdef\@LetraReporte{#1\selectfont}}

%% Comando para incluir la firma escaneada en el sitio donde va la línea de la firma del emisor.
\NewDocumentCommand{\FirmaFactura}{m O{0pt} O{0pt}}{% \FirmaFactura{imagen}[x-corr][y-corr]
 \if@factura
  \RequirePackage{graphicx}
  \ifx&#2&\else\setlength{\@FirmaFacturaXcorr}{#2}\fi
  \ifx&#3&\else\setlength{\@FirmaFacturaYcorr}{#3}\fi
  \savebox{\@CajaFirmaEmisor}{#1}
  \if@reporte
   \expandafter\AtBeginShipoutNext
  \else
   \expandafter\AtEndDocument
  \fi
  {%
   \begin{textblock*}{\@TamLineaFirmas}%
    (\textwidth+\oddsidemargin+1in-\@TamLineaFirmas/2-\wd\@CajaFirmaEmisor/2-\@PosFirmasXdos+\@FirmaFacturaXcorr,\@PosFirmasY-\ht\@CajaFirmaEmisor-\dp\@CajaFirmaEmisor+\@FirmaFacturaYcorr)%
    \usebox{\@CajaFirmaEmisor}%
   \end{textblock*}}%
 \fi}

\NewDocumentCommand{\FirmaReporte}{O{} O{0pt} O{0pt} G{\@Proveedor} O{2cm} O{1.5cm}}{% \Firma[imagen][x-corr][y-corr]{texto}[posición en X desde la derecha][tamaño linea]
 \renewcommand{\baselinestretch}{1}\selectfont
 \newif\if@firma@dibujo
 \newbox{\TextoFirma}%
 \newbox{\DibujoFirma}%
 \ifx&#1&\else\savebox{\DibujoFirma}{#1}\@firma@dibujotrue\fi
 \ifx&#2&\else\setlength{\@FirmaReporteXcorr}{#2}\fi
 \ifx&#3&\else\setlength{\@FirmaReporteYcorr}{#3}\fi
 \savebox{\TextoFirma}{#4}%
 \ifx&#5&\setlength{\@FirmaReporteTextPos}{2cm}\else\setlength{\@FirmaReporteTextPos}{#5}\fi
 \ifx&#6&\setlength{\@FirmaReporteTamLinea}{1.5cm}\else\setlength{\@FirmaReporteTamLinea}{#6}\fi
 \@LetraFirmas
 \if@firma@dibujo
  \newlength{\@FirmaReporteoddeven}%
  \setlength{\@FirmaReporteFirmaPos}{\zposy{Firma@zref@PosY}sp}%
 \fi
 \ifdim\wd\DibujoFirma>\wd\TextoFirma
  \setlength{\@FirmaReporteTamLinea}{\@FirmaReporteTamLinea+\wd\DibujoFirma}%
 \else
  \setlength{\@FirmaReporteTamLinea}{\@FirmaReporteTamLinea+\wd\TextoFirma}%
 \fi
 \par
 \vspace*{\ht\DibujoFirma}%
 \vspace*{\dp\DibujoFirma}%
 \hfill
 \parbox{\@FirmaReporteTamLinea}{%
  \if@firma@dibujo\zsaveposy{Firma@zref@PosY}\fi
  \rule{\@FirmaReporteTamLinea}{\@GrosorLineaFirmas}\\
  \centering{\usebox{\TextoFirma}}}%
 \hspace*{\@FirmaReporteTextPos}\par
 \if@firma@dibujo
  \mbox{}%
  \par
  \ifodd\c@page
   \setlength{\@FirmaReporteoddeven}{\oddsidemargin}%
  \else
   \setlength{\@FirmaReporteoddeven}{\evensidemargin}%
  \fi
  \begin{textblock*}{\@FirmaReporteTamLinea}
  (\textwidth+\@FirmaReporteoddeven+1in-0.5\@FirmaReporteTamLinea-0.5\wd\DibujoFirma-\@FirmaReporteTextPos+\@FirmaReporteXcorr,
   \paperheight-\@FirmaReporteFirmaPos-\ht\DibujoFirma-\dp\DibujoFirma+\@FirmaReporteYcorr)
   \noindent\usebox{\DibujoFirma}%
  \end{textblock*}
 \fi}

%% Con \FondoFactura le damos el nombre del archivo que contiene el formato de la factura, por ejemplo para compilaciones con 'prefactura', 'cotizacion' o para incluir una imagen de fondo como 'marca de agua'.
\newcommand{\FondoFactura}[1]{
 \if@factura
  \RequirePackage{graphicx}
  \@fondofacturatrue
  \gdef\@FondoFactura{#1}
 \fi}

%% Con \FondoReporte le damos el nombre del archivo que contiene el formato del reporte. Existen dos posibilidades: que dicho fondo salga en todas las páginas o sólo en la primera.
\NewDocumentCommand{\FondoReporte}{s m}{
 \if@reporte
  \@fondoreportetrue
  \RequirePackage{graphicx}
  \gdef\@FondoReporte{#2}
  \IfBooleanT{#1}{\@fondoreportestartrue}% Con * sale en todas las páginas; sin * sale sólo en la primera página.
 \fi}

%% Comando para establecer desde el preámbulo el estilo de página (\pagestyle) del reporte, tanto para la primera página como para las siguientes.
\NewDocumentCommand{\EstiloPagReporte}{o m}{
 \gdef\@EstiloPagReporteResto{#2}
 \IfValueTF{#1}{\gdef\@EstiloPagReporteUno{#1}}{\gdef\@EstiloPagReporteUno{\@EstiloPagReporteResto}}}

%% El título para el reporte.
\NewDocumentCommand{\TituloReporte}{s m}{
 \gdef\@TituloReporte{#2}%
 \IfBooleanTF{#1}{% Con '*' sale el título en las cabeceras o piés. Sin '*' no.
  \gdef\@InfoPagina{\let\\\relax\@InfoPaginaTitulo}}%
 {\let\@InfoPagina\@InfoPaginaNoTitulo}}

%% Para cada cliente o para cada personalización se puede tener un archivo .def o .tex con su nombre y ciertas macros cargadas. Ese archivo lo ponemos incluir con '\Cliente' en lugar de usar \input, y la extensión deberá ser .def o .tex.
\newcommand{\Cliente}[1]{%
 \IfFileExists{#1.def}{\input{#1.def}}{
  \IfFileExists{#1.tex}{\input{#1.tex}}{
   \ClassError{factura}{** No existe #1.def ni #1.tex **}{}}}}

%% Comando para mostrar macros con '@'.
\newcommand{\mostrar}[1]{\csname #1\endcsname}

%% Longitudes para uso interno.
\newlength{\@TamDatos}
\newlength{\@TamResumen}
\newlength{\@TamFinalEncabez}
\newlength{\@TamLineaFirmas}
\newlength{\@TamNumItem}
\newlength{\@TamCantidad}
\newlength{\@TamDescrip}
\newlength{\@TamPrecioU}
\newlength{\@TamDescuento}
\newlength{\@TamPrecioT}
\newlength{\@GrosorLineaFirmas}
\newlength{\@GrosorLineaEncabez}
\newlength{\@GrosorLineaDescrip}
\newlength{\@EsquinaLineaEncabez}
\newlength{\@EsquinaLineaDescrip}
\newlength{\@SombraEncabez}
\newlength{\@SombraDescrip}
\newlength{\@LineaNodoXo}
\newlength{\@LineaNodoYo}
\newlength{\@LineaNodoXf}
\newlength{\@LineaNodoYf}
\newlength{\@SepTotales}
\newlength{\@PosFechaX}
\newlength{\@PosFechaY}
\newlength{\@PosDenomX}
\newlength{\@PosDenomY}
\newlength{\@PosFirmasXuno}
\newlength{\@PosFirmasXdos}
\newlength{\@PosFirmasY}
\newlength{\@PosCondX}
\newlength{\@PosCondY}
\newlength{\@PosControlX}
\newlength{\@PosControlY}
\newlength{\@EspacioVacioInicial}
\newlength{\@EspacioVacioFinal}
\newlength{\@SeparaEncabez}
\newlength{\@SeparaInternaEncabez}
\newlength{\@SeparaInternaDescrip}
\newlength{\@SeparaElementos}
\newlength{\@SeparaMinTotales}
\newlength{\@SeparaFilas}
\newlength{\@SeparaFinLineaDesc}
\newlength{\@InicioReporte}
\newlength{\@FirmaFacturaXcorr}
\newlength{\@FirmaFacturaYcorr}
\newlength{\@FirmaReporteXcorr}
\newlength{\@FirmaReporteYcorr}
\newlength{\@FirmaReporteTextPos}
\newlength{\@FirmaReporteFirmaPos}
\newlength{\@FirmaReporteTamLinea}
\newlength{\@TempDimen}

%% Cajas para uso interno.
\newbox{\@CajaDatos}
\newbox{\@CajaResumen}
\newbox{\@CajaFirmaEmisor}
\newbox{\@CajaFirmas}
\newbox{\@CajaFecha}
\newbox{\@CajaDenom}
\newbox{\@CajaControl}
\newbox{\@CajaCond}
\newbox{\@CajaEspacioVacio}
\newbox{\@CajaPrueba}
\newbox{\@CajaCaracterCR}

%% Contadores para uso interno para uso interno:
\newcounter{@IVANoGeneral}%  '0' con sólo IVA G, '1' cuando hay IVA R o IVA A, y '2' cuando hay ambos.
\newcounter{@NumItem}%  Número del ítem actual, para uso de algunas macros en el cuadro de la factura y para cuando se usa la opción 'numitem'.

\input{factura.def}%  Cargamos los valores predeterminados.

\if@todosiva
 \@BIRtrue
 \@BIAtrue
 \@Exentotrue
 \@Gtrue
\fi

\if@csv%  Abre el archivo csv.
 \newwrite\csv
 \immediate\openout\csv=\jobname.csv
\fi

\if@spanish
 \RequirePackage[spanish]{babel}%  Babel en castellano.
 \RequirePackage[T1]{fontenc}%  Codificación T1 para las tipografías.
 \IfFileExists{lmodern.sty}{\RequirePackage{lmodern}}{}
\fi

\if@exparriba
 \RequirePackage{zref-savepos}[2016/05/21]%  Para guardar la posición en 'Y'.
\fi

\if@reporte
 \RequirePackage{eso-pic}%  Para el comando \AddToShipoutPicture.
 \RequirePackage{zref-savepos}%  Para la firma, que debe ser cargado aquí porque \FirmaReporte no se ejecuta desde el preámbulo.
\fi

%% Comando para escribir el encabezado en la factura.
\newcommand\@EncabezadoFactura{%
 \ifdefvoid{\@Resumen}{\@EscribeDatos}{\@EscribeDatosResumen}%
 \vspace*{\@SeparaElementos}%
 \if@exparriba\else\vfill\fi}

%% Comando para escribir el encabezado en el reporte.
\newcommand\@EncabezadoReporte{%
 \vspace*{-\topskip}%
 \if@fondoreporte
  \if@fondoreportestar
  \else
   \vspace*{\@InicioReporte}%
  \fi
 \fi
 \@EscribeDatosReporte
 \@LetraReporte}

%% El ambiente 'factura', usando el paquete 'environ' para su definición, y el comando auxiliar \@FacturaAuxCmd.
%% Gracias a Heiko Oberdiek y David Carlisle (Thanks to Heiko Oberdiek and David Carlisle).
%% http://tex.stackexchange.com/questions/108565/know-the-cell-width-with-tabular-or-include-a-paragraph-box-without-specifying
\NewEnviron{factura}{%
 \expandafter\@FacturaAuxCmd\expandafter{\BODY}%
 \ifnum\value{page}=1\else\ClassError{factura}{** La factura ocupa mas que una pagina **}{}\fi
}

%% Comando auxiliar para agregar un carácter al final de cada línea en la descripción dentro del cuadro de la factura si ocupa ésta más de una línea.
%% Gracias a Gustavo Mezzetti y David Carlisle (Thanks to Gustavo Mezzetti and David Carlisle)
%% http://tex.stackexchange.com/questions/296035/insert-a-special-character-at-each-end-of-line-in-a-paragraph
%% http://tex.stackexchange.com/questions/248944/how-to-put-before-lines
\newcommand{\@DescripcionAuxCmd}[2]{%
 \immediate\write\@auxout{\gdef\noexpand\@TamDescrip{\the\linewidth}}% Para poder establecer la línea diagonal hay que saber el tamaño del campo de la descripción.
 \setbox0\hbox{\parbox[t]{\linewidth}{#1%
  \if@impdesc\hfill\ \@EscribeTipoDeImpuesto{#2}\fi%
  \par\global\count1=\prevgraf}}%
 \ifnum\count1 = 1
  #1%
  \if@impdesc\hfill\ \@EscribeTipoDeImpuesto{#2}\fi
 \else
  \parbox[t]{\linewidth-\wd\@CajaCaracterCR-\@SeparaFinLineaDesc}{%
   \David@XStart#1\David@XEnd
   \par
   \count0=\prevgraf
   \count2=\prevgraf
   \loop
    \ifnum\count0=\count2
     \if@impdesc
      \vskip-\baselineskip
      \mbox{}\hfill\rlap{\hspace*{\wd\@CajaCaracterCR}\hspace*{\@SeparaFinLineaDesc}\llap{\@EscribeTipoDeImpuesto{#2}}}%
     \fi
    \else
     \mbox{}\hfill\rlap{\hspace*{\@SeparaFinLineaDesc}\usebox{\@CajaCaracterCR}}%
    \fi
    \vskip-2\baselineskip
    \advance\count0 -1
    \ifnum\count0 > 0
   \repeat
   \kern\count2\baselineskip\mbox{}%
   \strut}%
 \fi}

%% Comandos auxiliares para colocar en \parbox cada celda.
\newcommand{\@NumItemAuxCmd}[1]{%
 \savebox{\@CajaPrueba}{#1}%
 \ifdim\wd\@CajaPrueba > \@TamNumItem \global\@TamNumItem=\wd\@CajaPrueba\fi
 \parbox[t]{\@TamNumItem}{#1}}

\newcommand{\@CantidadAuxCmd}[1]{%
 \savebox{\@CajaPrueba}{#1}%
 \ifdim\wd\@CajaPrueba > \@TamCantidad \global\@TamCantidad=\wd\@CajaPrueba\fi
 \parbox[t]{\@TamCantidad}{#1}}

\newcommand{\@PrecioUAuxCmd}[1]{%
 \savebox{\@CajaPrueba}{#1}%
 \ifdim\wd\@CajaPrueba > \@TamPrecioU \global\@TamPrecioU=\wd\@CajaPrueba\fi
 \parbox[t]{\@TamPrecioU}{#1}}

\newcommand{\@DescuentoAuxCmd}[1]{%
 \savebox{\@CajaPrueba}{#1}%
 \ifdim\wd\@CajaPrueba > \@TamDescuento \global\@TamDescuento=\wd\@CajaPrueba\fi
 \parbox[t]{\@TamDescuento}{#1}}

\newcommand{\@PrecioTAuxCmd}[1]{%
 \savebox{\@CajaPrueba}{#1}%
 \ifdim\wd\@CajaPrueba > \@TamPrecioT \global\@TamPrecioT=\wd\@CajaPrueba\fi
 \parbox[t]{\@TamPrecioT}{#1}}

%% Presentación de totales en modo de columnas.
\newcommand{\@EscribeTotalCol}[1]{%
 \expandafter\FPifeq\csname Desc#1\endcsname{0}%
  \if@ivaexpresado\@EscribeTotalColBI{#1}\fi
 \else
  \@EscribeTotalColSubt{#1}%
  \@EscribeTotalColDesc{#1}%
  \if@ivaexpresado\@EscribeTotalColBI{#1}\fi
 \fi}

%% Forma agupada para la presentación de totales en modo de columnas.
\newcommand{\@EscribeTotalColAgrupado}{%
 \if@Exento\if@DescE\@EscribeTotalColSubt{E}\fi\fi
 \if@BIR\if@DescR\@EscribeTotalColSubt{R}\fi\fi
 \if@DescG\@EscribeTotalColSubt{G}\fi
 \if@BIA\if@DescA\@EscribeTotalColSubt{A}\fi\fi
 \if@Exento\if@DescE\@EscribeTotalColDesc{E}\fi\fi
 \if@BIR\if@DescR\@EscribeTotalColDesc{R}\fi\fi
 \if@DescG\@EscribeTotalColDesc{G}\fi
 \if@BIA\if@DescA\@EscribeTotalColDesc{A}\fi\fi
 \if@ivaexpresado
  \if@Exento\@EscribeTotalColBI{E}\fi
  \if@BIR\@EscribeTotalColBI{R}\fi
  \@EscribeTotalColBI{G}%
  \if@BIA\@EscribeTotalColBI{A}\fi
  \if@BIR\@EscribeTotalColAlicuota{R}\fi
  \@EscribeTotalColAlicuota{G}%
  \if@BIA\@EscribeTotalColAlicuota{A}\fi
 \fi}

\newcommand{\@EscribeTotalColBI}[1]{%
 \@LetraTitTotales \csname @@BI#1\endcsname
  \ifx#1E%
  \else
   \if@G\ \hfill(\csname @Alicuota#1porc\endcsname\%)\else\mbox{}\fi
  \fi
 & \@LetraNumTotales\numprint{\csname BI#1\endcsname} \\}

\newcommand{\@EscribeTotalColAlicuota}[1]{%
 {\@LetraTitTotales \csname @@Alicuota#1\endcsname\ \hfill (\csname @Alicuota#1porc\endcsname\%)}
 & \@LetraNumTotales\numprint{\csname Alicuota#1\endcsname} \\}

\newcommand{\@EscribeTotalColSubt}[1]{%
 {\@LetraTitTotales \csname @@Subtotal#1\endcsname}
 & \@LetraNumTotales\numprint{\csname Subt#1\endcsname} \\}

\newcommand{\@EscribeTotalColDesc}[1]{%
 {\@LetraTitTotales \csname @@Descuento#1\endcsname
 \csname if@Desc#1num\endcsname \else \ \hfill (\csname @Descuento#1porc\endcsname\%)\fi}
 & \@LetraNumTotales\numprint{\csname Desc#1\endcsname} \\}

%% Presentación de los totales en modo filas.
\newcommand{\@EscribeTotalFilasBI}[1]{%
 \@EscribeTotalFilasBIizq{#1}: & \@EscribeTotalFilasBIder{#1}}

\newcommand{\@EscribeTotalFilasAlicuota}[1]{%
 \@EscribeTotalFilasAlicuotaizq{#1}: & \@EscribeTotalFilasAlicuotader{#1}}

\newcommand{\@EscribeTotalFilasDesc}[1]{%
 \@EscribeTotalFilasDescizq{#1}: & \@EscribeTotalFilasDescder{#1}}

\newcommand{\@EscribeTotalFilasSoloBI}[1]{%
 {\@LetraTitTotales\@EscribeTotalFilasBIizq{#1}:} {\@LetraNumTotales\@EscribeTotalFilasBIder{#1}}}

\newcommand{\@EscribeTotalFilasSoloDesc}[1]{%
 {\@LetraTitTotales\@EscribeTotalFilasDescizq{#1}:} {\@LetraNumTotales\@EscribeTotalFilasDescder{#1}}}

\newcommand{\@EscribeTotalFilasSoloAlicuota}[1]{%
 {\@LetraTitTotales\@EscribeTotalFilasAlicuotaizq{#1}:} {\@LetraNumTotales\@EscribeTotalFilasAlicuotader{#1}}}

\newcommand{\@EscribeTotalFilasBIizq}[1]{%
 \@LetraTitTotales\csname @@BI#1\endcsname
 \ifx#1G%
  \if@G \ (\@AlicuotaGporc\%)\fi%  Si hay otra B.I. que no sea general, escribimos el porcentaje explícito en la general.
 \else
  \ifx#1E%
  \else
  \ (\csname @Alicuota#1porc\endcsname\%)%
  \fi
 \fi}

\newcommand{\@EscribeTotalFilasBIder}[1]{%
 \@LetraNumTotales\numprint{\csname BI#1\endcsname}}

\newcommand{\@EscribeTotalFilasAlicuotaizq}[1]{%
 \@LetraTitTotales\csname @@Alicuota#1\endcsname \ (\csname @Alicuota#1porc\endcsname\%)}

\newcommand{\@EscribeTotalFilasAlicuotader}[1]{%
 \@LetraNumTotales\numprint{\csname Alicuota#1\endcsname}}

\newcommand{\@EscribeTotalFilasDescizq}[1]{%
 \@LetraTitTotales\csname @@Descuento#1\endcsname \ (\csname @Descuento#1porc\endcsname\%)}

\newcommand{\@EscribeTotalFilasDescder}[1]{%
 \@LetraNumTotales\numprint{\csname Desc#1\endcsname}}

\newcommand{\@EscribeTotalFilasAuxTotal}{\@LetraTitTotal\@@Total: & \@LetraNumTotal\numprint{\Total}}

\newcommand{\@EscribeTotalFilas}[2][]{%
 \begin{tabular}[b]{@{}l@{\extracolsep{1ex}}r@{}}% ¡Esta tabla tiene que abrir hacia abajo para que la separación entre las filas se
  \csname @EscribeTotalFilasBI\endcsname{#2}%
  \ifx#2E%
   \ifx#1T%
    \\[\@SeparaFilas]%
    \@EscribeTotalFilasAuxTotal
   \fi
  \else
   \\[\@SeparaFilas]%
   \csname @EscribeTotalFilasAlicuota\endcsname{#2}%
  \fi
 \end{tabular}}

\newcommand{\@GeneraCajasTotalesFilas}{%
 \if@Exento
  \newbox{\@CajaBIE}\newbox{\@CajaBIET}%
  \savebox{\@CajaBIE}{\@EscribeTotalFilasSoloBI{E}}%
  \savebox{\@CajaBIET}{\@EscribeTotalFilas[T]{E}}%
 \fi
 \if@BIR
  \addtocounter{@IVANoGeneral}{1}%
  \newbox{\@CajaBIR}\newbox{\@CajaAliR}\newbox{\@CajaBIAliR}%
  \savebox{\@CajaBIR}{\@EscribeTotalFilasSoloBI{R}}%
  \savebox{\@CajaAliR}{\@EscribeTotalFilasSoloAlicuota{R}}%
  \savebox{\@CajaBIAliR}{\@EscribeTotalFilas{R}}%
 \fi
 \newbox{\@CajaBIG}\newbox{\@CajaAliG}\newbox{\@CajaBIAliG}%
 \savebox{\@CajaBIG}{\@EscribeTotalFilasSoloBI{G}}%
 \savebox{\@CajaAliG}{\@EscribeTotalFilasSoloAlicuota{G}}%
 \savebox{\@CajaBIAliG}{\@EscribeTotalFilas{G}}%
 \if@BIA
  \addtocounter{@IVANoGeneral}{1}%
  \newbox{\@CajaBIA}\newbox{\@CajaAliA}\newbox{\@CajaBIAliA}%
  \savebox{\@CajaBIA}{\@EscribeTotalFilasSoloBI{A}}%
  \savebox{\@CajaAliA}{\@EscribeTotalFilasSoloAlicuota{A}}%
  \savebox{\@CajaBIAliA}{\@EscribeTotalFilas{A}}%
 \fi}

\newcommand{\@EscribeTotalesFilasGET}{%
 \hspace*{\@SepTotales}\usebox{\@CajaBIG}%
 \hspace*{\@SepTotales}\usebox{\@CajaAliG}%
 \if@Exento\hspace*{\@SepTotales}\usebox{\@CajaBIE}\fi
 \hspace*{\@SepTotales}\usebox{\@CajaTotal}%
 \if@centrado\hspace*{\@SepTotales}\fi}

\newcommand{\@EscribeTotalesFilasGxET}{%
 \if@BIR\hspace*{\@SepTotales}\usebox{\@CajaBIAliR}\fi
 \hspace*{\@SepTotales}\usebox{\@CajaBIAliG}%
 \if@BIA\hspace*{\@SepTotales}\usebox{\@CajaBIAliA}\fi
 \hspace*{\@SepTotales}\if@Exento\usebox{\@CajaBIET}\else\usebox{\@CajaTotal}\fi
 \if@centrado\hspace*{\@SepTotales}\fi}

\newcommand{\@EscribeTotalesFilasRGA}{%
 \hspace*{\@SepTotales}\usebox{\@CajaBIAliR}%
 \hspace*{\@SepTotales}\usebox{\@CajaBIAliG}%
 \hspace*{\@SepTotales}\usebox{\@CajaBIAliA}%
 \hspace*{\@SepTotales}}

\newcommand{\@EscribeTotalesFilasRGAET}{%
 \@EscribeTotalesFilasRGA
 \if@Exento\usebox{\@CajaBIET}\else\usebox{\@CajaTotal}\fi
 \if@centrado\hspace*{\@SepTotales}\fi}

%% Escribe la letra que designa al tipo de impuesto que aplica al ítem.
\NewDocumentCommand{\@EscribeTipoDeImpuesto}{m}{%
 % Hay que abrir un grupo de ejecución porque el cambio en la tipografía altera la celda.
 {\if@G
   \@LetraTipoIVA
   \ifx#1G\@DenomAlicuotaG\fi% Si tiene IVA general escribimos 'G'.
   \ifx#1E\@DenomAlicuotaE\fi% Si está exento escribimos '(E)'.
   \ifx#1R\@DenomAlicuotaR\fi% Si tiene IVA reducido escribimos 'R'.
   \ifx#1A\@DenomAlicuotaA\fi% Si tiene IVA adicional escribimos 'A'.
  \fi}}

%% Comando para poner en cero los contadores de los totales porque el ambiente de la factura se evalúa tres veces y los totales se sumarían todos tres veces.
\newcommand{\@ZERO}{%
 \FPset\BIG{0}\global\let\BIG\BIG
 \FPset\BIR{0}\global\let\BIR\BIR
 \FPset\BIA{0}\global\let\BIA\BIA
 \FPset\BIE{0}\global\let\BIE\BIE
 \FPset\SubtE{0}\global\let\SubtE\SubtE
 \FPset\SubtG{0}\global\let\SubtG\SubtG
 \FPset\SubtR{0}\global\let\SubtR\SubtR
 \FPset\SubtA{0}\global\let\SubtA\SubtA
 \FPset\SubtX{0}\global\let\SubtX\SubtX
 \FPset\DescE{0}\global\let\DescE\DescE
 \FPset\DescG{0}\global\let\DescG\DescG
 \FPset\DescR{0}\global\let\DescR\DescR
 \FPset\DescA{0}\global\let\DescA\DescA
 \FPset\DescX{0}\global\let\DescX\DescX
 \FPset\AlicuotaG{0}\global\let\AlicuotaG\AlicuotaG
 \FPset\AlicuotaR{0}\global\let\AlicuotaR\AlicuotaR
 \FPset\AlicuotaA{0}\global\let\AlicuotaA\AlicuotaA}

%% Comandos para calcular todos los totales parciales y el total general.
\newcommand{\@CalculaTotalesI}{%
 \FPifeq\SubtG{0}\else\@CalculaTotalesII{G}\fi
 \FPifeq\SubtR{0}\else\@CalculaTotalesII{R}\fi
 \FPifeq\SubtA{0}\else\@CalculaTotalesII{A}\fi
 \FPifeq\SubtE{0}\else\@CalculaTotalesII{E}\fi
 \FPupn\Total{\BIE{} \BIR{} + \BIG{} + \BIA{} + \AlicuotaR{} + \AlicuotaG{} + \AlicuotaA{} + \@DigitosMoneda{} round}%
 \global\let\Total\Total}

\newcommand{\@CalculaTotalesII}[1]{%
 % Sumamos al descuento.
 \expandafter\FPupn\csname Desc#1\endcsname{\csname @Descuento#1factor\endcsname{} \csname Subt#1\endcsname{} * \csname @Descuento#1num\endcsname{} + \@DigitosMoneda{} round}%
 \global\expandafter\let\csname Desc#1\expandafter\endcsname\csname Desc#1\endcsname
 % Sumamos a la base imponible.
 \expandafter\FPupn\csname BI#1\endcsname{\csname Desc#1\endcsname{} \csname Subt#1\endcsname{} - \@DigitosMoneda{} round}%
 \global\expandafter\let\csname BI#1\expandafter\endcsname\csname BI#1\endcsname
 \ifx#1E%
 \else{%
  % Sumamos a la alícuota.
  \expandafter\FPupn\csname Alicuota#1\endcsname{\csname BI#1\endcsname{} \csname @Impuesto#1\endcsname{} * \@DigitosMoneda{} round}%
  \global\expandafter\let\csname Alicuota#1\expandafter\endcsname\csname Alicuota#1\endcsname}%
 \fi}

%% Comandos auxiliares para poder evaluar la definición de las columnas en la tabla con un comando que se expande completamente.
\def\@FacturaAuxColumnasEval{
 % Primera línea, la más externa.
 \ifbool{SinLineasVertExt}{}{|}
 % Columna para el número del ítem, si aplica.
 \ifbool{NumItem}{c}{r@{\extracolsep{0pt}}}
 % Segunda línea, que sale solamente cuando se usa la opción 'numitem'
 \ifbool{NumItem}{\ifbool{SinLineasVertInt}{}{|}}{}
 % Columna 'X' con DCU, columna fantasma con 'sincantidad' y columna 'c' con CDU.
 \ifbool{PrimeroDescrip}{X}{
  \ifbool{SinCantidad}{l@{\extracolsep{0pt}}}{c}}
 % Tercera línea.
 \ifbool{SinCantidad}{}{\ifbool{SinLineasVertInt}{}{|}}
 % Columna 'c' con DCU, columna 'r' con DUC, columna 'X' sin espacio para 'sincantidad' y columna 'X' con CDU.
 \ifbool{DCU}{c}{
  \ifbool{DUC}{r}{
   \ifbool{SinCantidad}{X@{\extracolsep{0pt}}}{X}}}
 % Cuarta línea, que sale solamente cuando no se usa 'sincantidad'.
 \ifbool{SinCantidad}{}{\ifbool{SinLineasVertInt}{}{|}}
 % Columna 'c' para DUC y columna 'r' para cualquier otro caso (DCU, CDU y 'sincantidad').
 \ifbool{DUC}{c}{r}
 % Quinta línea.
 \ifbool{SinLineasVertInt}{}{|}
 % Columna 'c' para 'descuentos' y columna 'r' sin espacio si no hay descuentos individuales.
 \ifbool{Descuentos}{c}{r@{\extracolsep{0pt}}}
 % Sexta línea, que sale solamente cuando hay descuentos.
 \ifbool{Descuentos}{\ifbool{SinLineasVertInt}{}{|}}{}
 % Columna 'r' siempre.
 r
 % Séptima y última línea.
 \ifbool{SinLineasVertExt}{}{|}}

%% Comando auxiliar para abrir la tabla del cuadro de la factura y expandir completamente las columnas.
\edef\@FacturaAuxInicioCmd{\noexpand\begin{tabularx}{\textwidth}{\@FacturaAuxColumnasEval}}

%% Comando auxiliar para abrir el '\multicolumn' para los totales en el modo de columnas y expandir completamente las columnas cuando hay o no barras verticales.
\edef\@ColumnasMultiColumnTotalesAuxCmd{%
 \noexpand\multicolumn{6}{\ifbool{SinLineasVertExt}{}{|} r}\begingroup
   \noexpand\ifdim \noexpand\ht\noexpand\@CajaEspacioVacio=0pt
   \noexpand\else
    \noexpand\if@linea\noexpand\zsaveposx{LineaNodoBCoordX}\noexpand\zsaveposy{LineaNodoBCoordY}\noexpand\fi\noexpand\fi% Fijamos la posición (x,y) final para la línea ya que estaremos justo en el punto donde escribimos el total, y hasta allí llega la línea en el modo de columnas.
    \noexpand\begin{tabular}[b]{@{\noexpand\extracolsep{2\noexpand\tabcolsep}}lr \ifbool{SinLineasVertExt}{}{|}}}

%% Comando para hacer los cálculos sobre cada ítem y establecer las macros con el contenido de cada ítem introducido.
\newcommand{\@CalculaItem}[5]{%
 \addtocounter{@NumItem}{1}%
 % Calculamos.
 \FPupn\PrecioU{#4 \@DigitosMoneda{} round}%
 \ifx\\#5\\\FPset\Dcto{0}\else\FPupn\Dcto{#5 \@DigitosPorc{} round clip}\fi% Fijamos en 0 el descuento si no se especifica.
 \FPupn\PrecioT{100 \Dcto{} 100 - / #2 * \PrecioU{} * \@DigitosMoneda{} round}%
 \global\let\PrecioU\PrecioU
 \global\let\Dcto\Dcto
 \global\let\PrecioT\PrecioT
 % Suma el elemento actual al subtotal acumulado.
 \expandafter\FPupn\csname Subt#1\endcsname{\PrecioT{} \csname Subt#1\endcsname{} + \@DigitosMoneda{} round}%
 \global\expandafter\let\csname Subt#1\expandafter\endcsname\csname Subt#1\endcsname
 % Guardamos en macros cada elemento agregado a la factura; por ejemplo: \@Item@i@Cantidad contiene la cantidad que se introdujo para el primer ítem; así mismo con ii@, @iii@, y así mismo también con @Descripcion, @PrecioU, @Descuento y @PrecioT.
 \expandafter\gdef\csname @Item@\romannumeral\value{@NumItem}@Cantidad\endcsname{\numprint{#2}}%
 \expandafter\gdef\csname @Item@\romannumeral\value{@NumItem}@Descripcion\endcsname{#3}%
 \expandafter\global\expandafter\edef\csname @Item@\romannumeral\value{@NumItem}@PrecioU\endcsname{\noexpand\numprint{\PrecioU}}%
 \expandafter\global\expandafter\edef\csname @Item@\romannumeral\value{@NumItem}@Descuento\endcsname{\noexpand\numprint{\Dcto}}%
 \expandafter\global\expandafter\edef\csname @Item@\romannumeral\value{@NumItem}@PrecioT\endcsname{\noexpand\numprint{\PrecioT}}}

\gdef\@pruebaref#1{%
 \expandafter\ifx\csname @Etiqueta@#1\endcsname\relax
  \ClassWarning{factura}{La etiqueta `#1' no está definida}{}\ignorespaces
  \@pruebareffalse
 \else
  \@pruebareftrue
 \fi}

\gdef\itemref#1{%
 \ifbool{NumItem}{}{\ClassWarning{factura}{Es recomendable usar la opción 'numitem' para enumerar los ítems}{}}%
 \@pruebaref{#1}\if@pruebaref \csname @Etiqueta@#1\endcsname \fi}
\gdef\cantref#1{\@pruebaref{#1}\if@pruebaref \csname @Item@\expandafter\romannumeral\csname @Etiqueta@#1\endcsname @Cantidad\endcsname \fi}
\gdef\descref#1{\@pruebaref{#1}\if@pruebaref \csname @Item@\expandafter\romannumeral\csname @Etiqueta@#1\endcsname @Descripcion\endcsname \fi}
\gdef\puref#1{\@pruebaref{#1}\if@pruebaref \csname @Item@\expandafter\romannumeral\csname @Etiqueta@#1\endcsname @PrecioU\endcsname \fi}
\gdef\dctoref#1{\@pruebaref{#1}\if@pruebaref \csname @Item@\expandafter\romannumeral\csname @Etiqueta@#1\endcsname @Descuento\endcsname \fi}
\gdef\ptref#1{\@pruebaref{#1}\if@pruebaref \csname @Item@\expandafter\romannumeral\csname @Etiqueta@#1\endcsname @PrecioT\endcsname \fi}

\newcommand{\label@factura}[1]{%
 \expandafter\ifx\csname @Etiqueta@#1\endcsname\relax
  \expandafter\global\expandafter\edef\csname @Etiqueta@#1\endcsname{\arabic{@NumItem}}\ignorespaces
  \ClassInfo{factura}{Etiqueta `#1' definida para el ítem \arabic{@NumItem}}{}%
 \else
  \edef\@label@test@uno{\csname @Etiqueta@#1\endcsname}%
  \edef\@label@test@dos{\the@NumItem}%
  \ifx\@label@test@uno\@label@test@dos
  \else
   \ClassWarning{factura}{La etiqueta `#1' se definió más de una vez}{}\ignorespaces
  \fi
 \fi}

%% Comando auxiliar para la definición del ambiente de la factura; al final de este comando está el texto que va en el enddef del ambiente de la factura.
\newcommand{\@FacturaAuxCmd}[1]{%
 \if@exparriba
  \setlength{\@EspacioVacioInicial}{\zposy{EspacioVacioInicial}sp}%
  \setlength{\@EspacioVacioFinal}{\zposy{EspacioVacioFinal}sp}%
  \global\@EspacioVacioInicial=\@EspacioVacioInicial% ¿por qué tendré que globalizarlas?
  \global\@EspacioVacioFinal=\@EspacioVacioFinal
  \savebox{\@CajaEspacioVacio}{\parbox[b][\@EspacioVacioInicial-\@EspacioVacioFinal]{\@TamDescrip}{%
   \if@linea
    \if@lineacompleta
     \zsaveposy{LineaNodoBCoordY}%
    \else
     \if@lineahastatotal
     \else
      \zsaveposx{LineaNodoACoordX}\mbox{}\hfill \zsaveposx{LineaNodoBCoordX}\zsaveposy{LineaNodoBCoordY}%
     \fi
    \fi
   \fi}}%
  \ifdim \ht\@CajaEspacioVacio=0pt \global\@lineafalse \fi
 \fi

 \ifx\undefined\Total\relax\else\ClassError{factura}{** Parece ya haberse usado un entorno de factura **}{}\fi
 %
 % Comandos \David@SavePos, \David@XStart, \David@XEnd, \David@XPad, \David@XLeft y \David@XRight para poder manejar el salto de línea en las columnas adyacentes a la columna 'X' del tabularx (la descripción), cuando esta ocupa más que una línea.
 % Gracias a David Carlisle (Thanks to David Carlisle).
 % http://tex.stackexchange.com/questions/111203/tabularx-bottom-alignment-on-r-or-l-columns-when-x-column-wraps
 \def\David@SavePos##1{\leavevmode\pdfsavepos\write\@auxout{\gdef\noexpand##1{\the\pdflastypos sp}}}%
 \def\David@XStart{\expandafter\David@SavePos\csname save@start@\romannumeral\value{@NumItem}\endcsname}%
 \def\David@XEnd{\expandafter\David@SavePos\csname save@end@\romannumeral\value{@NumItem}\endcsname}%
 \def\David@XPad##1##2##3{%
  \vtop{%
   \baselineskip\normalbaselineskip
   ##2%
   \expandafter
   \ifx\csname save@start@##1\endcsname
    \relax
   \else
    \dimen@\csname save@start@##1\endcsname\relax
    \loop
     \ifdim\dimen@>\csname save@end@##1\endcsname
     \advance\dimen@-\baselineskip
     \settowidth{\@TempDimen}{##3}%
      \ifdim\@TempDimen=0pt\settowidth{\@TempDimen}{##2}\fi
     \hbox{\parbox{\@TempDimen}{\@CaracterCeldasVacias}}%
    \repeat
   \fi
   ##3}}%
 \def\David@XLeft##1{\David@XPad{\romannumeral\value{@NumItem}}{\hbox{##1}}{}}%
 \def\David@XRight##1{\David@XPad{\romannumeral\value{@NumItem}}{}{\hbox{##1}}}%
 %
 % Caja auxiliar para el caracter de retorno de carro y poder saber si tamaño en el campo de la descripción.
 \savebox{\@CajaCaracterCR}{\@LetraItems\@CaracterCR}
 %
 % Comando interno general para agregar cualquier ítem.
 \newcommand{\@ITEM}[5]{% 1. [R|G|A|E|X]; 2. cantidad; 3. descripción; 4. p/u; 5. dcto.
  \@CalculaItem{##1}{##2}{##3}{##4}{##5}%
  % Si no es el primer ítem, entonces hace falta \\ para terminar el ítem anterior.
  \ifnum\value{@NumItem}=1%
  \else
   \\
   \if@conlineasha\hline\fi% Líneas para separar cada ítem, si hiciera falta.
  \fi
  % Primer -opcional- campo: El número del ítem.
  \ifbool{NumItem}{\David@XLeft{\@NumItemAuxCmd{\mbox{}\hfill \@LetraNumeros \arabic{@NumItem}\hfill\mbox{}}}}{}%
  &
  % Segundo campo: Acá puede ir la cantidad (cdu) o la descripción (dcu y duc).
  \ifbool{SinCantidad}{}{%
   \ifbool{PrimeroDescrip}
   {\@DescripcionAuxCmd{##3}{##1}}% dcu y duc.
   {\David@XLeft{\@CantidadAuxCmd{\mbox{}\hfill \@LetraNumeros \numprint{##2}\hfill\mbox{}}}}}% cdu.
  &
  % Tercer campo: Acá puede ir la descripción (cdu), la cantidad (dcu), o el precio unitario (duc).
  \ifbool{PrimeroDescrip}{%
   \if@dcu
    \David@XRight{\@CantidadAuxCmd{\mbox{}\hfill \@LetraNumeros \numprint{##2}\hfill\mbox{}}}% dcu.
   \else
    \David@XRight{\@PrecioUAuxCmd{%
     \ifx##1X \hfill \@CaracterItemXVacio \hfill\mbox{}%
     \else
      \if@impdesc\else\@EscribeTipoDeImpuesto{##1}\fi \hfill \@LetraNumeros \numprint{\PrecioU}
     \fi}}% duc.
   \fi}
  {\@DescripcionAuxCmd{##3}{##1}}% cdu.
  &
  % Cuarto campo: Acá puede ir el precio unitario (cdu y dcu) o la cantidad (duc).
  \FPifeq\PrecioU{##4}\else\ClassWarning{factura}{** Se está introduciendo un precio con más de dos decimales: (##3 - ##4. Redondeado a \PrecioU) **}{}\fi% Advertimos cuando el precio unitario tiene más de dos decimales.
  \ifbool{SinCantidad}{}{%
   \if@duc
    \David@XRight{\@CantidadAuxCmd{\mbox{}\hfill \@LetraNumeros \numprint{##2}\hfill\mbox{}}}% duc.
   \else
    \David@XRight{\@PrecioUAuxCmd{%
     \ifx##1X \hfill \@CaracterItemXVacio \hfill\mbox{}%
     \else
      \if@impdesc\else\@EscribeTipoDeImpuesto{##1}\fi \hfill \@LetraNumeros \numprint{\PrecioU}
     \fi}}% dcu y cdu.
   \fi}%
  &
  % Quinto -opcional- campo: Descuento.
  \ifbool{Descuentos}{%
   \David@XRight{\@DescuentoAuxCmd{%
    \ifx##1X \hfill \@CaracterItemXVacio \hfill\mbox{}%
    \else
     \mbox{}\hfill \@LetraNumeros \numprint{\Dcto}\%\hfill\mbox{}%
    \fi}}}{}% Tenemos que usar un condicional booleano porque si no da problemas con el condicional \FPifeq.
  &
  % Sexto campo: El total.
  \David@XRight{\@PrecioTAuxCmd{%
   \ifx##1X \hfill \@CaracterItemXVacio \hfill\mbox{}%
   \else
    \if@impdesc\else\@EscribeTipoDeImpuesto{##1}\fi \hfill \@LetraNumeros \numprint{\PrecioT}
   \fi}}%
  % Escribimos al csv.
  \if@csv
   \ifbool{SinCantidad}
    {\if@descuentos
      \immediate\write\csv{"\unexpanded{##3}","\Dcto","\PrecioT","##1"}%
     \else
      \immediate\write\csv{"\unexpanded{##3}","\PrecioT","##1"}%
     \fi}
    {\if@cdu
      \if@descuentos
       \immediate\write\csv{"##2","\unexpanded{##3}","\PrecioU","\Dcto","\PrecioT","##1"}%
      \else
       \immediate\write\csv{"##2","\unexpanded{##3}","\PrecioU","\PrecioT","##1"}%
      \fi
     \fi
     \if@dcu
      \if@descuentos
       \immediate\write\csv{"\unexpanded{##3}","##2","\PrecioU","\Dcto","\PrecioT","##1"}%
      \else
       \immediate\write\csv{"\unexpanded{##3}","##2","\PrecioU","\PrecioT","##1"}%
      \fi
     \fi
     \if@duc
      \if@descuentos
       \immediate\write\csv{"\unexpanded{##3}","\PrecioU","##2","\Dcto","\PrecioT","##1"}%
      \else
       \immediate\write\csv{"\unexpanded{##3}","\PrecioU","##2","\PrecioT","##1"}%
      \fi
     \fi}%
   \fi}%
 %
 % Usamos la definición de \label@factura dentro del entorno de la factura para que sea local aquí nada más.
 \let\label\label@factura
 \@LetraItems% Este es el tipo de letra que tendrán los ítems, y en este tipo de letra se define el \baselineskip de toda la factura.
 \@FacturaAuxInicioCmd
 \ifbool{SinLineasHoriExt}{}{\hline}%
 \@ZERO
 % Estamos en el número del ítem, si aplicara.
 \if@lineadesdeinicio \hspace*{-\tabcolsep}\zsaveposx{LineaNodoACoordX}\hspace*{\tabcolsep}\fi
 \ifbool{NumItem}{\@NumItemAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@NumItem \hfill\mbox{}}}{}%
 &
 % Avanzamos a la cantidad, o la descripción.
 \ifbool{SinCantidad}{}{\ifbool{PrimeroDescrip}{\@DescripcionAuxCmd{\@LetraTitCuadro \@@Descripcion}{}}{\@CantidadAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@Cantidad \hfill\mbox{}}}}%
 &% Avanzamos hasta la descripción, la cantidad o el precio unitario.
 \ifbool{SinCantidad}{\@DescripcionAuxCmd{\@LetraTitCuadro \@@Descripcion}{}}
  {\if@cdu \@DescripcionAuxCmd{\@LetraTitCuadro \@@Descripcion}{}\fi
   \if@dcu \@CantidadAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@Cantidad \hfill\mbox{}}\fi
   \if@duc \@PrecioUAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@PrecioU \space (\Moneda)\hfill\mbox{}}\fi}%
 &% Avanzamos hasta el precio unitario, o la cantidad, o columna fantasma cuando es 'sincantidad'.
 \ifbool{SinCantidad}{}
  {%
   \mbox{}\hfill
   \if@duc
    \@CantidadAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@Cantidad \hfill\mbox{}}%
   \else
    \@PrecioUAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@PrecioU \space (\Moneda)\hfill\mbox{}}%
   \fi}%
 &% Avanzamos hasta el descuento, que puede o no existir.
 \if@descuentos \@DescuentoAuxCmd{\mbox{}\hfill \@LetraTitCuadro \@@Descuento \hfill\mbox{}}\fi
 &% Avanzamos hasta el precio total.
 \@PrecioTAuxCmd{\mbox{}\hfill \@LetraTitCuadro \ifbool{SinCantidad}{\@@Precio}{\@@PrecioT}\space (\Moneda)\hfill\mbox{}}%
 \if@lineacompleta \hspace*{\tabcolsep}\zsaveposx{LineaNodoBCoordX}\hspace*{-\tabcolsep}\fi
 \\
 \ifbool{SinLineasHoriInt}{}{\hline}%
 %
 #1% Aquí entran todos los items que el usuario declara dentro del ambiente.
 \\% El último fin de línea se hace aquí.
 \if@conlineasha\hline\fi% Se verifica si hace falta una línea horizontal o no.
 \if@filas
  % Esto en lugar de \if@exparriba para que no se haga una linea vacía en la tabla cuando la caja está vacía.
  \ifdim \ht\@CajaEspacioVacio=0pt
   \ifbool{SinLineasHoriExt}{}{\if@conlineasha\else\hline\fi}% Verificamos si hay que poner la línea horizontal. Si está 'conlineasha' ya salió debido a esta opción.
  \else
   \ifbool{PrimeroDescrip}{&\usebox{\@CajaEspacioVacio}&&&&\\}{&&\usebox{\@CajaEspacioVacio}&&&\\}%
   \ifbool{SinLineasHoriExt}{}{\hline}% Siempre que hay relleno se pone la línea acá.
  \fi
 \else
  \ifbool{SinLineasHoriInt}{}{\if@conlineasha\else\hline\fi}% Línea que cierra los ítems en la tabla.
  % Agregamos el espacio espúreo.
  \ifdim \ht\@CajaEspacioVacio=0pt
  \else
   % Rellenamos la tabla con espacio espúreo, y le agregamos las lineas externas, si aplica.
   \ifbool{SinLineasVertExt}{\multicolumn{6}{c}{\usebox{\@CajaEspacioVacio}}}{\multicolumn{6}{|c|}{\usebox{\@CajaEspacioVacio}}}\\
  \fi
  % Modo de columnas: Abrimos la tabla para escribir los totales, y le agregamos las líneas verticales externas, si aplica.
  \@ColumnasMultiColumnTotalesAuxCmd
  \@CalculaTotalesI
  \if@agrupado
   \@EscribeTotalColAgrupado
  \else
   \if@Exento \@EscribeTotalCol{E}\fi
   \if@BIR\@EscribeTotalCol{R}\if@ivaexpresado\@EscribeTotalColAlicuota{R}\fi\fi
   \@EscribeTotalCol{G}\if@ivaexpresado\@EscribeTotalColAlicuota{G}\fi
   \if@BIA\@EscribeTotalCol{A}\if@ivaexpresado\@EscribeTotalColAlicuota{A}\fi\fi
  \fi
  \if@ivaexpresado\cline{2-2}\fi
  \hfill \@LetraTitTotal\@@Total & \@LetraNumTotal\numprint{\Total}\\
  \end{tabular}\endgroup
  \\
  \ifbool{SinLineasHoriExt}{}{\hline}%
 \fi
 \end{tabularx}%
 %
 \if@filas
  \@CalculaTotalesI
  \@LetraNumTotales
  \vspace*{\@SeparaElementos}\par
  \if@exparriba\else\vfill\fi
  \@GeneraCajasTotalesFilas
  \newbox{\@CajaTotal}%
  \savebox{\@CajaTotal}{{\@LetraTitTotal\@@Total}: \@LetraNumTotal\numprint{\Total}}%
  %
  \ifnum \value{@IVANoGeneral}=0%
   \newbox{\@CajaGET}%
   \savebox{\@CajaGET}{\@EscribeTotalesFilasGET}%
   \ifdim \the\wd\@CajaGET < \textwidth
    \parbox{\textwidth}{\@EscribeTotalesFilasGET}%
   \else
    \hspace*{\@SepTotales}%
    \usebox{\@CajaBIAliG}\hspace*{\@SepTotales}%
    \if@Exento\usebox{\@CajaBIET}\else\usebox{\@CajaTotal}\fi
    \if@centrado\hspace*{\@SepTotales}\fi
   \fi
  \fi
  \ifnum \value{@IVANoGeneral}=1%
   \newbox{\@CajaGxET}%
   \savebox{\@CajaGxET}{\@EscribeTotalesFilasGxET}%
   \ifdim \the\wd\@CajaGxET < \textwidth
    \@EscribeTotalesFilasGxET
   \else
    \hspace*{\@SepTotales}%
    \if@BIR\usebox{\@CajaBIAliR}\hspace*{\@SepTotales}\fi
    \usebox{\@CajaBIAliG}\hspace*{\@SepTotales}%
    \if@BIA\usebox{\@CajaBIAliA}\hspace*{\@SepTotales}\fi
    \\[\@SeparaFilas]\mbox{}%
    \if@centrado\hspace*{\@SepTotales}\else\hfill\fi
    \if@Exento\usebox{\@CajaBIE}\hspace*{\@SeparaMinTotales}\fi\usebox{\@CajaTotal}%
    \if@centrado\hspace*{\@SepTotales}\fi
   \fi
  \fi
  \ifnum \value{@IVANoGeneral}=2%
  \newbox{\@CajaRGAET}%
  \savebox{\@CajaRGAET}{\@EscribeTotalesFilasRGAET}%
   \ifdim \the\wd\@CajaRGAET < \textwidth
    \@EscribeTotalesFilasRGAET
   \else
    \newbox{\@CajaRGA}%
    \savebox{\@CajaRGA}{\@EscribeTotalesFilasRGA}%
    \ifdim \the\wd\@CajaRGA < \textwidth
     \@EscribeTotalesFilasRGA
     \\[\@SeparaFilas]\mbox{}%
     \if@centrado\hspace*{\@SepTotales}\else\hfill\fi
     \if@Exento\usebox{\@CajaBIE}\hspace*{\@SeparaMinTotales}\fi\usebox{\@CajaTotal}%
     \if@centrado\hspace*{\@SepTotales}\fi
    \else% Aquí casi cualquier cosa tiene aspecto feo.
     \ClassWarning{factura}{Es mejor no usar la opción de totalización en filas en este caso, o disminuir los tamaños de los tipos de letra para la totalización}{}%
     \centering{%
      \begin{tabular}{r@{\hspace*{\@SeparaMinTotales}}l}
       \usebox{\@CajaBIAliR} & \usebox{\@CajaBIAliA} \\[\@SeparaFilas]
       \usebox{\@CajaBIAliG} & \if@Exento\usebox{\@CajaBIET}\else\usebox{\@CajaTotal}\fi
      \end{tabular}}%
    \fi
   \fi
  \fi
 \fi
 \par
 \if@exparriba
  \vspace*{-\@EspacioVacioInicial}%
  \vspace*{\@EspacioVacioFinal}%
  \zsaveposy{EspacioVacioInicial}%
 \fi
 \vfill
 \if@exparriba\zsaveposy{EspacioVacioFinal}\fi
 \vspace*{\@SeparaElementos}\par}

 \ifbool{SinCantidad}
 % Definamos todos los comandos \Item***.
 {%
  \if@descuentos
   \newcommand{\Item}[3]{\@ITEM{G}{1}{#1}{#2}{#3}}% Ítem normal.
   \newcommand{\ItemR}[3]{\global\@BIRtrue\global\@Gtrue\@ITEM{R}{1}{#1}{#2}{#3}}% Ítem con IVA reducido.
   \newcommand{\ItemA}[3]{\global\@BIAtrue\global\@Gtrue\@ITEM{A}{1}{#1}{#2}{#3}}% Ítem con IVA reducido.
   \newcommand{\ItemE}[3]{\global\@Exentotrue\global\@Gtrue\@ITEM{E}{1}{#1}{#2}{#3}}% Ítem con IVA reducido.
  \else
   \newcommand{\Item}[2]{\@ITEM{G}{1}{#1}{#2}{0}}% Ítem normal.
   \newcommand{\ItemR}[2]{\global\@BIRtrue\global\@Gtrue\@ITEM{R}{1}{#1}{#2}{0}}% Ítem con IVA reducido.
   \newcommand{\ItemA}[2]{\global\@BIAtrue\global\@Gtrue\@ITEM{A}{1}{#1}{#2}{0}}% Ítem con IVA reducido.
   \newcommand{\ItemE}[2]{\global\@Exentotrue\global\@Gtrue\@ITEM{E}{1}{#1}{#2}{0}}% Ítem con IVA reducido.
  \fi
  \newcommand{\ItemX}[1]{\@ITEM{X}{1}{#1}{0}{0}}% Ítem sin precio.
  \let\ItemG\Item
  \if@csv
   \if@descuentos
    \immediate\write\csv{"\@@Descripcion","\@@Descuento","\@@Precio \space (\Moneda)"}
   \else
    \immediate\write\csv{"\@@Descripcion","\@@Precio \space (\Moneda)"}
   \fi
  \fi}
 {%
  \if@descuentos
   \newcommand{\Item}[4]{\@ITEM{G}{#1}{#2}{#3}{#4}}% Ítem normal.
   \newcommand{\ItemR}[4]{\global\@BIRtrue\global\@Gtrue\@ITEM{R}{#1}{#2}{#3}{#4}}% Ítem con IVA reducido.
   \newcommand{\ItemA}[4]{\global\@BIAtrue\global\@Gtrue\@ITEM{A}{#1}{#2}{#3}{#4}}% Ítem con IVA adicional.
   \newcommand{\ItemE}[4]{\global\@Exentotrue\global\@Gtrue\@ITEM{E}{#1}{#2}{#3}{#4}}% Ítem exento de IVA.
  \else
   \newcommand{\Item}[3]{\@ITEM{G}{#1}{#2}{#3}{0}}% Ítem normal.
   \newcommand{\ItemR}[3]{\global\@BIRtrue\global\@Gtrue\@ITEM{R}{#1}{#2}{#3}{0}}% Ítem con IVA reducido.
   \newcommand{\ItemA}[3]{\global\@BIAtrue\global\@Gtrue\@ITEM{A}{#1}{#2}{#3}{0}}% Ítem con IVA adicional.
   \newcommand{\ItemE}[3]{\global\@Exentotrue\global\@Gtrue\@ITEM{E}{#1}{#2}{#3}{0}}% Ítem exento de IVA.
  \fi
  \newcommand{\ItemX}[2]{\@ITEM{X}{#1}{#2}{0}{0}}% Ítem sin precio.
  \let\ItemG\Item
  \if@csv
   \if@cdu
    \if@descuentos
     \immediate\write\csv{"\@@Cantidad","\@@Descripcion","\@@PrecioU \space (\Moneda)","\@@Descuento","\@@PrecioT \space (\Moneda)"}%
    \else
     \immediate\write\csv{"\@@Cantidad","\@@Descripcion","\@@PrecioU \space (\Moneda)","\@@PrecioT \space (\Moneda)"}%
    \fi
   \fi
   \if@dcu
    \if@descuentos
     \immediate\write\csv{"\@@Descripcion","\@@Cantidad","\@@PrecioU \space (\Moneda)","\@@Descuento","\@@PrecioT \space (\Moneda)"}%
    \else
     \immediate\write\csv{"\@@Descripcion","\@@Cantidad","\@@PrecioU \space (\Moneda)","\@@PrecioT \space (\Moneda)"}%
    \fi
   \fi
   \if@duc
    \if@descuentos
     \immediate\write\csv{"\@@Descripcion","\@@PrecioU \space (\Moneda)","\@@Cantidad","\@@Descuento","\@@PrecioT \space (\Moneda)"}%
    \else
     \immediate\write\csv{"\@@Descripcion","\@@PrecioU \space (\Moneda)","\@@Cantidad","\@@PrecioT \space (\Moneda)"}%
    \fi
   \fi
  \fi}

\if@factura
 % Los descuentos totales no son compatibles -y no sé si lo serán- con el modo de totalización en filas.
 \if@filas
  \if@Descuentos
   \ClassWarning{factura}{La opción 'filas' no es compatible con los descuentos totales; sin efecto opción 'filas'.}{}
   \@filasfalse
  \fi
 \fi
 \if@cotizacion\def\@Denominacion{\@@DenomCotiza}\else\def\@Denominacion{\@@DenomFactura}\fi%  Fijamos la denominación del documento paras las cotizaciones o facturas, que son casos particulares del modo 'factura'.
 \AtEndPreamble{%  La geometría debe aplicarse aquí.
  \expandafter\geometry\expandafter{\@GeometriaFactura}}
 \AtBeginDocument{%  Aquí en la factura hay que cargar el estilo de página del reporte, pero con la factura se aplicará \thispagestyle{empty} luego, aunque quedará \pagestyle aplicado desde ahora.
  \if@fondoreportestar
   \pagestyle{soloabajo}%  Cuando el fondo es con '*' la información de página va sólo abajo.
  \else
   \pagestyle{plain}%  Esto aplica para cuando se define un fondo sin '*' y cuando no se define fondo en el reporte.
  \fi
  \addtolength{\@PosFechaX}{\oddsidemargin+1in}%  Le sumamos el margen izquierdo a las posiciones de las cosas; importante que se haga en un \AtBeginDocument antes de que empiecen a escribirse otras cosas que también se agregan a \AtBeginDocument.
  \addtolength{\@PosDenomX}{\oddsidemargin+1in}%
  \addtolength{\@PosControlX}{\oddsidemargin+1in}%
  \addtolength{\@PosCondX}{\oddsidemargin+1in}%
  \addtolength{\@PosFirmasXuno}{\oddsidemargin+1in}%
  \setlength{\parindent}{0pt}%
  \setlength{\lineskip}{0pt}%
  \setlength{\parskip}{0pt plus 1pt}%
  \expandafter\setlength{\@SepTotales}{\the\@SeparaMinTotales plus 1fill}% \@SeparaMinTotales es el mínimo espacio entre los totales en el modo 'filas', y SepTotales es una dimensión interna, estirable, con ese como su mínimo.
  \thispagestyle{empty}%
  \pagenumbering{roman}%
  \@EncabezadoFactura}
  \if@reporte
   \expandafter\AtBeginShipoutNext
  \else
   \expandafter\AtEndDocument%  Para la factura no puede estar lo que viene en un \AtBeginDocument porque se inserta un espacio extra que genera una página extra; tiene que estar en \AtEndDocument.
  \fi
   {%
   \@CargaFondoFactura
   \@PosicionaFecha
   \if@denom\@PosicionaDenom\fi
   \if@confirmas\@PosicionaFirmas\fi
   \if@concondiciones\@PosicionaCondiciones\fi
   \if@prefactura\@PosicionaNumControl\fi}

 \if@linea
  \RequirePackage{zref-savepos}%  Para determinar las coordenadas de la línea.
  \RequirePackage{eso-pic}%  Para poder usar \AtBeginShipoutNext porque si no se hace en el 'shipout' de la página se genera un espacio en blanco extra.
  \AtBeginShipoutNext{\if@linea\@DibujaLinea\fi}
   \if@filas
    \ifbool{SinLineasVertInt}{\@lineacompletatrue}
   \else
    \@lineahastatotaltrue\@lineadesdeiniciotrue
   \fi
 \fi

 %% El comando para la descripción del servicio prestado.
 \NewDocumentCommand{\Descripcion}{+m}{%
  \@LetraDescripcion
  \begin{tikzpicture}
   \node[draw=black, fill=white, inner sep=\@SeparaInternaDescrip, line width=\@GrosorLineaDescrip, rounded corners=\@EsquinaLineaDescrip,
         copy shadow={top color=black, bottom color=black, shadow xshift=\@SombraDescrip, shadow yshift=-\@SombraDescrip}]{%
    \ifbool{ExpAbajo}
     {\parbox[t][\textheight-\pagetotal-2\@SeparaInternaDescrip-\@GrosorLineaDescrip-\@SombraDescrip]
      {\textwidth-2\@SeparaInternaDescrip-\@GrosorLineaDescrip-\@SombraDescrip}}%
     {\parbox[t]{\textwidth-\@SombraDescrip-2\@SeparaInternaDescrip-2\@GrosorLineaDescrip}}%
    {\setlength{\parindent}{0.5cm}%
     \setlength{\parskip}{2pt plus 8pt}%
     \ifbool{ExpAbajo}{\vfill}{}%
      #1%
     \ifbool{ExpAbajo}{\vfill}{}}};%
  \end{tikzpicture}
  \par\vspace*{\@SombraDescrip}}%
\else
 \RenewEnviron{factura}{%
  \@ZERO
  \let\label\label@factura
  \let\@ITEM\@CalculaItem
  \BODY
  \@CalculaTotalesI}
 \NewDocumentCommand{\Descripcion}{+m}{}
\fi

\if@reporte
 \ifdefvoid{\@InfoPagina}{\let\@InfoPagina\@InfoPaginaNoTitulo}{}%
 \if@factura
 \else
  \AtEndPreamble{%
  \expandafter\geometry\expandafter{\@GeometriaReporte}}%  La geometría del reporte debe aplicarse aquí cuando sólo hay reporte, así se puede establecer el tamaño del papel.
 \fi
 \NewEnviron{reporte}{%
  \if@factura
   \expandafter\newgeometry\expandafter{\@GeometriaReporte}\cleardoublepage%  La geometría debe aplicarse aquí cuando también hay factura, pero no se puede cambiar el tamaño del papel.
  \fi
  \fancy@setoffs
  \@CargaFondoReporte
  \@EncabezadoReporte
  \ifdefvoid{\@EstiloPagReporteResto}{%
   \if@fondoreportestar%  Si no usamos \EstiloPagReporte entonces se fijará 'soloabajo' cuando se use \FondoReporte* para que sólo use marcas de pie de página, y si no se usó \FondoReporte* entonces se fijará 'plain' que usa cabeceras y piés de página.
    \pagestyle{soloabajo}%
   \else
    \pagestyle{plain}%
   \fi}
   {\pagestyle{\@EstiloPagReporteResto}}%  Si usamos \EstiloPagReporte en su argumento obligatorio entonces fijamos ese estilo de página.
  \ifdefvoid{\@EstiloPagReporteUno}{%
   \if@fondoreporte%  Si no le damos a \EstiloPagReporte su argumento opcional, entonces se fijará 'solonumpag' como el estilo de página para la primera página, pero solamente si usamos \FondoReporte, ya que el estilo de página predeterminado al usar \FondoReporte* ya se acaba de fijar y no necesita el caso especial de la primera hoja (\thispagestyle).
    \if@fondoreportestar
    \else
     \thispagestyle{solonumpag}%
    \fi
   \fi}
   {\thispagestyle{\@EstiloPagReporteUno}}%  Si usamoe el argumento opcional de \EstiloPagReporte establecemos ese estilo de página.
  \pagenumbering{arabic}%
  \setlength{\parindent}{0.666cm}%
  \setlength{\parskip}{4pt plus 6pt minus 2pt}% separación entre párrafos en el reporte.
  \vskip\baselineskip
  \BODY\clearpage}% espacio antes de empezar con el reporte, después del título -si lo hubiera-.
\else
 \NewEnviron{reporte}{}
\fi

%% Comando para el diseño de la forma libre.
\newcommand{\@CargaFondoFactura}{%
 \if@fondofactura
  \begin{textblock*}{\paperwidth}(0pt,0pt)%
   \includegraphics{\@FondoFactura}%
  \end{textblock*}%
 \fi}

%% Comando para el fondo del reporte.
\newcommand{\@CargaFondoReporte}{%
 \begin{textblock*}{\paperwidth}(0pt,0pt)% Tuve que abrir el textblock* aquí para que aplique siempre; de esta manera se corrige un defecto que se produce cuando se usa \vspace* al inicio de la página (dentro de \@EncabezadoReporte).
  \if@fondoreporte
   \if@fondoreportestar
    \AddToShipoutPictureBG{\includegraphics{\@FondoReporte}}%
   \else
     \noindent\includegraphics{\@FondoReporte}%
   \fi
  \fi
 \end{textblock*}}

%% Comando que coloca los espacios para firmar.
\newcommand{\@PosicionaFirmas}{%
 \savebox{\@CajaFirmas}{%
  \parbox{\textwidth+\oddsidemargin+1in-\@PosFirmasXuno-\@PosFirmasXdos}{\@EstiloFirmas}}%
 \ifbool{FirmasYnegativo}
  {\addtolength{\@PosFirmasY}{\paperheight-\ht\@CajaFirmas-\dp\@CajaFirmas}}
  {}%
 \begin{textblock*}{\wd\@CajaFirmas}(\@PosFirmasXuno,\@PosFirmasY)%
  \usebox{\@CajaFirmas}%
 \end{textblock*}}

%% Comando que coloca las condiciones del documento.
\newcommand{\@PosicionaCondiciones}{%
 \savebox{\@CajaCond}{%
  \parbox{\textwidth+\oddsidemargin+1in-\@PosCondX}{\@EstiloCondiciones}}%
 \ifbool{CondYnegativo}
  {\addtolength{\@PosCondY}{\paperheight}}% Aquí la caja abre hacia abajo, por eso no restamos el tamaño de la caja (\ht y \dp).
  {}%
 \begin{textblock*}{\wd\@CajaCond}(\@PosCondX,\@PosCondY)%
  \usebox{\@CajaCond}%
 \end{textblock*}}

%% Comando que coloca el número de control.
\newcommand{\@PosicionaNumControl}{%
 \savebox{\@CajaControl}{\@EstiloNumControl}%
 \ifbool{ControlXnegativo}
  {\addtolength{\@PosControlX}{\textwidth-\wd\@CajaControl}}
  {}%
 \ifbool{ControlYnegativo}
  {\addtolength{\@PosControlY}{\paperheight-\ht\@CajaControl-\dp\@CajaControl}}
  {}%
 \begin{textblock*}{\wd\@CajaControl}(\@PosControlX,\@PosControlY)%
  \usebox{\@CajaControl}%
 \end{textblock*}}

%% Comando que coloca la denominación del documento.
\newcommand{\@PosicionaDenom}{%
 \savebox{\@CajaDenom}{\@EstiloDenom}%
 \ifbool{DenomXnegativo}
  {\addtolength{\@PosDenomX}{\textwidth-\wd\@CajaDenom}}
  {}%
 \ifbool{DenomYnegativo}
  {\addtolength{\@PosDenomY}{\paperheight-\ht\@CajaDenom-\dp\@CajaDenom}}
  {}%
 \begin{textblock*}{\wd\@CajaDenom}(\@PosDenomX,\@PosDenomY)%
  \usebox{\@CajaDenom}%
 \end{textblock*}}

%% Comando que coloca la fecha.
\newcommand{\@PosicionaFecha}{%
 \savebox{\@CajaFecha}{\@EstiloFecha}%
 \ifbool{FechaXnegativo}
  {\addtolength{\@PosFechaX}{\textwidth-\wd\@CajaFecha}}
  {}%
 \ifbool{FechaYnegativo}
  {\addtolength{\@PosFechaY}{\paperheight-\ht\@CajaFecha-\dp\@CajaFecha}}
  {}%
 \begin{textblock*}{\wd\@CajaFecha}(\@PosFechaX,\@PosFechaY)%
  \usebox{\@CajaFecha}%
 \end{textblock*}}

%% Comando que coloca la identificación del reporte al inicio.
\newcommand{\@EscribeDatosReporte}{%
 {\@LetraEncReporte
  \setlength{\parindent}{0pt}%
  {\bfseries \@@Proveedor} \@Proveedor \par
  {\bfseries \@@Cliente} \@RazonSocial \par
  \ifdefvoid{\@Contacto}{}{{\bfseries \@@Contacto} \@Contacto \par}%
  \ifdefvoid{\@TituloReporte}{}{\vspace*{\baselineskip}{\@LetraTitReporte \centering \@TituloReporte \par}}}}

%% Comando que coloca la caja con los datos del cliente.
\newcommand{\@EscribeDatos}{%
 {\@LetraEncFactura% Abrimos un nuevo grupo para que el cambio de tipografía sea sólo local.
  \begin{tikzpicture}
   \node[draw=black, fill=white, inner sep=\@SeparaInternaEncabez, line width=\@GrosorLineaEncabez, rounded corners=\@EsquinaLineaEncabez,
         copy shadow={top color=black, bottom color=black, shadow xshift=\@SombraEncabez, shadow yshift=-\@SombraEncabez}]{%
   \parbox{\textwidth-\@SombraEncabez-2\@SeparaInternaEncabez-\@GrosorLineaEncabez}{%
    \hfill {\@LetraTitEnc \@@Datos} \hfill \mbox{}\par
    {\bfseries \@@RazonSocial} \@RazonSocial
    \dotfill
    {\bfseries \@@RIF} {\ttfamily \@RIF}%
    \par
    \ifdefvoid{\@Contacto}{}{{\bfseries \@@Contacto} \@Contacto \par}%
    {\bfseries \@@Direccion} \@Direccion
    \par
    {\bfseries \@@Telefono} {\ttfamily \@Telefono}%
    \ifdefvoid{\@Email}{}{\hspace*{0.666em}\@CaracterSeparaTelefonoEmail\hspace*{0.666em}{\bfseries \@@Email} {\ttfamily \@Email}}}};%
  \end{tikzpicture}%
  \par\vspace*{\@SombraEncabez}}}%  Para que textblock* esté en modo vertical.

%% Comandos auxiliares para los datos y el resumen.
\newcommand{\@DatosAux}{%
 \vfill
 \hfill {\@LetraTitEnc \@@Datos}\hfill \mbox{}\par
 {\bfseries \@@RazonSocial} \@RazonSocial \par
 {\bfseries \@@RIF} {\ttfamily \@RIF} \par
 \ifdefvoid{\@Contacto}{}{{\bfseries \@@Contacto} \@Contacto \par}%
 {\bfseries \@@Direccion} \@Direccion \par
 {\bfseries \@@Telefono} {\ttfamily \@Telefono} \hfill \par
 \ifdefvoid{\@Email}{}{{\bfseries \@@Email} {\ttfamily \@Email}}%
 \vfill}

\newcommand{\@ResumenAux}{%
 \hfill {\@LetraTitEnc \@@Resumen}\hfill \mbox{}%
 \vfill\@Resumen\vfill}

%% Comando que coloca las dos cajas del encabezado: la de los datos del cliente y la del resumen.
\newcommand{\@EscribeDatosResumen}{%
 {\@LetraEncFactura% Abrimos un nuevo grupo para que el cambio de tipografía sea sólo local.
  \savebox{\@CajaDatos}{%
   \parbox[t]{\textwidth/2-\@SeparaEncabez/2-2\@SeparaInternaEncabez-\@GrosorLineaEncabez-\@SombraEncabez}{%
    \@DatosAux}}%
  \savebox{\@CajaResumen}{%
   \parbox[t]{\textwidth/2-\@SeparaEncabez/2-2\@SeparaInternaEncabez-\@GrosorLineaEncabez-\@SombraEncabez}{%
    \@ResumenAux}}%
  \setlength{\@TamDatos}{\ht\@CajaDatos+\dp\@CajaDatos}%
  \setlength{\@TamResumen}{\ht\@CajaResumen+\dp\@CajaResumen}%
  \ifdim\@TamDatos>\@TamResumen
   \setlength{\@TamFinalEncabez}{\@TamDatos}%
  \else
   \setlength{\@TamFinalEncabez}{\@TamResumen}%
  \fi
  \begin{tikzpicture}
   \node[draw=black, fill=white, inner sep=\@SeparaInternaEncabez, line width=\@GrosorLineaEncabez, rounded corners=\@EsquinaLineaEncabez,
         copy shadow={top color=black, bottom color=black, shadow xshift=\@SombraEncabez, shadow yshift=-\@SombraEncabez}]{%
    \parbox[t][\@TamFinalEncabez]{\textwidth/2-\@SeparaEncabez/2-2\@SeparaInternaEncabez-\@GrosorLineaEncabez-\@SombraEncabez}{%
    \@DatosAux}};%
  \end{tikzpicture}%
  \hspace*{\@SeparaEncabez}\hspace*{\@SombraEncabez}%
  \begin{tikzpicture}
   \node[draw=black, fill=white, inner sep=\@SeparaInternaEncabez, line width=\@GrosorLineaEncabez, rounded corners=\@EsquinaLineaEncabez,
         copy shadow={top color=black, bottom color=black, shadow xshift=\@SombraEncabez, shadow yshift=-\@SombraEncabez}]{%
    \parbox[t][\@TamFinalEncabez]{\textwidth/2-\@SeparaEncabez/2-2\@SeparaInternaEncabez-\@GrosorLineaEncabez-\@SombraEncabez}{%
     \@ResumenAux}};%
  \end{tikzpicture}%
  \par\vspace*{\@SombraEncabez}}}%  El \par es para que textblock* esté en modo vertical.

%% Comando que coloca la línea diagonal.
\newcommand{\@DibujaLinea}{%
 \@LetraItems% Volvemos a fijar el \baselineskip de la tabla.
 \setlength{\@LineaNodoXo}{\zposx{LineaNodoACoordX} sp}%
 \setlength{\@LineaNodoYo}{\zposy{LineaNodoBCoordY} sp}%
 \setlength{\@LineaNodoXf}{\zposx{LineaNodoBCoordX} sp}%
 \setlength{\@LineaNodoYf}{\zposy{LineaNodoBCoordY} sp}%
 \addtolength{\@LineaNodoYo}{\@EspacioVacioInicial-\@EspacioVacioFinal}%
 \if@filas
 \else
  \if@DescG \addtolength{\@LineaNodoYo}{2\baselineskip}\fi
  \if@DescR \if@BIR \addtolength{\@LineaNodoYo}{2\baselineskip}\fi\fi
  \if@DescA \if@BIA \addtolength{\@LineaNodoYo}{2\baselineskip}\fi\fi
  \if@DescE \if@Exento \addtolength{\@LineaNodoYo}{2\baselineskip}\fi\fi
  \addtolength{\@LineaNodoYo}{\baselineskip/2}%
  \if@ivaexpresado
   \addtolength{\@LineaNodoYo}{2\baselineskip}%
   \if@BIR\addtolength{\@LineaNodoYo}{2\baselineskip}\fi
   \if@BIA\addtolength{\@LineaNodoYo}{2\baselineskip}\fi
   \if@Exento\addtolength{\@LineaNodoYo}{\baselineskip}\fi
  \fi
 \fi
 \if@linea
  \begin{textblock*}{\paperwidth-\@LineaNodoXo}(\@LineaNodoXo,\paperheight-\@LineaNodoYo)%
   \begin{tikzpicture}%
    \draw (\@LineaNodoXo,\@LineaNodoYo) -- (\@LineaNodoXf,\@LineaNodoYf);%
   \end{tikzpicture}%
  \end{textblock*}%
 \fi}

%% Escribimos los totales al archivo csv.
\newcommand{\@EscribeTotalesEnCSV}{%
 \if@csv
  \if@Exento
   \if@DescE
    \immediate\write\csv{Totales: \@@SubtotalE: \Moneda \SubtE}%
    \immediate\write\csv{Totales: \@@DescuentoE: \Moneda \DescE}%
   \fi
   \immediate\write\csv{Totales: \@@BIE: \Moneda \BIE}%
  \fi
  \if@BIR
   \if@DescE
    \immediate\write\csv{Totales: \@@SubtotalR: \Moneda \SubtR}%
    \immediate\write\csv{Totales: \@@DescuentoR: \Moneda \DescR}%
   \fi
   \immediate\write\csv{Totales: \@@BIR: \Moneda \BIR}%
  \immediate\write\csv{Totales: \@@AlicuotaR: \Moneda \AlicuotaR}%
  \fi
  \if@DescG
   \immediate\write\csv{Totales: \@@SubtotalG: \Moneda \SubtG}%
   \immediate\write\csv{Totales: \@@DescuentoG: \Moneda \DescG}%
  \fi
  \immediate\write\csv{Totales: \@@BIG: \Moneda \BIG}%
  \immediate\write\csv{Totales: \@@AlicuotaG: \Moneda \AlicuotaG}%
  \if@BIA
   \if@DescA
    \immediate\write\csv{Totales: \@@SubtotalA: \Moneda \SubtA}%
    \immediate\write\csv{Totales: \@@DescuentoA: \Moneda \DescA}%
   \fi
   \immediate\write\csv{Totales: \@@BIA: \Moneda \BIA}%
   \immediate\write\csv{Totales: \@@AlicuotaA: \Moneda \AlicuotaA}%
  \fi
  \immediate\write\csv{Totales: \@@Total: \Moneda \Total}%
  \immediate\closeout\csv
 \fi}

%% Hubo que redefinir \cleardoublepage agregándole \thispagestyle{empty} porque si no queda una página en blanco con cabeceras de página usando twoside.
\def\cleardoublepage{%
 \clearpage
 \if@twoside
  \ifodd\c@page
   \else
    \hbox{}\thispagestyle{empty}\newpage
    \if@twocolumn
     \hbox{}\newpage
    \fi
   \fi
 \fi}

\let\headrulebak\headrule%  Para poder volver a poner la línea de fancyhdr si algún estilo de página la quitó.

\endinput
%%
%% End of file `factura.cls'.
