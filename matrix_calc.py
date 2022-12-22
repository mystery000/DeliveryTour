import numpy as np
import pandas as pd
import requests
import pgeocode
import warnings
import json
from ortools.constraint_solver import routing_enums_pb2
from ortools.constraint_solver import pywrapcp

import mysql.connector;
### mysql connection
db = mysql.connector.connect(
  host="localhost",
  user="root",
  password="P@ssw0rd",
  database="delivery_tour"
)
sql_db = db.cursor()

########### Region Inputs ###########

# Zip code and Country where driver starts
depot_zip_code = '08258'
depot_country = 'Germany'

# Number of vehicles
num_vehicles = 4

# Vehicle capacity - should be in the same unit as volume
capacity = [9.5, 9.5, 9.5, 9]

# Google Maps API Key
API_key = 'XXXX'

# Time limit in seconds for the solver
time_limit = 100

# Driver Price per hour
price_hour = 15

# Driver Overnight cost
overnight_cost = 50

# Petrol Price/Liter
price_liter = 2.2

# Petrol per 100km
petrol_100 = 9

# Hours per Driver
hours_driver = 25

########### END Region Inputs ###########

# Path to input CSV file
INPUT_CSV = "inputs/my.csv"

session = requests.Session()

warnings.filterwarnings("ignore")
country_map = {"Austria": 'AT', "Germany": "DE"}

zip_2_zip_distance = {}
zip_2_zip_time = {}


def openrouteservice_request(origin, destination):
    request = {
        "locations": [origin, destination],
        "destinations": [1],
        "sources": [0],
        "metrics": ["distance", "duration"]
    }
    print("Request is sending...")
    response = session.post("https://routing.mastri-erp.de/ors/ors/v2/matrix/driving-car", json=request)
    if response.ok:
        data = response.json()
        distance = data['distances'][0][0]
        time = data['durations'][0][0]
        return distance, time
    else:
        print(response.text)


def get_real_distance(lon1, lat1, lon2, lat2):
    origins = (lat1, lon1)
    destination = (lat2, lon2)
    if (origins, destination) in zip_2_zip_time:
        return zip_2_zip_time[(origins, destination)], zip_2_zip_distance[(origins, destination)]
    else:
        distance, time = openrouteservice_request([lon1, lat1], [lon2, lat2])
        zip_2_zip_time[(origins, destination)] = int(time/60)
        zip_2_zip_distance[(origins, destination)] = int(distance)
        return int(time/60), int(distance)

