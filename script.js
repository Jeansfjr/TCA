const db = supabase.createClient(SUPABASE_URL, SUPABASE_CHAVE);

function preencher(idCorpo, linhas, campos) {
  const corpo = document.getElementById(idCorpo);

  if (!corpo) {
    console.error('Tabela não encontrada:', idCorpo);
    return;
  }

  corpo.innerHTML = '';

  linhas.forEach(function (linha, i) {
    const tr = document.createElement('tr');

    [i + 1].concat(campos.map(function (c) {
      return linha[c];
    })).forEach(function (valor) {
      const td = document.createElement('td');
      td.textContent = valor ?? '';
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
  if (r.error) { console.error(r.error); return; }

  preencher('corpo-classificacao', r.data,
    ['clube', 'pontos', 'jogos', 'vitorias', 'derrotas', 'saldo']);
}

async function carregarJogosEmCasa() {
  const r = await db.from('vw_desempenho_casa').select('*');
  if (r.error) { console.error(r.error); return; }

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
  if (r.error) { console.error(r.error); return; }

  const linhas = r.data.map(function (l) {
    return Object.assign({}, l, { saldo: l.gols_pro - l.gols_contra });
  });

  linhas.sort(function (a, b) {
    return b.vitorias - a.vitorias || b.saldo - a.saldo || b.gols_pro - a.gols_pro;
  });

  preencher('corpo-jogos-fora', linhas,
    ['clube', 'jogos', 'vitorias', 'derrotas', 'gols_pro', 'gols_contra', 'saldo']);
}

async function carregarArtilheiros() {
    const r = await db.from('vw_artilheiros').select('*');

    if (r.error) { console.error(r.error); return; }

    const linhas = r.data;

    linhas.sort(function (a, b) {
        return b.gols - a.gols;
    });

    preencher('corpo-artilheiros', linhas,
        ['clube', 'jogador', 'gols']);

}
async function carregarAssistentes() {
    const r = await db.from('vw_assistentes').select('*');

    if (r.error) {
        console.error(r.error);
        return;
    }

    const linhas = r.data;

    linhas.sort(function (a, b) {
        return b.assistencias - a.assistencias;
    });

    preencher('corpo-assistentes', linhas, ['clube', 'jogador', 'assistencias']);
}

carregarClassificacao();
carregarJogosEmCasa();
carregarJogosFora();
carregarArtilheiros();
carregarAssistentes();
