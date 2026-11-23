const db = supabase.createClient(SUPABASE_URL, SUPABASE_CHAVE);

function preencher(idCorpo, linhas, campos, numerar = true) {
    const corpo = document.getElementById(idCorpo);

    corpo.innerHTML = '';

    linhas.forEach(function (linha, i) {
        const tr = document.createElement('tr');

        const valores = campos.map(function (c) {
            return linha[c];
        });

        if (numerar) {
            valores.unshift(i + 1);
        }

        valores.forEach(function (valor) {
            const td = document.createElement('td');

            if (typeof valor === 'number' && campos.includes('pagamento')) {
                td.textContent = valor.toLocaleString('pt-BR');
            } else {
                td.textContent = valor ?? '';
            }

            tr.appendChild(td);
        });

        corpo.appendChild(tr);
    });
}

function preencherJogos(idCorpo, linhas, campos) {
    const corpo = document.getElementById(idCorpo);

    corpo.innerHTML = '';

    linhas.forEach(function (linha) {
        const tr = document.createElement('tr');

        campos.forEach(function (c) {
            const td = document.createElement('td');
            td.textContent = linha[c] ?? '';
            tr.appendChild(td);
        });

        corpo.appendChild(tr);
    });
}

async function carregarClassificacao() {
  const r = await db.from('vw_classificacao').select('*')
    .order('pontos', { ascending: false })
    .order('vitorias', { ascending: false })
    .order('saldo', { ascending: false })
    .order('gols_pro', { ascending: false });

  preencher('corpo-classificacao', r.data,
    ['clube', 'pontos', 'jogos', 'vitorias', 'derrotas', 'saldo']);
}

async function carregarJogosEmCasa() {
  const r = await db.from('vw_desempenho_casa').select('*');

  const linhas = r.data.map(function (l) {
    return Object.assign({}, l, { saldo: l.gols_pro - l.gols_contra });
  });

  linhas.sort(function (a, b) {
    return b.vitorias - a.vitorias || b.saldo - a.saldo || b.gols_pro - a.gols_pro;
  });

  preencher('corpo-jogos-casa', linhas,
    ['clube', 'jogos', 'vitorias', 'derrotas', 'gols_pro', 'gols_contra', 'saldo']);
}

async function carregarJogosFora() {
  const r = await db.from('vw_desempenho_fora').select('*');

  const linhas = r.data.map(function (l) {
    return Object.assign({}, l, { saldo: l.gols_pro - l.gols_contra });
  });

  linhas.sort(function (a, b) {
    return b.vitorias - a.vitorias || b.saldo - a.saldo || b.gols_pro - a.gols_pro;
  });

  preencher('corpo-jogos-fora', linhas,
    ['clube', 'jogos', 'vitorias', 'derrotas', 'gols_pro', 'gols_contra', 'saldo']);
}

async function carregarMelhorAtaque() {
    const { data } = await db
        .from('vw_melhor_ataque')
        .select('*')
        .order('gols_marcados', { ascending: false });

    preencher('corpo-melhor-ataque', data, [
        'clube',
        'gols_marcados'
    ]);
}

async function carregarMelhorDefesa() {
    const { data } = await db
        .from('vw_melhor_defesa')
        .select('*')
        .order('gols_sofridos', { ascending: true });

    preencher('corpo-melhor-defesa', data, [
        'clube',
        'gols_sofridos'
    ]);
}

async function carregarArtilheiros() {
    const r = await db.from('vw_artilheiros').select('*');

    const linhas = r.data;

    linhas.sort(function (a, b) {
        return b.gols - a.gols;
    });

    preencher('corpo-artilheiros', linhas,
        ['clube', 'jogador', 'gols']);

}
async function carregarAssistentes() {
    const r = await db.from('vw_assistentes').select('*');

    const linhas = r.data;

    linhas.sort(function (a, b) {
        return b.assistencias - a.assistencias;
    });

    preencher('corpo-assistentes', linhas, ['clube', 'jogador', 'assistencias']);
}

async function carregarVermelhos() {
    const r = await db.from('vw_cartoes_vermelhos').select('*');

    preencher('corpo-vermelhos', r.data, ['clube', 'jogador', 'vermelhos']);
}

async function carregarAmarelos() {
    const r = await db.from('vw_cartoes_amarelos').select('*');

    preencher('corpo-amarelos', r.data, ['clube', 'jogador', 'amarelos']);
}

async function carregarTreinadores() {
    const { data } = await db
        .from('vw_treinadores')
        .select('*')
        .order('clube', { ascending: true });

    preencherJogos('corpo-treinadores', data, [
        'clube',
        'treinador',
        'nacionalidade',
        'idade'
    ]);
}

async function carregarRodada1() {
    const { data } = await db.from('vw_rodada_1').select('*');

    preencherJogos('corpo-rodada-1', data, [
    'rodada',
    'data_hora',
    'mandante',
    'visitante',
    'placar',
    'estadio',
    'publico'
]);
}

async function carregarRodada2() {
    const { data } = await db.from('vw_rodada_2').select('*');

    preencherJogos('corpo-rodada-2', data, [
    'rodada',
    'data_hora',
    'mandante',
    'visitante',
    'placar',
    'estadio',
    'publico'
]);
}

async function carregarRodada3() {
    const { data } = await db.from('vw_rodada_3').select('*');

    preencherJogos('corpo-rodada-3', data, [
    'rodada',
    'data_hora',
    'mandante',
    'visitante',
    'placar',
    'estadio',
    'publico'
]);
}

