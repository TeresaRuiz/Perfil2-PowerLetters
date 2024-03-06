DROP DATABASE IF EXISTS powerletters;
CREATE DATABASE powerletters;
USE powerletters;
 
CREATE TABLE tb_usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    nombre_usuario VARCHAR(100),
    correo VARCHAR(100),
    clave VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    imagen VARCHAR(25)
);
 
CREATE TABLE tb_administradores (
    id_administrador INT PRIMARY KEY AUTO_INCREMENT,
    nombre_administrador VARCHAR(50),
    user_administrador VARCHAR(50),
    correo_administrador VARCHAR(50),
    clave_administrador VARCHAR(50),
    telefono_adm VARCHAR(20),
    fecha_registro DATETIME,
    imagen VARCHAR(25)
);
 
CREATE TABLE tb_genero (
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20)
);
 
CREATE TABLE tb_clasificaciones (
    id_clasificacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    descripcion VARCHAR(100)
);
 
CREATE TABLE tb_autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30),
    biografia VARCHAR(100)
);
 
CREATE TABLE tb_editoriales (
    id_editorial INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20)
);
 
CREATE TABLE tb_libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    id_autor INT,
    precio DECIMAL(10, 2),
    descripcion VARCHAR(200),
    imagen VARCHAR(25),
    id_clasificacion INT,
    id_editorial INT,
    id_administrador INT,
    existencias INT,
    CONSTRAINT fk_administrador FOREIGN KEY (id_administrador) REFERENCES tb_administradores(id_administrador),
    CONSTRAINT fk_autor FOREIGN KEY (id_autor) REFERENCES tb_autores(id_autor),
    CONSTRAINT fk_clasificacion FOREIGN KEY (id_clasificacion) REFERENCES tb_clasificaciones(id_clasificacion),
    CONSTRAINT fk_editorial FOREIGN KEY (id_editorial) REFERENCES tb_editoriales(id_editorial)
);
 
CREATE TABLE tb_pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pedido DATETIME,
    id_usuario INT,
    estado ENUM('FINALIZADO', 'PENDIENTE', 'ENTREGADO', 'CANCELADO'),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id_usuario)
);
 
CREATE TABLE tb_detalle_pedido (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_libro INT,
    cantidad INT,
    CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
    CONSTRAINT fk_libro FOREIGN KEY (id_libro) REFERENCES tb_libros(id_libro)
);
 
CREATE TABLE tb_resenias (
    id_resena INT PRIMARY KEY AUTO_INCREMENT,
    id_libro INT,
    id_usuario INT,
    comentario VARCHAR(250) 
);

	ALTER TABLE tb_resenias
	ADD CONSTRAINT fk_libros1 
	FOREIGN KEY (id_libro) 
	REFERENCES tb_libros(id_libro);
	
	ALTER TABLE tb_resenias
	ADD CONSTRAINT fk_usuario1 
	FOREIGN KEY (id_usuario) 
	REFERENCES tb_usuarios(id_usuario);
