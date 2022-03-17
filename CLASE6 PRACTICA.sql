/*1. Indicar por jornada la cantidad de docentes que dictan y sumar los costos. (agrupar por jornada, cantidad y suma)
Esta información sólo se desea visualizar para las asignaturas de desarrollo web. (aplico un where)
El resultado debe contener todos los valores registrados en la primera tabla (left join)
Renombrar la columna del cálculo de la cantidad de docentes como cant_docentes y la columna de la suma de los costos como suma_total */

SELECT * FROM Asignaturas;
SELECT * FROM Staff;

SELECT
	Asignaturas.Jornada,
	COUNT (Staff.DocentesID) AS cant_docentes,
	SUM (Asignaturas.Costo) AS suma_total
FROM Asignaturas
LEFT JOIN Staff
ON Asignaturas.AsignaturasID = Staff.Asignatura
WHERE Asignaturas.Nombre = 'Desarrollo Web'
GROUP BY Asignaturas.Jornada;

/*2. Se requiere saber el id del encargado, el nombre, el apellido y cuantos son los docentes
que tiene asignados cada encargado. Luego filtrar los encargados que tienen como resultado 0
ya que son los encargados que NO tienen asignado un docente. Renombrar el campo de la operación
como Cant_Docentes. */

SELECT * FROM Encargado;
SELECT * FROM Staff;

SELECT
	E.Encargado_ID,
	E.Nombre,
	E.Apellido,
	COUNT ( S.DocentesID ) AS Cant_Docentes
FROM Encargado AS E
LEFT JOIN Staff AS S
ON E.Encargado_ID = S.Encargado
GROUP BY
	E.Encargado_ID,
	E.Nombre,
	E.Apellido
HAVING 	COUNT ( S.DocentesID )>0
ORDER BY Cant_Docentes ;

/* 3. Se requiere saber todos los datos de asignaturas que no tienen un docente asignado. */

SELECT * FROM Staff;
SELECT * FROM Asignaturas;

SELECT A.*, S.DocentesID
FROM Staff AS S
RIGHT JOIN Asignaturas AS A
ON S.Asignatura = A.AsignaturasID
WHERE S.Asignatura IS NULL;

/* 4. Se quiere conocer la siguiente información de los docentes.
El nombre completo concatenar el nombre y el apellido. Renombrar NombresCompletos, el documento,
hacer un cálculo para conocer los meses de ingreso. Renombrar meses_ingreso, el nombre del encargado.
Renombrar NombreEncargado, el teléfono del encargado. Renombrar TelefonoEncargado,
el nombre del curso o carrera, la jornada y el nombre del área.
Solo se desean visualizar los que llevan más de 3 meses.Ordenar los meses de ingreso de mayor a menor. */

SELECT * FROM Staff;
SELECT * FROM Encargado;
SELECT * FROM Asignaturas;
SELECT *FROM Area;

SELECT
	CONCAT( Staff.Nombre,' ',Staff.Apellido ) AS NombresCompletos,
	Staff.Documento,
	DATEDIFF( MONTH, Staff.[Fecha Ingreso], GETDATE() ) AS meses_ingreso,
	Encargado.Nombre AS NombreEncargado,
	Encargado.Telefono AS TelefonoEncargado,
	Asignaturas.Nombre,
	Asignaturas.Jornada,
	Area.Nombre
FROM Staff
LEFT JOIN Encargado
ON Staff.Encargado = Encargado.Encargado_ID
LEFT JOIN Asignaturas
ON Staff.Asignatura = Asignaturas.AsignaturasID
LEFT JOIN Area
ON Asignaturas.Area = Area.AreaID
WHERE DATEDIFF( MONTH, Staff.[Fecha Ingreso], GETDATE() ) > 3
ORDER BY meses_ingreso DESC;

/* 5. Se requiere una listado unificado con nombre, apellido, documento y
una marca indicando a que base corresponde. Renombrar como Marca */

SELECT * FROM Staff;
SELECT * FROM Encargado;
SELECT * FROM Estudiantes;

SELECT
	Nombre, Apellido, Documento, 'Encargado' AS Marca
FROM Encargado
UNION
SELECT
	Nombre, Apellido, Documento, 'Staff' AS Marca
FROM Staff
UNION
SELECT
	Nombre, Apellido, Documento, 'Estudiantes' AS Marca
FROM Estudiantes;

--Union une las tablas,puede crear una columna pero siempre manteniendo la estrcutura y el orden de los datos, pequeñas diferencias,
--es como un copiar y pegar a continuacion.

