-- PROVEEDORES
INSERT INTO proveedores (nombre, correo, telefono, direccion) VALUES
('TechSupplier SA', 'contacto@techsupplier.com', '3101111111', 'Calle 10 #12-34'),
('Gadgets Import', 'ventas@gadgets.com', '3202222222', 'Carrera 45 #23-12'),
('ElectroWorld', 'info@electroworld.com', '3003333333', 'Av. 30 #11-20'),
('CompuGlobal', 'support@compuglobal.com', '3114444444', 'Calle 100 #50-25'),
('DigitalStore', 'ventas@digitalstore.com', '3155555555', 'Carrera 70 #45-10'),
('MegaTech', 'info@megatech.com', '3106666666', 'Av. 68 #12-33'),
('CompuZone', 'contact@compuzone.com', '3127777777', 'Calle 45 #15-60'),
('SmartTech', 'soporte@smarttech.com', '3198888888', 'Carrera 15 #34-80'),
('ElectroMax', 'ventas@electromax.com', '3189999999', 'Av. 80 #20-15'),
('GlobalTech', 'info@globaltech.com', '3171010101', 'Calle 22 #50-90'),
('HardSolutions', 'sales@hardsolutions.com', '3141212121', 'Carrera 7 #60-22'),
('LaptopWorld', 'ventas@laptopworld.com', '3161313131', 'Av. 40 #25-14'),
('GigaTech', 'info@gigatech.com', '3131414141', 'Calle 77 #45-32'),
('SuperGadgets', 'ventas@supergadgets.com', '3151515151', 'Carrera 11 #20-40'),
('MicroTech', 'support@microtech.com', '3121616161', 'Av. 20 #33-21');

-- PRODUCTOS
INSERT INTO productos (nombre, categoria, precio, stock, proveedor_id) VALUES
('Laptop Dell XPS 13', 'Laptops', 4500.00, 10, 1),
('iPhone 14', 'Smartphones', 5200.00, 15, 2),
('Mouse Logitech MX', 'Accesorios', 250.00, 30, 3),
('Monitor Samsung 24"', 'Monitores', 800.00, 20, 4),
('Teclado Mecánico Redragon', 'Accesorios', 300.00, 25, 5),
('Disco Duro 1TB Seagate', 'Almacenamiento', 350.00, 40, 6),
('Memoria RAM 16GB Kingston', 'Componentes', 400.00, 35, 7),
('Cargador Universal', 'Accesorios', 120.00, 50, 8),
('AirPods Pro', 'Auriculares', 950.00, 18, 9),
('Tablet Samsung Galaxy', 'Tablets', 2000.00, 12, 10),
('Laptop HP Pavilion', 'Laptops', 3800.00, 14, 11),
('Impresora Epson L3150', 'Impresoras', 1200.00, 8, 12),
('Cámara Canon EOS', 'Cámaras', 5000.00, 6, 13),
('Router TP-Link', 'Redes', 450.00, 22, 14),
('Disco SSD 2TB', 'Almacenamiento', 1600.00, 3, 15),
('Disco SSD 512GB', 'Almacenamiento', 600.00, 28, 15);

-- CLIENTES
INSERT INTO clientes (nombre, correo, telefono, estado) VALUES
('Juan Pérez', 'juanperez@mail.com', '3101112233', 'activo'),
('María López', 'marialopez@mail.com', '3204445566', 'activo'),
('Carlos Ramírez', 'carlosramirez@mail.com', '3117778899', 'activo'),
('Laura Torres', 'lauratorres@mail.com', '3001234567', 'activo'),
('Andrés Gómez', 'andresgomez@mail.com', '3159876543', 'activo'),
('Sofía Herrera', 'sofia@mail.com', '3136547890', 'activo'),
('Felipe Castro', 'felipe@mail.com', '3163332222', 'activo'),
('Ana Morales', 'ana@mail.com', '3194443333', 'activo'),
('Daniel Ruiz', 'daniel@mail.com', '3125556666', 'activo'),
('Camila Vega', 'camila@mail.com', '3181112222', 'activo'),
('Oscar Méndez', 'oscar@mail.com', '3149998888', 'activo'),
('Lucía Ríos', 'lucia@mail.com', '3177775555', 'activo'),
('Jorge Romero', 'jorge@mail.com', '3108889999', 'activo'),
('Paula Sánchez', 'paula@mail.com', '3203331111', 'activo'),
('Mateo Vargas', 'mateo@mail.com', '3192224444', 'activo');

-- VENTAS
INSERT INTO ventas (cliente_id, fecha) VALUES
(1, NOW() - INTERVAL '10 days'),
(2, NOW() - INTERVAL '9 days'),
(3, NOW() - INTERVAL '8 days'),
(4, NOW() - INTERVAL '7 days'),
(5, NOW() - INTERVAL '6 days'),
(6, NOW() - INTERVAL '5 days'),
(7, NOW() - INTERVAL '4 days'),
(8, NOW() - INTERVAL '3 days'),
(9, NOW() - INTERVAL '2 days'),
(10, NOW() - INTERVAL '1 day'),
(11, NOW() - INTERVAL '15 days'),
(12, NOW() - INTERVAL '20 days'),
(13, NOW() - INTERVAL '25 days'),
(14, NOW() - INTERVAL '30 days'),
(15, NOW() - INTERVAL '35 days');

-- DETALLES DE VENTAS
INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 4500.00),
(2, 2, 1, 5200.00),
(3, 3, 2, 250.00),
(4, 4, 1, 800.00),
(5, 5, 1, 300.00),
(6, 6, 2, 350.00),
(7, 7, 1, 400.00),
(8, 8, 3, 120.00),
(9, 9, 1, 950.00),
(10, 10, 1, 2000.00),
(11, 11, 1, 3800.00),
(12, 12, 1, 1200.00),
(13, 13, 1, 5000.00),
(14, 14, 2, 450.00),
(15, 15, 1, 600.00);