# Show title and special_features of films that are PG-13

```js
db.films.find(
  {
    Rating: "PG-13",
  },
  {
    Title: 1,
    "Special Features": 1,
  }
);
```

# Get a list of all the different films duration.

```js
db.films.distinct("Length");
```

# Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00

```js
db.films.find(
  {
    "Replacement Cost": {
      $gte: 20,
      $lte: 24,
    },
  },
  {
    Title: 1,
    "Rental Duration": 1,
    "Replacement Cost": 1,
  }
);
```

# Show title, category and rating of films that have 'Behind the Scenes' as special_features

```js
db.films.find(
  {
    "Special Features": /Behind the scenes/i,
  },
  {
    Title: 1,
    Category: 1,
    Rating: 1,
  }
);
```

# Show first name and last name of actors that acted in 'ZOOLANDER FICTION'

```js
db.films.find(
  {
    Title: "ZOOLANDER FICTION",
  },
  {
    "Actors.First name": 1,
    "Actors.Last name": 1,
  }
);
```

# Show the address, city and country of the store with id 1

```js
db.stores.find(
  {
    _id: 1,
  },
  {
    Address: 1,
    City: 1,
    Country: 1,
  }
);
```

# Show pair of film titles and rating of films that have the same rating.

```js

```

# Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).

```js

```
