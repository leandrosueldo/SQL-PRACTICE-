--CREAMOS BASE DE DATOS Y TABLAS INSERTANDO VALORES

CREATE DATABASE CLASE_8;

CREATE TABLE Estados(IDEstado int NOT NULL IDENTITY PRIMARY KEY, 
Nombre varchar(50) NOT NULL);

INSERT INTO Estados(Nombre)
VALUES ('Ingresado en Planta'),('En Camino'),('Espera en sucursal'),('Entregado');

CREATE TABLE Envios(IDEnvio varchar(20) NOT NULL PRIMARY KEY,
IDEstado int FOREIGN KEY REFERENCES Estados(IDEstado), 
Descripcion varchar(50) NOT NULL,
FechaEnvio datetime NOT NULL);

INSERT INTO Envios (IDEnvio, IDEstado,Descripcion, FechaEnvio)
VALUES ('EN-283450-AR',1,'Paquete fragil','02-25-2021'),
('EX-394899-CO',1,' No colocarlo en lugares humedos', '02-25-2021'),
('EN-485970-CL',2,' Presenta golpes','04-21-2021'),
('EX-298895-UY',3,' Caja Vacia tiene poco peso', '05-17-2021'), 
('EX-308498-MX',4,' Presenta abolladura', GETDATE()); --trae la fecha actual

SELECT * FROM Envios

SELECT * FROM Estados

--FUNCIONES ESCALARES 

SELECT *FROM Envios
WHERE LEFT (IDENVIO,2)='EX'; --Los que empiezan con ex. Con el numero digo la cantidad de caracteres 

SELECT *FROM Envios
WHERE LEFT (IDENVIO,2)='EN'; --Los que empiezan con en. Extraen caracteres.

SELECT *FROM Envios
WHERE RIGHT(IDENVIO,2)='AR'; --Los que terminan con ar. Lo uso como condicion con where para filtar.

SELECT IDEnvio, IDEstado, CONCAT(IDEnvio, IDEstado) AS Tracking --Concatenar columnas  como nueva 
FROM Envios;

SELECT CONCAT(LEFT(IDEnvio,2),(RIGHT(IDEnvio,2))) AS TipoEnvio, IDEstado, Descripcion
FROM Envios; --Concateno con left y right 

SELECT CONCAT(LEFT(IDEnvio,2), ' - ', (RIGHT(IDEnvio,2))) AS TipoEnvio, IDEstado, Descripcion
FROM Envios; --Puedo añadir guion o espacio

SELECT REPLACE(IDEnvio,'-', ' ') AS Nuevo_seguimiento, IDEnvio FROM Envios; --Reemplazamos guion por espacio. 
--Reemplaza cualquier elemento en la consulta, no cambia estructura. Elijo la otra original para comparar el cambio.

SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IDEnvio,'AR', ' Argentina'), 'CL', ' Chile'), 'UY', 'Uruguay'),'CO', 'Colombia'), 'MX', 'Mexico') AS NuevoID, IDEnvio
FROM Envios; --Hacemos replace anidados, varios replace de varios elmentos en la misma consulta. Siempre anidados, no hacer de forma individual.
--Hacerlo siempre ordenado, sino puede generar reemplazos en filas incorrectas

SELECT UPPER(Descripcion) AS Mayus --Cambiar a mayusculas 
FROM Envios;

SELECT LOWER(Descripcion) AS Minus --Cambiar a minusculas. Podemos seleccionar solo una parte.
FROM  Envios;

SELECT TRIM(Descripcion) --Elimina espacios de un campo (suele ser por errores de desarrollo)
AS Comentario FROM Envios;

--FECHAS

SELECT YEAR(FechaEnvio) AS Anio, FechaEnvio --Extrae el año de una fecha 
FROM Envios;

SELECT MONTH(FechaEnvio) AS Mes, FechaEnvio FROM Envios; --Extrae mes

SELECT DAY(FechaEnvio)  AS Dia, FechaEnvio --Extrae dia 
FROM Envios;

SELECT IDEnvio, YEAR(FechaEnvio) as Anio, MONTH(FechaEnvio) as Mes, DAY(FechaEnvio) as Dia FROM Envios; --Armo columnas por separado

SELECT IDEnvio, DATENAME(MONTH,FechaEnvio) AS Nombre_Mes FROM Envios; --Cambia el valor por escrito, nombre del mes 

SELECT FechaEnvio, DATEADD(MONTH,1,FechaEnvio) AS Mes_Proyeccion FROM Envios; --Corre un momento el mes, se puede aplicar para dia y año 
--y la cantidad de veces que se quiera avanzar. Se puede hacer negativo e ir para atras.

SELECT IDEnvio, FechaEnvio, DATEDIFF(MONTH, '05-17-2021', FechaEnvio) AS Diferencia FROM Envios; --Cuanto meses pasaron segun esa fecha, diferencia de tiempo. Puede ser en dias y años.

--REDONDEOS (Decimales siempre con punto)

SELECT FLOOR (22.65) AS Ejemplo; --Para abajo

SELECT CEILING (22.65) AS Ejemplo; --Para arriba 

SELECT ROUND (22.57,1) AS EJEMPLO; --Redondeo real y cantidad de decimales que quiero

SELECT ABS (-22.5) AS Ejemplo; --Valor absoluto

SELECT CAST(FechaEnvio AS varchar(50)) AS Nuevo_TipoDatos, FechaEnvio --Cambiar tipo de dato de la columna, en este caso a varchar. Nos cambia de fehca a alfanumerico. 
FROM Envios; --Nos modifica la visualizacion del dato

--SUBCONSULTA.
--Permite buscar valores de otras tablas que no conocemos exactamente, podemos hacer un select dentro de otro.

SELECT * FROM Envios
WHERE IDEstado = 4; --Esto es lo que quiero hacer, puedo hacerlo si ya conozco que el que busco es el estado 4

SELECT * FROM Envios
WHERE IDEstado =(Select IDEstado from Estados --Si no se que quiero el 4, hago una subconsulta que me diga cual es el id que necesito para mi consulta original
WHERE Nombre = 'Entregado'); --Select dentro de select, me busca la condicion que necesito.

Select IDEstado from Estados --Esta subconsulta me devuelve el estado 4, es lo mismo, por eso la reemplazo en la consulta original.
WHERE Nombre = 'Entregado'














