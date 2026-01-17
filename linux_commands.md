# Guia de Comandos Linux para Desenvolvedores

Dominar a linha de comando é um superpoder para qualquer desenvolvedor. Além do básico (`ls`, `cd`, `mv`), existe um vasto universo de ferramentas que podem otimizar seu fluxo de trabalho.

Este guia é uma referência para alguns desses comandos, organizados por categoria.

---

## Manipulação de Arquivos e Diretórios

*   **`find`**: Encontra arquivos e diretórios com base em critérios.
    *   `find . -name "*.py"`: Encontra todos os arquivos que terminam com `.py` no diretório atual e subdiretórios.
    *   `find . -type d -name "node_modules"`: Encontra todos os diretórios chamados `node_modules`.
    *   `find . -name "*.log" -delete`: Encontra e deleta todos os arquivos de log.

*   **`xargs`**: Executa comandos a partir da entrada padrão. Usado frequentemente em conjunto com o `find`.
    *   `find . -name "*.tmp" | xargs rm`: Encontra todos os arquivos `.tmp` e os passa para o comando `rm` para serem deletados. É mais seguro e eficiente que `-exec`.

*   **`tree`**: Exibe a estrutura de diretórios em formato de árvore. (Pode precisar ser instalado: `sudo apt install tree`).
    *   `tree -L 2`: Mostra a árvore com profundidade máxima de 2 níveis.

*   **`stat`**: Mostra informações detalhadas (metadados) de um arquivo.
    *   `stat arquivo.txt`: Exibe o tamanho, permissões, datas de acesso/modificação, etc.

## Processamento de Texto

*   **`grep`**: Busca por padrões em texto. A "ferramenta de busca" padrão do Unix.
    *   `grep "error" server.log`: Encontra todas as linhas contendo "error" no arquivo `server.log`.
    *   `grep -r "API_KEY" .`: Busca recursivamente pela string "API_KEY" em todos os arquivos do diretório atual.
    *   **Alternativa Moderna:** `rg` (Ripgrep) é uma ferramenta similar, mas muito mais rápida e que respeita `.gitignore` por padrão.

*   **`sed`**: "Stream Editor". Edita texto de forma programática.
    *   `sed 's/antigo/novo/g' arquivo.txt`: Substitui todas as ocorrências de "antigo" por "novo" no arquivo.

*   **`awk`**: Uma linguagem de programação para processamento de texto. Extremamente poderosa para manipular dados em colunas.
    *   `ls -l | awk '{print $1, $9}'`: Mostra apenas as permissões e os nomes dos arquivos da saída do `ls -l`.

*   **`jq`**: O "sed para JSON". Uma ferramenta para fatiar, filtrar, mapear e transformar dados JSON na linha de comando. (Precisa ser instalado: `sudo apt install jq`).
    *   `cat package.json | jq '.scripts'`: Extrai a chave "scripts" do `package.json`.

## Monitoramento de Sistema e Processos

*   **`htop`**: Um visualizador de processos interativo. Uma versão muito melhorada do `top`. (Precisa ser instalado: `sudo apt install htop`).

*   **`df`**: **d**isk **f**ree. Mostra o uso de espaço em disco do sistema de arquivos.
    *   `df -h`: Exibe em formato "legível por humanos" (human-readable), com KB, MB, GB.

*   **`du`**: **d**isk **u**sage. Estima o uso de espaço de arquivos e diretórios.
    *   `du -sh *`: Mostra um resumo do tamanho de cada arquivo/diretório no local atual.

*   **`ps`**: Mostra os processos atualmente em execução.
    *   `ps aux`: Mostra todos os processos de todos os usuários.
    *   `ps aux | grep "python"`: Encontra todos os processos de python em execução.

*   **`kill`**: Envia um sinal para um processo (geralmente para terminá-lo).
    *   `kill <PID>`: Envia o sinal de término (TERM), pedindo para o processo fechar educadamente.
    *   `kill -9 <PID>`: Envia o sinal de "matar" (KILL), forçando o término imediato do processo. Use como último recurso.

## Rede

*   **`curl`**: Ferramenta para transferir dados de ou para um servidor. Usado para fazer requisições web.
    *   `curl https://api.github.com/users/octocat`: Faz uma requisição GET para a API do GitHub.
    *   `curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' http://localhost:3000/data`: Envia dados JSON via POST.

*   **`wget`**: Ferramenta de linha de comando para baixar arquivos da internet.
    *   `wget https://releases.ubuntu.com/22.04/ubuntu-22.04.3-desktop-amd64.iso`: Baixa a imagem do Ubuntu.

*   **`ping`**: Verifica a conectividade de rede com um host.
    *   `ping google.com`: Envia pacotes para o Google e mede o tempo de resposta.

*   **`ss`**: "Socket Statistics". Uma ferramenta moderna para inspecionar sockets e conexões de rede (substitui o antigo `netstat`).
    *   `ss -tuln`: Mostra todos os sockets TCP (`t`) e UDP (`u`) que estão "escutando" (`l`) sem resolver nomes (`n`). Útil para ver quais portas estão abertas.

---

**Anterior:** [Guia: Configurando seu Terminal para Produtividade](./terminal_configs.md) | **Próximo:** [Guia: Gerenciando Dotfiles com Git e GitHub](./dotfiles_management.md)
