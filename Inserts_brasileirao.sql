INSERT INTO estadio (nome, cidade, capacidade) VALUES
('Arena do Gremio', 'Porto Alegre', 55662),
('Maracana', 'Rio de Janeiro', 78838),
('Allianz Parque', 'Sao Paulo', 43713),
('Beira-Rio', 'Porto Alegre', 50128),
('Neo Quimica Arena', 'Sao Paulo', 49205),
('Arena MRV', 'Belo Horizonte', 44892),
('Mineirao', 'Belo Horizonte', 61846),
('Vila Belmiro', 'Sao Paulo', 16068);

INSERT INTO clube(nome, cidade, ano_fundacao, id_estadio) VALUES
('Gremio', 'Porto Alegre', 1903, 1),
('Flamengo', 'Rio de Janeiro', 1895, 2),
('Palmeiras', 'Sao Paulo', 1914, 3),
('Internacional', 'Porto Alegre', 1909, 4),
('Corinthians', 'Sao Paulo', 1910, 5),
('Atletico-MG', 'Belo Horizonte', 1908, 6),
('Cruzeiro', 'Belo Horizonte', 1921, 7),
('Santos', 'Sao Paulo', 1912, 8);

INSERT INTO temporada(ano, data_inicio, data_fim, id_campeao) VALUES
(2026, '2026-02-01', NULL, NULL);

INSERT INTO treinador(nome, data_nascimento, nacionalidade, id_clube) VALUES
('Renato Portaluppi', '1962-09-09', 'Brasil', 1),
('Leonardo Jardim', '1974-08-01', 'Portugal', 2),
('Abel Ferreira', '1978-12-22', 'Portugal', 3),
('Eduardo Baptista', '1970-03-30', 'Brasil', 4),
('Clarence Seedorf', '1976-04-01', 'Holanda', 5),
('Eduardo Dominguez', '1978-09-01', 'Argentina', 6),
('Artur Jorge', '1972-01-01', 'Portugal', 7),
('Cuca', '1963-06-07', 'Brasil', 8);

