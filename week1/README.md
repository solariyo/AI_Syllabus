Week 1: CSV to JSON Price Processor

What I built:
Reads a CSV file of products, applies a discount based on product type, and saves the updated data as JSON. I fixed a KeyError because my header didn't match!

Discount rules:
- Vegetables: 10% off
- Fruits: 5% off
- Herbs: 15% off

Files in this folder:
- prices.csv - Input file (sample data)
- process_prices.py - Main Python script
- updated_prices.json - Output file (generated)
- README.md - This file

How to run:
1. Make sure prices.csv is in the same folder
2. Run: python process_prices.py
3. Output saved to updated_prices.json

What I learned:
- Reading CSV files with Python's csv.DictReader
- Applying business logic with a dictionary of discount rules
- Saving structured data as JSON
- Debugging: fixed a typo (DicReader -> DictReader) and a header mismatch (KeyError)
