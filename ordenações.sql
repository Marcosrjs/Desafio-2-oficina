-- Quais peças com menor estoque primeiro?
SELECT peca_id, nome, estoque, preco_venda
FROM pecas
ORDER BY estoque ASC, nome ASC;
