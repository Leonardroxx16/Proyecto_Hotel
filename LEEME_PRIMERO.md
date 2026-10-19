# LibreHotel MVC para Apache NetBeans

Aplicación web Java de LimaStay Intelligence reorganizada con Modelo Vista Controlador, Singleton, Repository y Strategy. Incluye persistencia real en H2, gestión hotelera y pruebas automatizadas. No requiere MySQL, XAMPP ni una cuenta de hosting para ejecutarse localmente.

## Inicio rápido en Windows

1. Descomprime todo el ZIP en una carpeta propia. No ejecutes archivos dentro del ZIP.
2. Instala o selecciona **JDK 17**. Comprueba en una terminal que `java -version` indique 17 o posterior. Para trabajar en NetBeans utiliza un JDK completo.
3. Abre `iniciar-local.bat`. El script compila y arranca el Tomcat integrado en modo local. No descarga dependencias.
4. Espera el mensaje **LibreHotel listo** y abre **http://localhost:8080/LibreHotelMvc/**.
5. Ingresa con una cuenta de la tabla siguiente. Mantén abierta la consola mientras utilizas el sistema. Para detenerlo, presiona **Ctrl+C** y espera a que termine.

En Linux o macOS: `bash iniciar-local.sh`. La aplicación se enlaza únicamente a 127.0.0.1 en este modo.

| Perfil | Correo | Contraseña inicial |
| --- | --- | --- |
| Administración | admin@limastay.pe | AdminHotel2026! |
| Recepción | recepcion.miraflores@limastay.pe | Recepcion2026! |
| Operaciones | operaciones@limastay.pe | Operaciones2026! |

Son cuentas ficticias para evaluación local. Cambia sus contraseñas en **Usuarios** y retira el bloque de credenciales de la vista de acceso antes de publicar. El rol se obtiene de la base de datos, no de un botón del formulario.

## Abrir y ejecutar en Apache NetBeans

1. Utiliza una instalación de Apache NetBeans con soporte **Java Web y EE** y Maven. Habilita ese soporte desde Plugins si no aparece.
2. Selecciona **Archivo → Abrir proyecto** y abre la carpeta `LibreHotelMvc` que contiene `pom.xml`. Se reconoce como proyecto **Maven Web Application**. La estructura Ant anterior fue sustituida por Maven; no es necesario crear un proyecto vacío ni copiar clases a mano.
3. En Servicios → Servidores agrega **Apache Tomcat 10.1.x** e indica la carpeta donde lo tengas instalado. El Tomcat integrado del script local funciona por separado; para el botón Ejecutar de NetBeans registra una instalación completa.
4. En Propiedades del proyecto selecciona **JDK 17** y el servidor Tomcat 10.1. Este proyecto usa `jakarta.servlet`, no `javax.servlet`; Tomcat 9 no corresponde a esta versión.
5. Ejecuta **Limpiar y construir**. Maven descarga las dependencias y plugins declarados la primera vez; necesita Internet o su caché local. Las pruebas usan una base en memoria y no alteran tus datos.
6. Presiona **Ejecutar proyecto (F6)**. La dirección esperada es `http://localhost:8080/LibreHotelMvc/`; revisa la URL y el puerto que indique NetBeans.

Si Maven no tiene conexión, el script `compilar.bat` genera el WAR con las dependencias incluidas. La carpeta `dist` contiene también un WAR ya compilado. Puedes desplegarlo en Tomcat 10.1 mientras resuelves la configuración de Maven.

**No ejecutes el servidor de NetBeans y el integrado a la vez sobre la misma base y puerto.** Detén uno antes de iniciar el otro.

## Datos locales

En el primer arranque se crea automáticamente:

- Windows: `C:\Users\TU_USUARIO\LibreHotel\data\librehotel.mv.db`.
- Linux/macOS: `~/LibreHotel/data/librehotel.mv.db`.

Se crean tablas y datos ficticios de ejemplo: tres usuarios, un huésped, un proveedor, cuatro habitaciones y horarios para los próximos quince días. No se fabrican reservas ni ingresos en el dashboard. Los cambios se mantienen al reiniciar; el inicializador no restablece contraseñas ni reintroduce datos eliminados lógicamente.

En `database` se incluyen además **librehotel.mv.db**, una base física de ejemplo lista para usar, **librehotel-demo.sql**, su copia SQL, y **schema.sql**, el esquema. La ejecución normal crea su propia base en la ruta anterior. Para emplear la base física incluida, con la aplicación detenida copia `database/librehotel.mv.db` a esa ruta **solo si todavía no existe una base allí**. Otra opción es configurar su ruta según `docs/BASE_DE_DATOS.md`. Los horarios de la copia corresponden a la fecha de preparación; puedes crear horarios nuevos desde el módulo de aforo.

## Qué puedes probar

1. Inicia sesión como administrador.
2. Registra o edita un huésped.
3. En Reservas, consulta fechas y cantidad de personas; crea una reserva pendiente.
4. Abre la reserva y registra un pago ya recibido para confirmarla. Este registro no ejecuta un cobro bancario.
5. Asigna un horario de spa, gimnasio o restaurante comprendido en la estadía.
6. Prueba cancelar la reserva: libera habitación y cupos; si había un pago, queda como reembolso pendiente de gestión manual.
7. Consulta el reporte de pagos, descarga CSV y realiza un respaldo SQL.
8. Crea un usuario de prueba y falla tres veces su contraseña. Desde otra cuenta administrativa puedes desbloquearlo en Usuarios.

## Contenido y comprobaciones

- `src/main/java`: código Java separado por responsabilidades.
- `src/main/webapp/WEB-INF/views`: vistas JSP protegidas frente al acceso directo.
- `src/main/resources/db/schema.sql`: esquema que realmente ejecuta el inicializador.
- `src/test/java`: pruebas JUnit 5 con H2 real en memoria.
- `dist/LibreHotelMvc.war`: aplicación compilada para Tomcat.
- `tools/lib`: dependencias incluidas para compilar y arrancar sin descargas.
- `original/login-original.html`: pantalla recibida, conservada como referencia; no forma parte de la aplicación activa.
- `docs`: arquitectura, base de datos, alcance, respaldo, pruebas y despliegue posterior.

Pruebas: `compilar.bat test` en Windows o `bash compilar.sh test` en Linux/macOS. `probar.bat` mantiene el resultado en pantalla. Las instrucciones y resultados de validación se encuentran en `docs/PRUEBAS.md`.

## Alcance del componente predictivo

La estrategia `RuleBasedRiskStrategy` produce una **estimación demostrativa por reglas**. No se proporcionaron registros históricos etiquetados ni un modelo entrenado. No se acredita el objetivo de exactitud mayor al 85 % del borrador. La interfaz y la documentación identifican esa limitación. `RiskStrategy` permite incorporar después un modelo validado conservando el resto del sistema.

No se ha publicado en Internet. Para el paso posterior consulta `docs/MIGRACION.md`.
