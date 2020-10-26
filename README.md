<p align="center">
    <img width="400" height="200" src="https://cc.uffs.edu.br/images/logo/CC-logo-com-background.svg" title="Logo do projeto"><br />
    <img src="https://img.shields.io/maintenance/yes/2020?style=for-the-badge" title="Status do projeto">
    <img src="https://img.shields.io/github/workflow/status/ccuffs/template/ci.uffs.cc?label=Build&logo=github&logoColor=white&style=for-the-badge" title="Status do build">
</p>

- [Projeto](#projeto)
- [Features](#features)
- [Telas](#telas)
- [Começando](#come%c3%a7ando)
  - [Instalação](#instala%c3%a7%c3%a3o)
  - [Iniciando o projeto](#iniciando-o-projeto)
- [Arquitetura](#arquitetura)
  - [Bloc](#bloc)
  - [Estrutura de Pastas](#estrutura%20de%20pastas)
  - [Links úteis](#links%20%c3%bateis)
- [Licença](#licen%c3%a7a)


# Aplicativo CCUFFS <!-- omit in toc -->

## Projeto
Esse repositório contém o código do aplicativo móvel para uso de alunos, professores e técnicos do curso de [Ciência da Computação](https://cc.uffs.edu.br) da [UFFS](http://www.uffs.edu.br), Chapecó/SC.

Veja o arquivo [ROADMAP](ROADMAP.md) para conhecer as funcionalidades esperadas para o aplicativo e um rascunho do plano de desenvolvimento.

> **IMPORTANTE:** Sempre consulte o [CONTRIBUTING](CONTRIBUTING.md) e o [ROADMAP](ROADMAP.md) antes de começar a desenvolver uma nova feature! Um bom começo pode envolver a consulta das [ISSUES](https://github.com/ccuffs/app-cc/issues) abertas.

## Features Implementadas

As principais features do projeto são:

* Login de usuários com IdUFFS;
* Visualização de noticias;
* Leitor de noticias personalizável;
* QrCode único de usuário;
* Exibição de notícias importantes (Mensagens Diretas);

## Telas

Segue abaixo algumas imagens das telas implementadas na versão atual do aplicativo

<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/89925005-2d24e400-dbd9-11ea-9e4d-a2b29974418f.gif" alt="drawing" height="500"/>


<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/89923101-6e67c480-dbd6-11ea-810d-7114734cf0c4.gif" alt="drawing" height="500"/>
<br><br>

<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/89925021-331ac500-dbd9-11ea-9caa-74ce7b1d6712.gif" alt="drawing" height="500"/>


<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/89925035-38780f80-dbd9-11ea-936b-59542c8e1cbc.gif" alt="drawing" height="500"/>

<br><br>

<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/89925059-4037b400-dbd9-11ea-8b03-6072e758f117.gif" alt="drawing" height="500"/>


<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/89925071-44fc6800-dbd9-11ea-8008-611719f5f1d1.gif" alt="drawing" height="500"/>

<br><br>

<img style="margin-right: 5%" src="https://user-images.githubusercontent.com/26921536/90092932-baaf2380-dd00-11ea-8a0e-2fd0c3586dae.gif" alt="drawing" height="500"/>

<img style="margin-right: 5%" src=https://user-images.githubusercontent.com/26921536/90203618-906c6d00-ddb7-11ea-82b7-fbd2258af72b.gif height="500" />




## Começando
Caso tenha interesse em rodar localmente o projeto, siga os passos abaixo. Levem em consideração que sera necessário a instalação do flutter em seu computador, bem como um emulador ou um dispositivo android conectado e configurado em seu computador para a utilização com o aplicativo.


## Instalação

Tenha certeza de que possui o flutter instalado em seu computador. Mais detalhes sobre a instalação do flutter podem ser encontrados em seu [site oficial](https://flutter.dev/docs/get-started/install).

## Iniciando o projeto

``` bash
    git clone https://github.com/ccuffs/app-cc/
```

Vá até o diretório do projeto com o comando abaixo:

``` bash
    cd app-cc/
```

Execute o projeto com:

``` bash
    flutter run
```

## Arquitetura

### Bloc
Este projeto utiliza bloc como arquitetura de state management. Caso queira contribuir, leve em consideração que não sera admitido a utilização de outro state management (por exemplo providers). 

### Estrutura de Pastas
Este projeto possui uma estrutura de pastas bem simples. Todos os blocs podem ser encontrados dentro de lib/blocs e novos blocs devem ser adicionados lá.
Todas as Telas devem ser adicionadas em lib/screens e seus nomes devem seguir o prefixo nome_tela_view. Caso seja necessário, pode-se dividir os widgets e criar novos arquivos de widgets que devem ser adicionados as suas respectivas pastas a não ser que sejam um widget compartilhado.

Widgets compartilhados (usados por varias views) devem ser salvos dentro da pasta shared/widgets

Este projeto não usa uma lógica de controllers para separar funções e da a liberdade de utilização de setState em conjunto ao bloC caso facilite a implementação de determinada feature e mantenha o código consiso. 

### Links úteis
- [Bloc Tutoriais](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx)
- [Bloc biblioteca](https://pub.dev/packages/flutter_bloc)
- [Instalação do Flutter](https://flutter.dev/docs/get-started/install)
- [IDE](https://flutter.dev/docs/get-started/editor?tab=vscode)


## Licença

A [licença](https://github.com/ccuffs/app-cc/blob/master/LICENSE) desse projeto é a MIT License.