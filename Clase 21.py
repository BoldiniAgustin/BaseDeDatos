import redis
from datetime import date
redis = redis.Redis(host='localhost', port=6379)

print ("Videogame stock)
today = str(date.today())

game = ""
date = ""

while game =="":
  game = input("Most recent videogame")
  if game == "":
    print("Please enter a videogame")
  else: 
    redis.lpush(today, game)

print("Most recent videogame: " + game + ".")