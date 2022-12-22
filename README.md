# Delivery Tour

# How to run
1. Restore sql dump file
2. pip install -r requirments.txt
3. python matrix_calc.py

# How it works
1. Read data from csv file in inputs
2. Request to https://routing.mastri-erp.de/ors/ors/v2/matrix/driving-car
3. Save as output.csv for orders and output_nodes.csv for nodes
4. Save response data to delivery_tour db
