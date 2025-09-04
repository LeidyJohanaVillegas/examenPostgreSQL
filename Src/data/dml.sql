-- PROVEEDORES
INSERT INTO proveedores (nombre, correo, telefono, direccion) VALUES
('InnovaTech', 'contacto@innovatech.com', '3112223333', 'Calle 15 #34-56'),
('GizmoWorld', 'ventas@gizmoworld.com', '3124445555', 'Carrera 10 #20-45'),
('Electronix', 'info@electronix.com', '3136667777', 'Av. 50 #18-22'),
('CompuNet', 'support@compunet.com', '3148889999', 'Calle 88 #30-10'),
('DigitalPro', 'ventas@digitalpro.com', '3150001111', 'Carrera 80 #22-30'),
('MegaParts', 'info@megaparts.com', '3162223333', 'Av. 90 #25-40'),
('CompuTech', 'contact@computech.com', '3174445555', 'Calle 70 #10-15'),
('SmartGadgets', 'soporte@smartgadgets.com', '3186667777', 'Carrera 40 #35-50'),
('ElectroGear', 'ventas@electrogear.com', '3198889999', 'Av. 60 #20-25'),
('GlobalParts', 'info@globalparts.com', '3101112222', 'Calle 100 #55-60'),
('HardTech', 'sales@hardtech.com', '3113334444', 'Carrera 5 #15-20'),
('LaptopKing', 'ventas@laptopking.com', '3125556666', 'Av. 35 #40-45'),
('GigaGadgets', 'info@gigagadgets.com', '3137778888', 'Calle 25 #30-35'),
('SuperParts', 'ventas@superparts.com', '3149990000', 'Carrera 12 #22-24'),
('MicroWorld', 'support@microworld.com', '3151112222', 'Av. 10 #14-18');

-- PRODUCTOS
INSERT INTO productos (nombre, categoria, precio, stock, proveedor_id) VALUES
('MacBook Pro 16"', 'Laptops', 6000.00, 8, 1),
('Samsung Galaxy S21', 'Smartphones', 4800.00, 18, 2),
('Teclado Logitech K120', 'Accesorios', 180.00, 40, 3),
('Monitor LG 27"', 'Monitores', 1200.00, 15, 4),
('Auriculares Bose QC35', 'Auriculares', 1300.00, 20, 5),
('Disco Duro WD 2TB', 'Almacenamiento', 450.00, 25, 6),
('Memoria RAM 8GB Corsair', 'Componentes', 250.00, 30, 7),
('Cargador iPhone', 'Accesorios', 90.00, 60, 8),
('AirPods Max', 'Auriculares', 1500.00, 10, 9),
('Tablet iPad Air', 'Tablets', 2500.00, 9, 10),
('Laptop Asus ZenBook', 'Laptops', 4200.00, 12, 11),
('Impresora HP LaserJet', 'Impresoras', 1800.00, 7, 12),
('Cámara Sony Alpha', 'Cámaras', 5500.00, 5, 13),
('Router Netgear', 'Redes', 500.00, 18, 14),
('Disco SSD 1TB Samsung', 'Almacenamiento', 1100.00, 6, 15),
('Disco SSD 256GB Kingston', 'Almacenamiento', 350.00, 30, 15);

-- CLIENTES
INSERT INTO clientes (nombre, correo, telefono, estado) VALUES
('Luis Fernández', 'luisfernandez@mail.com', '3102223344', 'activo'),
('Elena Martínez', 'elenamartinez@mail.com', '3205556677', 'activo'),
('Miguel Soto', 'miguelsoto@mail.com', '3118889990', 'activo'),
('Natalia Gómez', 'nataliagomez@mail.com', '3004445566', 'activo'),
('Pedro Castillo', 'pedrocastillo@mail.com', '3157778889', 'activo'),
('Sonia Rivera', 'soniarivera@mail.com', '3131234567', 'activo'),
('Raúl Pérez', 'raulperez@mail.com', '3169990001', 'activo'),
('Gabriela Díaz', 'gabrieladiaz@mail.com', '3193216547', 'activo'),
('Javier Morales', 'javiermorales@mail.com', '3129876543', 'activo'),
('Carolina Silva', 'carolinasilva@mail.com', '3187654321', 'activo'),
('Ricardo León', 'ricardoleon@mail.com', '3142223333', 'activo'),
('Isabel Torres', 'isabeltorres@mail.com', '3174445555', 'activo'),
('Hugo Sánchez', 'hugosanchez@mail.com', '3106667777', 'activo'),
('Verónica Ortiz', 'veronicaortiz@mail.com', '3208889999', 'activo'),
('Andrés Medina', 'andresmedina@mail.com', '3190001112', 'activo');

-- VENTAS
INSERT INTO ventas (cliente_id, fecha) VALUES
(1, NOW() - INTERVAL '12 days'),
(2, NOW() - INTERVAL '11 days'),
(3, NOW() - INTERVAL '10 days'),
(4, NOW() - INTERVAL '9 days'),
(5, NOW() - INTERVAL '8 days'),
(6, NOW() - INTERVAL '7 days'),
(7, NOW() - INTERVAL '6 days'),
(8, NOW() - INTERVAL '5 days'),
(9, NOW() - INTERVAL '4 days'),
(10, NOW() - INTERVAL '3 days'),
(11, NOW() - INTERVAL '16 days'),
(12, NOW() - INTERVAL '21 days'),
(13, NOW() - INTERVAL '26 days'),
(14, NOW() - INTERVAL '31 days'),
(15, NOW() - INTERVAL '36 days');

-- DETALLES DE VENTAS
INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 2, 6000.00),
(2, 2, 1, 4800.00),
(3, 3, 3, 180.00),
(4, 4, 1, 1200.00),
(5, 5, 1, 1300.00),
(6, 6, 4, 450.00),
(7, 7, 2, 250.00),
(8, 8, 5, 90.00),
(9, 9, 1, 1500.00),
(10, 10, 1, 2500.00),
(11, 11, 1, 4200.00),
(12, 12, 1, 1800.00),
(13, 13, 1, 5500.00),
(14, 14, 2, 500.00),
(15, 15, 1, 1100.00);


-- insert tablas auxiliares

INSERT INTO auditoria_ventas (venta_id, usuario, fecha) VALUES
(1, 'admin', NOW() - INTERVAL '10 days'),
(2, 'vendedor1', NOW() - INTERVAL '9 days'),
(3, 'admin', NOW() - INTERVAL '8 days'),
(4, 'vendedor2', NOW() - INTERVAL '7 days'),
(5, 'admin', NOW() - INTERVAL '6 days');
INSERT INTO alertas_stock (producto_id, nombre_producto, mensaje, fecha) VALUES
(1, 'Laptop Dell XPS 13', 'El producto se agotó en inventario', NOW() - INTERVAL '5 days'),
(5, 'Teclado Mecánico Redragon', 'El producto se agotó en inventario', NOW() - INTERVAL '3 days'),
(14, 'Router TP-Link', 'El producto se agotó en inventario', NOW() - INTERVAL '2 days');

INSERT INTO historial_precios (producto_id, precio_anterior, precio_nuevo, fecha) VALUES
(1, 4500.00, 4700.00, NOW() - INTERVAL '15 days'),
(1, 4700.00, 5000.00, NOW() - INTERVAL '10 days'),
(2, 5200.00, 5300.00, NOW() - INTERVAL '8 days'),
(3, 250.00, 275.00, NOW() - INTERVAL '6 days'),
(5, 300.00, 350.00, NOW() - INTERVAL '2 days');
