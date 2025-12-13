# BVT Automation Suite - Automation Exercise

Este proyecto contiene un Build Verification Test (BVT) automatizado para el sitio [Automation Exercise](https://www.automationexercise.com/), desarrollado bajo el enfoque BDD utilizando Ruby, Cucumber y Capybara.

## Tecnologias

*   Ruby
*   Cucumber (Gherkin)
*   Capybara
*   Selenium WebDriver
*   Google Chrome

## Pre-requisitos

Asegurese de tener instalado:
1.  Ruby (con DevKit en Windows).
2.  Google Chrome actualizado.
3.  Bundler (`gem install bundler`).

## IMPORTANTE: Pre-condicion de Datos

Para que los escenarios de Login (TC13, TC14 y TC18) funcionen correctamente, el usuario de prueba debe existir en la base de datos del sitio web.

Si el sitio ha eliminado los datos, registre manualmente este usuario antes de ejecutar:

*   **URL:** https://www.automationexercise.com/login
*   **Email:** qa_valid_user@test.com
*   **Password:** 123456
*   **Nombre:** Tester
*   *(Nota: Complete el registro con cualquier direccion valida para asegurar el flujo de checkout).*

## Instalacion

1.  Clonar el repositorio:
    ```bash
    git clone https://github.com/TU_USUARIO/TU_REPO.git
    ```

2.  Instalar las dependencias:
    ```bash
    bundle install
    ```

## Estructura del Proyecto

*   **features/**: Contiene el archivo `.feature` con los 21 escenarios BDD.
*   **features/step_definitions/**: Contiene `steps.rb` con la logica de automatizacion.
*   **features/support/**: Configuracion del driver (env.rb) y hooks.
*   **.gitignore**: Archivos excluidos del control de versiones.

## Alcance de las Pruebas

El suite cubre 21 escenarios criticos (Smoke Test):

1.  **Navegacion (Backgrounds):** Home, Contact Us, Test Cases, Footer.
2.  **Datos (Outline):** Login con credenciales invalidas y busqueda de productos.
3.  **Hooks:** Validacion de Scroll, Cookies, Screenshots y items recomendados.
4.  **Flujos Criticos:** Login exitoso, Logout, Carrito de compras, Checkout (Simulacion de compra completa) y Formulario de contacto.

## Ejecucion

Para ejecutar todos los escenarios:

```bash
bundle exec cucumber