INSERT INTO jogador (nome, data_nascimento, posicao, nacionalidade, numero_camisa, id_clube) VALUES
--Grêmio
('Weverton', NULL, 'Goleiro', 'Brasil', NULL, 1),
('Gustavo Martins', NULL, 'Zagueiro', 'Brasil', NULL, 1),
('Wallace', NULL, 'Zagueiro', 'Brasil', NULL, 1),
('Balbuena', NULL, 'Zagueiro', 'Paraguai', NULL, 1),
('Joao Pedro', NULL, 'Lateral', 'Brasil', NULL, 1),
('Marlon', NULL, 'Lateral', 'Brasil', NULL, 1),
('Villasanti', NULL, 'Volante', 'Paraguai', NULL, 1),
('Noriega', NULL, 'Meia', 'Peru', NULL, 1),
('Amuzu', NULL, 'Atacante', 'Belgica', NULL, 1),
('Enamorado', NULL, 'Atacante', 'Colombia', NULL, 1),
('Carlos Vinicius', NULL, 'Atacante', 'Brasil', NULL, 1),
--Flamengo
('Agustin Rossi', NULL, 'Goleiro', 'Argentina', NULL, 2),
('Guillermo Varela', NULL, 'Lateral', 'Uruguai', NULL, 2),
('Leo Ortiz', NULL, 'Zagueiro', 'Brasil', NULL, 2),
('Leo Pereira', NULL, 'Zagueiro', 'Brasil', NULL, 2),
('Ayrton Lucas', NULL, 'Lateral', 'Brasil', NULL, 2),   
('Erick Pulgar', NULL, 'Volante', 'Chile', NULL, 2),
('Jorginho', NULL, 'Volante', 'Italia', NULL, 2),
('Giorgian de Arrascaeta', NULL, 'Meia', 'Uruguai', NULL, 2),
('Jorge Carrascal', NULL, 'Meia', 'Colombia', NULL, 2),
('Pedro', NULL, 'Atacante', 'Brasil', NULL, 2),
('Samuel Lino', NULL, 'Atacante', 'Brasil', NULL, 2),
--Palmeiras
('Carlos Miguel', NULL, 'Goleiro', 'Brasil', 1, 3),
('Murilo', NULL, 'Zagueiro', 'Brasil', NULL, 3),
('Gustavo Gomez', NULL, 'Zagueiro', 'Paraguai', NULL, 3),
('Bruno Fuchs', NULL, 'Zagueiro', 'Brasil', NULL, 3),
('Khellven', NULL, 'Lateral', 'Brasil', NULL, 3),
('Arthur', NULL, 'Lateral', 'Brasil', NULL, 3),
('Marlon Freitas', NULL, 'Volante', 'Brasil', NULL, 3),
('Andreas Pereira', NULL, 'Meia', 'Brasil', NULL, 3),
('Mauricio', NULL, 'Meia', 'Brasil', NULL, 3),
('Jhon Arias', NULL, 'Atacante', 'Colombia', NULL, 3),
('Vitor Roque', NULL, 'Atacante', 'Brasil', 9, 3),
--Internacional
('Kauan Jesus', NULL, 'Goleiro', 'Brasil', NULL, 4),
('Bruno Gomes', NULL, 'Zagueiro', 'Brasil', NULL, 4),
('Gabriel Mercado', NULL, 'Zagueiro', 'Argentina', NULL, 4),
('Juninho', NULL, 'Zagueiro', 'Brasil', NULL, 4),
('Braian Aguirre', NULL, 'Lateral', 'Argentina', NULL, 4),
('Matheus Bahia', NULL, 'Lateral', 'Brasil', NULL, 4),
('Rodrigo Villagra', NULL, 'Volante', 'Argentina', NULL, 4),
('Thiago Maia', NULL, 'Volante', 'Brasil', NULL, 4),
('Johan Carbonero', NULL, 'Atacante', 'Colombia', NULL, 4),
('Vitinho', NULL, 'Atacante', 'Brasil', NULL, 4),
('Alerrandro', NULL, 'Atacante', 'Brasil', NULL, 4),
--Corinthians
('Hugo Souza', NULL, 'Goleiro', 'Brasil', NULL, 5),
('Pedro Milans', NULL, 'Lateral', 'Uruguai', NULL, 5),
('Andre Ramalho', NULL, 'Zagueiro', 'Brasil', NULL, 5),
('Gustavo Henrique', NULL, 'Zagueiro', 'Brasil', NULL, 5),
('Fabrizio Angileri', NULL, 'Lateral', 'Argentina', NULL, 5),
('Andre Luiz', NULL, 'Volante', 'Brasil', NULL, 5),
('Breno Bidon', NULL, 'Volante', 'Brasil', NULL, 5),
('Rodrigo Garro', NULL, 'Meia', 'Argentina', NULL, 5),
('Matheus Bidu', NULL, 'Meia', 'Brasil', NULL, 5),
('Kaio Cesar', NULL, 'Atacante', 'Brasil', NULL, 5),
('Yuri Alberto', NULL, 'Atacante', 'Brasil', NULL, 5),
--Atlético-MG
('Gabriel Delfim', NULL, 'Goleiro', 'Brasil', NULL, 6),
('Leo Duarte', NULL, 'Zagueiro', 'Brasil', NULL, 6),
('Lyanco', NULL, 'Zagueiro', 'Brasil', NULL, 6),
('Vitor Hugo', NULL, 'Zagueiro', 'Brasil', NULL, 6),
('Renan Lodi', NULL, 'Lateral', 'Brasil', NULL, 6),
('Alan Franco', NULL, 'Volante', 'Equador', NULL, 6),
('Kevin Castano', NULL, 'Volante', 'Colombia', NULL, 6),
('Maycon', NULL, 'Meia', 'Brasil', NULL, 6),
('Bernard', NULL, 'Meia', 'Brasil', NULL, 6),
('Victor Hugo', NULL, 'Atacante', 'Brasil', NULL, 6),
('Tomas Cuello', NULL, 'Atacante', 'Argentina', NULL, 6),
--Cruzeiro
('Otavio', NULL, 'Goleiro', 'Brasil', 81, 7),
('Fagner', NULL, 'Lateral', 'Brasil', 23, 7),
('Fabricio Bruno', NULL, 'Zagueiro', 'Brasil', 15, 7),
('Jonathan Jesus', NULL, 'Zagueiro', 'Brasil', 34, 7),
('Gabriel Rojas', NULL, 'Lateral', 'Argentina', 27, 7),
('Lucas Romero', NULL, 'Volante', 'Argentina', 29, 7),
('Ze Lucas', NULL, 'Volante', 'Brasil', 5, 7),
('Gerson', NULL, 'Meia', 'Brasil', 8, 7),
('Bruno Rodrigues', NULL, 'Atacante', 'Brasil', 9, 7),
('Keny Arroyo', NULL, 'Atacante', 'Equador', 99, 7),
('Kaio Jorge', NULL, 'Atacante', 'Brasil', 19, 7),
--Santos
('Diogenes', NULL, 'Goleiro', 'Brasil', NULL, 8),
('Rodinei', NULL, 'Lateral', 'Brasil', NULL, 8),
('Joao Alencar', NULL, 'Zagueiro', 'Brasil', NULL, 8),
('Luan Peres', NULL, 'Zagueiro', 'Brasil', NULL, 8),
('Barreal', NULL, 'Lateral', 'Argentina', NULL, 8),
('Christian Oliva', NULL, 'Volante', 'Uruguai', NULL, 8),
('Gustavo Henrique', NULL, 'Volante', 'Brasil', NULL, 8),
('Philippe Coutinho', NULL, 'Meia', 'Brasil', NULL, 8),
('Gabriel Bontempo', NULL, 'Meia', 'Brasil', NULL, 8),
('Everton Cebolinha', NULL, 'Atacante', 'Brasil', NULL, 8),
('Gabigol', NULL, 'Atacante', 'Brasil', NULL, 8);

