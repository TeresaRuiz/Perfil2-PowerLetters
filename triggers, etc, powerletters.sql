USE powerletters;

	/* TRIGGER */
-- Este trigger se activará después de insertar un nuevo pedido
DELIMITER //
CREATE TRIGGER tr_actualizar_existencias
AFTER INSERT ON tb_detalle_pedidos
FOR EACH ROW
BEGIN
    -- Actualiza las existencias del libro afectado por el nuevo pedido
    UPDATE tb_libros
	 SET existencias = CASE
	 WHEN existencias - NEW.cantidad < 0 THEN 0
	 ELSE existencias - NEW.cantidad
	 END
WHERE id_libro = NEW.id_libro;
END;
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
DELIMITER //

CREATE PROCEDURE actualizar_direccion_usuario(user_id INT, nueva_direccion VARCHAR(100))
BEGIN
    UPDATE tb_usuarios
    SET direccion = nueva_direccion
    WHERE id_usuario = user_id;
END;
//

DELIMITER ;
