poliTeX
=======

Classe do LaTeX para manuscritos da Escola Politécnica da USP.

A classe poliTeX (leia-se "POLITEK") é baseada na classe para monografias ABNT adaptada pelo Prof. Paulo Barreto para os padrões da POLI-USP ([link](http://www.ime.usp.br/~leofl/tex/modelo_poli.zip)). Porém, ela apresenta consideráveis mudanças na implementação e funcionalidades da classe. Algumas das principais diferenças são:

+ Remoção de funções que não suportavam diretamente o padrão da POLI-USP (diferentes cabeçalhos, formatações de títulos, tipos de sumários...);
+ Limpeza do código e adição de comentários para facilitar a manutenção: a nova classe tem metade do tamanho da anterior;
+ Remoção de "hacks" de formatação usando de pacotes padrões do LaTeX como ```fancyhdr``` e ```geometry```;
+ Mudanças na implementação das partes pré-textuais;
+ Novas funcionalidades: epígrafe do trabalho, epígrafes nos capítulos, suporte para o uso de partes (```\part```);
+ Suporte para trabalhos de TCC e múltiplos autores;
+ Internacionalização: suporte para documentos redigidos em inglês;
+ De acordo com a norma POLI 2013 ([link](http://www.poli.usp.br/images/stories/media/download/bibliotecas/DiretrizesTesesDissertacoes.pdf)).

