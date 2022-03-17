--EJERCICIO 1---
/*An�lisis de docentes por camada: 
N�mero de documento, nombre de docente y camada para identificar la camada mayor y 
la menor seg�n el numero de la  camada. 
N�mero de documento, nombre de docente y camada para identificar 
la camada con fecha de ingreso Mayo 2021. 
Agregar un campo indicador que informe cuales son los registros �mayor o menor� y
los que son �Mayo 2021� y ordenar el listado de menor a mayor por camada*/

SELECT * FROM Staff;

SELECT TOP(1) Documento, Nombre, Camada --uso top para ver maximo o minomo (es una opcion mas rara)
FROM Staff
ORDER BY Camada ASC;

SELECT TOP(1) Documento, Nombre, Camada --al reves 
FROM Staff
ORDER BY Camada ASC;

SELECT  Documento, Nombre, Camada --nos trae el mes y a�o especifico
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
/*An�lisis de profesiones con mas estudiantes: 
Identificar la profesi�n y la cantidad de estudiantes que ejercen, 
mostrar el listado solo de las profesiones que tienen mas de 5 estudiantes.
Ordenar de mayor a menor por la profesi�n que tenga mas estudiantes.*/

SELECT P.Profesiones,
COUNT(E.EstudiantesID) AS cant_estudiantes
FROM Profesiones AS P
INNER JOIN Estudiantes AS E 
ON P.ProfesionesID=E.Profesion 
GROUP BY P.Profesiones
HAVING COUNT(E.EstudiantesID) > 5
ORDER BY cant_estudiantes DESC;

--EJERCICIO 3---
/*An�lisis de estudiantes por �rea de educaci�n: 
Identificar: nombre del �rea, si la asignatura es carrera o curso , a qu� jornada pertenece, 
cantidad de estudiantes y monto total del costo de la asignatura. 
Ordenar el informe de mayor a menor por monto de costos total tener 
en cuenta los docentes que no tienen asignaturas ni estudiantes asignados, tambi�n sumarlos.*/

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
 /*An�lisis mensual de estudiantes por �rea: 

SELECT AR.Nombre,

--EJERCICIO 5---

SELECT 
ORDER BY Camada DESC;

--EJERCICIO 6---

SELECT 




