CREATE TABLE estadio (
    id_estadio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    capacidade INT NOT NULL CHECK(capacidade > 0)
);

CREATE TABLE clube (
    id_clube SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    cidade VARCHAR(100) NOT NULL,
    ano_fundacao INT NOT NULL,
    id_estadio INT REFERENCES estadio(id_estadio)
);

CREATE TABLE temporada (
    id_temporada SERIAL PRIMARY KEY,
    ano INT NOT NULL UNIQUE,
    data_inicio DATE NOT NULL,
    data_fim DATE CHECK(data_fim IS NULL OR data_fim >= data_inicio),
    id_campeao INT REFERENCES clube(id_clube)
);

CREATE TABLE treinador (
    id_treinador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    nacionalidade VARCHAR(50) DEFAULT('Brasil'),
    id_clube INT REFERENCES clube(id_clube)
);

CREATE TABLE jogador (
    id_jogador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    posicao VARCHAR(30) NOT NULL CHECK(posicao IN ('Goleiro','Zagueiro', 'Lateral', 'Volante', 'Meia', 'Atacante')),
    nacionalidade VARCHAR(50) DEFAULT('Brasil'),
    numero_camisa INT CHECK(numero_camisa BETWEEN 1 AND 99),
    id_clube INT NOT NULL REFERENCES clube(id_clube),
    UNIQUE (id_clube, numero_camisa) 
);

CREATE TABLE partida (
    id_partida SERIAL PRIMARY KEY,
    id_temporada INT NOT NULL REFERENCES temporada(id_temporada),
    rodada INT NOT NULL CHECK(rodada BETWEEN 1 AND 38),
    data_hora TIMESTAMP NOT NULL,
    id_clube_casa INT NOT NULL REFERENCES clube(id_clube),
    id_clube_fora INT NOT NULL REFERENCES clube(id_clube) CHECK(id_clube_fora != id_clube_casa),
    gols_casa INT NOT NULL DEFAULT 0 CHECK(gols_casa >= 0),
    gols_fora INT NOT NULL DEFAULT 0 CHECK(gols_fora >= 0),
    id_estadio INT NOT NULL REFERENCES estadio(id_estadio),
    publico INT,
    UNIQUE(id_temporada, rodada, id_clube_casa)
);

CREATE TABLE gol (
    id_gol SERIAL PRIMARY KEY,
    id_partida INT NOT NULL REFERENCES partida(id_partida) ON DELETE CASCADE,
    id_marcador INT NOT NULL REFERENCES jogador(id_jogador),
    minuto INT NOT NULL CHECK(minuto BETWEEN 1 AND 90),
    tipo VARCHAR(10) DEFAULT('Normal') CHECK(tipo IN ('Normal', 'Penalti', 'Contra', 'Falta'))
);

CREATE TABLE cartao (
    id_cartao SERIAL PRIMARY KEY,
    id_partida INT NOT NULL REFERENCES partida(id_partida) ON DELETE CASCADE,
    id_jogador INT NOT NULL REFERENCES jogador(id_jogador),
    minuto INT NOT NULL CHECK(minuto BETWEEN 1 AND 90),
    cor VARCHAR(8) NOT NULL CHECK(cor IN ('Amarelo', 'Vermelho'))
);