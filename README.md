# user_registration

Uma aplicação feita na versão 3.0.1 do Flutter para cadastro de pessoas utilizando uma Api REST.

## Executando o projeto

Para executar o projeto faça o download das bibliotecas necessárias:
```
flutter pub get
```

Após isso basta executá-lo:
```
flutter run
```

## APK
Na pasta ``/apk`` é possível encontrar o apk gerado da aplicação para fim de testes.

## Login

![image](https://user-images.githubusercontent.com/40008264/170808984-5483e64b-4ee5-4c74-a6d0-78d5d9c91b3d.png)

Na tela de login é necessário informar o usuário (email da conta) e a senha.

![image](https://user-images.githubusercontent.com/40008264/170809024-e176b003-d13f-4cb1-87ec-9438ebfc3525.png)

Se ocorrer algum erro na requisição, será informado ao usuário o erro devolvido pela Api.

Em caso de sucesso o token retornado será armazenado no Shared Preferences para uso nas próximas requisições.

## Lista de Usuários

![image](https://user-images.githubusercontent.com/40008264/170809094-54115b4e-1442-4ef7-abc0-6667c19769c4.png)

Ao logar com sucesso será possível ver os usuários que já foram cadastrados.

No canto inferior da tela é possível cadastrar um novo usuário pressionando o floating action button.

Em caso de pressionar em cima de um usuário existente, irá abrir a tela de cadastro com as informações do usuário para alteração.

## Tela de Cadastro

![image](https://user-images.githubusercontent.com/40008264/170809158-65ed4799-9a9a-437f-850f-e41f045e9d7c.png)

Na tela de cadastro temos 3 chips que trazem os tipos de perfis que são permitidos serem criados, sendo eles: USER, MANAGER, ADMINISTRATOR.
Além disso outros campos como:
- Nome (nome que será exibido no usuário, campo com tamanho maximo de 50 caracteres)
- CPF (campo no formato ###.###.###-##, campo é validado com base nesse formato)
- Email (campo com tamanho maximo de 20 caracteres)
- Senha (campo com tamanho maximo de 10 caracteres)

Abaixo do formulário existem 2 botões:
- SAVE (responsável por enviar o cadastro ou as alterações)
- DELETE (botão responsável por deletar o cadastro, porém só será exibido no caso de editar um cadastro já existente)

![image](https://user-images.githubusercontent.com/40008264/170809414-a1e76ced-d769-4568-b6c0-4b30382d0ae0.png)

Ao deletar será necessário confirmar a ação por meio do dialog que será exibido.

Se houver algum erro na requisição tanto na parte de enviar, atualizar ou deletar, será informado ao usuário no dialog.

Ao concluir irá retornar à tela de lista e irá atualiza-lá.
