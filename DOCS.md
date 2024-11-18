# Documentación
El proyecto tiene los siguientes microservicios con sus respectivos modelos **customer** & **order**.

![microservices_rails](https://github.com/user-attachments/assets/0815878c-6007-478e-bc3c-45cf8adea36d)

## Microservicios
Ambos manejan la versión `3.1.2` de **Ruby** y la versión `7.2.2` de Rails.

### Instalación
#### Requisitos previos:
- Instalar Ruby en su versión `3.1.2`. Para la instalación te recomiendo usar [rbenv](https://github.com/rbenv/rbenv) o [asdf](https://asdf-vm.com/).
- Instalar el motor de base de datos **PostgreSQL**
- Instalar Docker, para poder ejecutar **RabbitMQ** en caso de no tenerlo instalado.

#### Instalación microservicios
Una vez cumplido los requsitos previos, entra a cada microservicio y realiza los siguientes pasos:
- Ejecutar `bundle install` para instalar las dependencias definidas en el *Gemfile*.
- Editar los datos de conexión a la base de datos dentro del archivo `service/config/database.yml` de cada servicio.
- Crear base de datos: `db:create`
- Ejecutar migriciones: `db:migrate`
- Ejecutar `rails db:seed` dentro de la raiz de cada microservicio para tener datos de prueba.
- Crear el archivo `.env` para definir las variables de entorno, usa el **.env.example** como guia.
- Levantar el servidor:
  - **Para el microservicio customer:** `rails s`
  - **Para el microservicio order:** `rails s -p 3001`
> Debe lenvantarse cada uno por separado (terminales separadas) para que ambos servicios esten habilitados.

Al finalizar el ejercicio debemos tener los servicios como lo muestra la siguiente imagen:

<img width="528" alt="image" src="https://github.com/user-attachments/assets/199f7b52-03c7-41ed-8f43-305767dbc7bb">

#### Instalación RabbitMQ
Para usar rabbitMQ, usamos docker. Ejecuta el siguiente comando en la raiz del proyecto desde la terminal.
`docker-compose up`
Esto levanta el servicio de RabbitMQ en local. Al verificar desde docker desktop vemos los siguientes servicios. 

![image](https://github.com/user-attachments/assets/d942035b-8661-4060-948d-839d17a1850b)

## Funcionamiento
A continuación vemos el diagrama de flujo, el cual nos muestra el funcionamiento y comunicación de los servicios al crear una nueva **orden**.

![sequence diagram drawio](https://github.com/user-attachments/assets/6d0cc929-eacc-459f-870d-242a5312e2eb)

## Pruebas unitarias.
Para ejecuta la suite de prubas, ingresa a cada microservicio y ejecuta el siguiente comando.
` bundle exec rspec`
al ejecutarse, debe aparece en consola algo como lo que muestra la siguiente imagen:

<img width="507" alt="image" src="https://github.com/user-attachments/assets/058ec06d-3511-4837-aaba-f3f2b2c086d2">

## API

### Order micro-service
#### Get all Orders:
- Path: `localhost:3001/api/v1/orders`
- Method: *GET*
- Response:
  ```json
  {
    "message": "success",
    "response": [
        {
            "id": 1,
            "product_name": "Burger",
            "quantity": 2,
            "price": "15.5",
            "status": "created",
            "customer_id": 1
        },
    ]
  }
  ```
#### Get Orders by customer_id:
- Path: `localhost:3001/api/v1/orders?customer_id=:id`
- Method: *GET*
- Response:
```json
{
    "message": "success",
    "response": [
        {
            "id": 1,
            "product_name": "Burger",
            "quantity": 2,
            "price": "15.5",
            "status": "created",
            "customer_id": 1
        },
    ]
}
```

#### Get Order by id:
- Path: `localhost:3002/api/v1/orders/:id`
- Method: *GET*
- Response:
  ```json
  {
      "message": "success",
      "response": {
          "id": 2,
          "product_name": "Burger",
          "quantity": 2,
          "price": "15.5",
          "status": "created",
          "customer_id": 1
      }
  }
  ```
#### Create order:
- Path: `localhost:3001/api/v1/orders`
- Method: *POST*
- Response:
  ```json
  {
      "message": "Order created!",
      "response": {
          "order": {
              "id": 123,
              "product_name": "Burger",
              "quantity": 2,
              "price": "15.5",
              "status": "created",
              "customer_id": 8
          },
          "customer": {
              "message": "success",
              "response": {
                  "customer_name": "Klimt",
                  "address": "562 Carlos Gardens",
                  "orders_count": 9
              }
          }
      }
  }
  ```

### Customer micro-service
#### Get customer by id:
- Path: `localhost:3000/api/v1/customers/:id`
- Method: *GET*
- Response:
  ```json
  {
      "message": "success",
      "response": {
          "customer_name": "Cassatt",
          "address": "12703 Christine Turnpike",
          "orders_count": 5
      }
  }
  ```


