-- 1. Actualización automática del stock en ventas
CREATE OR REPLACE FUNCTION descontar_stock()
RETURNS TRIGGER AS $$
DECLARE
    v_stock INT;
BEGIN
    SELECT stock INTO v_stock FROM productos WHERE id = NEW.producto_id;
    IF v_stock < NEW.cantidad THEN
        RAISE EXCEPTION 'No hay suficiente stock para el producto %', NEW.producto_id;
    END IF;

    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.producto_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_descontar_stock
BEFORE INSERT ON ventas_detalle
FOR EACH ROW
EXECUTE FUNCTION descontar_stock();

-- 2. Registro de auditoría de ventas
CREATE OR REPLACE FUNCTION registrar_auditoria()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_ventas (venta_id, usuario)
    VALUES (NEW.id, current_user);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditoria_ventas
AFTER INSERT ON ventas
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria();

-- 3. Notificación de productos agotados
CREATE OR REPLACE FUNCTION notificar_stock_agotado()
RETURNS TRIGGER AS $$
DECLARE
    v_nombre TEXT;
BEGIN
    IF NEW.stock = 0 THEN
        SELECT nombre INTO v_nombre FROM productos WHERE id = NEW.id;
        INSERT INTO alertas_stock (producto_id, nombre_producto, mensaje)
        VALUES (NEW.id, v_nombre, 'El producto se agotó en inventario');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notificar_stock
AFTER UPDATE ON productos
FOR EACH ROW
WHEN (NEW.stock = 0)
EXECUTE FUNCTION notificar_stock_agotado();

-- 4. Validación de correo en clientes
CREATE OR REPLACE FUNCTION validar_cliente()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.correo IS NULL OR NEW.correo = '' THEN
        RAISE EXCEPTION 'El correo del cliente no puede estar vacío';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_cliente
BEFORE INSERT ON clientes
FOR EACH ROW
EXECUTE FUNCTION validar_cliente();

-- 5. Historial de cambios de precio
CREATE OR REPLACE FUNCTION registrar_cambio_precio()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.precio <> OLD.precio THEN
        INSERT INTO historial_precios (producto_id, precio_anterior, precio_nuevo)
        VALUES (OLD.id, OLD.precio, NEW.precio);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_historial_precios
AFTER UPDATE OF precio ON productos
FOR EACH ROW
EXECUTE FUNCTION registrar_cambio_precio();

-- 6. Bloqueo de eliminación de proveedores con productos activos
CREATE OR REPLACE FUNCTION bloquear_eliminacion_proveedor()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM productos WHERE proveedor_id = OLD.id) THEN
        RAISE EXCEPTION 'No se puede eliminar el proveedor %, tiene productos asociados', OLD.id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_bloquear_proveedor
BEFORE DELETE ON proveedores
FOR EACH ROW
EXECUTE FUNCTION bloquear_eliminacion_proveedor();

-- 7. Control de fechas en ventas
CREATE OR REPLACE FUNCTION validar_fecha_venta()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha > NOW() THEN
        RAISE EXCEPTION 'La fecha de la venta no puede ser futura';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_fecha_venta
BEFORE INSERT ON ventas
FOR EACH ROW
EXECUTE FUNCTION validar_fecha_venta();

-- 8. Reactivación de clientes inactivos
CREATE OR REPLACE FUNCTION reactivar_cliente()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE clientes
    SET estado = 'activo'
    WHERE id = NEW.cliente_id AND estado = 'inactivo';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_reactivar_cliente
BEFORE INSERT ON ventas
FOR EACH ROW
EXECUTE FUNCTION reactivar_cliente();



-------------------------------------------------------------------------------------------------------
-- comp0robaciones tiggers
-------------------------------------------------------------------------------------------------------
--1. trg_descontar_stock
-- Ver stock actual del producto 1
SELECT stock FROM productos WHERE id = 1;

-- Insertar una venta y su detalle (puede ser manual o con la función `registrar_venta`)
-- Si hay stock suficiente:
INSERT INTO ventas (cliente_id, fecha) VALUES (1, NOW());
-- Suponiendo que la venta anterior fue id = 16 (ajusta según tu tabla)
INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario)
VALUES (16, 1, 2, 6000.00);

-- Confirmar stock actualizado
SELECT stock FROM productos WHERE id = 1;

-- Caso de error: stock insuficiente
INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario)
VALUES (16, 1, 999, 6000.00);  -- Esto debería lanzar excepción

--2. trg_auditoria_ventas
-- Insertar una venta
INSERT INTO ventas (cliente_id, fecha) VALUES (2, NOW());

-- Revisar la tabla de auditoría
SELECT * FROM auditoria_ventas ORDER BY venta_id DESC LIMIT 1;

--3. trg_notificar_stock
-- Baja el stock manualmente a 0
UPDATE productos SET stock = 0 WHERE id = 2;

-- Verificar si se insertó la alerta
SELECT * FROM alertas_stock WHERE producto_id = 2;

--4. trg_validar_cliente
-- Intento válido
INSERT INTO clientes (nombre, correo, telefono, estado)
VALUES ('Cliente Prueba', 'correo@ejemplo.com', '3120000000', 'activo');

-- Intento inválido
INSERT INTO clientes (nombre, correo, telefono, estado)
VALUES ('Cliente Sin Correo', '', '3120000000', 'activo');  -- ❌ lanza excepción

--5. trg_historial_precios
-- Ver historial actual
SELECT * FROM historial_precios WHERE producto_id = 1;

-- Cambiar el precio
UPDATE productos SET precio = 6200.00 WHERE id = 1;

-- Confirmar en historial
SELECT * FROM historial_precios WHERE producto_id = 1;

--6. trg_bloquear_proveedor
-- Intento de borrar proveedor con productos
DELETE FROM proveedores WHERE id = 1;  --  lanza excepción

-- Borra productos del proveedor
DELETE FROM productos WHERE proveedor_id = 1;

-- Ahora sí permite borrar
DELETE FROM proveedores WHERE id = 1;

--7. trg_validar_fecha_venta 
-- Venta válida
INSERT INTO ventas (cliente_id, fecha) VALUES (3, NOW());

-- Venta inválida
INSERT INTO ventas (cliente_id, fecha) VALUES (3, NOW() + INTERVAL '1 day');  -- ❌

--8. trg_reactivar_cliente
-- Marcar cliente 4 como inactivo
UPDATE clientes SET estado = 'inactivo' WHERE id = 4;

-- Verificar estado actual
SELECT estado FROM clientes WHERE id = 4;

-- Insertar venta
INSERT INTO ventas (cliente_id, fecha) VALUES (4, NOW());

-- Verificar que esté activo ahora
SELECT estado FROM clientes WHERE id = 4;
