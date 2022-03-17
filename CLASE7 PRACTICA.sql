--EJERCICIO 1---
/*Análisis de docentes por camada: 
Número de documento, nombre de docente y camada para identificar la camada mayor y 
la menor según el numero de la  camada. 
Número de documento, nombre de docente y camada para identificar 
la camada con fecha de ingreso Mayo 2021. 
Agregar un campo indicador que informe cuales son los registros ”mayor o menor” y
los que son “Mayo 2021” y ordenar el listado de menor a mayor por camada*/

SELECT * FROM Staff;

SELECT TOP(1) Documento, Nombre, Camada --uso top para ver maximo o minomo (es una opcion mas rara)
FROM Staff
ORDER BY Camada ASC;

SELECT TOP(1) Documento, Nombre, Camada --al reves 
FROM Staff
ORDER BY Camada ASC;

SELECT  Documento, Nombre, Camada --nos trae el mes y año especifico
FROM Staff
WHERE YEAR([Fecha Ingreso])= 2021 AND MONTH([Fecha Ingreso])= 05 ;

--si quiero toda la query junta con union, no puedo usar distintos order, solo uno al final
--en union siempre respetar estructura y tipo de dato de todas las columnas

SELECT
S.Documento,
S.nombre,
S.Camada,
'Mayor' AS Marca_Indicador --columna para indicar que dato es 
FROM STAFF AS S
WHERE S.Camada = (SELECT MAX(Camada) FROM Staff) --uso funcion max y min
UNION --pega la info de distintas consultas
SELECT
S.Documento,
S.nombre,
S.Camada,
'Menor' AS Marca_Indicador
FROM staff AS S
WHERE S.Camada = (SELECT MIN(Camada) FROM Staff)
UNION
SELECT
S.Documento,
S.nombre,
S.Camada,
'Mayo 2021' AS Marca_Indicador
FROM staff AS S
WHERE YEAR([Fecha Ingreso])=2021 AND MONTH([Fecha Ingreso])=05 --funciones de fechas 
ORDER BY Camada; --ordena todo asi de menor a mayor por camada

--EJERCICIO 2---
/*Análisis de profesiones con mas estudiantes: 
Identificar la profesión y la cantidad de estudiantes que ejercen, 
mostrar el listado solo de las profesiones que tienen mas de 5 estudiantes.
Ordenar de mayor a menor por la profesión que tenga mas estudiantes.*/

SELECT P.Profesiones,
COUNT(E.EstudiantesID) AS cant_estudiantes
FROM Profesiones AS P
INNER JOIN Estudiantes AS E 
ON P.ProfesionesID=E.Profesion 
GROUP BY P.Profesiones
HAVING COUNT(E.EstudiantesID) > 5
ORDER BY cant_estudiantes DESC;

--EJERCICIO 3---
/*Análisis de estudiantes por área de educación: 
Identificar: nombre del área, si la asignatura es carrera o curso , a qué jornada pertenece, 
cantidad de estudiantes y monto total del costo de la asignatura. 
Ordenar el informe de mayor a menor por monto de costos total tener 
en cuenta los docentes que no tienen asignaturas ni estudiantes asignados, también sumarlos.*/

SELECT 
 AR.Nombre, -- Nombre tabla area--
 A.Tipo, -- Tipo > Tabla Asignaturas
 A.Jornada, -- Jornada >  Tabla Asignaturas --
 COUNT(E.EstudiantesID) AS Cantidad_Estudiantes, -- Estudiantes > Tabla Estudiantes--
 SUM(A.Costo) AS costo_Total -- Tabla Asignaturas--
 FROM Asignaturas AS A
 INNER JOIN Area  AS AR
 ON A.Area=AR.AreaID
 LEFT JOIN Staff AS S 
 ON S.Asignatura=A.AsignaturasID
 LEFT JOIN Estudiantes AS E
 ON S.DocentesID=E.Docente
 GROUP BY  AR.Nombre, A.Tipo,A.Jornada
 ORDER BY costo_Total DESC;

 --EJERCICIO 4---
 /*Análisis mensual de estudiantes por área: Identificar para cada área: el año y el mes (concatenados en formato YYYY-M), cantidad de estudiantes y monto total de las asignaturas. Ordenar por mes del más actual al más antiguo y por cantidad de clientes de mayor a menor.*/

SELECT AR.Nombre,CONCAT(YEAR(E.[Fecha Ingreso]),'-', MONTH(E.[Fecha Ingreso])) AS Fecha,COUNT(E.EstudiantesID) AS Cantidad_Estudiantes,SUM(A.Costo) AS TotalFROM Estudiantes AS EINNER JOIN Staff AS S ON E.Docente=S.DocentesIDINNER JOIN Asignaturas AS A ON S.Asignatura=A.AsignaturasIDINNER JOIN Area AS ARON A.Area=AR.AreaIDGROUP BY AR.Nombre, CONCAT(YEAR(E.[Fecha Ingreso]),'-', MONTH(E.[Fecha Ingreso]))ORDER BY Fecha DESC, Cantidad_Estudiantes DESC;

--EJERCICIO 5---/*Análisis encargado tutores jornada noche: Identificar el nombre del encargado, el documento, el numero de la camada(solo el numero) y la fecha de ingreso del tutor. Ordenar por camada de forma mayor a menor.*/

SELECT E.nombre,E.Documento,RIGHT(S.Camada,5) AS camada,S.[Fecha Ingreso] AS [Fecha Ingreso Tutor]FROM Encargado AS EINNER JOIN Staff AS S ON E.Encargado_ID=S.EncargadoINNER JOIN Asignaturas AS A ON A.AsignaturasID=S.AsignaturaWHERE A.Jornada='Noche' AND E.Tipo like '%Tutores%' --tutores jornada noche
ORDER BY Camada DESC;

--EJERCICIO 6---/*Análisis asignaturas sin docentes o tutores: Identificar el tipo de asignatura, la jornada, la cantidad de áreas únicas y la cantidad total de asignaturas que no tienen asignadas docentes o tutores.Ordenar por tipo de forma descendente.*/

SELECT A.Tipo,A.jornada,COUNT(DISTINCT A.area) AS cant_areas,COUNT(A.nombre) AS cant_asignaturas,S. DocentesIDFROM Asignaturas AS A LEFT JOIN Staff AS S  ON A.AsignaturasID=S.AsignaturaWHERE DocentesID is nullGROUP BY A.Tipo, A.Jornada, S.DocentesIDORDER BY A.tipo DESC;





