-- Listar ordens com cliente, veículo e totais
SELECT
  os.os_id,
  c.nome AS cliente,
  v.placa,
  v.marca || ' ' || v.modelo AS veiculo,
  os.status,
  vt.total_servicos,
  vt.total_pecas,
  vt.total_os
FROM ordens_servico os
JOIN clientes c ON c.cliente_id = os.cliente_id
JOIN veiculos v ON v.veiculo_id = os.veiculo_id
JOIN vw_os_totais vt ON vt.os_id = os.os_id
ORDER BY os.data_abertura DESC;
