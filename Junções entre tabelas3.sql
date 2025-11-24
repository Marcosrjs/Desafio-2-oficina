-- Peças utilizadas por fornecedor, com quantidade total e faturamento
SELECT
  forn.nome AS fornecedor,
  pe.nome AS peca,
  SUM(op.quantidade) AS qtd_total,
  SUM(op.quantidade * op.preco_unitario) AS faturamento
FROM os_pecas op
JOIN pecas pe ON pe.peca_id = op.peca_id
LEFT JOIN fornecedores forn ON forn.fornecedor_id = pe.fornecedor_id
GROUP BY forn.nome, pe.nome
ORDER BY faturamento DESC;
