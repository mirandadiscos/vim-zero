# 8. Guia de Instalação e Configuração

Documentação com seções para instalação do Git e `asdf` (v14).

## Seção 1: Instalação e Uso do Git

O Git é um sistema de controle de versão distribuído, essencial para o desenvolvimento de software.

### Instalação

*   **Para Debian/Ubuntu:**
    ```bash
    sudo apt update && sudo apt install git
    ```
*   **Para Fedora/CentOS/RHEL:**
    ```bash
    sudo dnf install git  # ou sudo yum install git
    ```

### Uso Essencial

1.  **Configuração Inicial (apenas uma vez):**
    ```bash
    git config --global user.name "Seu Nome"
    git config --global user.email "seu-email@example.com"
    ```
2.  **Clonar um projeto:**
    ```bash
    git clone https://github.com/exemplo/repositorio.git
    ```
3.  **Salvar suas alterações:**
    ```bash
    git add .                           # Adiciona todos os arquivos modificados
    git commit -m "Mensagem do commit"  # Salva as alterações localmente
    git push                            # Envia as alterações para o repositório remoto
    ```

## Seção 2: Instalação e Uso do `asdf` (v0.14.0) e Editor Vim

O `asdf` é um gerenciador de versões de ferramentas CLI. Com ele, você pode ter várias versões de Node.js, Ruby, etc., no mesmo sistema.

### Instalação do `asdf`

```bash
# 1. Clone o repositório do asdf na branch específica v0.14.0
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```

### Configuração do Shell

Após a instalação do `asdf`, você precisa configurá-lo no seu shell. Fornecemos arquivos `.rc` completos e prontos para uso no diretório `exemplos_rc/`:
*   `exemplos_rc/exemplo.bashrc`
*   `exemplos_rc/exemplo.zshrc`

Para usar um desses arquivos como sua configuração de shell principal, você pode:
1.  **Renomear seu arquivo de configuração atual (opcional, para backup):**
    ```bash
    mv ~/.bashrc ~/.bashrc_backup # ou mv ~/.zshrc ~/.zshrc_backup
    ```
2.  **Copiar o arquivo de exemplo para seu diretório home:**
    ```bash
    cp exemplos_rc/exemplo.bashrc ~/.bashrc # ou cp exemplos_rc/exemplo.zshrc ~/.zshrc
    ```
3.  **Reiniciar o terminal** ou executar `source ~/.bashrc` (ou `source ~/.zshrc`) para carregar as mudanças.

Esses arquivos incluem a configuração do `asdf` e um boilerplate comum para ambientes de shell.

### Configuração do Editor Vim (`.vimrc`)

Também fornecemos um arquivo `vimrc` de exemplo, completo e pronto para uso:
*   `exemplos_rc/exemplo.vimrc`

Para usar este arquivo como sua configuração do Vim:
1.  **Renomear seu arquivo .vimrc atual (opcional, para backup):**
    ```bash
    mv ~/.vimrc ~/.vimrc_backup
    ```
2.  **Copiar o arquivo de exemplo para seu diretório home:**
    ```bash
    cp exemplos_rc/exemplo.vimrc ~/.vimrc
    ```
3.  **Abra o Vim.** As configurações serão carregadas automaticamente.

Este `vimrc` de exemplo inclui configurações básicas para produtividade, como números de linha, destaque de sintaxe, indentação e alguns mapeamentos úteis.

### Como Instalar Linguagens (Exemplo)

Com o `asdf` configurado, você pode instalar qualquer linguagem com seu respectivo plugin. Por exemplo, para instalar Node.js:

```bash
asdf plugin-add nodejs
asdf install nodejs latest
asdf global nodejs latest
```

## Seção 3: `direnv` e Ambientes por Diretório (`.envrc`)

O `direnv` é uma ferramenta que carrega e descarrega automaticamente variáveis de ambiente dependendo do diretório em que você está. Isso é útil para gerenciar configurações específicas de cada projeto.

### Instalação do `direnv`

*   **Para Debian/Ubuntu:**
    ```bash
    sudo apt update && sudo apt install direnv
    ```
*   **Para Fedora/CentOS/RHEL:**
    ```bash
    sudo dnf install direnv
    ```
*   **Para outras plataformas,** consulte a documentação oficial do `direnv`.

### Configuração do Shell para `direnv`

**Importante:** Os arquivos `exemplo.bashrc` e `exemplo.zshrc` que fornecemos já foram atualizados para carregar o `direnv` automaticamente se ele estiver instalado. Nenhuma ação adicional é necessária se você estiver usando nossos arquivos de exemplo.

### Configuração por Projeto (`.envrc`)

O `direnv` funciona com arquivos `.envrc` na raiz de cada projeto. Fornecemos um exemplo pronto para uso:
*   `exemplos_rc/exemplo.envrc`

Para usar este arquivo:
1.  **Copie o exemplo para a raiz do seu projeto:**
    ```bash
    cp exemplos_rc/exemplo.envrc /caminho/para/seu/projeto/.envrc
    ```
2.  **Permita que o `direnv` carregue o arquivo:**
    Navegue até o diretório do seu projeto e execute:
    ```bash
    direnv allow
    ```
A partir de agora, toda vez que você entrar nesse diretório, o `direnv` carregará automaticamente as configurações do `.envrc` (como as ferramentas do `asdf` via `use asdf` e variáveis de ambiente).