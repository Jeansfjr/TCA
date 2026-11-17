// =====================================================================
// CONFIGURAÇÃO DO SITE
// 1) Cole a URL e a chave PUBLICÁVEL do seu projeto no Supabase.
//    (Nunca use a chave que começa com sb_secret_.)
// 2) O CATALOGO mais abaixo define o menu: categorias e consultas.
//    Para criar uma consulta nova, veja as instruções no fim do arquivo.
// =====================================================================

const SUPABASE_URL = 'https://luflumgxwrhmsvneivpo.supabase.co';
const SUPABASE_CHAVE = 'sb_publishable_CYFinVYz3W0OUiobjagb6A_0i85C8O_';

const T = (campo, titulo, formato) => ({ campo: campo, titulo: titulo, formato: formato });
const N = (campo, titulo, formato) => ({ campo: campo, titulo: titulo, formato: formato, numero: true });

const fmtData   = v => new Date(v).toLocaleString('pt-BR', { dateStyle: 'short', timeStyle: 'short' });
const fmtMilhar = v => (v == null ? '-' : Number(v).toLocaleString('pt-BR'));

const COLS_DESEMPENHO = [
  T('clube', 'Clube'), N('pontos', 'Pontos'), N('jogos', 'Jogos'),
  N('vitorias', 'Vitórias'), N('empates', 'Empates'), N('derrotas', 'Derrotas'),
  N('gols_pro', 'Gols pró'), N('gols_contra', 'Gols contra')
];
const COLS_JOGO_SIMPLES = [
  N('rodada', 'Rodada'), T('mandante', 'Mandante'),
  N('gols_casa', 'Gols'), N('gols_fora', 'Gols'), T('visitante', 'Visitante')
];

