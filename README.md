# Aplicativo móvel do curso

Esse repositório contém o código do aplicativo móvel para uso de alunos, professores e técnicos do curso de [Ciência da Computação](https://cc.uffs.edu.br) da [UFFS](http://www.uffs.edu.br), Chapecó/SC.

Veja o arquivo [ROADMAP](ROADMAP.md) para conhecer as funcionalidades esperadas para o aplicativo e um rascunho do plano de desenvolvimento.


# Ficha Técnica

[Protótipo do APP](https://marvelapp.com/d049b9h)
Projeto sendo desenvolvido em [Flutter](https://flutter.dev/)


# Sobre a arquitetura

  

Podem encontrar mais informações sobre aqui -> https://pub.dev/packages/flutter_clean_architecture

  

Mas em resumo o sistema esta divido nas seguintes pastas:

```
app
 |-> pages
     |-> page_name
         |-> name_controller.dart
         |-> name_view.dart
         |-> name_presenter.dart
 |-> utils
 |-> widgets
data
 |-> helpers
 |-> repositories
 |-> streams
device
 |-> repositories
 |-> streams
 |-> utils
domain
 |-> entities
 |-> repositories
 |-> usecases
```

### App
Aqui ficam oque sera realmente exibido, e as classes que auxiliam as de exibição, dentro de pages temos a view, que exibe widgets, o controller, que controla as ações da view, e o presenter, que é responsavel por comunicar esta camada com as outras. Em utils temos classes utilitarias, e em widgets qualquer widget default do sistema.

#### View
Aqui mora oque sera realmente exibido na tela, widgets realmente.

#### Controller
Possui a logica de controle da tela, ele é responsavel pelas navegações, exibição de erros, de modais, do loading, e de contactar o presenter.

#### Presenter
O presenter é uma camada de conexão com um UseCase, essa conexão se faz da seguinte forma.
- Um usecase é instanciado na criação do presenter;
- Ele é executado em uma função do presenter;
-   - A execução de um usecase recebe uma classe observer, que é responsavel por chamar 3 funcões dentro do presenter (essas funções são definidas pelo controller), essas funções representam uma alteração(onNext), a finalização do usecase(onComplete), ou um erro no usecase(onError).
- - Através desse observador valores e variaveis devem retornar para o controller.

### Data e Device
Eles tem funções bem parecidas, eles são responsaveis por armazenar, buscar e manuzear dados, data é responsavel por buscar dados externos, como de APIs ou DBs, enquanto device controla informações do celular, como bateria, conectividade, ou informações pessoais, como numero do usuário.

#### Repositories
São responsaveis por buscar as informações.

#### Streams
São responsaveis por distribuir e manter informações.

### Domain
Ele representa a conexão entre o App e Data ou Device.

#### Usecases
Eles acessam repositorios, instanciam entidades, alimentam streams, e devolvem dados ao controller, aqui é onde a maior parte da logica esta normalmente, e onde os testes devem ser mais fortes, são faceis de mocar o que esta ao seu redor.

#### Repositories
São abstracts, sempre, quando um presenter recebe um repository, na verdade ele recebe um abstract daqui, isso é usado pra manter as classes sempre herdando de alguem mais forte, e pra manter a sincronia entre tudo.

#### Entities
São classes estruturadas que representam atores do sistema, a relação mais próxima com uma estrutura MVC, seria que eles são Models, aqui colocamos, user, address, city, essas coisas

-------------------------------------------------------------------------------

Basicamente é isso, espero não ter sido confuso, sei que parece bastante coisa, mas depois que começa a se trabalhar com essa estrutura ela é bem fluida, evita bastante erros, e é bem facil de alterar, e é muito facil separar commits e pulls em tarefas pequenas, pois como tudo gira em torno de interfaces, alguem pode fazer toda a interface, sem ter acesso a api, ou saber se ela funciona, pois a interface acessa os dados tratados, assim eliminamos dependencias desnecessarias.
