# 🛠️ Banco de Dados da Oficina Mecânica

Este projeto foi desenvolvido como parte do desafio de modelagem e implementação de banco de dados relacional para o contexto de uma **oficina mecânica**.  
O objetivo é criar um esquema lógico, implementar o banco em SQL, inserir dados de teste e elaborar consultas complexas para análise e relatórios.

---

## 📌 Contexto

A oficina atende clientes que possuem veículos, realiza diagnósticos, executa serviços, utiliza peças de estoque e emite ordens de serviço com pagamentos.  
O banco de dados foi projetado para permitir:

- Gestão de clientes e veículos  
- Controle de ordens de serviço  
- Registro de serviços e peças utilizados  
- Administração de funcionários e fornecedores  
- Controle de estoque e pagamentos  
- Relatórios de faturamento, lucratividade e eficiência operacional  

---

## 🗂️ Esquema Lógico Relacional

### Principais entidades e relacionamentos

- **Clientes** → possuem veículos e ordens de serviço  
- **Veículos** → vinculados a clientes  
- **Funcionários** → mecânicos, atendentes e gerentes  
- **Serviços** → catálogo de serviços oferecidos  
- **Peças** → estoque de peças, vinculadas a fornecedores  
- **Ordens de Serviço (OS)** → consolidam serviços, peças e pagamentos  
- **Pagamentos** → registros financeiros das OS  
- **Agendamentos** → marcação de atendimentos futuros  

### Cardinalidades

- Cliente (1) — (N) Veículo  
- Veículo (1) — (N) Ordem de Serviço  
- Ordem de Serviço (1) — (N) Serviços e Peças  
- Serviço (1) — (N) OS_Servicos  
- Peça (1) — (N) OS_Pecas  
- Fornecedor (1) — (N) Peças  
- Ordem de Serviço (1) — (N) Pagamentos  
- Cliente (1) — (N) Agendamentos  

---

## 📜 Estrutura do Projeto

- `schema.sql` → criação das tabelas e relacionamentos  
- `seed.sql` → inserção de dados de teste  
- `queries.sql` → consultas SQL demonstrativas  

---

## 🔎 Exemplos de Consultas

- **Recuperações simples (SELECT):**
  ```sql
  SELECT servico_id, nome, preco_base FROM servicos ORDER BY nome;
