# Guia de Comandos do Vim

Este guia é uma referência rápida para os comandos mais comuns do Vim, organizado por nível de proficiência. Para entender os conceitos por trás desses comandos (como os Modos de Edição e a "Linguagem" do Vim), consulte o arquivo `introducao.md`.

---

## Nível 1: Comandos de Sobrevivência

*Estes são os comandos essenciais para abrir um arquivo, fazer uma pequena alteração e sair sem destruir nada.*

### **Salvar e Sair (Modo de Comando)**
*   `:w` - **w**rite. *Salva as alterações no arquivo.*
*   `:q` - **q**uit. *Fecha o Vim. Falhará se houver alterações não salvas.*
*   `:wq` - *Salva e fecha. A combinação mais comum.*
*   `:q!` - *Sai forçadamente, descartando quaisquer alterações. Sua "saída de emergência".*
*   `ZZ` - (No Modo Normal) *Um atalho rápido para `:wq`.*

### **Navegação e Edição Simples (Modo Normal)**
*   `h`, `j`, `k`, `l` - *Movimentação básica: esquerda, baixo, cima, direita. Mantenha suas mãos na home row.*
*   `x` - *Deleta o caractere sob o cursor. Útil para pequenas correções.*
*   `i` - **i**nsert. *Entra no Modo de Inserção antes do cursor para que você possa começar a digitar.*
*   `a` - **a**ppend. *Entra no Modo de Inserção depois do cursor.*
*   `u` - **u**ndo. *Desfaz a última alteração.*
*   `Ctrl+r` - **r**edo. *Refaz uma alteração que você desfez.*
*   `<Esc>` - *Volta para o Modo Normal. A tecla mais importante do Vim.*

---

## Nível 2: O Editor do Dia a Dia

*Comandos que transformam o Vim de "algo que você consegue usar" em uma ferramenta de edição eficiente.*

### **Navegação Rápida (Modo Normal)**
*   `w` - *Pula para o início da próxima **p**alavra (word).*
*   `b` - *Volta para o início da palavra **a**nterior (back).*
*   `e` - *Pula para o **f**im da palavra atual (end).*
*   `0` - *Vai para o início absoluto da linha.*
*   `^` - *Vai para o primeiro caractere não-branco da linha.*
*   `$` - *Vai para o fim da linha.*
*   `gg` - *Salta para a primeira linha do arquivo.*
*   `G` - *Salta para a última linha do arquivo.*
*   `Ctrl+d` / `Ctrl+u` - *Rola meia página para **b**aixo (down) ou para **c**ima (up).*

### **Operadores (Verbos) Comuns (Modo Normal)**
*   `d` - **d**elete. *O verbo para deletar. Sozinho não faz nada, precisa de um movimento.*
    *   `dd` - *Deleta a linha inteira.*
    *   `dw` - *Deleta do cursor até o fim da palavra.*
    *   `d$` - *Deleta do cursor até o fim da linha.*
*   `c` - **c**hange. *Similar ao `d`, mas entra no Modo de Inserção após a operação.*
    *   `cc` - *Muda a linha inteira.*
    *   `cw` - *Muda a palavra (change word). Um dos comandos mais úteis.*
*   `y` - **y**ank (copiar). *O verbo para copiar.*
    *   `yy` - *Copia a linha inteira.*
    *   `yw` - *Copia a palavra.*
*   `p` / `P` - **p**aste. *Cola o conteúdo copiado/deletado depois (`p`) ou antes (`P`) do cursor.*

### **Busca (Modo Normal)**
*   `/texto` - *Busca por "texto" no arquivo para frente.*
*   `?texto` - *Busca por "texto" para trás.*
*   `n` / `N` - *Pula para a **p**róxima (**n**ext) ou anterior ocorrência da busca.*

---

## Nível 3: A Gramática do Vim

*Aqui você deixa de pensar em atalhos e começa a falar a "linguagem" do Vim, combinando verbos e substantivos.*

### **O Ponto Mágico (`.`)**
*   `.` - *Repete a última **alteração** (qualquer comando que mude o texto, como `dd`, `cw`, `x`). Este é talvez o comando mais importante para a eficiência no Vim. Use `cw` para renomear uma variável, depois pule para a próxima e pressione `.`.*

### **Objetos de Texto (Text Objects)**
*Use `i` (inner) e `a` (around) para operar dentro ou ao redor de delimitadores.*
*   `ci"` - *Muda o texto **d**entro das **a**spas.*
*   `ci(` - *Muda o texto **d**entro dos **p**arênteses.*
*   `diw` - *Deleta a **p**alavra **i**nterna (delete inner word), não importa onde o cursor esteja na palavra.*
*   `caw` - *Muda **u**ma **p**alavra (change a word), incluindo o espaço em branco após ela.*
*   `dat` - *Deleta o conteúdo **a**o redor de uma **t**ag HTML.*

### **Janelas (Splits)**
*   `:sp <arquivo>` - *Abre um arquivo em uma nova janela horizontal (**sp**lit).*
*   `:vsp <arquivo>` - *Abre um arquivo em uma nova janela **v**ertical.*
*   `Ctrl+w` + `h,j,k,l` - *Navega entre as janelas.*
*   `Ctrl+w` + `q` - *Fecha a janela atual.*

---

## Nível 4: Magia Negra do Vim

*Comandos que fazem outros desenvolvedores perguntarem "como você fez isso?".*

### **Macros (Gravando suas Ações)**
*   `q<letra>` - *Começa a gravar tudo que você digita no registro `<letra>` (ex: `qa`).*
*   `q` - (no Modo Normal) *Para a gravação.*
*   `@<letra>` - *Executa a macro gravada (ex: `@a`).*
*   `@@` - *Repete a última macro executada.*
*   *Caso de uso: Automatizar uma tarefa repetitiva e complexa em múltiplas linhas.*

### **Marcadores (Marks)**
*   `m<letra>` - *Cria um marcador (bookmark) na posição atual (ex: `ma`).*
*   `` `<letra> `` - *Salta de volta para a posição exata do marcador (ex: `` `a ``).*
*   `'<letra>` - *Salta para o início da linha do marcador (ex: `'a`).*
*   *Caso de uso: Marcar um ponto importante no código, ir para outro arquivo e voltar instantaneamente.*

### **Registros (Áreas de Transferência Múltiplas)**
*   O Vim tem múltiplos registros (a-z) para copiar e colar.
*   `"<letra>y` - *Copia (yank) para o registro `<letra>` (ex: `"ayy` copia a linha para o registro `a`).*
*   `"<letra>p` - *Cola do registro `<letra>` (ex: `"ap`).*
*   *Caso de uso: Copiar várias partes diferentes de um arquivo e colá-las em outra ordem.*

### **Outros Comandos Poderosos**
*   `Ctrl+a` / `Ctrl+x` - (no Modo Normal) *Incrementa ou decrementa o primeiro número encontrado na linha. Ótimo para editar listas numeradas ou constantes.*
*   `gf` - **g**oto **f**ile. *Com o cursor sobre um caminho de arquivo, este comando abre o arquivo correspondente.*

---

**Anterior:** [Introdução ao Vim: Por que e Como Funciona](./introducao.md) | **Próximo:** [Guia de Plugins para Vim](./vim_plugins.md)
