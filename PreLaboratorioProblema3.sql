CREATE DATABASE FIXO_db; /*se crea la database, en este caso pongo 
						el nombre de la empresa y el db de database*/ 
use FIXO_db;	-- seleccionamos la base de datos

Create table Direccion( 			-- Se crea la tabla direccion con el formato del diagrama
	idDireccion int primary key,
    Direccion varchar(45),
	Ciudad varchar(45),
    Pais varchar(45)
);

INSERT INTO Direccion(idDireccion, Direccion, Ciudad, Pais)  /*Se insertan los datos para 
															funcionalidad a la tabla direccion*/
values
(1,'Zona 5','Guatemala','Guatemala'),
(2,'Zona 1','Villa Nueva','Guatemala'),
(3,'5 avenida','Fraijanes','Guatemala'),
(4,'Zona 12','Guatemala','Guatemala'),
(5,'Zona 9','San Miguel Petapa','Guatemala');

Create table Cliente(		-- Se crea la tabla cliente con el formato del diagrama
	idCliente INT PRIMARY KEY,
    Nombre VARCHAR(45),
    Apellido VARCHAR(45),
    Edad INT(11),
    Direccion_idDireccion INT(11),
    FOREIGN KEY (Direccion_idDireccion) REFERENCES Direccion(idDireccion)	/* el foreign key relaciona la 
																				tabla cliente con direccion
                                                                                por medio de "Direccion_idDireccion"*/			/**/
																																													
);

INSERT INTO Cliente(idCliente, Nombre, Apellido, Edad, Direccion_idDireccion) /*Se insertan los datos
																			para funcionalidad a la tabla Cliente*/
values
(1,'Dominykas','Lukasevicius','20','5'),
(2,'Papu','Gomez','22','4'),
(3,'Pipe','Lopez','43','3'),
(4,'Juliana','Cano','34','2'),
(5,'Mert','Alkan','18','1');

Create table categoria( -- Se crea la tabla categoria con el formato del diagrama
	idCategoria int primary key,
    Nombre varchar(45)
);

INSERT INTO Categoria(idCategoria, Nombre) -- Se insertan los datos para funcionalidad a la tabla categoria
values
	(1,'Fantasia'),
	(2,'Romantica'),
	(3,'Comedia'),
	(4,'Terror'),
	(5,'Familiar'); 
    
CREATE TABLE Peliculas ( -- Se crea la tabla categoria con el formato del diagrama
    idPeliculas INT PRIMARY KEY,
    Nombre VARCHAR(45),
    Duracion INT(11),
    Descripcion TEXT,
    Año INT(11),
    Categoria_idCategoria INT,
    FOREIGN KEY (Categoria_idCategoria) REFERENCES categoria(idCategoria) /* el foreign key relaciona la 
																				tabla peliculas con categoria
                                                                                por medio de "Categoria_idCategoria"*/	
);

INSERT INTO Peliculas(idPeliculas,Nombre,Duracion,Descripcion,Año,Categoria_idCategoria)  
																/*Se insertan los datos para 
																	funcionalidad a la tabla peliculas*/
values
(1,'Shrek','90','Un ogro llamado Shrek vive en su pantano.','2001',1),
(2,'Blade','120','Un hombre medio mortal, medio vampiro y capaz de andar bajo la luz solar, trata de vengar la muerte de su madre.','1998',4),
(3,'POKEMON1','96','Ash y sus compañeros Pokémon se enfrentan a una criatura clonada que le ha declarado la guerra a sus oponentes.','1998',3),
(4,'Orgullo y prejuicio','127','Elizabeth Bennet conoce al apuesto y adinerado Sr. Darcy, con quien, rápidamente, inicia una intensa y compleja relación.','2005',2),
(5,'Coco','95','Miguel es un niño que sueña con ser músico, pero su familia se lo prohíbe.','2017',5);

CREATE TABLE Inventario ( -- Se crea la tabla inventario con el formato del diagrama
    idCopiasPeliculas INT PRIMARY KEY,
    Peliculas_idPeliculas INT,
    Disponible TINYINT,
    FOREIGN KEY (Peliculas_idPeliculas) REFERENCES Peliculas(idPeliculas) /* el foreign key relaciona la 
																				tabla inventario con peliculas
                                                                                por medio de "Peliculas_idPeliculas"*/
);

INSERT INTO Inventario(idCopiasPeliculas,Peliculas_idPeliculas,Disponible)-- Se insertan los datos para funcionalidad a 
																		-- la tabla inventario
