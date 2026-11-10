--Simples (uma tabela)

--1.Todos os clubes em ordem alfabética.

SELECT *
FROM clube ORDER BY nome ASC;

--2.Jogadores de uma posição (por exemplo, atacantes).

SELECT *
FROM jogador
WHERE posicao = 'Atacante';

--3.Jogos de uma rodada específica.

SELECT *
FROM partida
WHERE rodada = 5;

--4.Estádios com capacidade acima de 50 mil.

SELECT *
FROM estadio
WHERE capacidade > 50000;

--5.Jogos com público acima de 50 mil.

SELECT *
FROM partida
WHERE publico > 50000;

--6.Clubes de uma cidade (por exemplo, Porto Alegre).

SELECT *
FROM clube
WHERE cidade = 'Porto Alegre';

--7.Treinadores estrangeiros.

SELECT *
FROM treinador
WHERE nacionalidade != 'Brasil';


--Com JOIN

--8. ★ Jogadores de cada clube, com o nome do clube.

SELECT 
    jogador.nome AS jogador,
    clube.nome AS clube
FROM jogador
    JOIN clube ON jogador.id_clube = clube.id_clube;

--9. ★ Lista de jogos com nome do mandante, do visitante e do estádio (a tabela clube entra duas vezes).

SELECT
    mandante.nome AS mandante,
    visitante.nome AS visitante,
    estadio.nome AS estadio
FROM partida
    JOIN clube AS mandante ON partida.id_clube_casa = mandante.id_clube
    JOIN clube AS visitante ON partida.id_clube_fora = visitante.id_clube
    JOIN estadio ON partida.id_estadio = estadio.id_estadio;

--10. Estádio e treinador de cada clube.

SELECT
    estadio.nome AS estadio,
    treinador.nome AS treinador
FROM clube
    JOIN estadio ON clube.id_estadio = estadio.id_estadio
    JOIN treinador ON treinador.id_clube = clube.id_clube
ORDER BY clube.nome;

--11. Todos os gols, com jogador, clube e partida.

SELECT
    jogador.nome AS jogador,
    clube.nome AS clube,
    gol.id_partida AS partida
FROM gol
    JOIN jogador ON gol.id_marcador = jogador.id_jogador
    JOIN clube ON jogador.id_clube = clube.id_clube
ORDER BY gol.id_partida;


--12. Todos os cartões, com jogador, clube e partida.

SELECT
    jogador.nome AS jogador,
    clube.nome AS clube,
    cartao.id_partida AS partida
FROM cartao
    JOIN jogador ON cartao.id_jogador = jogador.id_jogador
    JOIN clube ON jogador.id_clube = clube.id_clube;

--13. Verificação: partidas em que o estádio não é o do mandante (deve vir vazio).

SELECT 
    partida.id_partida,
    partida.id_estadio AS estadio_da_partida,
    clube.id_estadio AS estadio_d  o_clube
FROM partida
    JOIN clube ON partida.id_clube_casa = clube.id_clube
WHERE partida.id_estadio != clube.id_estadio;


--Com agregação (GROUP BY, HAVING)

--14. Quantidade de jogadores por clube e por posição.

SELECT 
    clube.nome AS clube,
    jogador.posicao AS posicao,
    COUNT(jogador.id_jogador) AS jogadores_total
FROM clube
    JOIN jogador ON jogador.id_clube = clube.id_clube
GROUP BY clube.nome, jogador.posicao
ORDER BY clube.nome, jogadores_total;

--15. ★ Artilheiros (sem contar gol contra).

SELECT
    jogador.nome AS artilheiros,
    COUNT(*) AS gols
FROM gol
    JOIN jogador ON gol.id_marcador = jogador.id_jogador
WHERE gol.tipo != 'Contra'
GROUP BY jogador.id_jogador, jogador.nome
ORDER BY gols DESC, jogador.nome;

--16. ★ Clubes com mais cartões, separando amarelos e vermelhos.

SELECT
    clube.nome AS clube,
    (SELECT COUNT(*) 
    FROM cartao
    JOIN jogador ON cartao.id_jogador = jogador.id_jogador
    WHERE jogador.id_clube = clube.id_clube AND cartao.cor = 'Amarelo') AS amarelos,
    (SELECT COUNT(*) FROM cartao
    JOIN jogador ON cartao.id_jogador = jogador.id_jogador
    WHERE jogador.id_clube = clube.id_clube AND cartao.cor = 'Vermelho') AS vermelhos
FROM clube
ORDER BY amarelos DESC, vermelhos DESC, clube.nome;

--17. ★ Maior público e público médio por estádio.

SELECT
    estadio.nome AS estadio,
    estadio.capacidade AS capacidade,
    MAX(partida.publico) AS maior_publico,
    AVG(partida.publico) AS media_publico
FROM partida
    JOIN estadio ON partida.id_estadio = estadio.id_estadio
GROUP BY estadio.nome, estadio.capacidade
ORDER BY estadio.nome;

--18. Média de gols por rodada.

