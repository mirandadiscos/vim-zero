# 09. Ferramentas Avançadas de Busca: ripgrep e fzf

Para sermos eficientes na linha de comando, precisamos de ferramentas que nos permitam encontrar o que precisamos *instantaneamente*. Este guia foca em duas ferramentas que, juntas, transformam a maneira como você busca por arquivos e texto: **ripgrep (`rg`)** e **fzf**.

---

## 1. `ripgrep` (`rg`): O `grep` que você sempre quis

`ripgrep` é um buscador de texto orientado a linhas que supera `grep` em velocidade e usabilidade.

**Principais Vantagens:**
*   **Extremamente Rápido:** Construído em Rust, é significativamente mais rápido que outras ferramentas.
*   **Inteligente por Padrão:** Respeita automaticamente seu `.gitignore` e não busca em arquivos binários.
*   **Saída Amigável:** A formatação da saída é limpa e legível.

### Instalação

```bash
# Para Debian/Ubuntu (pode não ser a versão mais recente)
sudo apt install ripgrep

# Para outras plataformas ou para obter a versão mais recente,
# consulte as instruções oficiais: https://github.com/BurntSushi/ripgrep#installation
```

### Uso Essencial

```bash
# Busca recursiva por "minha_variavel" a partir do diretório atual
rg "minha_variavel"

# Busca em um arquivo específico
rg "minha_variavel" meu_arquivo.js

# Busca por um padrão case-insensitive (-i) em arquivos do tipo Javascript (-g "*.js")
rg -i "getuser" -g "*.js"

# Mostra as 3 linhas de contexto antes e depois de cada match (-C 3)
rg -C 3 "MinhaClasse"
```

`ripgrep` por si só já é uma grande melhoria. Agora vamos adicionar a interatividade com `fzf`.

---

## 2. `fzf`: O Fuzzy Finder Interativo

`fzf` é um "fuzzy finder" de uso geral para a linha de comando. Ele lê uma lista de itens do `stdin`, abre uma interface interativa e escreve o item selecionado no `stdout`.

**Principais Vantagens:**
*   **Busca "Fuzzy":** Você não precisa digitar o nome exato; `fzf` encontra correspondências aproximadas.
*   **Interativo e Visual:** Filtre e selecione itens em tempo real.
*   **Integrável:** Pode ser combinado com qualquer outro comando.

### Instalação

```bash
# Instala via Git e executa o script de instalação
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
*O script de instalação irá perguntar se você quer habilitar os atalhos e a autocompleção. Responda `y` (sim) para tudo.*

### Uso Essencial (Atalhos Padrão)

*   **`Ctrl-T`:** Busca por arquivos e diretórios a partir do diretório atual. Cole o caminho do item selecionado na linha de comando.
*   **`Ctrl-R`:** Busca "fuzzy" no seu histórico de comandos.
*   **`Alt-C`:** Busca por um diretório e entra nele.

---

## 3. A Combinação Perfeita: `fzf` + `ripgrep`

Esta é a configuração que muda o jogo. Vamos configurar `fzf` para usar `ripgrep` para buscar **conteúdo** dentro dos arquivos de forma interativa.

**O Objetivo:** Ter um atalho que abra uma janela do `fzf`, onde você digita um termo e `fzf` mostra em tempo real todos os arquivos e linhas que contêm aquele termo, com um preview do arquivo.

### Configuração

Adicione o seguinte ao seu `.bashrc` ou `.zshrc`:

```bash
# Configuração para fzf usar ripgrep para busca de conteúdo
# Esta variável de ambiente diz ao fzf para usar rg ao invés do comando padrão (find)
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# Para busca de conteúdo dentro dos arquivos com preview
# Ativado por um atalho como Ctrl-F (configuração pode variar)
# Ou pode ser uma função no seu shell.
fzf-rg() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_CMD="$RG_PREFIX '$1' || true"
  
  fzf --ansi --disabled --query "$1" \
      --bind "change:reload:$FZF_CMD" \
      --preview "bat --color=always --style=numbers --line-range :500 {1}" \
      --preview-window "right,60%,wrap"
}
```
*Nota: Este exemplo de função `fzf-rg` usa `bat` para um preview com syntax highlighting. Se você não tiver `bat`, pode substituir por `cat` ou `head`.*

Com essa configuração:
1.  `fzf` (sozinho ou com `Ctrl-T`) usará `rg` para listar arquivos, sendo mais rápido e respeitando `.gitignore`.
2.  Você pode criar um alias ou atalho para a função `fzf-rg` para ter uma busca de conteúdo interativa e poderosa.

---

**Anterior:** [Guia de Instalação e Configuração](./08_exemplos_config.md)