values
(1, 1, 6),
(2, 2, 8),
(3, 3, 4),
(4, 4, 1),
(5, 5, 1);

CREATE TABLE Renta ( -- Se crea la tabla renta con el formato del diagrama
    idRenta INT PRIMARY KEY,
    Fecha_Renta DATE,
    Fecha_Entrega DATE,
    Inventario_idCopiasPeliculas INT,
    Cliente_idCliente INT,
    FOREIGN KEY (Inventario_idCopiasPeliculas) REFERENCES Inventario(idCopiasPeliculas), 
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)	/* Se tienen dos foreign keys
																		los cuales conectan a la tabla renta con 
																		inventario y cliente por medio de 
																		Inventario_idCopiasPeliculas" y Cliente_idCliente*/
);
INSERT INTO Renta(idRenta,Fecha_Renta,Fecha_Entrega,Inventario_idCopiasPeliculas,Cliente_idCliente)
					/*Se insertan los datos para funcionalidad a la tabla renta*/
values
    (1,'2025-02-22','2025-03-09',1,1),
    (2,'2025-02-25','2025-04-11',2,2),
    (3,'2025-03-01','2025-03-12',3,3),
    (4,'2025-04-10','2025-04-20',4,4),
    (5,'2025-05-07','2025-06-01',5,5);
    
CREATE TABLE Proveedores( /*Creo una tabla proveedores como parte de las dos adiciones, la conecto
							con un foreign key a Peliculas para saber que pelicula me entrego cada proveedor*/ 
	idProveedores int primary key,
    Nombre varchar(45),
    Cobro int(7),
    fecha_entrega date,
    Proveedores_idPeliculas int,
    FOREIGN KEY (Proveedores_idPeliculas) REFERENCES Peliculas(idPeliculas)	
    
);
INSERT INTO Proveedores(idProveedores, Nombre, Cobro, fecha_entrega ,Proveedores_idPeliculas)
					/*Se insertan los datos para funcionalidad a la tabla proveedores*/
values
(1,'Disney','200','2025-01-24','5'),
(2,'DreamWorks','1000','2025-02-14','1'),
(3,'New Line Cinema','2500','2024-12-31','2'),
(4,'SONY','700','2025-02-24','3'),
(5,'Universal','2000','2025-01-24','4');

CREATE TABLE Informacion_peliculas(/*Creo una tabla para la informacion de cada pelicula como parte de las dos
								adiciones, la conecto con un foreign key a Peliculas para saber 
                                la informacion mas detallada de cada pelicula.*/ 
	idInformacion_peliculas int primary key, -- el main id de la tabla
    Protagonista varchar(45),	
    Director varchar(45),
    Valoracion tinyint,  -- uso tinyint ya que la valoracion es sobre 10
    Presupuesto int(7),	-- de tipo entero, esta sobre millones de dolares
    Informacion_idPeliculas int,
    foreign key (Informacion_idPeliculas) references Peliculas(idPeliculas)	
);

INSERT INTO Informacion_peliculas(idInformacion_peliculas, Protagonista, Director, Valoracion, Presupuesto, Informacion_idPeliculas)
					/*Se insertan los datos para funcionalidad a la tabla Informacion_peliculas*/
values
(1,'Mike Myers','Vicky Jenson','8','60','1'),
(2,'Wesley Snipes','Stephen Norrington','7','45','2'),
(3,'Jay Goede','Kunihiko Yuyama','6','30','3'),
(4,'Keira Knightley','Joe Wright','8','28','4'),
(5,'Anthony Gonzalez','Lee Unkrich','8','175','5');

select * from Peliculas where not Nombre = "POKEMON1";
-- Elimina las peliculas con nombre pokemon1
select * from Peliculas order by Año desc;
-- Ordena las peliculas por año de forma descendente
select * from Cliente where Nombre = "Juliana";
-- selecciona unicamente donde la columna nombre sea "Juliana"
select * from Categoria order by Nombre asc;
-- Ordena las categorias de forma ascendente
select * from Inventario;
-- visualiza la tabla inventario
select * from Renta;
-- visualiza la tabla renta
select * from categoria;
-- visualiza la tabla categoria
select * from proveedores;
-- visualiza la tabla reserva
select * from Direccion;
-- visualiza la tabla direccion
select * from Cliente;
-- visualiza la tabla cliente
select * from Peliculas;
-- visualiza la tabla peliculas
select * from informacion_peliculas;
-- visualiza la tabla informacion










