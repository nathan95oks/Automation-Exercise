Given('el usuario navega a la pagina principal') do
  visit '/'
end

Given('el usuario navega a la pagina de {string}') do |pagina|
  links = {
    "Signup / Login" => "a[href='/login']",
    "Products" => "a[href='/products']",
    "Contact us" => "a[href='/contact_us']"
  }
  find(links[pagina]).click
end

Then('el titulo de la pagina debe ser {string}') do |titulo_esperado|
  expect(page).to have_title titulo_esperado
end

Then('el logo de la barra de navegacion debe ser visible') do
  expect(page).to have_css("img[alt='Website for automation practice']")
end

When('hago click en el enlace {string}') do |link_text|
  click_link link_text
end

When(/^hago click en el bot[óo]n "([^"]*)"$/) do |btn_text|
  if page.has_link?(btn_text)
    click_link(btn_text, match: :first)
  elsif page.has_button?(btn_text)
    click_button(btn_text)
  else
    find(:xpath, "//*[contains(text(), '#{btn_text}')]", match: :first).click
  end
end

Then('deberia ver el texto {string}') do |texto|
  expect(page).to have_content(texto)
end

Then('deberia ser redirigido a la pagina de casos de prueba') do
  expect(page).to have_current_path('/test_cases')
end

When('hago scroll hasta el footer') do
  page.execute_script "window.scrollTo(0, document.body.scrollHeight)"
end

When('ingreso el email {string} y password {string}') do |email, pass|
  find("input[data-qa='login-email']").set(email)
  find("input[data-qa='login-password']").set(pass)
end

When('hago click en el boton login') do
  find("button[data-qa='login-button']").click
end

Then('deberia ver el mensaje de error {string}') do |msg|
  expect(page).to have_content(msg)
end

When('busco el producto {string}') do |producto|
  find("input#search_product").set(producto)
  find("button#submit_search").click
end

Then('deberia ver items relacionados con {string}') do |producto|
  expect(page).to have_content("SEARCHED PRODUCTS")
  expect(page).to have_selector(".productinfo p", text: /#{producto}/i)
end

When('hago click en la flecha de subir') do
  find("#scrollUp").click
end

Then('deberia ver el texto del carrusel principal') do
  expect(page).to have_css("#slider-carousel", visible: true)
end

Then('no deberia ver ningun usuario logueado') do
  expect(page).to have_no_content("Logged in as")
end

When('hago click en ver producto del primer item') do
  page.execute_script "window.scrollBy(0, 400)"
  first("a[href^='/product_details']", visible: true).click
end

Then('deberia ver el nombre del producto, precio y disponibilidad') do
  expect(page).to have_css(".product-information h2")
  expect(page).to have_content("Availability:")
  expect(page).to have_content("Condition:")
  expect(page).to have_content("Rs.") 
end

When('hago scroll hasta {string}') do |texto_seccion|
  elemento = find(:xpath, "//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '#{texto_seccion.downcase}')]")  
  page.execute_script("arguments[0].scrollIntoView(true);", elemento)
end

When('agrego un item recomendado al carrito') do
  within(".recommended_items") do
    find(".add-to-cart", match: :first, visible: true).click
  end
end

Then('el mensaje {string} deberia aparecer') do |msg|
  expect(page).to have_content(msg)
end

When('intento registrarme con el nombre {string} y email {string}') do |nombre, email|
  find("input[data-qa='signup-name']").set(nombre)
  find("input[data-qa='signup-email']").set(email)
  find("button[data-qa='signup-button']").click
end

Then('deberia ver el error {string}') do |error|
  expect(page).to have_content(error)
end

Then('deberia ver {string} en el navbar') do |texto|
  expect(page).to have_content(texto)
end

Given('el usuario ha iniciado sesion con {string} y {string}') do |email, pass|
  visit '/login'
  find("input[data-qa='login-email']").set(email)
  find("input[data-qa='login-password']").set(pass)
  find("button[data-qa='login-button']").click
end

Then('deberia ver la pagina de login nuevamente') do
  expect(page).to have_content("Login to your account")
end

When('paso el mouse sobre el primer producto y hago click en {string}') do |btn_name|
  product = first(".single-products")
  product.hover
  product.find(".add-to-cart", match: :first).click
end

Then('el carrito de compras deberia tener {string} producto') do |cantidad|
  visit '/view_cart'
  rows = all("tbody tr").count
  expect(rows).to eq(cantidad.to_i)
end

Given('el usuario tiene productos en el carrito') do
  step 'el usuario navega a la pagina de "Products"'
  step "paso el mouse sobre el primer producto y hago click en 'Add to cart'"
  step 'hago click en el botón "Continue Shopping"'
  
  visit '/view_cart'
end

When('hago click en el boton {string} para eliminar el producto') do |btn|
  find(".cart_quantity_delete").click
end

Then('el producto deberia desaparecer del carrito') do
  expect(page).to have_content("Cart is empty!")
end

When('lleno el formulario de contacto con datos validos') do
  find("input[data-qa='name']").set("Tester")
  find("input[data-qa='email']").set("test@tester.com")
  find("input[data-qa='subject']").set("BVT Testing")
  find("textarea[data-qa='message']").set("Esta es una prueba automatizada")
end

When('subo un archivo de prueba') do
  File.write('test_file.txt', 'contenido de prueba')
  attach_file('upload_file', File.absolute_path('test_file.txt'))
end

When('hago click en Submit') do
  find("input[data-qa='submit-button']").click
  page.driver.browser.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoSuchAlertError
end

Then('deberia ver el mensaje de exito {string}') do |msg|
  expect(page).to have_content(msg)
end

When('ingreso los datos de tarjeta {string}, CVC {string} y expiracion {string} \/ {string}') do |card, cvc, month, year|
  find("input[name='name_on_card']").set("QA Tester")
  find("input[name='card_number']").set(card)
  find("input[name='cvc']").set(cvc)
  find("input[name='expiry_month']").set(month)
  find("input[name='expiry_year']").set(year)
end

Then('verifico que el subtotal de cada producto sea matematicamente correcto') do
  filas = all("tbody tr")
  
  filas.each do |fila|
    precio_texto = fila.find(".cart_price").text
    precio = precio_texto.gsub(/\D/, '').to_i 
    
    cantidad_texto = fila.find(".cart_quantity button").text
    cantidad = cantidad_texto.to_i
    
    total_mostrado_texto = fila.find(".cart_total_price").text
    total_mostrado = total_mostrado_texto.gsub(/\D/, '').to_i
    
    calculo_real = precio * cantidad
    
    puts "Validando: #{precio} x #{cantidad} = #{calculo_real} (Web muestra: #{total_mostrado})"
    
    expect(total_mostrado).to eq(calculo_real)
  end
end

When('agrego todos los productos visibles al carrito') do
  products = all(".single-products")
  
  products.each_with_index do |product, index|
    current_product = all(".single-products")[index]
    
    current_product.hover
    current_product.find(".add-to-cart", match: :first, visible: true).click
    
    find("button.close-modal", wait: 5).click
  end
end

When('elimino todos los productos del carrito') do
  visit '/view_cart'
  # Loop while there is at least one delete button
  while page.has_css?(".cart_quantity_delete", wait: 2)
    find(".cart_quantity_delete", match: :first).click
    # Wait briefly for the row to be removed to avoid stale element errors or clicking the same row
    sleep 0.1 
  end
end