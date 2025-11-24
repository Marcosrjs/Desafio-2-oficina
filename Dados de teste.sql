-- Clientes
INSERT INTO clientes (nome, cpf, telefone, email, endereco) VALUES
('Marcos Silva', '12345678901', '71-99999-0001', 'marcos@example.com', 'Av. Sete, Salvador'),
('Ana Souza',   '98765432100', '71-98888-0002', 'ana@example.com',   'Rio Vermelho, Salvador'),
('Carlos Lima', '11122233344', '71-97777-0003', 'carlos@example.com','Barra, Salvador');

-- Funcionários
INSERT INTO funcionarios (nome, cpf, telefone, email, cargo) VALUES
('João Mecânico', '22233344455', '71-90000-1001', 'joao@example.com', 'Mecânico'),
('Paula Atendente','33344455566','71-90000-1002','paula@example.com','Atendente'),
('Rita Gerente',  '44455566677', '71-90000-1003', 'rita@example.com', 'Gerente');

-- Fornecedores
INSERT INTO fornecedores (nome, cnpj, telefone, email) VALUES
('AutoPeças Bahia', '12345678000199', '71-3123-0001', 'contato@autobahia.com'),
('MecParts',        '98765432000155', '71-3123-0002', 'vendas@mecparts.com');

-- Peças
INSERT INTO pecas (fornecedor_id, nome, codigo, custo, preco_venda, estoque) VALUES
(1, 'Filtro de óleo', 'FIL-001', 20.00, 45.00, 50),
(1, 'Pastilha de freio', 'PAF-010', 80.00, 150.00, 30),
(2, 'Correia dentada', 'COR-200', 60.00, 120.00, 20);

-- Serviços
INSERT INTO servicos (nome, descricao, preco_base) VALUES
('Troca de óleo', 'Troca de óleo e filtro', 120.00),
('Alinhamento', 'Alinhamento de direção', 90.00),
('Revisão completa', 'Checklist geral', 350.00),
('Troca de pastilhas', 'Substituição de pastilhas de freio', 180.00);

-- Veículos
INSERT INTO veiculos (cliente_id, placa, marca, modelo, ano, cor) VALUES
(1, 'ABC1D23', 'Toyota', 'Corolla', 2018, 'Prata'),
(2, 'EFG4H56', 'Volkswagen', 'Gol', 2015, 'Branco'),
(3, 'IJK7L89', 'Honda', 'Civic', 2020, 'Preto');

-- Ordens de serviço
INSERT INTO ordens_servico (veiculo_id, cliente_id, diagnostico, observacoes, status) VALUES
(1, 1, 'Vazamento mínimo de óleo', 'Cliente relata ruído ao ligar', 'Em execução'),
(2, 2, 'Freio vibrando', 'Sugere troca das pastilhas', 'Aberta'),
(3, 3, 'Revisão 20k', 'Agendar alinhamento após revisão', 'Aberta');

-- Itens de serviços
INSERT INTO os_servicos (os_id, servico_id, funcionario_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 1, 120.00), -- Troca de óleo
(1, 2, 1, 1, 90.00),  -- Alinhamento
(2, 4, 1, 1, 180.00), -- Troca de pastilhas
(3, 3, 1, 1, 350.00); -- Revisão completa

-- Itens de peças
INSERT INTO os_pecas (os_id, peca_id, funcionario_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 1, 45.00),  -- Filtro de óleo
(2, 2, 1, 1, 150.00), -- Pastilha de freio
(3, 3, 1, 1, 120.00); -- Correia dentada

-- Pagamentos
INSERT INTO pagamentos (os_id, metodo, valor, status) VALUES
(1, 'Pix', 255.00, 'Pago'),
(2, 'Cartão', 0.00, 'Pendente'),
(3, 'Dinheiro', 0.00, 'Pendente');

-- Agendamentos
INSERT INTO agendamentos (cliente_id, veiculo_id, funcionario_id, data_horario, motivo, observacoes) VALUES
(1, 1, 2, NOW() + INTERVAL '1 day', 'Troca de óleo', 'Cliente prefere manhã'),
(2, 2, 2, NOW() + INTERVAL '2 days', 'Freio', 'Trazer carro lavado'),
(3, 3, 2, NOW() + INTERVAL '3 days', 'Revisão', 'Tempo estimado: 3h');
