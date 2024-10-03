extends Node

@onready var Main = self.get_parent()
@onready var timeAndDate = get_parent().find_child("CanvasLayer").get_child(0).get_child(0).find_child("TimeAndDate")

var date = {"Hour" : 1
			,"Day" : 1
			,"Month" : 1
			,"Year" : 1800}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var provinceReferences = Main.referenceToAllProvinces

var isprocessed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isprocessed:
		timeAndDate.text = "Time: " + str(date["Hour"])+ ":00 " + "Date: " + str(date["Day"]) + "/" + str(date["Month"]) + "/" + str(date["Year"])

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
