extends Node

@onready var Main = self.get_parent()
@onready var timeAndDate = get_parent().find_child("CanvasLayer").get_child(0).get_child(0).find_child("TimeAndDate")
var EnemyPlayerNode

signal sendProvinceData

var isprocessed = false
var provinceReferences
var enemySpawn = false

var date = {"Hour" : 1
			,"Day" : 1
			,"Month" : 1
			,"Year" : 1100}


var provinceVariables = {"Wood" : 0
						,"Stone" : 0
						,"Metal" : 0
						,"hasTown" : false
						,"hasArmy" : false
						,"Population" : 0
						,"Owner" : 0
						,"ProvinceName": " "
						,"hasMine" : false
						,"hasForge" : false
						,"hasCropField" : false
						,"hasForesterHut" : false}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	provinceReferences = Main.referenceToAllProvinces

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isprocessed:
		timeAndDate.text = "Time: " + str(date["Hour"])+ ":00 " + "Date: " + str(date["Day"]) + "/" + str(date["Month"]) + "/" + str(date["Year"])

#controls all data in provinces
########### Province Data ###########
var allProvincesData = []
func createProvinceData():
	for n in range(provinceReferences.size()):
		# Make a copy of provinceVariables for each province
		var new_province_data = provinceVariables.duplicate()
		# Assign province name to the new dictionary
		new_province_data["ProvinceName"] = provinceReferences[n].name
		# Append the dictionary to the array
		allProvincesData.append(new_province_data)

########### Province Data ###########

########### Region Data ###########
var allRegionsData = []

########### Region Data ###########


##all reasource managment should happen within the TIME zone need to write down documentation 
##if there is a instance of the rule being broken
########### Time ###########

func _on_timer_timeout() -> void:
	hourUp()
	isprocessed = true

func hourUp():

	if date["Hour"] < 24:
		date["Hour"] += 1
	else:
		date["Hour"] = 1
		dayUp()

func dayUp():
	for n in allProvincesData.size():
		var r = randi() % 3 + 1      # Returns between 1 and 5
		if allProvincesData[n]["hasTown"]:
			if allProvincesData[n]["hasMine"]:
				allProvincesData[n]["Stone"] += 10
				if r == 1:
					allProvincesData[n]["Metal"] += 1
			if allProvincesData[n]["hasForge"]:
				pass ##this will be used to make units
			if allProvincesData[n]["hasCropField"]:
				allProvincesData[n]["Population"] += 1
			if allProvincesData[n]["hasForesterHut"]:
				allProvincesData[n]["Wood"] += 10
	
	if date["Day"] < 10:
		date["Day"] += 1
	else:
		monthUp()
		date["Day"] = 1

func monthUp():
	for n in allProvincesData.size():
		if allProvincesData[n]["Owner"] == 1:
			emit_signal("sendProvinceData", allProvincesData[n]["Wood"], allProvincesData[n]["Stone"], allProvincesData[n]["Metal"], allProvincesData[n]["Population"])
			allProvincesData[n]["Wood"] = 0
			allProvincesData[n]["Stone"] = 0
			allProvincesData[n]["Metal"] = 0
			allProvincesData[n]["Population"] = 0
	if enemySpawn == false:
		SpawnEnemy()
	if date["Month"] < 12:
		date["Month"] += 1
	else:
		date["Month"] = 1
		yearUp()

func yearUp():
	
	
	date["Year"] += 1
########### Time ###########

func SpawnEnemy():
	enemySpawn = true
	EnemyPlayerNode = Main.find_child("EnemyPlayerNode")
	while true:
		var random = randi_range(0, allProvincesData.size())
		if allProvincesData[random]["Owner"] != 1:
			EnemyPlayerNode.spawnEnemyStartNode(provinceReferences[random], allProvincesData[random])
			break
