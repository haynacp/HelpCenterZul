# HelpCenter Zul

HelpCenter Zul é um aplicativo iOS que fornece uma central de ajuda listando categorias e artigos detalhados. Este projeto foi desenvolvido utilizando uma arquitetura MVVM com modularização para garantir uma melhor manutenção e escalabilidade.

## Solução Adotada

A solução adotada foi baseada na arquitetura MVVM (Model-View-ViewModel) para separar claramente as responsabilidades entre a camada de apresentação e a camada de dados. A modularização foi utilizada para organizar melhor o código e facilitar a manutenção e a escalabilidade do projeto.

### Libs Utilizadas

- SDWebImage: Biblioteca para carregar e cachear imagens de forma assíncrona.

### Estrutura

- AppDelegate
- Modules
    - Core
      - Extensions
      - Utils
    - Network
        - Models
        - Services
    - UIComponents
        - Cells
        - Views
    - Features
        - Main
          - ViewModel
          - Views
        - Detail
          - ViewModel
          - Views
    - Resources


### Escolhas Feitas

- MVVM: Para separar a lógica de apresentação da lógica de negócios e facilitar a testabilidade.
- SDWebImage: Para carregamento e cache eficiente de imagens.
- Modularização: Para organizar melhor o código e facilitar a manutenção e escalabilidade do projeto.


### Pré-requisitos
- Xcode: Versão 11.0 ou superior.
- Cocoapods: Para gerenciar as dependências.

## Contato

Se tiver alguma dúvida, sinta-se à vontade para abrir uma issue ou entrar em contato através do email: hayna.cp@gmail.com
