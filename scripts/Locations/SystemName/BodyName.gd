extends Node
## Edit Below this line
const name = "Earth" # Body Name
const pop = "13 Billion" # Population
const rot = 0.6 # Sprite Rotation Speed
const industry = "Agriculture" # Industry type
## Blurb is the info that a planet shows
const blurb = "Earth is the home planet of the humans. Good agriculture, Abundant Water but sadly any useful minerals and fuels are long gone."
const market = true # 'true' if the body has a market 'false' if not
const shipyard = true # 'true' if the body has a shipyard 'false' if not
const fuel = true # 'true' if the body has a fuel market 'false' if not
const soldships = ["shuttle","corvette"] # Lists ships sold at shipyard.
## if shipyard = false then set 'const soldships = []' like so
## marketSellPrices : These are the markets base selling prices. 
## or what a market sells cargo for
## These should always be  higher than marketBuyPrices and are
## randomized below
var marketSellPrices = {"food":8,"water":10,"ore":550,"hightechgoods":2500,"steel":300,"luxuries":875,"consumergoods":179}
## marketSupplyAmt : These is the base amount the market has to sel. 
## These should relate to marketSellPrices (cheaper items more available)
## randomized below
var marketSupplyAmt = {"food":23000,"water":23000,"ore":200,"hightechgoods":40,"steel":310,"luxuries":2300,"consumergoods":1830}
## marketBuyPrices : These are the markets base buying prices.
## or what a body pays you for cargo
## These should always be  lower than marketSellPrices and are
## randomized below
var marketBuyPrices = {"food":3,"water":4,"ore":300,"hightechgoods":2000,"steel":230,"luxuries":700,"consumergoods":140}
## marketDemandAmt : This is how many the market wants to buy 
## These should relate to the marketBuyPrices 
## (pay more for high demand) and are randomized below
var marketDemandAmt = {"food":0,"water":0,"ore":5000,"hightechgoods":4000,"steel":3200,"luxuries":450,"consumergoods":240}
var fuelPriceMin = 6 #
var fuelPriceMax = 15
var fuelPriceMid = 11
var fuelAmtMin = 1
var fuelAmtMax = 3 

## do not edit below this line

var marketSellPriceRand = {} # Do not edit
var marketSupplyAmtRand = {} # Do not edit
var marketBuyPriceRand = {} # Do not edit
var marketDemandAmtRand = {} # Do not edit
var fuelPrice #leave empty
var fuelAmount #leave empty
var fuelSitu #leave empty
func _ready():
	print(name+".gd called")# Do not edit
func setupVars():
	if SaveLoad.locationChanged == true:
		print("location Changed! Doing Vars")
		randomize()# Do not edit
		## Sets amount of fuel in stock 
		## fuelAmount = int(range_rand('minAmount','maxAmount')
		fuelAmount = int(rand_range(fuelAmtMin, fuelAmtMax))
	
		randomize()
		## Sets price of fuel 
		## fuelPices = int(range_rand('minAmount','maxAmount')
		fuelPrice = int(rand_range(fuelPriceMin,fuelPriceMax))
		if fuelPrice < fuelPriceMid : # number shoud be half way between fuelprices min and max
			fuelSitu = "Fuel is cheap @ "+str(fuelPrice)+" Credits!"
		elif fuelPrice > fuelPriceMid: # number shoud be half way between fuelprices min and max
			fuelSitu = "Fuel is expensive @ "+str(fuelPrice)+" Credits!"
		## Leave all alone now
		else:
			fuelSitu = "Fuel is at a normal price @ "+str(fuelPrice)+" Credits!"
		randomize()
		for key in marketBuyPrices:
			var minlv = (marketBuyPrices[key]*0.6) 
			var maxlv = (marketBuyPrices[key]*1.2)
			marketBuyPriceRand[key]= int(rand_range(minlv,maxlv))
		for key in marketDemandAmt:
			var minlv = (marketDemandAmt[key]*0.6)
			var maxlv = (marketDemandAmt[key]*1.2)
			marketDemandAmtRand[key]= int(rand_range(minlv,maxlv))
		randomize()
		for key in marketSellPrices:
			var minlv = (marketSellPrices[key]*0.6)
			var maxlv = (marketSellPrices[key]*1.2)
			marketSellPriceRand[key]= int(rand_range(minlv,maxlv))
		for key in marketSupplyAmt:
			var minlv = (marketSupplyAmt[key]/0.6)
			var maxlv = (marketSupplyAmt[key]*1.3)
			marketSupplyAmtRand[key]= int(rand_range(minlv,maxlv))
		print("vars setup")
		SaveLoad.locationChangeReset()
		SaveLoad.setup_market(marketBuyPriceRand,marketSellPriceRand,marketSupplyAmtRand,marketDemandAmtRand,fuelPrice,fuelAmount,fuelSitu)
		print(str(SaveLoad.currentMarket))
	else:
		print(str(SaveLoad.currentMarket))
