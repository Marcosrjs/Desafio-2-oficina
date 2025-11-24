-- Quais agendamentos futuros por atendente, com situação?
SELECT
  a.agendamento_id,
  a.data_horario,
  c.nome AS cliente,
  v.placa,
  f.nome AS atendente,
  a.status,
  a.motivo
FROM agendamentos a
JOIN clientes c ON c.cliente_id = a.cliente_id
JOIN veiculos v ON v.veiculo_id = a.veiculo_id
LEFT JOIN funcionarios f ON f.funcionario_id = a.funcionario_id
WHERE a.data_horario > NOW()
ORDER BY a.data_horario;
