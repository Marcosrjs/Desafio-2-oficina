-- Quais clientes têm valor acumulado em OS superior a 500?
SELECT c.cliente_id, c.nome, SUM(
  COALESCE(s.quantidade * s.preco_unitario, 0) +
  COALESCE(p.quantidade * p.preco_unitario, 0)
) AS valor_total
FROM clientes c
JOIN ordens_servico os ON os.cliente_id = c.cliente_id
LEFT JOIN os_servicos s ON s.os_id = os.os_id
LEFT JOIN os_pecas p ON p.os_id = os.os_id
GROUP BY c.cliente_id, c.nome
HAVING SUM(
  COALESCE(s.quantidade * s.preco_unitario, 0) +
  COALESCE(p.quantidade * p.preco_unitario, 0)
) > 500
ORDER BY valor_total DESC;
