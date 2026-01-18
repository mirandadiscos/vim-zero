# 02. Comandos Essenciais do Linux para Desenvolvedores

Dominar a linha de comando é um superpoder. Este guia é uma referência para comandos essenciais, com foco em cenários práticos para o dia a dia do desenvolvimento.

---

## 1. Manipulação de Arquivos e Diretórios

### `find`
**O que faz:** Encontra arquivos e diretórios com base em critérios como nome, tipo, tamanho, etc.
**Quando usar:** Quando você precisa localizar arquivos específicos em uma árvore de diretórios complexa.

**Exemplos:**
```bash
# Encontra todos os arquivos que terminam com .py no diretório atual e subdiretórios
find . -name "*.py"

# Encontra todos os diretórios chamados 'node_modules' para posterior remoção
find . -type d -name "node_modules"

# Encontra e deleta todos os arquivos de log (.log)
find . -name "*.log" -delete
```

### `xargs`
**O que faz:** Executa um comando a partir da entrada padrão (stdin).
**Quando usar:** Em conjunto com outros comandos (como `find`) para aplicar uma ação a uma lista de itens.

**Exemplo:**
```bash
# Encontra todos os diretórios 'node_modules' e os remove interativamente
find . -type d -name "node_modules" | xargs rm -r
```

### `chmod` e `chown`
**O que faz:** Altera as permissões (`chmod`) e a propriedade (`chown`) de arquivos e diretórios.
**Quando usar:** Quando você precisa corrigir problemas de permissão, como ao executar um script.

**Exemplos:**
```bash
# Torna um script executável
chmod +x meu_script.sh

# Altera o proprietário de um arquivo para o usuário 'vito'
sudo chown vito:vito /caminho/para/o/arquivo
```

---

## 2. Processamento de Texto

### `grep` (e seu sucessor `rg`)
**O que faz:** Busca por padrões em texto.
**Quando usar:** Para encontrar rapidamente linhas que contêm uma string ou expressão regular em um ou mais arquivos.
**Alternativa Moderna:** `rg` (Ripgrep) é muito mais rápido e respeita `.gitignore` por padrão.

**Exemplos:**
```bash
# Encontra todas as linhas contendo "error" no arquivo server.log
grep "error" server.log

# Busca recursivamente pela string "API_KEY" em todos os arquivos do diretório atual
rg "API_KEY" .
```

### `sed`
**O que faz:** "Stream Editor". Edita texto de forma programática.
**Quando usar:** Para fazer substituições de texto em arquivos diretamente da linha de comando.

**Exemplo:**
```bash
# Substitui todas as ocorrências de "antigo" por "novo" em um arquivo
sed -i 's/antigo/novo/g' arquivo.txt
```

### `jq`
**O que faz:** O "sed para JSON". Permite fatiar, filtrar e transformar dados JSON.
**Quando usar:** Quando você precisa extrair ou manipular dados de uma resposta de API ou de um arquivo de configuração JSON.

**Exemplo:**
```bash
# Extrai o valor da chave "version" de um arquivo package.json
cat package.json | jq -r '.version'
```

---

## 3. Monitoramento de Sistema e Processos

### `htop`
**O que faz:** Um visualizador de processos interativo. Uma versão muito melhorada do `top`.
**Quando usar:** Para entender quais processos estão consumindo mais CPU e memória de forma visual e interativa.

### `df` e `du`
**O que fazem:** `df` (disk free) mostra o uso de espaço em disco do sistema; `du` (disk usage) estima o uso de espaço de arquivos.
**Quando usar:** `df` para ter uma visão geral do disco; `du` para encontrar quais pastas estão ocupando mais espaço.

**Exemplos:**
```bash
# Mostra o uso de disco em formato legível (GB, MB, etc.)
df -h

# Mostra um resumo do tamanho de cada item no diretório atual
du -sh *
```

### `ps` e `kill`
**O que fazem:** `ps` lista os processos em execução; `kill` envia um sinal para um processo (geralmente para terminá-lo).
**Quando usar:** Para encontrar o ID de um processo (`PID`) e finalizá-lo.

**Exemplos:**
```bash
# Encontra todos os processos de python em execução
ps aux | grep "python"

# Envia o sinal de término (pede para o processo fechar)
kill <PID>

# Força o término imediato (use como último recurso)
kill -9 <PID>
```

---

## 4. Rede e Transferência de Arquivos

### `curl`
**O que faz:** Ferramenta para transferir dados de ou para um servidor.
**Quando usar:** Para fazer requisições HTTP, testar APIs e baixar arquivos.

**Exemplos:**
```bash
# Faz uma requisição GET para a API do GitHub
curl https://api.github.com/users/octocat

# Envia dados JSON via POST
curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' http://localhost:3000/data
```

### `ssh`
**O que faz:** "Secure Shell". Conecta-se a um servidor remoto de forma segura.
**Quando usar:** Para administrar servidores ou máquinas remotas.

**Exemplo:**
```bash
# Conecta-se ao servidor com o usuário 'admin'
ssh admin@endereco_do_servidor
```

### `scp` e `rsync`
**O que fazem:** Copiam arquivos entre máquinas. `scp` é simples; `rsync` é mais poderoso e eficiente, pois só transfere as diferenças.
**Quando usar:** `scp` para cópias rápidas; `rsync` para transferências grandes ou recorrentes.

**Exemplos:**
```bash
# Copia um arquivo local para um servidor remoto
scp /caminho/local/arquivo.txt usuario@servidor:/caminho/remoto/

# Sincroniza um diretório local com um remoto
rsync -avz /caminho/local/ usuario@servidor:/caminho/remoto/
```

---

**Anterior:** [Configuração do Terminal](./01_terminal_setup.md) | **Próximo:** [Introdução ao Vim e Neovim](./03_vim_neovim_intro_basics.md)