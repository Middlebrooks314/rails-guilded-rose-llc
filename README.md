# Guilded Rose LLC Store API
[![Middlebrooks314](https://circleci.com/gh/Middlebrooks314/rails-guilded-rose-llc.svg?style=shield)](https://app.circleci.com/pipelines/github/Middlebrooks314/rails-guilded-rose-llc)


Guilded Rose LLC Store API is a RESTful API for the Gilded Rose storefront inventory kata. 

## Technologies
* Ruby on Rails
* PostgresSQL database
* Rspec (testing)
* Heroku (deployment)

## Installation

#### To run the API on your local machine:
1. Fork the repository and clone the master branch to your computer.
2. In your local terminal, ```cd``` into the root directory of the app.
3. In your local terminal, run ```bundle 
install``` to install all the dependencies.
4. In your local terminal run ```rake db:create``` and ```rake db:migrate``` to setup the database 
#### To  run the Rspec tests


```bash
rspec <ruby_test_file>_spec.rb
```

#### To use the deployed version of the API, use the following as the base URL:

 https://safe-wave-09726.herokuapp.com/ 



## Usage

### INDEX Items

  Returns json data about all of the items.

* **URL**

  /api/v1/items

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**
 
   None

* **Data Params**

  None
* **Sample cURL Request:**

```bash
curl https://localhost:3000.com/api/v1/items | jq
```

* **Success Response:**

  * **Code:** 200
 
    **Content:**
  ```javascript
  [
    {
      "id": 1,
      "name": "Carrots",
      "sell_in": 10,
      "quality": 15,
      "description": null
    },
    {
      "id": 2,
      "name": "Basil",
      "sell_in": 11,
      "quality": 25,
      "description": "a sweet herb"
    },
    {
      "id": 3,
      "name": "Dog Treats",
      "sell_in": 15,
      "quality": 20,
      "description": "Doggy ice cream"
    }
  ]
  ```


---
### SHOW Item

  Returns json data about a single item.

* **URL**

  /api/v1/items/:id

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

  None
* **Sample cURL Request:**

```bash
curl https://localhost:3000.com/api/v1/items/2 | jq
```


* **Success Response:**

  * **Code:** 200
 
    **Content:**
  ```javascript
    { "id": 2, "name": "Basil", "sell_in": 11, "quality": 25 }
  ```

---
### POST Item

  Add a single item to the database.

* **URL**

  /api/v1/items

* **Method:**

  `POST`
  
*  **URL Params**

   **Required:**
 
  For <username>:<password> please contact the senior developer for the basic auth credentials.

* **Data Params**

  `{name: string, sell_in: integer, quality: integer}`

* **Sample cURL Request:**

```bash
curl --user <username>:<password> http://localhost:3000//api/v1/items -X POST -F 'name=Baz' -F 'sellIn=6' -F 'quality=7' | jq
```

* **Success Response:**

  * **Code:** 200
 
    **Content:**
  ```javascript
    { "id": 4, "name": "yogurt", "sell_in": 6, "quality": 7 }
  ```
 

### INDEX Reviews

  Returns json data about all reviews associated with a particular item.

* **URL**

  /api/v1/items/:id/reviews

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**
 
   `id=[integer]`

* **Data Params**

  None
* **Sample cURL Request:**

```bash
curl https://localhost:3000.com/api/v1/items/3/reviews | jq
```

* **Success Response:**

  * **Code:** 200
 
    **Content:**
  ```javascript
  [
    {
      "text": "this made my dog sick"
    },
    {
      "text": "a little too salty for my taste"
    },
    {
      "text": "after eating this my dog was suddenly able to fly"
    }
  ]
  ```


---
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
