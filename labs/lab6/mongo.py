#!/usr/bin/python3

from pymongo import MongoClient
import os
import re

# Environment variables for MongoDB connection
MONGOUSER = os.getenv('MONGOUSER')
MONGOPASS = os.getenv('MONGOPASS')
MONGOHOST = os.getenv('MONGOHOST')

# Connecting to MongoDB
client = MongoClient(MONGOHOST, username=MONGOUSER, password=MONGOPASS, connectTimeoutMS=500, retryWrites=True)
db = client.cwe9gz
collection = db.classes

#Creating 5 documents (classes)
collection.insert_many([
    
    {
        "name": "Data Science Systems",
        "instructor": "Neal Magee",
        "location": "Data Science Building Room 205"
    },

    {
        "name": "A Survey of Calculus II",
        "instructor": "Brianna Kurtz",
        "location": "Minor Hall 130"
    },

    {
        "name": "Chance: Intro to Statistics",
        "instructor": "Lei Zhang",
        "location": "Monroe Hall 110"
    },

    {
        "name": "Software Engineering",
        "instructor": "Derrick Stone",
        "location": "Rice Hall 130"
    },

    {
        "name": "Foundations of Machine Learning",
        "instructor": "Michael Freenor",
        "location": "Data Science Building Room 306"
    }])

# Query to find classes that are not in the Data Science Building
results = collection.find({"location": { "$not":  re.compile("Data Science Building", re.IGNORECASE)}})

#Printing out each class that is not in the Data Science Buidling
for document in results:
    print(document)