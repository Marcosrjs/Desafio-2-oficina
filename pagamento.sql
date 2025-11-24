-- Para cada pagamento, qual o saldo a receber da OS?
-- Saldo = total_os - total_pago_acumulado
WITH totais AS (
  SELECT os.os_id,
         COALESCE(SUM(s.quantidade * s.preco_unitario), 0) AS total_serv,
         COALESCE(SUM(p.quantidade * p.preco_unitario), 0) AS total_pec,
         COALESCE(SUM(s.quantidade * s.preco_unitario), 0) +
         COALESCE(SUM(p.quantidade * p.preco_unitario), 0) AS total_os
  FROM ordens_servico os
  LEFT JOIN os_servicos s ON s.os_id = os.os_id
  LEFT JOIN os_pecas p ON p.os_id = os.os_id
  GROUP BY os.os_id
),
pagos AS (
  SELECT os_id, COALESCE(SUM(valor), 0) AS total_pago
  FROM pagamentos
  WHERE status = 'Pago'
  GROUP BY os_id
)
SELECT t.os_id, t.total_os, COALESCE(pg.total_pago, 0) AS total_pago, (t.total_os - COALESCE(pg.total_pago, 0)) AS saldo
FROM totais t
LEFT JOIN pagos pg ON pg.os_id = t.os_id
ORDER BY saldo DESC;
