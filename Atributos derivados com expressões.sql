-- Qual é o total de cada OS (serviços + peças), com margem bruta estimada?
-- Margem bruta estimada = total_os - custo_estimado_pecas (considerando custo cadastrado)
SELECT
  os.os_id,
  COALESCE(SUM(s.quantidade * s.preco_unitario), 0) AS total_servicos,
  COALESCE(SUM(p.quantidade * p.preco_unitario), 0) AS total_pecas,
  COALESCE(SUM(s.quantidade * s.preco_unitario), 0) +
  COALESCE(SUM(p.quantidade * p.preco_unitario), 0) AS total_os,
  COALESCE(SUM(p.quantidade * pe.custo), 0) AS custo_pecas,
  (COALESCE(SUM(s.quantidade * s.preco_unitario), 0) +
   COALESCE(SUM(p.quantidade * p.preco_unitario), 0) -
   COALESCE(SUM(p.quantidade * pe.custo), 0)) AS margem_bruta
FROM ordens_servico os
LEFT JOIN os_servicos s ON s.os_id = os.os_id
LEFT JOIN os_pecas p ON p.os_id = os.os_id
LEFT JOIN pecas pe ON pe.peca_id = p.peca_id
GROUP BY os.os_id
ORDER BY margem_bruta DESC;
