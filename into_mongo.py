import pymongo
DB_NAME = "test"
COLUMN = "customers"
myclient = pymongo.MongoClient("mongodb://localhost:27017/")

mydb = myclient[DB_NAME]

mycol = mydb[COLUMN]

mydict = { "name": "John", "address": "Highway 37" }

#x = mycol.insert_one(mydict)
x = mycol.find_one()

print(x) 