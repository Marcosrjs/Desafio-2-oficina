-- Criação do schema 
CREATE SCHEMA oficina;
SET search_path TO oficina;

-- Tabela de clientes
CREATE TABLE clientes (
  cliente_id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(120),
  endereco VARCHAR(200),
  data_cadastro DATE DEFAULT CURRENT_DATE
);

-- Tabela de veículos
CREATE TABLE veiculos (
  veiculo_id SERIAL PRIMARY KEY,
  cliente_id INT NOT NULL REFERENCES clientes(cliente_id),
  placa VARCHAR(10) UNIQUE NOT NULL,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  ano INT CHECK (ano >= 1950 AND ano <= EXTRACT(YEAR FROM CURRENT_DATE) + 1),
  cor VARCHAR(30)
);

-- Tabela de funcionários
CREATE TABLE funcionarios (
  funcionario_id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  email VARCHAR(120),
  cargo VARCHAR(40) NOT NULL, -- 'Mecânico', 'Atendente', 'Gerente', etc.
  ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de serviços (catálogo)
CREATE TABLE servicos (
  servico_id SERIAL PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  descricao TEXT,
  preco_base NUMERIC(10,2) NOT NULL CHECK (preco_base >= 0)
);

-- Tabela de fornecedores
CREATE TABLE fornecedores (
  fornecedor_id SERIAL PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  cnpj CHAR(14) UNIQUE,
  telefone VARCHAR(20),
  email VARCHAR(120)
);

-- Tabela de peças (estoque)
CREATE TABLE pecas (
  peca_id SERIAL PRIMARY KEY,
  fornecedor_id INT REFERENCES fornecedores(fornecedor_id),
  nome VARCHAR(100) NOT NULL,
  codigo VARCHAR(50) UNIQUE,
  custo NUMERIC(10,2) NOT NULL CHECK (custo >= 0),
  preco_venda NUMERIC(10,2) NOT NULL CHECK (preco_venda >= 0),
  estoque INT NOT NULL DEFAULT 0 CHECK (estoque >= 0)
);

-- Tabela de ordens de serviço
CREATE TABLE ordens_servico (
  os_id SERIAL PRIMARY KEY,
  veiculo_id INT NOT NULL REFERENCES veiculos(veiculo_id),
  cliente_id INT NOT NULL REFERENCES clientes(cliente_id),
  data_abertura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_fechamento TIMESTAMP,
  status VARCHAR(20) NOT NULL DEFAULT 'Aberta', -- 'Aberta', 'Em execução', 'Concluída', 'Cancelada'
  diagnostico TEXT,
  observacoes TEXT
);

-- Itens de serviço realizados na OS
CREATE TABLE os_servicos (
  os_servico_id SERIAL PRIMARY KEY,
  os_id INT NOT NULL REFERENCES ordens_servico(os_id) ON DELETE CASCADE,
  servico_id INT NOT NULL REFERENCES servicos(servico_id),
  funcionario_id INT REFERENCES funcionarios(funcionario_id),
  quantidade NUMERIC(10,2) NOT NULL DEFAULT 1 CHECK (quantidade > 0),
  preco_unitario NUMERIC(10,2) NOT NULL CHECK (preco_unitario >= 0)
);

-- Itens de peças utilizadas na OS
CREATE TABLE os_pecas (
  os_peca_id SERIAL PRIMARY KEY,
  os_id INT NOT NULL REFERENCES ordens_servico(os_id) ON DELETE CASCADE,
  peca_id INT NOT NULL REFERENCES pecas(peca_id),
  funcionario_id INT REFERENCES funcionarios(funcionario_id),
  quantidade INT NOT NULL CHECK (quantidade > 0),
  preco_unitario NUMERIC(10,2) NOT NULL CHECK (preco_unitario >= 0)
);

-- Pagamentos da OS
CREATE TABLE pagamentos (
  pagamento_id SERIAL PRIMARY KEY,
  os_id INT NOT NULL REFERENCES ordens_servico(os_id) ON DELETE CASCADE,
  data_pagamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  metodo VARCHAR(20) NOT NULL, -- 'Pix', 'Cartão', 'Dinheiro', 'Boleto'
  valor NUMERIC(10,2) NOT NULL CHECK (valor >= 0),
  status VARCHAR(20) NOT NULL DEFAULT 'Pago' -- 'Pago', 'Pendente', 'Estornado'
);

-- Agendamentos
CREATE TABLE agendamentos (
  agendamento_id SERIAL PRIMARY KEY,
  cliente_id INT NOT NULL REFERENCES clientes(cliente_id),
  veiculo_id INT NOT NULL REFERENCES veiculos(veiculo_id),
  funcionario_id INT REFERENCES funcionarios(funcionario_id),
  data_horario TIMESTAMP NOT NULL,
  motivo VARCHAR(120) NOT NULL,
  observacoes TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'Agendado' -- 'Agendado', 'Atendido', 'Cancelado', 'Não compareceu'
);

-- Views auxiliares (opcional)
CREATE VIEW vw_os_totais AS
SELECT
  os.os_id,
  os.cliente_id,
  os.veiculo_id,
  COALESCE(SUM(s.quantidade * s.preco_unitario), 0) AS total_servicos,
  COALESCE(SUM(p.quantidade * p.preco_unitario), 0) AS total_pecas,
  COALESCE(SUM(s.quantidade * s.preco_unitario), 0) +
  COALESCE(SUM(p.quantidade * p.preco_unitario), 0) AS total_os
FROM ordens_servico os
LEFT JOIN os_servicos s ON s.os_id = os.os_id
LEFT JOIN os_pecas p ON p.os_id = os.os_id
GROUP BY os.os_id, os.cliente_id, os.veiculo_id;