INSERT INTO partida(id_temporada, rodada, data_hora, id_clube_casa, id_clube_fora, gols_casa, gols_fora, id_estadio, publico) VALUES
--RODADA 1
(1, 1, '2026-02-01 16:00:00', 2, 8, 2, 1, 2, 62000),
(1, 1, '2026-02-01 18:30:00', 3, 7, 1, 0, 3, 40100),
(1, 1, '2026-02-01 19:00:00', 1, 6, 4, 0, 1, 38500),
(1, 1, '2026-02-01 21:30:00', 4, 5, 1, 1, 4, 41200),
--RODADA 2
(1, 2, '2026-02-08 16:00:00', 8, 7, 0, 2, 8, 14800),
(1, 2, '2026-02-08 18:30:00', 2, 6, 3, 0, 2, 67800),
(1, 2, '2026-02-08 19:00:00', 3, 5, 2, 1, 3, 41900),
(1, 2, '2026-02-08 21:30:00', 1, 4, 7, 1, 1, 52300),
--RODADA 3
(1, 3, '2026-02-15 16:00:00', 7, 6, 1, 1, 7, 48700),
(1, 3, '2026-02-15 18:30:00', 8, 5, 1, 0, 8, 15200),
(1, 3, '2026-02-15 19:00:00', 2, 4, 2, 2, 2, 70200),
(1, 3, '2026-02-15 21:30:00', 3, 1, 0, 1, 3, 42500),
--RODADA 4
(1, 4, '2026-02-22 16:00:00', 6, 5, 2, 1, 6, 39800),
(1, 4, '2026-02-22 18:30:00', 7, 4, 0, 1, 7, 51000),
(1, 4, '2026-02-22 19:00:00', 8, 1, 1, 2, 8, 15600),
(1, 4, '2026-02-22 21:30:00', 2, 3, 1, 1, 2, 72500),
--RODADA 5
(1, 5, '2026-03-01 16:00:00', 5, 4, 0, 0, 5, 44300),
(1, 5, '2026-03-01 18:30:00', 6, 1, 1, 3, 6, 37900),
(1, 5, '2026-03-01 19:00:00', 7, 3, 2, 2, 7, 55600),
(1, 5, '2026-03-01 21:30:00', 8, 2, 0, 2, 8, 15900);

