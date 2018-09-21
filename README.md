# Shop API Server

A simple Shop API server in Ruby with basic functionalities. This is built for Shopify backend developer challenge.

## Installations
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

## Basic Usage

You would need to sign in or sign up with a shop account in order to retrieve an authorization token for you to modify any products or orders using Product, Order, and Shop API.

    curl -X POST -d '{"name": "anthony ho", "password": "foolbar" }' http://<ip-address>/signin

    Response
    {
        "id": 1,
        "name": "anthony ho",
        "token": "eyJhbGciOiJIUzI1NiJ9.ey.71gfw-NLCRoU2W-t00sdLljTfLUFXzy32HhllCW1-9s"
    }

All Shop, Product and Order API would require you to pass in the token for authorization

    curl -H 'Authorization: "eyJhbGciOiJIUzI1NiJ9.ey.71gfw-NLCRoU2W-t00sdLljTfLUFXzy32HhllCW1-9s"' http://<ip-address>/orders

Please refer to the API Docs below for more detailed usage.

## API Docs

### Authenticate API

#### Authenticate API Endpoints

The following API will let you create or log into your own shop

    * POST /signin
    Login with current shop credentials and returns a token for authentication

    * POST /signup
    Creates a new shop and returns a token for authentication


### Shop API

#### Shop API Endpoints 

The following API will let you query or modify your own shop properties

    * GET /shop/:id
    retrieves your shop properties

    * PUT /shop/:id
    Changes your shop properties

    * DELETE /shop/:id
    Delete your shop

### Product API

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


### Order API

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

## Design

    TBD

## Development

    TBD
