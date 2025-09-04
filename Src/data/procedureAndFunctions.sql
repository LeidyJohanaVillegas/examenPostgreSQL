-- funcion de registrar venta

DECLARE
    v_stock INT;
    v_venta_id INT;
BEGIN
    --Val cliente
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = p_cliente_id) THEN
        RAISE EXCEPTION 'El cliente con id % no existe', p_cliente_id;
    END IF;

    -- Val stock
    SELECT stock INTO v_stock FROM productos WHERE id = p_producto_id;
    IF v_stock IS NULL THEN
        RAISE EXCEPTION 'El producto con id % no existe', p_producto_id;
    ELSIF v_stock < p_cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente para producto %, disponible: %, solicitado: %',
            p_producto_id, v_stock, p_cantidad;
    END IF;

    -- Reg venta
    INSERT INTO ventas (cliente_id, fecha)
    VALUES (p_cliente_id, NOW())
    RETURNING id INTO v_venta_id;

    -- Ins detalle de venta
    INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario)
    VALUES (v_venta_id, p_producto_id, p_cantidad, p_precio);

    -- Act stock
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id = p_producto_id;

    RAISE NOTICE 'Venta registrada correctamente. ID Venta: %', v_venta_id;
END;


-----------------------------------------------------------------------------
--comprobaciones 
-----------------------------------------------------------------------------

--verificacion stock del producto
SELECT stock FROM productos WHERE id = 1;
-- registrar venta
SELECT registrar_venta(1, 1, 3, 4500.00);
-- Última venta registrada
SELECT * FROM ventas ORDER BY id DESC LIMIT 1;

-- Detalle de la última venta
SELECT * FROM ventas_detalle ORDER BY venta_id DESC LIMIT 1;

-- Stock actualizado del producto 1
SELECT stock FROM productos WHERE id = 1;

--el cliente no existe, para comprobar con otro debe cambiar el 999 por otro id
SELECT registrar_venta(999, 1, 1, 4500.00);

--el producto no existe, para comprobar cambiar el 999 por otro id
SELECT registrar_venta(1, 999, 1, 100);

-- el stock insuficiente
SELECT registrar_venta(1, 1, 20, 4500.00);