INSERT INTO gol (id_partida, id_marcador, minuto, tipo) VALUES
-- Partida 1: Flamengo 2x1 Santos
(1, 21, 15, 'Normal'),
(1, 19, 60, 'Penalti'),
(1, 86, 78, 'Normal'),
-- Partida 2: Palmeiras 1x0 Cruzeiro
(2, 33, 33, 'Normal'),
-- Partida 3: Grêmio 4x0 Atlético-MG
(3, 11, 18, 'Normal'),
(3, 9, 34, 'Normal'),
(3, 10, 61, 'Penalti'),
(3, 8, 77, 'Normal'),
-- Partida 4: Internacional 1x1 Corinthians
(4, 44, 22, 'Normal'),
(4, 55, 70, 'Normal'),
-- Partida 5: Santos 0x2 Cruzeiro
(5, 77, 41, 'Normal'),
(5, 74, 85, 'Falta'),
-- Partida 6: Flamengo 3x0 Atlético-MG
(6, 21, 10, 'Normal'),
(6, 21, 55, 'Normal'),
(6, 19, 80, 'Penalti'),
-- Partida 7: Palmeiras 2x1 Corinthians
(7, 33, 28, 'Normal'),
(7, 30, 64, 'Falta'),
(7, 52, 89, 'Normal'),
-- Partida 8: Grêmio 7x1 Internacional
(8, 11, 9, 'Normal'),
(8, 9, 21, 'Normal'),
(8, 11, 27, 'Normal'),
(8, 10, 38, 'Normal'),
(8, 44, 50, 'Normal'),
(8, 8, 52, 'Normal'),
(8, 7, 64, 'Falta'),
(8, 11, 70, 'Penalti'),
-- Partida 9: Cruzeiro 1x1 Atlético-MG
(9, 77, 38, 'Normal'),
(9, 66, 66, 'Normal'),
-- Partida 10: Santos 1x0 Corinthians
(10, 88, 52, 'Normal'),
-- Partida 11: Flamengo 2x2 Internacional
(11, 21, 19, 'Normal'),
(11, 36, 67, 'Contra'),
(11, 44, 44, 'Normal'),
(11, 42, 81, 'Normal'),
-- Partida 12: Palmeiras 0x1 Grêmio
(12, 11, 58, 'Normal'),
-- Partida 13: Atlético-MG 2x1 Corinthians
(13, 66, 14, 'Normal'),
(13, 63, 72, 'Penalti'),
(13, 55, 88, 'Normal'),
-- Partida 14: Cruzeiro 0x1 Internacional
(14, 44, 31, 'Normal'),
-- Partida 15: Santos 1x2 Grêmio
(15, 85, 25, 'Normal'),
(15, 10, 41, 'Normal'),
(15, 8, 83, 'Normal'),
-- Partida 16: Flamengo 1x1 Palmeiras
(16, 19, 40, 'Normal'),
(16, 30, 90, 'Normal'),
-- Partida 17: Corinthians 0x0 Internacional
-- Partida 18: Atlético-MG 1x3 Grêmio
(18, 11, 12, 'Normal'),
(18, 9, 40, 'Normal'),
(18, 58, 55, 'Normal'),
(18, 10, 73, 'Normal'),
-- Partida 19: Cruzeiro 2x2 Palmeiras
(19, 77, 9, 'Normal'),
(19, 77, 47, 'Normal'),
(19, 33, 30, 'Normal'),
(19, 25, 76, 'Normal'),
-- Partida 20: Santos 0x2 Flamengo
(20, 21, 35, 'Normal'),
(20, 19, 61, 'Normal');

INSERT INTO cartao (id_partida, id_jogador, minuto, cor) VALUES
(1, 15, 88, 'Amarelo'),
(1, 85, 34, 'Amarelo'),
(3, 58, 80, 'Vermelho'),
(4, 36, 55, 'Amarelo'),
(5, 74, 33, 'Amarelo'),
(7, 52, 70, 'Amarelo'),
(8, 42, 90, 'Amarelo'),
(9, 69, 60, 'Vermelho'),
(11, 36, 75, 'Amarelo'),
(13, 48, 50, 'Amarelo'),
(14, 69, 66, 'Amarelo'),
(15, 81, 79, 'Vermelho'),
(16, 25, 41, 'Amarelo'),
(19, 69, 88, 'Amarelo'),
(19, 25, 70, 'Amarelo');