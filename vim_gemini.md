# Guia Extra: Usando Vim + Gemini para Superprodutividade

A combinação de um editor de texto eficiente como o Vim e um assistente de IA poderoso como o Gemini, diretamente na linha de comando, cria um fluxo de trabalho de desenvolvimento extremamente rápido e focado. A ideia é simples: use cada ferramenta para o que ela faz de melhor, sem nunca sair do terminal.

*   **Vim:** Para edição e manipulação de texto na velocidade da luz.
*   **Gemini (CLI):** Para geração de código, explicação, refatoração e brainstorming.

---

## 1. O Fluxo de Trabalho Básico: Lado a Lado

A maneira mais simples e eficaz de usar o Vim e o Gemini juntos é em um ambiente com painéis de terminal (splits). Use um emulador de terminal moderno que suporte isso, como:
*   **Windows Terminal**
*   **iTerm2** (macOS)
*   **tmux** (Linux, macOS)

![Layout com Vim e Gemini lado a lado](https://i.imgur.com/8aIs3b6.png)

### Cenário 1: Gerar e Colar
*Você precisa de uma nova função, um teste unitário ou um bloco de código repetitivo (boilerplate).*

1.  **Peça ao Gemini:** No painel do Gemini, escreva um prompt claro.
    > "Crie uma função em Python que recebe o caminho de um arquivo e retorna o número de linhas. Inclua tratamento de exceções para arquivo não encontrado."

2.  **Copie o Código:** Copie o bloco de código gerado pelo Gemini.
3.  **Cole no Vim:** No painel do Vim, mova o cursor para onde você quer o código e cole-o (usando `p` no modo normal).

### Cenário 2: Copiar, Explicar e Refatorar
*Você encontra um trecho de código legado ou complexo que não entende completamente.*

1.  **Copie do Vim:** Selecione o bloco de código no Vim (usando o Modo Visual) e copie-o (`y`).
2.  **Peça ao Gemini:** No painel do Gemini, cole o código e peça ajuda.
    > "Explique este código Rust para mim. O que a macro `println!` está fazendo aqui?"
    
    Ou, para melhorias:
    > "Refatore este código JavaScript para usar `async/await` em vez de Promises aninhadas."

3.  **Copie a Nova Versão:** Copie o código refatorado do Gemini.
4.  **Substitua no Vim:** No Vim, selecione o bloco de código antigo novamente (ou use um movimento como `cip` - change inner paragraph) e cole a nova versão, substituindo-o.

---

## 2. Integração Avançada: Criando um Comando no Vim

Você pode criar atalhos no seu `.vimrc` para enviar código diretamente do Vim para o Gemini CLI, tornando o fluxo de trabalho ainda mais rápido.

**Aviso:** O exemplo abaixo é **conceitual**. Ele assume que a interface de linha de comando do Gemini pode aceitar um prompt via argumentos, algo como `gemini "meu prompt"`. Você precisará adaptar o comando à sintaxe real do seu Gemini CLI.

### Exemplo de Configuração no `.vimrc`
Adicione o seguinte ao seu `.vimrc` para criar um atalho que explica o código selecionado:

```vim
" Mapeia <Leader>ge (g de gemini, e de explain) no Modo Visual
" para enviar o texto selecionado para o Gemini CLI.
vnoremap <leader>ge :!gemini "Explique este código:" "$(xclip -o)"<CR>
```

**Como Funciona:**
*   `vnoremap`: Cria um atalho não-recursivo para o **Modo Visual**.
*   `<leader>ge`: O atalho. A tecla "leader" geralmente é `\` ou `espaço`.
*   `:!`: Executa um comando de shell.
*   `gemini "..."`: O comando do Gemini CLI.
*   `"$(xclip -o)"`: Este é um truque para sistemas Linux com `xclip` instalado (`sudo apt install xclip`). Ele pega o conteúdo da área de transferência (que o Vim preenche ao copiar) e o insere no comando. Em outros sistemas, você pode precisar de uma abordagem diferente.
*   `<CR>`: Simula o pressionamento da tecla Enter.

**Uso:**
1.  Selecione um bloco de código no Vim (Modo Visual).
2.  Pressione `\` + `g` + `e`.
3.  O Vim executará o comando no shell, e a resposta do Gemini aparecerá no seu terminal.

---

## 3. Boas Práticas

*   **Prompts Claros:** A qualidade da saída do Gemini depende da qualidade da sua entrada. Em vez de "arrume isso", tente "Este código Python está levantando um `IndexError` nesta linha. Como posso adicionar uma verificação para evitar isso?".
*   **Use Registros:** Copie diferentes trechos de código para registros nomeados no Vim (ex: `"ayy` para copiar uma linha para o registro `a`, `"byy` para o registro `b`) para poder fazer várias perguntas ao Gemini sem perder o que copiou.
*   **Confie, mas Verifique:** Sempre revise e entenda o código gerado pela IA antes de integrá-lo ao seu projeto. Use o Gemini como um assistente que acelera seu trabalho, não como um substituto para seu julgamento.

---

**Anterior:** [Guia: Gerenciando Dotfiles com Git e GitHub](./dotfiles_management.md) | **Voltar ao [README](./README.md)**
