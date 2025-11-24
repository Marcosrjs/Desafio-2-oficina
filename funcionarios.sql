-- Quem são os funcionários ativos ordenados por cargo e nome?
SELECT funcionario_id, nome, cargo, ativo
FROM funcionarios
WHERE ativo = TRUE
ORDER BY cargo, nome;
