CREATE TABLE restaurants (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_restaurants_data ON restaurants USING GIN (data);

INSERT INTO restaurants (data) VALUES
('{
  "restaurant_name": "Burger King",
  "city": "Toronto",
  "cuisine": "Fast Food",
  "menu": ["Burger", "Fries", "Drink"],
  "rating": 4.2
}'),
('{
  "restaurant_name": "Sushi World",
  "city": "Montreal",
  "cuisine": "Japanese",
  "menu": ["Sushi", "Ramen", "Tempura"],
  "rating": 4.7
}'),
('{
  "restaurant_name": "Pizza Nova",
  "city": "Vancouver",
  "cuisine": "Italian",
  "menu": ["Pizza", "Pasta", "Salad"],
  "rating": 4.5
}');