-- Listar los productos con stock menor a 5 unidades
SELECT id, nombre, categoria, stock
FROM productos
WHERE stock < 5;

-- Calcular ventas totales de un mes específico 
SELECT DATE_TRUNC('month', v.fecha) AS mes,
       SUM(vd.cantidad * vd.precio_unitario) AS total_ventas
FROM ventas v
JOIN ventas_detalle vd ON v.id = vd.venta_id
WHERE DATE_TRUNC('month', v.fecha) = DATE '2025-08-01'
GROUP BY mes;

-- Obtener el cliente con más compras realizadas
SELECT c.id, c.nombre, COUNT(v.id) AS total_compras
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
GROUP BY c.id, c.nombre
ORDER BY total_compras DESC
LIMIT 1;

-- Listar los 5 productos más vendidos
SELECT p.id, p.nombre, SUM(vd.cantidad) AS total_vendidos
FROM productos p
JOIN ventas_detalle vd ON p.id = vd.producto_id
GROUP BY p.id, p.nombre
ORDER BY total_vendidos DESC
LIMIT 5;

-- Consultar ventas realizadas en un rango de fechas de tres días y un mes 
SELECT v.id, v.fecha, c.nombre AS cliente, SUM(vd.cantidad * vd.precio_unitario) AS total_venta
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN ventas_detalle vd ON v.id = vd.venta_id
WHERE v.fecha BETWEEN '2025-05-01' AND '2025-08-06'
GROUP BY v.id, v.fecha, c.nombre
ORDER BY v.fecha;

-- Identificar clientes que no han comprado en el último mes
SELECT c.id, c.nombre, c.correo
FROM clientes c
LEFT JOIN ventas v ON c.id = v.cliente_id 
  AND v.fecha >= NOW() - INTERVAL '1 months'
WHERE v.id IS NULL;