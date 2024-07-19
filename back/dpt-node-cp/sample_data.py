from pymongo import MongoClient
import random
from datetime import datetime, timedelta

# Connect to MongoDB
client = MongoClient("mongodb://root:dpt-dev@dpt.dpt-dev.oastu.lan:27017")

# Create a database named "finance"
db = client["bav_sample"]

# Create a collection named "financial_facts"
collection = db["financial_facts"]

# Define some sample companies and product types
companies = ["Company A", "Company B", "Company C", "Company D", "Company E"]
product_types = ["Product 1", "Product 2", "Product 3", "Product 4", "Product 5"]

# Generate a larger number of sample financial facts
sample_facts = []
for i in range(1000):  # Adjust this value to generate more or fewer documents
    fact = {
        "company": random.choice(companies),
        "product_type": random.choice(product_types),
        "revenue": random.randint(1, 100) * 1000,
        "expenses": random.randint(1, 100) * 500,
        "date": datetime.now()
        - timedelta(days=random.randint(0, 365)),  # Random date in the past year
    }
    sample_facts.append(fact)

# Insert the sample facts into the collection
collection.insert_many(sample_facts)

print("Sample financial facts inserted into MongoDB.")
