
(function () {
    'use strict';

    const db = supabase.createClient(SUPABASE_URL, SUPABASE_CHAVE);

    const secao = document.getElementById('times');

    // Mantém o título e prepara a área da classificação
    secao.innerHTML = `
        <h2>Tabela dos Times</h2>
        <button id="btn-classificacao">Classificação Geral</button>
        <div id="resultado-classificacao" hidden>
            <h3>Classificação Geral</h3>
            <p id="mensagem"></p>
            <div id="tabela"></div>
        </div>
    `;

    const botao = document.getElementById('btn-classificacao');
    const resultado = document.getElementById('resultado-classificacao');
    const mensagem = document.getElementById('mensagem');
    const tabela = document.getElementById('tabela');

    // Busca os dados no Supabase
    async function carregarClassificacao() {
        resultado.hidden = false;
        mensagem.textContent = 'Carregando classificação...';
        tabela.innerHTML = '';

        const resposta = await db
            .from('vw_classificacao')
            .select('*')
            .order('pontos', { ascending: false })
            .order('vitorias', { ascending: false })
            .order('saldo', { ascending: false })
            .order('gols_pro', { ascending: false });

        if (resposta.error) {
            console.error(resposta.error);
            mensagem.textContent = 'Erro ao carregar a classificação.';
            return;
        }

        if (resposta.data.length === 0) {
            mensagem.textContent = 'Nenhum dado encontrado.';
            return;
        }

        mensagem.textContent = '';
        montarTabela(resposta.data);
    }

    // Monta a tabela com os dados recebidos
    function montarTabela(linhas) {
        const colunas = CATALOGO
            .find(cat => cat.id === 'times')
            .consultas.find(cons => cons.id === 'classificacao')
            .colunas;

        const tabelaHTML = document.createElement('table');
        const cabecalho = document.createElement('thead');
        const corpo = document.createElement('tbody');
        const linhaCabecalho = document.createElement('tr');

        const thPosicao = document.createElement('th');
        thPosicao.textContent = 'Posição';
        linhaCabecalho.appendChild(thPosicao);

        colunas.forEach(coluna => {
            const th = document.createElement('th');
            th.textContent = coluna.titulo;
            linhaCabecalho.appendChild(th);
        });

        cabecalho.appendChild(linhaCabecalho);

        linhas.forEach((linha, indice) => {
            const tr = document.createElement('tr');

            const tdPosicao = document.createElement('td');
            tdPosicao.textContent = indice + 1;
            tr.appendChild(tdPosicao);

            colunas.forEach(coluna => {
                const td = document.createElement('td');
                let valor = linha[coluna.campo];

                if (valor == null) {
                    valor = '-';
                } else if (coluna.formato) {
                    valor = coluna.formato(valor);
                }

                td.textContent = valor;
                tr.appendChild(td);
            });

            corpo.appendChild(tr);
        });

        tabelaHTML.appendChild(cabecalho);
        tabelaHTML.appendChild(corpo);
        tabela.appendChild(tabelaHTML);
    }

    botao.addEventListener('click', carregarClassificacao);

})();
