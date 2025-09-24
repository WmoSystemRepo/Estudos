Quando('acesso a página principal das Starbugs') do
  visit 'https://starbugs.vercel.app/'
end

Então('eu devo ver uma lista de cafés disponíveis') do
  products = all('.coffee-item')
  expect(products.size).to be > 0
end

Dado('que estou na página principal da Starbugs') do
    visit 'https://starbugs.vercel.app/'
end

Dado('que desejo compra o café {string}') do |product_name|
  @product_name  = product_name
end

Dado('que esse produto custa R$ {float}') do |product_price|
  puts product_price
end

Dado('que o custo de entrega é de R$ {float}') do |delivery_price|
  puts delivery_price
end

Quando('inicio a compra desse item') do
  product = find('.coffee-item', text: @product_name)
  product.find('.buy-coffee').click
  sleep 10
end

Então('deve ver a página de Checkout com detalhes do produto') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('o valor total da compra deve ser de R$ {float}') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que desenho comprar o café {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('inicio a compra deste item') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('devo um popup informando que o produto está indisponivel') do
  pending # Write code here that turns the phrase above into concrete actions
end