async function carregarRodada4() {
    const { data } = await db.from('vw_rodada_4').select('*');

    preencherJogos('corpo-rodada-4', data, [
    'rodada',
    'data_hora',
    'mandante',
    'visitante',
    'placar',
    'estadio',
    'publico'
]);
}

async function carregarRodada5() {
    const { data } = await db.from('vw_rodada_5').select('*');

    preencherJogos('corpo-rodada-5', data, [
    'rodada',
    'data_hora',
    'mandante',
    'visitante',
    'placar',
    'estadio',
    'publico'
]);
}

async function carregarMaisGols() {
    const { data } = await db
        .from('vw_mais_gols')
        .select('*')
        .order('total_gols', { ascending: false });

    preencherJogos('corpo-mais-gols', data, [
        'rodada',
        'mandante',
        'placar',
        'visitante',
        'total_gols'
    ]);
}

async function carregarSemGols() {
    const { data } = await db
        .from('vw_sem_gols')
        .select('*');

    preencherJogos('corpo-sem-gols', data, [
        'rodada',
        'data_hora',
        'mandante',
        'visitante',
        'estadio'
    ]);
}

async function carregarExpulsos() {
    const { data } = await db
        .from('vw_expulsos')
        .select('*');

    preencherJogos('corpo-expulsos', data, [
        'rodada',
        'mandante',
        'visitante',
        'jogador_expulso',
        'clube'
    ]);
}

async function carregarRodadasMaisGols() {
    const { data } = await db
        .from('vw_rodadas_mais_gols')
        .select('*')
        .order('total_gols', { ascending: false });

    preencher('corpo-rodada-mais-gols', data, [
        'rodada',
        'total_gols'
    ]);
}


async function carregarInformacoesClubes() {
    const { data, error } = await db
        .from('vw_informacoes_clubes')
        .select('*');

    const clubes = [
        { nome: 'Gremio', id: 'corpo-gremio', escudo: 'gremio.png' },
        { nome: 'Flamengo', id: 'corpo-flamengo', escudo: 'flamengo.png' },
        { nome: 'Palmeiras', id: 'corpo-palmeiras', escudo: 'palmeiras.png' },
        { nome: 'Internacional', id: 'corpo-internacional', escudo: 'internacional.png' },
        { nome: 'Santos', id: 'corpo-santos', escudo: 'santos.png' },
        { nome: 'Corinthians', id: 'corpo-corinthians', escudo: 'corinthians.png' },
        { nome: 'Atletico-MG', id: 'corpo-atletico-mg', escudo: 'atletico-mg.png' },
        { nome: 'Cruzeiro', id: 'corpo-cruzeiro', escudo: 'cruzeiro.png' }
    ];

    clubes.forEach(clube => {
        const corpo = document.getElementById(clube.id);
        const informacoes = data.find(item => item.clube === clube.nome);

        corpo.innerHTML = `
            <tr>
                <td>
                    <img src="img/${clube.escudo}" alt="Escudo do ${clube.nome}">
                </td>
                <td>${informacoes.treinador}</td>
                <td>${informacoes.estadio}</td>
                <td>${informacoes.capacidade.toLocaleString('pt-BR')}</td>
                <td>${informacoes.ano_fundacao}</td>
                <td>${informacoes.cidade}</td>
            </tr>
        `;
    });
}


async function carregarPremiacoes() {
    const { data } = await db
        .from('vw_premiacoes')
        .select('*')
        .order('posicao');

    preencher(
        'corpo-premiacao-geral',
        data,
        ['clube', 'posicao', 'acesso', 'pagamento', 'rebaixamento'],
            false
        );

        preencher(
            'corpo-libertadores',
            libertadores,
            ['clube', 'posicao', 'pagamento'],
            false
        );

        preencher(
            'corpo-sulamericana',
            sulamericana,
            ['clube', 'posicao', 'pagamento'],
            false
        );

        preencher(
            'corpo-rebaixamento',
            rebaixamento,
            ['clube', 'posicao', 'pagamento'],
            false
        );
}

async function carregarLibertadores() {
    const { data } = await db
        .from('vw_premiacoes')
        .select('*')
        .eq('acesso', 'Libertadores')
        .order('posicao');

    preencher(
        'corpo-libertadores',
        data,
        ['clube', 'posicao', 'pagamento'],
        false
    );
}

async function carregarSulamericana() {
    const { data } = await db
        .from('vw_premiacoes')
        .select('*')
        .eq('acesso', 'Sul-Americana')
        .order('posicao');

    preencher(
        'corpo-sulamericana',
        data,
        ['clube', 'posicao', 'pagamento'],
        false
    );
}

async function carregarRebaixamento() {
    const { data } = await db
        .from('vw_premiacoes')
        .select('*')
        .eq('rebaixamento', 'Sim')
        .order('posicao');

    preencher(
        'corpo-rebaixamento',
        data,
        ['clube', 'posicao', 'pagamento'],
        false
    );
}

carregarClassificacao();
carregarJogosEmCasa();
carregarJogosFora();
carregarMelhorAtaque();
carregarMelhorDefesa();
carregarArtilheiros();
carregarAssistentes();
carregarVermelhos();
carregarAmarelos();
carregarTreinadores();
carregarRodada1();
carregarRodada2();
carregarRodada3();
carregarRodada4();
carregarRodada5();
carregarMaisGols();
carregarSemGols();
carregarExpulsos();
carregarRodadasMaisGols();
carregarInformacoesClubes();
carregarPremiacoes();
carregarLibertadores();
carregarSulamericana();
carregarRebaixamento();
