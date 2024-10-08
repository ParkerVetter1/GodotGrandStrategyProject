extends Node

@onready var Main = self.get_parent()
@onready var timeAndDate = get_parent().find_child("CanvasLayer").get_child(0).get_child(0).find_child("TimeAndDate")

var isprocessed = false
var provinceReferences

var date = {"Hour" : 1
			,"Day" : 1
			,"Month" : 1
			,"Year" : 1800}

# Need this to be not 1 dictionary but the template of 1 i can copy and assign to each province
var provinceVariables = {"Wood" : 0
						,"Stone" : 0
						,"Metal" : 0
						,"hasTown" : false
						,"hasArmy" : false
						,"Population" : 0
						,"Owner" : 0
						,"ProvinceName": " "}

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

########### Time ###########

func _on_timer_timeout() -> void:
	hourUp()
	isprocessed = true

func hourUp():
	for n in allProvincesData.size():
		if allProvincesData[n]["hasTown"]:
			allProvincesData[n]["Population"] += 1
	if date["Hour"] < 24:
		date["Hour"] += 1
	else:
		date["Hour"] = 1
		dayUp()

func dayUp():
	
	if date["Day"] < 31:
		date["Day"] += 1
	else:
		date["Day"] = 1
		monthUp()

func monthUp():
	
	if date["Month"] < 12:
		date["Day"] += 1
	else:
		date["Month"] = 1
		yearUp()

func yearUp():
	
	date["Year"] += 1

########### Time ###########
