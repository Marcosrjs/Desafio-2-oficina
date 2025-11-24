-- Quais ordens de serviço estão atualmente abertas ou em execução?
SELECT os_id, status, data_abertura
FROM ordens_servico
WHERE status IN ('Aberta', 'Em execução')
ORDER BY data_abertura DESC;
