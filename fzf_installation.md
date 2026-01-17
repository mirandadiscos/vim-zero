# Guia de Instalação e Otimização do `fzf`

`fzf` é um "fuzzy finder" de linha de comando de uso geral, e é uma das ferramentas de produtividade mais impactantes que você pode adicionar ao seu arsenal.

Este guia cobre a instalação e, crucialmente, como torná-lo ainda mais poderoso.

## O que é um "Fuzzy Finder"?

Em vez de procurar por uma correspondência exata, um "fuzzy finder" permite que você digite alguns caracteres e ele encontrará todas as linhas que contêm esses caracteres, na ordem, mas não necessariamente juntos.

Por exemplo, para encontrar o arquivo `app/controllers/users_controller.rb`, você pode simplesmente digitar `aconusr` e o `fzf` o encontrará instantaneamente.

Isso o torna incrivelmente rápido para encontrar arquivos, comandos no seu histórico, processos, etc.

![GIF do fzf em ação](https://raw.githubusercontent.com/junegunn/i/master/fzf-history.gif)

Para o nosso caso, o `fzf` é a dependência principal do plugin `fzf.vim`, que traz essa funcionalidade para dentro do Vim.

---

## 1. Instruções de Instalação

O `fzf` é um programa de linha de comando. Você deve instalá-lo no seu sistema operacional.

### Linux
#### Com Gerenciador de Pacotes (Recomendado)
*   **Debian / Ubuntu:** `sudo apt install fzf`
*   **Fedora / RHEL:** `sudo dnf install fzf`
*   **Arch Linux:** `sudo pacman -S fzf`

#### Com Git (Método Universal)
Se o `fzf` não estiver no seu gerenciador de pacotes ou se você quiser a versão mais recente.
1.  **Clone o repositório:**
    ```bash
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ```
2.  **Execute o script de instalação (Passo Crucial):**
    ```bash
    ~/.fzf/install
    ```

### macOS (com Homebrew)
1.  **Instale:**
    ```bash
    brew install fzf
    ```
2.  **Execute o script de instalação:**
    ```bash
    $(brew --prefix)/opt/fzf/install
    ```

### Windows (Dentro do WSL)
Siga as instruções para **Linux** acima, executando os comandos dentro do seu ambiente WSL.

---

## 2. O que o Script de Instalação Faz?

Ao executar `~/.fzf/install`, o script pergunta se você quer:
1.  **Ativar o autocompletar "fuzzy"? (y/n)** - Sim. Isso permite que você use `fzf` para completar nomes de arquivos, etc.
2.  **Ativar atalhos de teclado? (y/n)** - Sim. Isso ativa os atalhos que mudam o jogo.
3.  **Modificar seu arquivo de shell? (y/n)** - Sim. O script adiciona uma linha ao seu `~/.bashrc`, `~/.zshrc`, etc., para carregar o `fzf` toda vez que você abre um terminal.

Após executar, reinicie seu terminal. Você terá acesso aos seguintes atalhos:
*   `Ctrl+T` - Encontra arquivos e subdiretórios no diretório atual.
*   `Ctrl+R` - Busca no seu histórico de comandos.
*   `Alt+C` - Busca por um diretório e entra nele após a seleção.

---

## 3. Otimização: Usando `fzf` com `ripgrep`

Por padrão, o `fzf` (e o atalho `Ctrl+T`) usa o comando `find` para listar os arquivos. Isso tem duas desvantagens:
1.  Pode ser lento em projetos grandes.
2.  Ele **não** respeita as regras do seu arquivo `.gitignore`, mostrando arquivos de `node_modules`, `build`, etc.

A solução é usar o `fzf` com o **`ripgrep` (`rg`)**, um buscador de arquivos extremamente rápido que respeita o `.gitignore` por padrão.

### Passo 1: Instale o `ripgrep`
```bash
# Debian / Ubuntu
sudo apt install ripgrep

# Fedora / RHEL
sudo dnf install ripgrep

# Arch Linux
sudo pacman -S ripgrep

# macOS
brew install ripgrep
```

### Passo 2: Configure o `fzf` para usar o `ripgrep`
Adicione a seguinte linha ao seu arquivo de configuração do shell (`~/.zshrc` ou `~/.bashrc`). Isso diz ao `fzf` para usar `rg` como seu comando padrão para encontrar arquivos.

```bash
# Usa ripgrep para o fzf, respeitando .gitignore e mostrando arquivos ocultos.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
```

---

**Anterior:** [Guia de Plugins para Vim](./vim_plugins.md) | **Próximo:** [Guia: Transformando o Vim em um IDE com CoC](./vim_ide.md)

Depois de adicionar esta linha e reiniciar seu terminal, o atalho `Ctrl+T` e os comandos do `fzf.vim` (como `:Files`) se tornarão significativamente mais rápidos e inteligentes, escondendo o "lixo" do seu projeto e mostrando apenas os arquivos relevantes.