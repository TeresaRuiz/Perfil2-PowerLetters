USE powerletters;

/*TRIGGER*/
	-- Este trigger se activará después de insertar un nuevo pedido
DELIMITER //
CREATE TRIGGER tr_actualizar_existencias
AFTER INSERT ON tb_detalle_pedidos
FOR EACH ROW
BEGIN
    -- Actualiza las existencias del libro afectado por el nuevo pedido
    UPDATE tb_libros
    SET existencias = existencias - NEW.cantidad
    WHERE id_libro = NEW.id_libro;
END //
DELIMITER ;
	
	/*fUNCION*/
	-- Esta función recibe el id de un pedido y devuelve el total calculado
DELIMITER //
CREATE FUNCTION calcular_total_pedido(pedido_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    
    -- Calcula el total sumando el precio de los libros en el pedido
    SELECT SUM(l.precio * dp.cantidad)
    INTO total
    FROM tb_detalle_pedidos dp
    JOIN tb_libros l ON dp.id_libro = l.id_libro
    WHERE dp.id_pedido = pedido_id;
    
    RETURN total;
END //
DELIMITER ;
	
	/*procedimiento*/
	
	-- Este procedimiento recibe los datos de una reseña y la inserta en la tabla tb_resenias
-- Luego, actualiza el contador de reseñas en el libro correspondiente
DELIMITER //
CREATE PROCEDURE insertar_resena_y_actualizar_contador(
    libro_id INT,
    usuario_id INT,
    comentario VARCHAR(250)
)
BEGIN
    -- Inserta la nueva reseña en la tabla tb_resenias
    INSERT INTO tb_resenias (id_libro, id_usuario, comentario)
    VALUES (libro_id, usuario_id, comentario);
 
    -- Actualiza el contador de reseñas en el libro correspondiente
    UPDATE tb_libros
    SET contador_resenias = contador_resenias + 1
    WHERE id_libro = libro_id;
END //
DELIMITER ;

-- Verificar que las existencias en tb_libros se hayan actualizado
SELECT * FROM tb_libros WHERE id_libro = 1;

-- Ejemplo para probar la Función
SELECT calcular_total_pedido(1) AS total_pedido;

-- Ejemplo para probar el Procedimiento Almacenado
CALL insertar_resena_y_actualizar_contador(1, 1, 'Excelente libro');

-- Verificar que se haya insertado la reseña en tb_resenias
SELECT * FROM tb_resenias WHERE id_libro = 1;

-- Verificar que el contador de reseñas en tb_libros se haya actualizado
SELECT * FROM tb_libros WHERE id_libro = 1;
