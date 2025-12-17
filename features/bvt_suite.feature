Feature: Build Verification Test for Automation Exercise
  Como un usuario de Automation Exercise
  Quiero verificar las funcionalidades críticas (Home, Cart, Auth, Products)
  Para asegurar la estabilidad del sistema


  Rule: Navigation Verification using Background

    Background:
      Given el usuario navega a la pagina principal

    Scenario: TC01 - Verificar titulo de la pagina de inicio
      Then el titulo de la pagina debe ser "Automation Exercise"

    Scenario: TC02 - Verificar visibilidad del logo
      Then el logo de la barra de navegacion debe ser visible

    Scenario: TC03 - Verificar enlace de Contact Us
      When hago click en el enlace "Contact us"
      Then deberia ver el texto "GET IN TOUCH"

    Scenario: TC04 - Verificar pagina de Test Cases
      When hago click en el botón "Test Cases"
      Then deberia ser redirigido a la pagina de casos de prueba

    Scenario: TC05 - Verificar suscripcion en el footer
      When hago scroll hasta el footer
      Then deberia ver el texto "SUBSCRIPTION"

  Rule: Data Driven Testing for Auth and Search

   Background:
      Given el usuario navega a la pagina principal

   Scenario Outline: TC06 - Login con credenciales invalidas
      Given el usuario navega a la pagina de "Signup / Login"
      When ingreso el email "<email>" y password "<password>"
      And hago click en el boton login
      Then deberia ver el mensaje de error "<error_msg>"

      Examples:
        | email             | password | error_msg                            |
        | wrong@test.com    | 12345    | Your email or password is incorrect! |
        | fail@test.com     | 99999    | Your email or password is incorrect! |

    Scenario Outline: TC07 - Busqueda de productos variados
      Given el usuario navega a la pagina de "Products"
      When busco el producto "<producto>"
      Then deberia ver items relacionados con "<producto>"

      Examples:
        | producto |
        | Dress    |
        | Tshirt   |
        | Jeans    |

 
  Rule: Scenarios requiring specific setup/teardown Hooks

   Background:
      Given el usuario navega a la pagina principal

    @maximize_window
    Scenario: TC08 - Verificar scroll up con flecha
      Given el usuario navega a la pagina principal
      When hago scroll hasta el footer
      And hago click en la flecha de subir
      Then deberia ver el texto del carrusel principal

    @clear_cookies
    Scenario: TC09 - Verificar sesion limpia al inicio
      Given el usuario navega a la pagina principal
      Then no deberia ver ningun usuario logueado

    @screenshot_on_finish
    Scenario: TC10 - Verificar detalles de un producto
      Given el usuario navega a la pagina de "Products"
      When hago click en ver producto del primer item
      Then deberia ver el nombre del producto, precio y disponibilidad

    @slow_motion @maximize_window  
    Scenario: TC11 - Agregar item recomendado al carrito
      Given el usuario navega a la pagina principal
      When hago scroll hasta "RECOMMENDED ITEMS"
      And agrego un item recomendado al carrito
      Then el mensaje "Added!" deberia aparecer

    @database_clean
    Scenario: TC12 - Intento de registro con email existente
      Given el usuario navega a la pagina de "Signup / Login"
      When intento registrarme con el nombre "Test" y email "test@test.com"
      Then deberia ver el error "Email Address already exist!"


  Rule: Critical Business Flows

    Background:
      Given el usuario navega a la pagina principal

    @maximize_window
    Scenario: TC13 - Login con credenciales correctas
      Given el usuario navega a la pagina de "Signup / Login"
      When ingreso el email "qa_valid_user@test.com" y password "123456"
      And hago click en el boton login
      Then deberia ver "Logged in as" en el navbar

    @maximize_window
    Scenario: TC14 - Logout de usuario
      Given el usuario ha iniciado sesion con "qa_valid_user@test.com" y "123456"
      When hago click en el boton "Logout"
      Then deberia ver la pagina de login nuevamente

    @maximize_window
    Scenario: TC15 - Agregar productos al carrito
      Given el usuario navega a la pagina de "Products"
      When paso el mouse sobre el primer producto y hago click en 'Add to cart'
      And hago click en el botón "Continue Shopping"
      Then el carrito de compras deberia tener "1" producto

    @maximize_window
    Scenario: TC16 - Remover productos del carrito
      Given el usuario tiene productos en el carrito
      When hago click en el boton 'X' para eliminar el producto
      Then el producto deberia desaparecer del carrito

    @maximize_window
    Scenario: TC17 - Verificar formulario de Contact Us
      Given el usuario navega a la pagina de "Contact us"
      When lleno el formulario de contacto con datos validos
      And subo un archivo de prueba
      And hago click en Submit
      Then deberia ver el mensaje de exito "Success! Your details have been submitted successfully."

      @maximize_window
    Scenario: TC18 - Realizar compra completa (Checkout)
      Given el usuario ha iniciado sesion con "qa_valid_user@test.com" y "123456"
      And el usuario tiene productos en el carrito
      When hago click en el botón "Proceed To Checkout"
      And hago click en el botón "Place Order"
      And ingreso los datos de tarjeta "4100 0000 0000 0000", CVC "123" y expiracion "01" / "2030"
      And hago click en el botón "Pay and Confirm Order"
      Then deberia ver el mensaje de exito "Congratulations! Your order has been confirmed!"

      @maximize_window 
    Scenario: TC19 - Flujo E2E: Buscar, Agregar y Verificar persistencia tras Login

      Given el usuario navega a la pagina de "Products"
      When busco el producto "Winter Top"
      And paso el mouse sobre el primer producto y hago click en 'Add to cart'
      And hago click en el botón "Continue Shopping"
      
      And hago click en el enlace "Signup / Login"
      And ingreso el email "qa_valid_user@test.com" y password "123456"
      And hago click en el boton login
      
      And hago click en el enlace "Cart"
      Then el carrito de compras deberia tener "1" producto



      @maximize_window @math_check 
    Scenario: TC20 - Validacion Matematica: Precios y Subtotales en el Carrito
      Given el usuario navega a la pagina de "Products"

      When busco el producto "Blue Top"
      And paso el mouse sobre el primer producto y hago click en 'Add to cart'
      And hago click en el botón "Continue Shopping"
 
      And busco el producto "Men Tshirt"
      And paso el mouse sobre el primer producto y hago click en 'Add to cart'
      And hago click en el botón "Continue Shopping"

      And hago click en el enlace "Cart"
      Then verifico que el subtotal de cada producto sea matematicamente correcto

    
    Scenario: TC21 - Verificar agregar todos los productos visibles al carrito 
      Given el usuario navega a la pagina de "Products"
      When agrego todos los productos visibles al carrito
      Then el carrito de compras deberia tener "34" producto







  













        