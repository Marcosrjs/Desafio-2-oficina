-- Quais clientes estão cadastrados e desde quando?
SELECT cliente_id, nome, date_trunc('day', data_cadastro) AS data_cadastro
FROM clientes
ORDER BY data_cadastro DESC;
