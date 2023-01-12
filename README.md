poliTeX
=======

**Infelizmente, eu não tenho mais tempo para manter esse repositório.  
A classe poliTeX continua funcionando para escrever sua monografia/dissertacão/tese, mas eu não posso mais atender a pedidos de funcionalidades, responder a dúvidas ou resolver bugs. Boa sorte a todos!**

---

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


Uso
===

O arquivo ```template.tex``` é um documento da classe poliTeX com todas as funcionalidades comentadas. Basta abri-lo e escrever seu TCC, dissertação ou tese. A seguir, estão as principais opções e funções da classe para referência.


Opções da classe
----------------

- ```pnumromarab```: Numera as páginas usando algorismos romanos na parte pré-textual e algarismo arábicos na parte textual. A contagem de páginas reinicia no início da parte textual. Se esta opção não for definida, o padrão da ABNT/POLI é seguido, numerando todas as páginas com algorismo arábicos, iniciando a contagem na falsa folha de rosto.

- ```abnttoc```: Inclui "p." na frente da numeração das páginas no sumário conforme exigido pela ABNT/POLI. Esta é a única opção que, se ignorada, não segue a ABNT (porque esse "p." no sumário é ridículo).

- ```normalnum```: Força figuras e tabelas a serem numeradas continuamente por todo o texto. O padrão ABNT/POLI exige que a numeração reinicie a cada capítulo, que é o que ocorre se esta opção não for usada.

- ```draftprint```: Esta opção de impressão reduz a margem interna (remove a sangria para encadernação), o que pode economizar folhas na hora de imprimir versões para revisão.

- ```twosideprint```: Ajusta as margens e paginação para impressão frente-e-verso.

- ```capsec```: Esta opção força a capitalização dos títulos das seções, isto é, independente de como você escrever no código, os títulos das seções serão apresentados em letras maiúsculas.

- ```espacosimples```: Gera o documento usando espaçamento simples ao invés de 1.5 (exigido pelo padrão POLI).

- ```espacoduplo```: Gera o documento usando espaçamento duplo ao invés de 1.5 (exigido pelo padrão POLI).

- ```times```: Tenta usar Times como fonte para o corpo do texto ao invés de Computer Modern Roman, a fonte padrão do LaTeX. Requer pacotes adicionais (```mathptmx```).

- ```noindentfirst```: O padrão é que todos os parágrafos sejam indentados. Se desejar, pode ativar esta opção que força o primeiro parágrafo de capítulos/seções a não serem indentados.


O preâmbulo
-----------
Para usar a classe poliTeX você precisa definir os parâmetros do seu documento no preâmbulo:

#### Título

```
\titulo{Título}
```

#### Autor(es)

```
\autor{Nome Sobrenome}
```

**Nota**: você pode definir múltiplos autores (por exemplo, para TCCs) separando os autores por quebras de linhas. Usar mais de 5 autores pode deixar a capa um pouco apertada.

```
\autor{Nome Sobrenome\\%
       Nome Sobrenome\\%
       Nome Sobrenome}
```

#### Orientador / Coorientador

```
\orientador{Nome do orientador}
\coorientador{Nome do coorientador (opcional)}
```

**Nota**: Esses campos não devem ser definidos para teses/memoriais de livre docência.

#### Tipo de documento

- TCC

```
\tcc{Eletricista com ênfase em Sistemas Eletrônicos}
```

- Dissertação de mestrado

```
\dissertacao{Engenharia Elétrica}
```

- Tese de doutorado

```
\teseDOC{Engenharia Elétrica}
```

- Tese de livre docência

```
\teseLD
```

- Memorial para livre docência

```
\memorialLD
```

#### Departamento e área de concentração

```
\departamento{Nome do departamento}
\areaConcentracao{Área de concentração}
```

#### Local

```
\local{São Paulo}
```

#### Ano

```
\data{2014}
```



Geração de elementos pré-textuais
---------------------------------

De acordo com a norma ABNT/POLI, os elementos pré-textuais devem aparecer na seguinte ordem:

1. Capa
2. Falsa folha de rosto
3. Folha de rosto
4. Dedicatória (opcional)
5. Agradecimentos (opcional)
6. Epígrafe (opcional)
7. Resumo em língua vernácula
8. Resumo em língua estrangeira
9. Listas (tabelas, figuras, símbolos) (opcional)
10. Sumário