def read_inputs():
    input_sample = pd.read_csv(INPUT_CSV, delimiter=';')
    cols = input_sample.select_dtypes(include=[np.object_]).columns
    input_sample[cols] = input_sample[cols].apply(
        lambda x: x.str.normalize('NFKD').str.encode('ascii', errors='ignore').str.decode('utf-8'))
    input_sample['volume'] = input_sample['volume'].replace(',', '.', regex=True)
    input_sample = input_sample.replace(',', '', regex=True)

    input_sample['origin_city'] = input_sample['current location'].str.split(' ').str[-2]
    input_sample['destination_city'] = input_sample['destination'].str.split(' ').str[-2]
    input_sample['destination_zip'] = input_sample['destination'].str.split(' ').str[-1]
    input_sample['origin_zip'] = input_sample['current location'].str.split(' ').str[-1]

    input_sample['Time at Destination in Min'] = input_sample['Time at Destination in Min'].fillna(0)

    customers_dict = []
    origins = input_sample['current location'].tolist()
    destinations = input_sample['destination'].tolist()
    origin_cities = input_sample['origin_city'].tolist()
    destination_cities = input_sample['destination_city'].tolist()
    priorities = input_sample['Priority'].tolist()

    volumes = input_sample['volume'].tolist()
    time_destination = input_sample['Time at Destination in Min'].tolist()
    orders = []
    demands = []
    demands_pick_up = []

    nomi = pgeocode.Nominatim(country_map[depot_country])
    output = nomi.query_postal_code(depot_zip_code)

    start_cus = 0
    customers_dict.append({})
    customers_dict[start_cus]['Country'] = depot_country
    customers_dict[start_cus]['Zip Code'] = depot_zip_code
    customers_dict[start_cus]['lat'] = output['latitude']
    customers_dict[start_cus]['lon'] = output['longitude']
    customers_dict[start_cus]['city'] = output['community_name']
    customers_dict[start_cus]['volume'] = 0
    customers_dict[start_cus]['index'] = 0
    customers_dict[start_cus]['name'] = 'c0'
    customers_dict[start_cus]['time_destination'] = 0
    customers_dict[start_cus]['priority'] = 'high'

    demands.append(0)
    demands_pick_up.append(0)
    start_cus += 1

    start_ord = 0
    for ind in range(0, len(input_sample)):
        zc_origin = origins[start_ord]
        volume = volumes[start_ord]
        td = time_destination[start_ord]
        customers_dict.append({})
        country = zc_origin.split(' ')[0]
        zip_code = zc_origin.split(' ')[-1]
        customers_dict[start_cus]['Country'] = country
        country_code = country_map[country]
        customers_dict[start_cus]['Zip Code'] = zip_code
        nomi = pgeocode.Nominatim(country_code)
        output = nomi.query_postal_code(zip_code)
        customers_dict[start_cus]['lat'] = output['latitude']
        customers_dict[start_cus]['lon'] = output['longitude']
        customers_dict[start_cus]['city'] = origin_cities[ind]
        customers_dict[start_cus]['volume'] = -float(volume) * 100
        customers_dict[start_cus]['time_destination'] = td
        customers_dict[start_cus]['index'] = start_cus
        customers_dict[start_cus]['name'] = start_cus
        customers_dict[start_cus]['priority'] = priorities[ind]

        demands.append(int(float(volume) * 100))
        demands_pick_up.append(int(float(volume) * 100))
        start_cus += 1
        zc_destination = destinations[start_ord]
        customers_dict.append({})
        country = zc_destination.split(' ')[0]
        zip_code = zc_destination.split(' ')[-1]
        customers_dict[start_cus]['Country'] = country
        country_code = country_map[country]
        customers_dict[start_cus]['Zip Code'] = zip_code
        nomi = pgeocode.Nominatim(country_code)
        output = nomi.query_postal_code(zip_code)
        customers_dict[start_cus]['lat'] = output['latitude']
        customers_dict[start_cus]['lon'] = output['longitude']
        customers_dict[start_cus]['city'] = destination_cities[ind]
        customers_dict[start_cus]['volume'] = float(volume) * 100
        customers_dict[start_cus]['index'] = start_cus
        customers_dict[start_cus]['name'] = start_cus
        customers_dict[start_cus]['time_destination'] = td
        customers_dict[start_cus]['priority'] = priorities[ind]

        demands.append(-int(float(volume) * 100))
        demands_pick_up.append(-int(float(volume) * 100))
        start_cus += 1
        orders.append([start_cus - 2, start_cus - 1])
        start_ord += 1
    distances_dict = []
    time_dict = []
    for i in range(0, len(customers_dict)):
        ele_i = customers_dict[i]
        distances_dict_aux = []
        time_dict_aux = []
        for j in range(0, len(customers_dict)):
            ele_j = customers_dict[j]
            lon1 = ele_i['lon']
            lat1 = ele_i['lat']
            lon2 = ele_j['lon']
            lat2 = ele_j['lat']
            time, dist = get_real_distance(lon1, lat1, lon2, lat2)
            if ele_i['Zip Code'] != ele_j['Zip Code']:
                time += ele_j['time_destination']
            distances_dict_aux.append(dist)
            time_dict_aux.append(time)
        distances_dict.append(distances_dict_aux)
        time_dict.append(time_dict_aux)
    print("Finished calculating distances")
    order = 1
    ord = 1
    for ind in range(0, len(input_sample)):
        depot = 0
        c1 = order
        c2 = order + 1
        tot_time = time_dict[depot][c1] + time_dict[c1][c2] + time_dict[c2][depot]
        print("Order:", ord, ", Priority:", customers_dict[order]['priority'], ",Total Time (depot-pickup-delivery-depot):", round(tot_time/60,2))
        order += 2
        ord += 1
    return customers_dict, distances_dict, time_dict, orders, demands, demands_pick_up


