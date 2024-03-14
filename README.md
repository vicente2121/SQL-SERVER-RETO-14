# Proyecto de Modelado de Datos y ETL

¡Bienvenido a nuestro proyecto de Modelado de Datos y ETL!

## Introducción

¿Quién dice que con nuestros retos de datos no puedes dar tus primeros pasos en ETL con Integration Services? En este proyecto, no solo te adentrarás en el mundo del ETL, sino que también crearás consultas en SQL, procesos y modificaciones con T-SQL.

Ayer exploramos las maravillas de Python Power Query en Excel y hasta nos sumergimos en dinámicas fascinantes. Hoy, continuamos nuestro viaje con SQL y SSIS, modelado de datos en SQL Server y, al final, respondiendo preguntas de negocio con T-SQL.

¡¡¡¡Empecemos!!!!

## Paso 1: Creación del ETL
![3](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/3e6489ff-6a6d-4a41-9526-ed7ba4a0c4ef)

Creamos un ETL hiper básico, pero que para muchos que son nuevos y otros que no podrán colocar en práctica (que de todo se aprende y tenemos que aprender). Pero primero es importar nuestro fichero Excel así, con Integration Services, hacia SQL Server.
![1](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/90e8ff22-5238-4b9c-ac75-f37322c3b2ca)

1. Creamos un flujo de datos.
2. Luego creamos un conector de Excel.
3. Realizamos las conversiones de los datos para que tengan el efecto deseado.
4. Procedemos a crear la conexión a nuestra base de datos.
5. Ejecutamos y cargamos los datos.
![2](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/b49d6e02-4133-4513-96a4-3fbd83b694ae)

## Paso 2: Creación de Dimensiones

En la tabla de aterrizaje (Recuerda que el código estará en mi GitHub lo que realicé en T-SQL), procedemos a la fase dos.

1. **Dim_Empresa**: Creamos la dimensión para las combinaciones únicas de Empresa y empresa bandera.
2. **Dim_Ubicacion**: Creamos la dimensión para las combinaciones únicas de Direccion, Localidad, Provincia, Region, Latitud, Longitud.
3. **Dim_Horario**: Creamos la dimensión para las combinaciones únicas de Horario_Tipo.
4. **Dim_Calendario**: Creamos la dimensión calendario automatizado para las fechas.

## Paso 3: Creación de la Tabla de Hechos

Creamos la tabla de hechos final, do![7](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/567a4897-cdb9-4b3c-80ae-056fc96c8954)
nde almacenamos los datos aditivos y de fecha para responder preguntas de negocio en T-SQL.
![8](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/279b9b31-c61e-4513-b628-9ddc450702f9)

## Actualización de Claves Foráneas
![10](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/5fb55bd4-5b14-469b-9202-7d59eeeeac83)

Vinculamos las claves foráneas de las dimensiones con la tabla de hechos para completar nuestro modelo dimensional.

## Limpieza Final

Eliminamos las columnas categóricas y dejamos solo las llaves foráneas y los datos aditivos para obtener un modelo dimensional completo y limpio.

![11](https://github.com/vicente2121/SQL-SERVER-RETO-14/assets/72566296/45dc284e-af18-430a-8061-8d00305af1e9)


¡Gracias por unirte a este emocionante viaje de modelado de datos y ETL!
