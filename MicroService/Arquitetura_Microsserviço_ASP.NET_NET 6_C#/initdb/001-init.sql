-- Exemplo simples para validar inicialização:
CREATE TABLE IF NOT EXISTS healthcheck (id INT PRIMARY KEY, ok TINYINT);
INSERT INTO healthcheck (id, ok) VALUES (1,1)
  ON DUPLICATE KEY UPDATE ok=VALUES(ok);
