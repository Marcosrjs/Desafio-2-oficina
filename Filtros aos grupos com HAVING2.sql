-- Quais serviços do catálogo têm preço médio aplicado nas OS acima do preço base?
SELECT sv.servico_id, sv.nome,
       AVG(s.preco_unitario) AS preco_medio_aplicado,
       sv.preco_base
FROM servicos sv
JOIN os_servicos s ON s.servico_id = sv.servico_id
GROUP BY sv.servico_id, sv.nome, sv.preco_base
HAVING AVG(s.preco_unitario) > sv.preco_base
ORDER BY preco_medio_aplicado DESC;
