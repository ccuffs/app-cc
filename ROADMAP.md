# Roadmap do projeto

Esse arquivo descreve a ideia geral do aplicativo e rascunha um possível plano de desenvolvimento.

## Funcionalidades do app

Em linhas gerais, as necessidades para o aplicativo são as seguintes (não estão em ordem alguma de prioridade):

* **A)** Alunos e professores conseguirem fazer login utilizando o idUFFS (mesmo do portal do aluno/professor)

* **B)** Aba com as notícias postadas no site do curso;

* **C)** Aba para acesso a um chat estilo whatsapp/telegram que dará acesso à assistente virtual do curso no futuro;

* **D)** Aba com mensagens diretas, estilo SMS, onde o aluno receberá informações urgentes ou importantes, e.x.: não haverá aula, período de matrícula, etc.

* **E)** Um botao para ativar um leitor de QR code (será usado para interação em enquetes na aula, eventos do curso, etc);

* **F)** Um botão para mostrar um QR code do dispositivo, que identificará a pessoa unicamente (para ser lido em eventos, por exemplo);

* **G)** Uma aba para transferência de arquivos entre os aplicativos do curso e os PCs do lab;

* **H)** Aba com o calendário do curso, em um estilo de timeline navegável;

* **I)** Perfil pessoal com informações sobre horas acumuladas (como horas de ACC);

* **J)** No perfil pessoal, lista de "achievements" do curso e os achievements já conseguimos pelo usuário.

Vários desses requesitos são superfluos em um primeiro momento e são mais uma visão do que o app será no futuro.

## Plano de desenvolvimento

O desenvolvimento pode ser levado em fases, nas quais elementos mais importantes são trabalhados primeiro.

Poderíamos organizar da seguinte forma:

* **Fase 1** - básico (funcionalidades A e B);

* **Fase 2 -** comunicação (funcionalidades D e H);

* **Fase 3** - assistente virtual (funcionalide C)

* **Fase 4** - troca de informações (funcionalidades E, F e G);

* **Fase 5** - perfil pessoal (funcionalidades I e J);

## Tecnologias

O projeto precisa ser desenvolvido em [Flutter](https://flutter.dev), _obrigatoriamente_.

Qualquer integração com os serviços da UFFS, ex.: login idUFFS, será implementada pelo curso de Ciência da Computação, em um projeto em separado. O responsável por gerenciar essas implementações é o prof. [Fernando Bevilacqua](https://github.com/Dovyski).
