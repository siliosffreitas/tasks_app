# Lista de tarefas

Aplicativo de desafio para Keener.

## Get Start

Para compilar este projeto, certifique-se de ter a versão 2.10.0 do Flutter instalado


## Requisitos:
1. Uso do Crashlytics e Analytics como log de eventos e de erros

<img src="screenshots/crashlytics.png" width="400" title="crashlytics"/>

<img src="screenshots/analytics.png" width="400" title="analytics"/>

2. Uso do Firebase para autenticação do usuário

<img src="screenshots/firebase_auth.png" width="400" title="Authentication"/>

3. Uso do Cloud Firestore como banco de dados 


<img src="screenshots/cloud_firestore.png" width="400" title="Cloud Firestore"/>

4. O Mobx está sendo utilzado como gerenciador de estado das telas, ele representa a camada de **Presenter**, que será exlicado logo mais na sessão de arquitetura.

5. Uso do Flutter Modular para injeção de dependências (soli**D**). Todas as dependências nas classes são injetadas por quem utiliza-as, facilitando assim a criação dos testes
6. Arquitetura Limpa e princípios do SOLID. A Arquitetura seguida foi a proposta por **Uncle Bob Martin** levemente adaptado. 

<img src="screenshots/topology.png" width="400" title="Topologia"/>

## Preview

Na pasta screenshots existem alguns prints tirados do app rodando e um vídeo com um overview.
### Tela de Login
<img src="screenshots/login.png" width="400" title="Login"/>

### Tela de Cadastro
<img src="screenshots/signin.png" width="400" title="Cadastro"/>

### Tela Home
<img src="screenshots/home.png" width="400" title="Home"/>

### Nova tarefa
<img src="screenshots/new_task.png" width="400" title="Nova tarefa"/>

### Detalhes de uma tarefa
<img src="screenshots/task.png" width="400" title="Detalhes de uma tarefa"/>

## DEMO
<video src="screenshots/demo.mp4" width="400"  controls></video>

## Testes com dispositivos:
O projeto foi testado nos seguintes dispositivos:
- Samsung A20s (Real)
- iPhone 14 (Real)
