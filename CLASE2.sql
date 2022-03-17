--USOS DEL SELECT FROM--

SELECT * FROM CLIENTES
SELECT IDCliente, NombreCliente FROM CLIENTES

--USOS DEL INSERT INTO "TABLA" (CAMPOS O COLUMNAS) VALUES (VALORES), DEBEN RESPETAR ESTRUCTURA Y TIPO DE DATO DE LA COLUMNA--
--CREAMOS NUEVA BASE DE DATOS--

CREATE DATABASE Clase_5
CREATE TABLE Categorias (IDCategoria int NOT NULL PRIMARY KEY,
NombreCategoria varchar(50) NOT NULL, 
Descripcion varchar(50) NOT NULL);

SELECT * FROM Categorias

INSERT INTO Categorias (IDCategoria,NombreCategoria,Descripcion)
VALUES (1,'Bebidas','Refrescos, cafes, tes, cervezas y ales');

INSERT INTO Categorias (IDCategoria,NombreCategoria,Descripcion)
VALUES (2,'Carnes','Milanesas, Camarones, Pollo');

--CREO OTRA BASE CON IDENTITY AUTOINCREMENTAL, CALCULA SOLO EL ID--

CREATE DATABASE Clase_5B
CREATE TABLE Categorias (IDCategoria int NOT NULL IDENTITY PRIMARY KEY,
NombreCategoria varchar(50) NOT NULL, 
Descripcion varchar(50) NOT NULL);

INSERT INTO Categorias (NombreCategoria,Descripcion)
VALUES ('Bebidas','Refrescos, cafes, tes, cervezas y ales');

SELECT * FROM Categorias

INSERT INTO Categorias (NombreCategoria,Descripcion)
VALUES ('Quesos', 'Brie, Hebras, Para Untar'), ('Carnes','Milanesas, Camarones, Pollo');

--Clase5 (base de dato), tasks, import data para importar datos de un excel-- 

DROP TABLE Categorias;

--Con corchetes o comillas dobles puedo dejar espacios en los nombres-- 
CREATE TABLE Categorias(IDCategoria int NOT NULL IDENTITY PRIMARY KEY, [Nombre Categoria] varchar(50) NOT NULL, Descripcion varchar(50) NOT NULL);

INSERT INTO Categorias ([Nombre Categoria], Descripcion)VALUES ('Bebidas', 'Refrescos, cafes, tes, cervezas y ales');
INSERT INTO Categorias ([Nombre Categoria],Descripcion)
VALUES ('Quesos', 'Brie, Hebras, Para Untar'), ('Carnes','Milanesas, Camarones, Pollo');

--UPDATE MODIFICA REGISTROS, UPDATE TABLE.. SET COLUMNA = NOMBRE NUEVO DEL ELEMENTO, WHERE ID = NUMERO DE FILA

UPDATE Categorias SET [Nombre Categoria] = 'Quesillos' WHERE IDCategoria = 2;

SELECT * FROM Categorias

--PUEDO USAR AND Y OR--
UPDATE Categorias SET [Nombre Categoria] = 'Otros' WHERE IDCategoria = 3 AND Descripcion = 'Milanesas, Camarones, Pollo';

--DELETE PERMITE ELIMINAR REGISTROS, FILAS. SI BORRO UNO DEL MEDIO NO SE CORRE LA NUMERACION, QUEDA EL ESPACIO--
DELETE FROM Categorias WHERE IDCategoria = 2;

--BORRO TODO EL CONTENIDO DE LA TABLA
DELETE FROM Categorias;