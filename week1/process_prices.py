
# Write a program that runs in your terminal. It reads a CSV file (like a price list), applies a business rule (like giving discounts based on product type), and saves the updated data as a JSON file.
# 
# What to show in your GitHub (week1/ folder):
# 
# · Your Python script
# · The sample CSV file you used
# · The JSON output file your script created
# · A README file explaining what your script does and how to run it

# In[1]:

##Create a new file called process_prices.py
#writefile prices.csv
#product_name,product_type,price
#Microgreens,Vegetable,10.00
#Lettuce,Vegetable,5.00
#Tomatoes,Fruit,8.00
#Strawberries,Fruit,12.00
#Basil,Herb,7.00
#Mint,Herb,6.00

# In[2]:
import csv
#from google.colab import drive
import json
#import os
#Define discount rules
DISCOUNT_RULES = {
    "Vegetable": 0.10, # 10% off
    "Fruit": 0.05,     #  5% off
    "Herb": 0.15       # 15% off
}

# In[3]:
#apply_discount Function

def apply_discount(product_type, price):
    """Apply discount based on product type"""
    if product_type in DISCOUNT_RULES:
        discount = DISCOUNT_RULES[product_type]
        return round(price * (1 - discount), 2)
    return price

# In[4]:
#import os

# 1. Where is Python right now?
#print("Current folder:", os.getcwd()) # it shows where Python is looking

# 2. What files are in this folder?
#print("Files in current folder:", os.listdir())

#3. Let's SEARCH your entire Google.Drive for the CSV (if you mounted it)
#from google.colab import drive
#drive.mount('/content/drive')

#import glob
#found = glob.glob('/content/drive/MyDrive/**/prices.csv', recursive = True)
#print("Found CSV at these locations.", found)

# In[5]:
def process_csv(input_file, output_file):
    """Read CSV, apply discounts, save as JSON"""
    updated_products = []
 #   drive.mount('/content/drive')
  #  input_file = '/content/drive/MyDrive/Week1/prices.csv'


    with open(input_file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            product_type = row['product_type']
            original_price = float(row['price'])
            discounted_price = apply_discount(product_type, original_price)

            updated_products.append({
                'product_name': row['product_name'],
                'product_type': product_type,
                'original_price': original_price,
                'discounted_price': discounted_price,
                'saving': round(original_price - discounted_price, 2)
            })
    with open(output_file, 'w') as f:
        json.dump(updated_products, f, indent=2)

    print(f"✅ Processed {len(updated_products)} products")
    print(f"📁 Saved to {output_file}")

if __name__ == "__main__":
    process_csv('prices.csv', 'updated_prices.json')