const CATALOGO = [
  {
    id: 'times',
    menu: 'Tabelas dos times',
    titulo: 'Tabela dos times',
    descricao: 'Classificação, desempenho, cartões e dados dos clubes.',
    consultas: [
      {
        id: 'classificacao', titulo: 'Classificação geral',
        descricao: 'Tabela completa do campeonato, ordenada por pontos, vitórias, saldo e gols pró.',
        view: 'vw_classificacao', posicao: true,
        colunas: COLS_DESEMPENHO.concat([N('saldo', 'Saldo')]),
        ordenar: [['pontos', false], ['vitorias', false], ['saldo', false], ['gols_pro', false]]
      },
      {
        id: 'saldo-de-gols', titulo: 'Saldo de gols',
        descricao: 'Clubes ordenados pelo saldo de gols (gols marcados menos gols sofridos).',
        view: 'vw_classificacao', posicao: true,
        colunas: [T('clube', 'Clube'), N('saldo', 'Saldo'), N('gols_pro', 'Gols pró'), N('gols_contra', 'Gols contra'), N('jogos', 'Jogos')],
        ordenar: [['saldo', false], ['gols_pro', false]]
      },
      {
        id: 'melhor-ataque', titulo: 'Melhor ataque',
        descricao: 'Clubes que mais marcaram gols.',
        view: 'vw_classificacao', posicao: true,
        colunas: [T('clube', 'Clube'), N('gols_pro', 'Gols pró'), N('jogos', 'Jogos')],
        ordenar: [['gols_pro', false]]
      },
      {
        id: 'melhor-defesa', titulo: 'Melhor defesa',
        descricao: 'Clubes que menos sofreram gols.',
        view: 'vw_classificacao', posicao: true,
        colunas: [T('clube', 'Clube'), N('gols_contra', 'Gols contra'), N('jogos', 'Jogos')],
        ordenar: [['gols_contra', true]]
      },
      {
        id: 'em-casa', titulo: 'Desempenho em casa',
        descricao: 'Campanha de cada clube considerando só os jogos como mandante.',
        view: 'vw_desempenho_casa', posicao: true,
        colunas: COLS_DESEMPENHO,
        ordenar: [['pontos', false], ['vitorias', false]]
      },
      {
        id: 'fora-de-casa', titulo: 'Desempenho fora de casa',
        descricao: 'Campanha de cada clube considerando só os jogos como visitante.',
        view: 'vw_desempenho_fora', posicao: true,
        colunas: COLS_DESEMPENHO,
        ordenar: [['pontos', false], ['vitorias', false]]
      },
      {
        id: 'cartoes', titulo: 'Cartões por clube',
        descricao: 'Quantidade de cartões amarelos e vermelhos de cada clube.',
        view: 'vw_cartoes_clubes',
        colunas: [T('clube', 'Clube'), N('amarelos', 'Amarelos'), N('vermelhos', 'Vermelhos'), N('total', 'Total')],
        ordenar: [['total', false], ['vermelhos', false]]
      },
      {
        id: 'clubes', titulo: 'Dados dos clubes',
        descricao: 'Cidade, ano de fundação, estádio e treinador de cada clube.',
        view: 'vw_clubes',
        colunas: [T('clube', 'Clube'), T('cidade', 'Cidade'), N('ano_fundacao', 'Fundação'),
                  T('estadio', 'Estádio'), N('capacidade', 'Capacidade', fmtMilhar), T('treinador', 'Treinador')],
        ordenar: [['clube', true]]
      }
    ]
  },
  {
    id: 'jogadores',
    menu: 'Tabela dos jogadores',
    titulo: 'Tabela dos jogadores',
    descricao: 'Artilheiros, elencos e cartões dos jogadores.',
    consultas: [
      {
        id: 'artilheiros', titulo: 'Artilheiros',
        descricao: 'Jogadores com mais gols (gols contra não contam).',
        view: 'vw_artilheiros', posicao: true,
        colunas: [T('jogador', 'Jogador'), T('clube', 'Clube'), N('gols', 'Gols')],
        ordenar: [['gols', false], ['jogador', true]]
      },
      {
        id: 'elenco', titulo: 'Elenco por clube',
        descricao: 'Os jogadores de cada clube. Escolha um clube na caixa abaixo.',
        view: 'vw_elenco',
        colunas: [T('jogador', 'Jogador'), T('clube', 'Clube'), T('posicao', 'Posição'),
                  T('nacionalidade', 'Nacionalidade'), N('numero_camisa', 'Camisa')],
        ordenar: [['clube', true], ['jogador', true]],
        filtro: { rotulo: 'Clube', campos: ['clube'], todos: 'Todos os clubes' }
      },
      {
        id: 'por-posicao', titulo: 'Jogadores por posição',
        descricao: 'Os jogadores de uma posição em campo. Escolha a posição na caixa abaixo.',
        view: 'vw_elenco',
        colunas: [T('jogador', 'Jogador'), T('clube', 'Clube'), T('posicao', 'Posição'), T('nacionalidade', 'Nacionalidade')],
        ordenar: [['posicao', true], ['clube', true], ['jogador', true]],
        filtro: { rotulo: 'Posição', campos: ['posicao'], todos: 'Todas as posições' }
      },
      {
        id: 'cartoes', titulo: 'Cartões por jogador',
        descricao: 'Jogadores que receberam cartões, com amarelos e vermelhos.',
        view: 'vw_cartoes_jogadores',
        colunas: [T('jogador', 'Jogador'), T('clube', 'Clube'), N('amarelos', 'Amarelos'), N('vermelhos', 'Vermelhos'), N('total', 'Total')],
        ordenar: [['total', false], ['vermelhos', false], ['jogador', true]]
      }
    ]
  },
  {
    id: 'jogos',
    menu: 'Tabela dos jogos',
    titulo: 'Tabela dos jogos',
    descricao: 'Resultados, rodadas, goleadas e públicos.',
    consultas: [
      {
        id: 'todos', titulo: 'Todos os jogos',
        descricao: 'Todos os jogos disputados, em ordem de data.',
        view: 'vw_jogos',
        colunas: [N('rodada', 'Rodada'), T('data_hora', 'Data', fmtData), T('mandante', 'Mandante'),
                  N('gols_casa', 'Gols'), N('gols_fora', 'Gols'), T('visitante', 'Visitante'),
                  T('estadio', 'Estádio'), N('publico', 'Público', fmtMilhar)],
        ordenar: [['data_hora', true]]
      },
      {
        id: 'por-rodada', titulo: 'Jogos por rodada',
        descricao: 'Os jogos de uma rodada. Escolha a rodada na caixa abaixo.',
        view: 'vw_jogos',
        colunas: [N('rodada', 'Rodada'), T('data_hora', 'Data', fmtData), T('mandante', 'Mandante'),
                  N('gols_casa', 'Gols'), N('gols_fora', 'Gols'), T('visitante', 'Visitante'), T('estadio', 'Estádio')],
        ordenar: [['rodada', true], ['data_hora', true]],
        filtro: { rotulo: 'Rodada', campos: ['rodada'], todos: 'Todas as rodadas', formatoValor: v => 'Rodada ' + v }
      },
      {
        id: 'por-clube', titulo: 'Jogos de um clube',
        descricao: 'Todos os jogos de um clube, como mandante ou visitante. Escolha o clube na caixa abaixo.',
        view: 'vw_jogos',
        colunas: [N('rodada', 'Rodada'), T('data_hora', 'Data', fmtData), T('mandante', 'Mandante'),
                  N('gols_casa', 'Gols'), N('gols_fora', 'Gols'), T('visitante', 'Visitante'), T('estadio', 'Estádio')],
        ordenar: [['data_hora', true]],
        filtro: { rotulo: 'Clube', campos: ['mandante', 'visitante'], todos: 'Todos os clubes' }
      },
      {
        id: 'goleadas', titulo: 'Maiores goleadas',
        descricao: 'Os 5 jogos com maior diferença de gols.',
        view: 'vw_goleadas', limite: 5,
        colunas: COLS_JOGO_SIMPLES.concat([N('diferenca', 'Diferença')]),
        ordenar: [['diferenca', false], ['rodada', true]]
      },
      {
        id: 'sem-gols', titulo: 'Jogos sem gols',
        descricao: 'Jogos que terminaram 0 a 0.',
        view: 'vw_jogos_sem_gols',
        colunas: COLS_JOGO_SIMPLES.concat([T('estadio', 'Estádio')]),
        ordenar: [['rodada', true]]
      },
      {
        id: 'maior-publico', titulo: 'Maiores públicos',
        descricao: 'Os 5 jogos com maior público.',
        view: 'vw_jogos', limite: 5,
        colunas: [T('mandante', 'Mandante'), T('visitante', 'Visitante'), T('estadio', 'Estádio'),
                  N('rodada', 'Rodada'), N('publico', 'Público', fmtMilhar)],
        ordenar: [['publico', false]]
      },
      {
        id: 'gols-por-rodada', titulo: 'Gols por rodada',
        descricao: 'Total de gols e média por jogo em cada rodada.',
        view: 'vw_gols_por_rodada',
        colunas: [N('rodada', 'Rodada'), N('jogos', 'Jogos'), N('total_gols', 'Total de gols'),
                  N('media_por_jogo', 'Média por jogo', v => (v == null ? '-' : Number(v).toLocaleString('pt-BR', { minimumFractionDigits: 2 })))],
        ordenar: [['rodada', true]]
      }
    ]
  }
];