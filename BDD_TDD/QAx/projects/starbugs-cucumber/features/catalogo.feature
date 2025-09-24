#language: pt

Funcionalidade: Catálogo de cafés
Como um usuário do site
Eu quero ver o catálogo de cafés na página principal
Para que eu possa escolher e saber mais sobre os produtos disponíveis

Cenário: Acessar o catálogo de cafés na página principal
Quando acesso a página principal das Starbugs
Então eu devo ver uma lista de cafés disponíveis

@temp
Cenário: Iniciar a compra de um café
Dado que estou na página principal da Starbugs
E que desejo compra o café "Expresso Gelado"
E que esse produto custa R$ 9.99
E que o custo de entrega é de R$ 10.00
Quando inicio a compra desse item
Então deve ver a página de Checkout com detalhes do produto
E o valor total da compra deve ser de R$ 19.99

@temp
Cenário: Café indisponivel
Dado que estou na página principal da Starbugs
E que desenho comprar o café "Expresso Cremoso"
Quando inicio a compra deste item
Então devo um popup informando que o produto está indisponivel
