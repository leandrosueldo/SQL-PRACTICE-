--Indicar cuantos cursos y carreras  tiene el área de Data. Renombrar la nueva columna como cant_asignaturas.

SELECT * FROM Asignaturas;
SELECT * FROM Area;

SELECT Tipo, COUNT(AsignaturasID) AS Cant_asignaturas FROM Asignaturas 
WHERE Area = (SELECT AreaID FROM Area WHERE Nombre = 'Data')
GROUP BY Tipo; --SUBCONSULTA

SELECT Tipo, COUNT(AsignaturasID) AS Cant_asignaturas FROM Asignaturas 
WHERE Area = 5
GROUP BY Tipo; --ES LO MISMO

--Se requiere saber cual es el nombre, el documento y el teléfono de los estudiantes que son profesionales en agronomía
--y que nacieron entre el año 1970 y el año 2000.

SELECT * FROM Estudiantes

SELECT Nombre, Documento, Telefono, [Fecha de Nacimiento] FROM Estudiantes 
WHERE Profesion = 6 AND YEAR ([Fecha de Nacimiento]) BETWEEN 1970 AND 2000; --Seleciona solo el año de le fecha para la condicion

SELECT Nombre, Documento, Telefono, [Fecha de Nacimiento] FROM Estudiantes 
WHERE Profesion = (SELECT ProfesionesID FROM Profesiones 
WHERE Profesiones = 'Agronomo Agronoma') AND YEAR ([Fecha de Nacimiento]) BETWEEN 1970 AND 2000; --ES LO MISMO

--Se requiere un listado de los docentes que ingresaron en el año 2021 y concatenar los campos nombre y apellido. 
--El resultado debe utilizar un separador: guión (-). Ejemplo: Elba-Jimenez.
--Renombrar la nueva columna como Nombres_Apellidos. Los resultados de la nueva columna deben estar en mayúsculas.

SELECT * FROM STAFF

SELECT [Fecha Ingreso], UPPER (CONCAT(Nombre,'-', Apellido)) AS Nombres_Apellidos 
FROM Staff WHERE YEAR([Fecha Ingreso]) = 2021;

--Indicar la cantidad de encargados de docentes y de tutores. 
--Renombrar la columna como CantEncargados. Quitar la palabra ”Encargado ”en cada uno de los registros.
--Renombrar la columna como NuevoTipo.

SELECT * FROM ENCARGADO

SELECT COUNT(Encargado_ID) AS CantEncargados, REPLACE(Tipo, 'Encargado', '') AS NuevoTipo 
FROM Encargado GROUP BY REPLACE(Tipo, 'Encargado', '') ; --USO EL GROUP BY CON TODO LO QUE USE ANTES, NO ME DEJA PONER EL NOMBRE DE LA NUEVA COLUMNA

--Indicar cual es el precio promedio de las carreras y los cursos por jornada. 
--Renombrar la nueva columna como Promedio. Ordenar los promedios de Mayor a menor

SELECT AVG (Costo) AS Promedio, Tipo, Jornada FROM Asignaturas 
GROUP BY Tipo, Jornada ORDER BY Promedio DESC;

--Se requiere calcular la edad de los estudiantes en una nueva columna.
--Renombrar a la nueva columna Edad. Filtrar solo los que son mayores de 18 años. Ordenar de Menor a Mayor

SELECT [Fecha de Nacimiento], Nombre, YEAR(GETDATE()) - YEAR([Fecha de Nacimiento]) AS Edad 
FROM Estudiantes WHERE YEAR(GETDATE()) - YEAR([Fecha de Nacimiento]) > 18 ORDER BY Edad ASC;

--Se requiere saber el Nombre,el correo, la camada y la fecha de ingreso de personas del staff
--que contienen correo .edu y su DocenteID se mayor o igual que 100 

SELECT Nombre, Correo, Camada, [Fecha Ingreso] FROM Staff 
WHERE RIGHT (Correo,4)= '.edu' AND DocentesID >100 ;

--Se requiere conocer el documento, el domicilio el código postal y el nombre de los primeros estudiantes
--que se registraron en la plataforma.

SELECT TOP(5) Documento, Domicilio, [Codigo Postal], Nombre, [Fecha Ingreso]
FROM Estudiantes ORDER BY [Fecha Ingreso]; --SIEMPRE HAY QUE ORDENAR EL TOP POR UNA CONDICION

--Indicar el nombre apellido y documento de los docentes y tutores que tienen asignaturas “UX”

SELECT Nombre, Apellido, Documento, Asignatura FROM Staff 
WHERE Asignatura BETWEEN 1 AND 16