def create_data_model(distances_dict, time_dict, orders, demands, demands_pick_up):
    """Stores the data for the problem."""
    data = {}
    data['distance_matrix'] = distances_dict
    data['time_matrix'] = time_dict
    data['pickups_deliveries'] = orders
    data['demands'] = demands
    data['demands_pick_up'] = demands_pick_up
    data['num_vehicles'] = num_vehicles
    data['vehicle_capacities'] = [int(100*c) for c in capacity]
    data['depot'] = 0
    return data

def get_solution(data, manager, routing, solution, customers_dict):
    """Prints solution on console."""
    print(f'Objective: {solution.ObjectiveValue()}')
    total_distance = 0
    total_time = 0
    total_load = 0
    total_load_vei = {}
    total_distance_vei = {}
    total_time_vei = {}
    sol_dict = {}
    for vehicle_id in range(data['num_vehicles']):
        total_load_vei[vehicle_id] = 0
        total_distance_vei[vehicle_id] = 0
        total_time_vei[vehicle_id] = 0
        index = routing.Start(vehicle_id)
        plan_output = 'Route for vehicle {}:\n'.format(vehicle_id)
        route_time = 0
        route_distance = 0
        route_load = 0
        order = 1
        while not routing.IsEnd(index):
            d = {}
            if vehicle_id not in sol_dict:
                d['node'] = 0
                d['order'] = 0
                d['time'] = 0
                d['distance'] = 0
                d['zip'] = customers_dict[0]['Zip Code']
                d['city'] = customers_dict[0]['city']
                d['country'] = customers_dict[0]['Country']
                d['volume'] = customers_dict[0]['volume']
                sol_dict[vehicle_id] = [d]
                d = {}
            node_index = manager.IndexToNode(index)
            if data['demands'][node_index] < 0:
                route_load -= data['demands_pick_up'][node_index]
            else:
                route_load += data['demands_pick_up'][node_index]
            plan_output += ' [{0},{1}] -> '.format(node_index, route_load)
            previous_index = index
            index = solution.Value(routing.NextVar(index))
            node_index_current = manager.IndexToNode(index)
            distance = data['distance_matrix'][manager.IndexToNode(previous_index)][manager.IndexToNode(index)]
            route_time += routing.GetArcCostForVehicle(previous_index, index, vehicle_id)
            total_time_vei[vehicle_id] += routing.GetArcCostForVehicle(previous_index, index, vehicle_id)
            total_distance_vei[vehicle_id] += distance
            route_distance += distance
            d['node'] = node_index_current
            d['order'] = order
            d['time'] = route_time
            d['distance'] = route_distance
            d['zip'] = customers_dict[node_index_current]['Zip Code']
            d['country'] = customers_dict[node_index_current]['Country']
            d['city'] = customers_dict[node_index_current]['city']
            d['volume'] = customers_dict[node_index_current]['volume']
            sol_dict[vehicle_id].append(d)
            order += 1
        plan_output += '[{0},{1}]\n'.format(manager.IndexToNode(index), route_load)
        plan_output += 'Time of the route (min): {}\n'.format(route_time)
        plan_output += 'Time of the route (h): {}\n'.format(route_time / 60)
        plan_output += 'Load of the route: {}\n'.format(route_load)
        print(plan_output)
        total_distance += route_distance
        total_time += route_time
        total_load += route_load
    # print(sol_dict)
    # print(total_time_vei)
    # print(total_distance_vei)
    # print('Total distance of all routes: {}m'.format(route_time))
    # print('Total load of all routes: {}'.format(total_load))
    return total_time, total_distance / 1000, sol_dict