SELECT
    ROUND(AVG(partida.gols_casa + partida.gols_fora), 2) AS media_gols,
    partida.rodada AS rodada
FROM partida
GROUP BY partida.rodada
ORDER BY media_gols DESC;


--19. Quantidade de gols por tipo.

SELECT
    tipo,
    COUNT(*) AS qtd
FROM gol
GROUP BY tipo
ORDER BY qtd DESC;

--20. Gols no 1º e no 2º tempo (por faixa de minuto).

SELECT
    (SELECT
        COUNT(*) FROM gol WHERE gol.minuto <= 45) AS gols_primeiro_tempo,
    (SELECT
        COUNT(*) FROM gol WHERE gol.minuto > 45) AS gols_segundo_tempo;

--21. Jogadores com 2 gols ou mais.

SELECT
    jogador.nome AS nome,
    COUNT(*) AS gols
FROM gol
    JOIN jogador ON gol.id_marcador = jogador.id_jogador
WHERE gol.tipo != 'Contra'
GROUP BY jogador.id_jogador, jogador.nome
HAVING COUNT(*) >= 2
ORDER BY gols DESC, jogador.nome;

--22. Quantidade de estrangeiros por clube.


SELECT
    clube.nome AS clube,
    COUNT(jogador.nacionalidade) AS estrangeiros
FROM clube
    JOIN jogador ON jogador.id_clube = clube.id_clube
WHERE jogador.nacionalidade != 'Brasil'
GROUP BY clube.id_clube, clube.nome
ORDER BY estrangeiros DESC, clube.nome;

--Classificação (as mais difíceis)
--23. ★ Classificação completa: jogos, vitórias, empates, derrotas, gols pró e contra, saldo e pontos.

SELECT
    clube, jogos, vitorias, empates, derrotas, gols_pro, gols_contra, 
    gols_pro - gols_contra AS saldo, 
    3 * vitorias + empates AS pontos
FROM (
SELECT
    clube.nome AS clube,
    (SELECT 
        COUNT(*) FROM partida WHERE partida.id_clube_casa = clube.id_clube 
        OR partida.id_clube_fora = clube.id_clube) AS jogos,
    (SELECT 
        COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND partida.gols_casa > partida.gols_fora)
        OR (partida.id_clube_fora = clube.id_clube AND partida.gols_fora > partida.gols_casa)) AS vitorias,
    (SELECT
        COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND gols_casa = gols_fora) 
        OR (partida.id_clube_fora = clube.id_clube AND gols_casa = gols_fora)) AS empates,
    (SELECT
        COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND gols_casa < gols_fora) 
        OR (partida.id_clube_fora = clube.id_clube AND gols_casa > gols_fora)) AS derrotas,
    (SELECT
        SUM(partida.gols_casa) FROM partida WHERE (partida.id_clube_casa = clube.id_clube)) +
    (SELECT
        SUM(partida.gols_fora) FROM partida WHERE (partida.id_clube_fora = clube.id_clube)) AS gols_pro,
    (SELECT
        SUM(partida.gols_fora) FROM partida WHERE (partida.id_clube_casa = clube.id_clube)) +
    (SELECT
        SUM(partida.gols_casa) FROM partida WHERE (partida.id_clube_fora = clube.id_clube)) AS gols_contra,
    (SELECT
        SUM(partida.gols_casa - partida.gols_fora) FROM partida) AS saldo
FROM clube
) AS classificação
ORDER BY pontos DESC, vitorias DESC, saldo DESC, gols_pro DESC;

--24. Melhor ataque e melhor defesa.

SELECT
    clube,
    gols_pro AS melhor_ataque,
    gols_contra AS melhor_defesa
FROM (
    SELECT
        clube.nome AS clube,
        (SELECT
            SUM(partida.gols_casa) FROM partida WHERE (partida.id_clube_casa = clube.id_clube)) +
        (SELECT
            SUM(partida.gols_fora) FROM partida WHERE (partida.id_clube_fora = clube.id_clube)) AS gols_pro,
        (SELECT
            SUM(partida.gols_fora) FROM partida WHERE (partida.id_clube_casa = clube.id_clube)) +
        (SELECT
            SUM(partida.gols_casa) FROM partida WHERE (partida.id_clube_fora = clube.id_clube)) AS gols_contra
        FROM clube)
ORDER BY gols_pro DESC, gols_contra ASC, clube
LIMIT 1;

--25. Desempenho como mandante e como visitante.

SELECT
    clube, 
    3 * vitorias_casa + empates_casa AS pontos_mandante,
    3 * vitorias_fora + empates_fora AS pontos_visitante
FROM (
    SELECT 
        clube.nome AS clube,
        (SELECT 
            COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND partida.gols_casa > partida.gols_fora)) AS vitorias_casa,
        (SELECT
            COUNT(*) FROM partida WHERE (partida.id_clube_fora = clube.id_clube AND partida.gols_fora > partida.gols_casa)) AS vitorias_fora,
        (SELECT
        COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND gols_casa = gols_fora)) AS empates_casa,
        (SELECT
        COUNT(*) FROM partida WHERE (partida.id_clube_fora = clube.id_clube AND gols_casa = gols_fora)) AS empates_fora
    FROM clube
) AS desempenho
ORDER BY pontos_mandante DESC, pontos_visitante DESC, clube;

