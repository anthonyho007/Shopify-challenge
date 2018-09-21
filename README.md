# Shop API Server

A simple Shop API server in Ruby with basic functionalities. This is built for Shopify backend developer challenge.

## Table of Content

1. [Installaltions](#Installations)
2. [Basic Usage](#Usage)
   * [Authentication API](#Auth)
   * [Shop API](#Shop)
   * [Product API](#Product)
   * [Order API](#Order)
3. [API Docs](#Docs)
4. [Design](#Design)
5. [Development](#Development)

## Installations [](#){name=Installations}
download / clone with

    git clone https://github.com/anthonyho007/shop-api-server.git

to install postgresql, and rails on your local machine, you can follow the links

    https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres

    https://gorails.com/setup/ubuntu/18.10

to install the project dependencies

    cd shop-api-server

    bundle install

    rake db:setup

to start the server

    rails s

## Basic Usage[](#){name=Usage}

You would need to sign in or sign up with a shop account in order to retrieve an authorization token for you to modify any products or orders using Product, Order, and Shop API.

    curl -X POST -d '{"name": "anthony ho", "password": "foolbar" }' http://<ip-address>/signin

    Response
    {
        "id": 1,
        "name": "anthony ho",
        "token": "eyJhbGciOiJIUzI1NiJ9.ey.71gfw-NLCRoU2W-t00sdLljTfLUFXzy32HhllCW1-9s"
    }

All Shop, Product and Order API would require you to pass in the token for authorization in the header

    curl -H 'Authorization: "eyJhbGciOiJIUzI1NiJ9.ey.71gfw-NLCRoU2W-t00sdLljTfLUFXzy32HhllCW1-9s"' http://<ip-address>/orders

Please refer to the API Docs below for more detailed usage.

## API Docs[](#){name=Docs}

### Authenticate API(#){name=Auth}

#### Authenticate API Endpoints

The following API will let you create or log in to your own shop

    * POST /signin
    Login with current shop credentials and returns a token for authentication

    * POST /signup
    Creates a new shop and returns a token for authentication

#### Sign in with existing shop credentials

**POST      /signin**
```sh
{
    "name": "Anthony Ho",
    "password": "foolb"
}

```
**Response**
```sh
{
    "id": 1,
    "name": "AnthonyHo",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJzaG9wX2lkIjI3IylfPT_dtFM"
}
```

#### Create a new shop through signup

**POST      /signup**
```sh
{
    "name": "Anthony Ho",
    "password": "foolb"
}

```
**Response**
```sh
{
    "id": 2,
    "name": "TonyHo",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJzaG9wX2lkIjoyLmcbw1vqFQ4"
}

```


### Shop API(#){name=Shop}

#### Shop API Endpoints 

The following API will let you query or modify your own shop properties

    * GET /shop/:id
    retrieves your shop properties

    * PUT /shop/:id
    Changes your shop properties

    * DELETE /shop/:id
    Delete your shop


#### Get Shop properties

**GET      /shops/:id**           -H 'Authorization: "[token]"'

**Response**
```sh
{
    "id": 1,
    "name": "AnthonyHo",
    "created_at": "2018-09-21T00:15:45.652Z"
}

```
#### Update Shop properties

**PUT      /shops/:id**           -H 'Authorization: "[token]"'
```sh
{
    "name": "Tony The Great",
    "password": "newPassword"
}

```
**Response**
```sh
{
    "id": 1,
    "name": "Tony The Great",
    "created_at": "2018-09-21T00:15:45.652Z"
}

```

#### Delete Shop

**DELETE      /shop/:id**           -H 'Authorization: "[token]"'

**Response**

```sh
HTTP/1.1 204 No Content
```

### Product API(#){name=Product}

#### Product API Endpoints

The following API will let you do the following with Product resources of your own shop

    * GET /products
    retrieves a list of products

    * GET /products/:id
    retrieve a specific product

    * POST /products/
    Create a new product

    * PUT /products/:id
    Updates a product

    * DELETE /products/:id
    Deletes a product

#### Get all products

**GET      /products**           -H 'Authorization: "[token]"'

**Response**
```sh
{
    "products": [
        {
            "created_at": "2018-09-21T00:26:14.627Z",
            "id": 1,
            "name": "CherryMxBlue keyboard",
            "price": "12.22",
            "shop_id": 1,
            "updated_at": "2018-09-21T00:26:14.627Z"
        },
        {
            "created_at": "2018-09-21T04:37:43.265Z",
            "id": 2,
            "name": "Happy Tree House Mouse",
            "price": "24.12",
            "shop_id": 1,
            "updated_at": "2018-09-21T04:37:43.265Z"
        }
    ]
}

```

#### Get a specific product

**GET      /products/:id**           -H 'Authorization: "[token]"'

**Response**
```sh
{
    "created_at": "2018-09-21T04:37:43.265Z",
    "id": 2,
    "name": "Happy Tree House Mouse",
    "price": "24.12",
    "shop_id": 1,
    "updated_at": "2018-09-21T04:37:43.265Z"
}

```

#### Create a new product

**POST      /products/:id**           -H 'Authorization: "[token]"'
```sh
{
    "name": "Happy Tree House Mouse",
    "price": 24.12
}

```
**Response**
```sh
{
    "created_at": "2018-09-21T04:37:43.265Z",
    "id": 2,
    "name": "Happy Tree House Mouse",
    "price": "24.12",
    "shop_id": 1,
    "updated_at": "2018-09-21T04:37:43.265Z"
}

```

#### Update a specific product

**PUT      /products/:id**           -H 'Authorization: "[token]"'
```sh
{
    "price": 12.00
}

```
**Response**
```sh
{
    "created_at": "2018-09-21T04:37:43.265Z",
    "id": 2,
    "name": "Happy Tree House Mouse",
    "price": "12.00",
    "shop_id": 1,
    "updated_at": "2018-09-21T04:37:43.265Z"
}

```

#### Delete a product

**DELETE      /product/:id**           -H 'Authorization: "[token]"'

**Response**

```sh
HTTP/1.1 204 No Content
```


### Order API(#){name=Order}

#### Order API Endpoints

The following API will let you do the following with Order resources of your own shop

    * GET /orders
    retrieves a list of orders

    * GET /orders/:id
    retrieves a specific order

    * POST /orders
    Create a new order with specific products and quantities

    * PUT /orders/:id
    Updates an order

    * DELETE /orders/:id
    Deletes an order

#### Get all orders

**GET      /orders**           -H 'Authorization: "[token]"'

**Response**
```sh
{
    "products": [
        {
            "created_at": "2018-09-21T00:26:14.627Z",
            "id": 1,
            "name": "CherryMxBlue keyboard",
            "price": "12.22",
            "shop_id": 1,
            "updated_at": "2018-09-21T00:26:14.627Z"
        },
        {
            "created_at": "2018-09-21T04:37:43.265Z",
            "id": 2,
            "name": "Happy Tree House Mouse",
            "price": "24.12",
            "shop_id": 1,
            "updated_at": "2018-09-21T04:37:43.265Z"
        }
    ]
}

```

#### Get a specific order

**GET      /orders/:id**           -H 'Authorization: "[token]"'

**Response**
```sh
{
    "order": {
        "id": 2,
        "lineitems": [
            {
                "price": "12.22",
                "product_id": 1,
                "quantities": 2
            }
        ],
        "total": "24.44"
    }
}


```

#### Create a new order

**POST      /orders/:id**           -H 'Authorization: "[token]"'
```sh
{
    "product_ids_and_quantities": [
        {
            "product_id": 1,
            "quantities": 2
        },
        {
            "product_id": 2,
            "quantities": 4
        }
    ]
}

```
**Response**
```sh
{
    "order": {
        "id": 3,
        "lineitems": [
            {
                "price": "12.22",
                "product_id": 1,
                "quantities": 2
            },
            {
                "price": "24.12",
                "product_id": 2,
                "quantities": 4
            }
        ],
        "total": "120.92"
    }
}


```

#### Update a specific order

**PUT      /orders/:id**           -H 'Authorization: "[token]"'
```sh
{
    "product_ids_and_quantities": [
        {
            "product_id": 1,
            "quantities": 1
        }
    ]
}
```
**Response**
```sh
{
    "order": {
        "id": 3,
        "lineitems": [
            {
                "price": "12.22",
                "product_id": 1,
                "quantities": 1
            }
        ],
        "total": "12.22"
    }
}

```

#### Delete a order

**DELETE      /order/:id**           -H 'Authorization: "[token]"'

**Response**

```sh
HTTP/1.1 204 No Content
```

## Design[](#){name=Design}

    TBD

## Development[](#){name=Development}

    TBD