def main():
    ## initialize nodes and orders tables from db
    sql_init_nodes = "TRUNCATE TABLE nodes"
    sql_init_orders = "TRUNCATE TABLE orders"
    sql_db.execute(sql_init_nodes)
    db.commit()
    sql_db.execute(sql_init_orders)
    db.commit()

    customers_dict, distances_dict, time_dict, orders, demands, demands_pick_up = read_inputs()

    """Solve the CVRP problem."""
    # Instantiate the data problem.
    data = create_data_model(distances_dict, time_dict, orders, demands, demands_pick_up)

    # Create the routing index manager.
    manager = pywrapcp.RoutingIndexManager(len(data['time_matrix']),
                                           data['num_vehicles'], data['depot'])

    # Create Routing Model.
    routing = pywrapcp.RoutingModel(manager)

    # Create and register a transit callback.
    def distance_callback(from_index, to_index):
        """Returns the distance between the two nodes."""
        # Convert from routing variable Index to distance matrix NodeIndex.
        from_node = manager.IndexToNode(from_index)
        to_node = manager.IndexToNode(to_index)
        return data['time_matrix'][from_node][to_node]

    transit_callback_index = routing.RegisterTransitCallback(distance_callback)
    # Define cost of each arc.
    routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index)

    def demand_callback_pick_up(from_index):
        # Returns the demand of the node.
        # Convert from routing variable Index to demands NodeIndex.
        from_node = manager.IndexToNode(from_index)
        return data['demands_pick_up'][from_node]

    demand_callback_index_pick_up = routing.RegisterUnaryTransitCallback(
        demand_callback_pick_up)
    routing.AddDimensionWithVehicleCapacity(
        demand_callback_index_pick_up,
        0,  # null capacity slack
        data['vehicle_capacities'],  # vehicle maximum capacities
        True,  # start cumul to zero
        'Capacity_Pickup')

    # Add Distance constraint.
    dimension_name = 'Distance'
    routing.AddDimension(
        transit_callback_index,
        0,  # no slack
        3000000,  # vehicle maximum travel distance
        False,  # start cumul to zero
        dimension_name)
    distance_dimension = routing.GetDimensionOrDie(dimension_name)

    # Define Transportation Requests.
    for request in data['pickups_deliveries']:
        pickup_index = manager.NodeToIndex(request[0])
        delivery_index = manager.NodeToIndex(request[1])
        routing.AddPickupAndDelivery(pickup_index, delivery_index)
        routing.solver().Add(
            routing.VehicleVar(pickup_index) == routing.VehicleVar(delivery_index))
        routing.solver().Add(
            distance_dimension.CumulVar(pickup_index) < distance_dimension.CumulVar(delivery_index))

    def time_callback(from_index, to_index):
        """Returns the travel time between the two nodes."""
        # Convert from routing variable Index to time matrix NodeIndex.
        from_node = manager.IndexToNode(from_index)
        to_node = manager.IndexToNode(to_index)
        return data['time_matrix'][from_node][to_node]

    transit_callback_index = routing.RegisterTransitCallback(time_callback)
    routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index)

    time = 'Time'
    routing.AddDimension(
        transit_callback_index,
        3000000,  # allow waiting time
        60 * hours_driver, #3000000,  # maximum time per vehicle
        True,  # Don't force start cumul to zero.
        time)

    # Allow to drop nodes.
    for node in range(1, len(data['distance_matrix'])):
        #routing.AddDisjunction([manager.NodeToIndex(node)], 10**6)
        if customers_dict[node]['priority'] == 'low':
            routing.AddDisjunction([manager.NodeToIndex(node)], 10000)
        if customers_dict[node]['priority'] == 'medium':
            routing.AddDisjunction([manager.NodeToIndex(node)], 1000000)

    # Setting first solution heuristic.
    search_parameters = pywrapcp.DefaultRoutingSearchParameters()
    search_parameters.first_solution_strategy = (
        routing_enums_pb2.FirstSolutionStrategy.AUTOMATIC)
    #search_parameters.local_search_metaheuristic = (
    #    routing_enums_pb2.LocalSearchMetaheuristic.GUIDED_LOCAL_SEARCH)
    search_parameters.time_limit.seconds = time_limit

    # Solve the problem.
    solution = routing.SolveWithParameters(search_parameters)

    # Print solution on console.
    if solution:
        total_time, total_distance, sol_dict = get_solution(data, manager, routing, solution, customers_dict)

        df = pd.DataFrame()
        nodes = []
        ords = []
        times_all = []
        datetimes = []
        distances = []
        zips = []
        countries = []
        volumes = []
        vei = []
        types = []
        cities = []
        perc_cap = []
        vol_cumuls = []
        petrol_list = []
        petrolprice_list = []

        for i in sol_dict.keys():
            vol_cumul = 0
            start = 0
            for j in sol_dict[i]:
                vei.append(i)
                nodes.append(j['node'])
                ords.append(j['order'])
                times_all.append(round(j['time']/60,1))
                if start == 0:
                    datetimes.append(round(j['time']/60,1))
                else:
                    if j['node'] == 0:
                        datetimes.append(round(j['time']/60,1))
                    else:
                        datetimes.append(round(j['time']/60,1))
                distances.append(round(j['distance']/1000,1))
                total_petrol = ((j['distance']/1000) * petrol_100)/100
                total_petrol_price = price_liter * total_petrol
                petrol_list.append(round(total_petrol,1))
                petrolprice_list.append(round(total_petrol_price,1))
                zips.append(j['zip'])
                cities.append(j['city'])
                countries.append(j['country'])
                if j['node'] == 0:
                    volumes.append(0)
                    types.append("depot")
                else:
                    if j['volume'] < 0:
                        volumes.append(-j['volume']/100)
                        types.append("pick-up")
                    else:
                        volumes.append(j['volume']/100)
                        types.append("delivery")
                vol_cumul -= j['volume']/100
                vol_cumuls.append(round(vol_cumul,1))
                perc_cap.append(round(100*vol_cumul/capacity[i],1))
                start += 1
        df['vehicle'] = vei
        df['node'] = nodes
        df['zip'] = zips
        df['city'] = cities
        df['country'] = countries
        df['order'] = ords
        df['time(h)'] = datetimes
        df['distance(km)'] = distances
        df['demand'] = volumes
        df['type'] = types
        df['load'] = vol_cumuls
        df['capacity %'] = perc_cap
        df['petrol(L)'] = petrol_list
        df['petrol cost(EUR)'] = petrolprice_list

        cols = df.select_dtypes(include=[np.object_]).columns
        df[cols] = df[cols].apply(
            lambda x: x.str.normalize('NFKD').str.encode('ascii', errors='ignore').str.decode('utf-8'))
        df.to_csv("output.csv", index=False)   # df -> orders table
        for i in range(0, len(types)):
            sql = f"insert into delivery_tour.orders(vehicle, node, zip, city, country, `order`, `time`, distance, demand, `type`, `load`, capacity, petrol, petrol_cost) values({vei[i]},{nodes[i]},{zips[i]},'{cities[i]}','{countries[i]}',{ords[i]},{datetimes[i]},{distances[i]},{volumes[i]},'{types[i]}',{vol_cumuls[i]},{perc_cap[i]},{petrol_list[i]},{petrolprice_list[i]})"
            sql_db.execute(sql)
            db.commit()

        ns = []
        visited = []
        zips = []
        citys = []
        countrys = []
        priority = []
        for i in range(0, len(data['demands'])):
            if i in nodes:
                visited.append("yes")
            else:
                visited.append("no")
            ns.append(i)
            zips.append(customers_dict[i]['Zip Code'])
            citys.append(customers_dict[i]['city'])
            countrys.append(customers_dict[i]['Country'])
            priority.append(customers_dict[i]['priority'])

        df_2 = pd.DataFrame()
        df_2["node"] = ns
        df_2["zip"] = zips
        df_2["city"] = citys
        df_2["country"] = countrys
        df_2["visited"] = visited
        df_2["priority"] = priority

        df_2.to_csv("output_nodes.csv", index=False)
        for i in range(0, len(ns)):
            sql = f"insert into delivery_tour.nodes(node, zip, city, country, visited, priority) values({ns[i]},{zips[i]},'{citys[i]}','{countrys[i]}','{visited[i]}','{priority[i]}')"
            sql_db.execute(sql)
            db.commit()
    else:
        print("No Solution")
        status = routing.status()
        if status == 1:
            print("Problem not solved yet.")
        elif status == 3:
            print("No solution found to the problem.")
        elif status == 4:
            print("Time limit reached before finding a solution.")
        elif status == 5:
            print("Model, model parameters, or flags are not valid.")

if __name__ == '__main__':
    main()