--26. Clubes que ainda não perderam.

SELECT
    clube, vitorias, derrotas
FROM (
    SELECT
        clube.nome AS clube,
        (SELECT 
            COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND partida.gols_casa > partida.gols_fora)
            OR (partida.id_clube_fora = clube.id_clube AND partida.gols_fora > partida.gols_casa)) AS vitorias,
        (SELECT
            COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND gols_casa < gols_fora) 
            OR (partida.id_clube_fora = clube.id_clube AND gols_casa > gols_fora)) AS derrotas
    FROM clube
) AS resultado
WHERE derrotas = 0
ORDER BY vitorias DESC, clube;

--Subconsultas e casos especiais

--27. Maiores goleadas (Diferença de 3 gols ou mais).

SELECT
    partida.id_partida AS partida,
    casa.nome AS clube_casa,
    fora.nome AS clube_fora,
    partida.gols_casa AS gols_casa,
    partida.gols_fora AS gols_fora
FROM partida
    JOIN clube AS casa ON partida.id_clube_casa = casa.id_clube
    JOIN clube AS fora ON partida.id_clube_fora = fora.id_clube
WHERE partida.gols_casa >= partida.gols_fora + 3
ORDER BY gols_casa DESC, gols_fora DESC, partida.id_partida;


--28. Jogos sem gols.

SELECT
    partida.id_partida AS partida,
    casa.nome AS clube_casa,
    fora.nome AS clube_fora,
    partida.gols_casa + partida.gols_fora AS total_gols
FROM partida
    JOIN clube AS casa ON partida.id_clube_casa = casa.id_clube
    JOIN clube AS fora ON partida.id_clube_fora = fora.id_clube
WHERE partida.gols_casa + partida.gols_fora = 0;

--29. Clubes que nunca perderam em casa.

SELECT
    clube.nome AS clube,
FROM clube
WHERE (
    SELECT

)

--30. Clube com mais vitórias (subconsulta com MAX).

SELECT
    clube, MAX(vitorias)
FROM (
    SELECT
        clube.nome AS clube,
        (SELECT 
            COUNT(*) FROM partida WHERE (partida.id_clube_casa = clube.id_clube AND partida.gols_casa > partida.gols_fora)
            OR (partida.id_clube_fora = clube.id_clube AND partida.gols_fora > partida.gols_casa)) AS vitorias
    FROM clube
) AS resultado
GROUP BY resultado.clube, vitorias
ORDER BY vitorias DESC
LIMIT 1;

--31. Jogadores que fizeram gol e levaram cartão na mesma partida.

SELECT
    jogador.nome AS nome,
FROM gol
    JOIN jogador ON gol.id_marcador = jogador.id_jogador
WHERE gol.tipo != 'Contra' AND
GROUP BY jogador.id_jogador, jogador.nome
ORDER BY gols DESC, jogador.nome;

--32. Jogadores expulsos.

SELECT
    jogador.nome AS jogador,
    gol.id_partida AS partida
FROM gol
    JOIN cartao ON cartao.id_partida = gol.id_partida
                AND cartao.id_jogador = gol.id_marcador
    JOIN jogador ON jogador.id_jogador = gol.id_marcador
WHERE gol.tipo != 'Contra'
GROUP BY gol.id_partida, jogador.id_jogador, jogador.nome
ORDER BY gol.id_partida;

--33. Jogos que tiveram gol contra.

SELECT
    partida.id_partida AS partida,
    gol.tipo AS gols_contra
FROM partida
    JOIN gol ON gol.id_partida = partida.id_partida
WHERE gol.tipo = 'Contra';

--34. Rodada com mais gols.

SELECT
    partida.rodada AS rodada,
    MAX(partida.gols_casa + partida.gols_fora) AS total_gols
FROM partida
GROUP BY partida.rodada
ORDER BY total_gols DESC
LIMIT 1;

--35. Clubes com menos gols sofridos que a média (subconsulta com AVG)

SELECT
    clube,
    gols_contra
FROM (
    SELECT
        clube.nome AS clube,
        (SELECT SUM(partida.gols_fora) FROM partida WHERE partida.id_clube_casa = clube.id_clube)
        + (SELECT SUM(partida.gols_casa) FROM partida WHERE partida.id_clube_fora = clube.id_clube) AS gols_contra
    FROM clube
) AS gols_sofridos
WHERE gols_contra < (
    SELECT AVG(gols_contra)
    FROM (
        SELECT
            (SELECT SUM(partida.gols_fora) FROM partida WHERE partida.id_clube_casa = clube.id_clube)
            + (SELECT SUM(partida.gols_casa) FROM partida WHERE partida.id_clube_fora = clube.id_clube) AS gols_contra
        FROM clube
    ) AS media
)
ORDER BY gols_contra, clube;
