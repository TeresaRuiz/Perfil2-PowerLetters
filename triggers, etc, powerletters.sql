USE powerletters;

/*TRIGGER*/
	CREATE TRIGGER tr_actualizar_estado
	AFTER INSERT ON tb_pedidos
	FOR EACH ROW
	UPDATE tb_pedidos SET estado = 'PENDIENTE' WHERE id_pedido = NEW.id_pedido;
	
	/*fUNCION*/
	DELIMITER //
	CREATE FUNCTION calcular_total(id_pedido INT) RETURNS DECIMAL(10,2)
	BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(precio * cantidad) INTO total FROM tb_libros WHERE id_libro IN (SELECT id_libro FROM tb_detallePedido WHERE id_pedido = id_pedido);
    RETURN total;
	 END //
	DELIMITER ;
	
	/*procedimiento*/
	
	DELIMITER //
	CREATE PROCEDURE actualizar_existencias(id_libro INT, cantidad INT)
	BEGIN
	UPDATE tb_libros SET existencias = existencias - cantidad WHERE id_libro = id_libro;
	END //
	DELIMITER ;