**Nota**: O termo de julgamento (que fica entre a falsa folha de rosto e a folha de rosto) é obtido da banca e a ficha catalográfica (que fica no *verso* da folha de rosto) deve ser solicitada ao setor de bibliotecas (http://www.poli.usp.br/en/bibliotecas/servicos/catalogacao-na-publicacao.html).

**Nota**: A língua do documento é definida pelo uso do pacote ```babel```. Os títulos das seções são traduzidos automaticamente. Para escrever o texto em português, use no preâmbulo ```\usepackage[brazil]{babel}```. Para inglês, use ```\usepackage[english]{babel}```.

**Atenção**: Ao trocar de língua, sempre faça um ```make clean``` ou apague todos os arquivos auxiliares criados pelo LaTeX antes de compilar. Esse é um problema do pacote ```babel```. Mas não se preocupe: se você esquecer, o ```babel``` é chato e vai lembrar você com um erro. Considere-se avisado!


#### Capa e folhas de rosto

```
\capa
\falsafolhaderosto
\folhaderosto
```

#### Dedicatória (opcional)

```
\dedicatoria{Dedicatória}
```


#### Agradecimentos (opcional)

```
\begin{agradecimentos}

Lorem ipsum...

\end{agradecimentos}
```


#### Epígrafe (opcional)

```
\epigrafe{%
	\emph{``Epígrafe''}
	\begin{flushright}
		-{}- Autor
	\end{flushright}
}
```


#### Resumo em língua vernácula

```
\begin{resumo}
Resumo...
%
\\[3\baselineskip]
%
\textbf{Palavras-Chave} -- Palavra, Palavra, Palavra, Palavra, Palavra.
\end{resumo}
```


#### Resumo em língua estrangeira
```
\begin{abstract}
Abstract...
%
\\[3\baselineskip]
%
\textbf{Keywords} -- Word, Word, Word, Word, Word.
\end{abstract}
```


#### Listas (opcional)

```
\listadefiguras
\listadetabelas
```

**Nota**: Você também pode incluir listas personalizadas (e.g., lista de símbolos ou siglas) usando o ambiente `pretextualsection`. Estas listas são definidas pelo usuário (você deve inseri-las manualmente, mesmo que o conteúdo seja gerado usando algum pacote do LaTeX):

```
\begin{pretextualsection}{Lista de símbolos}

Lista de símbolos...

\end{pretextualsection}
```


#### Sumário

```
\sumario
```



Funções auxiliares
------------------

#### Citações longas (mais de 3 linhas)

```
\begin{citacaoLonga}
	Uma longa citação literal
\end{citacaoLonga}
```

#### Epígrafe para capítulos

```
\capepigrafe[0.5\textwidth]{``Frase espirituosa de um autor famoso''}{Autor famoso}
```



Citações e referências ABNT: ABNTeX 2
-------------------------------------

O padrão da POLI exige que citações e referências estejam no formato ABNT. Para fazer isto usando BibTeX, instale o pacote ABNTeX 2 disponível pelo CTAN (http://www.ctan.org/tex-archive/macros/latex/contrib/abntex2). Em seguida, inclua no preâmbulo ```\usepackage[num]{abntex2cite}``` (para citações no modelo numérico) ou ```\usepackage[alf]{abntex2cite}``` (para citações no modelo autor-data). Logo antes das suas referências, declare o estilo ```\bibliographystyle{abntex2-num}``` ou ```\bibliographystyle{abntex2-alf}```. Se preferir usar outro estilo de referência (do IEEE, por exemplo), ignore o pacote ```abntex2cite``` e declare o estilo antes do ```\bibliography```.



Dicas
-----

+ Use BibTeX!
+ Escreva cada capítulo do seu documento em um arquivo .tex separado. Use o comando ```\include{capitulo.tex}``` para incluir os capítulos no seu documento principal.
+ Use espaços inquebráveis ```~```, ou seja, espaços nos quais o LaTeX não muda de linha. Use antes de parênteses, citações, números e qualquer outro ítem que ficaria estranho começando uma linha.
+ Saiba sobre os diferentes ambientes de matemática e use aquele que for mais adequado para o seu caso (```equation```, ```subequations```, ```align```, ```aligned```, ```gather```, ```gathered```, ```cases```, ```multline```). Não manipule o espaçamento e indentação de equações na mão.


Issues
------

Problema e sugestões devem ser enviadas pelo repositório GitHub:

https://github.com/lchamon/poliTeX
