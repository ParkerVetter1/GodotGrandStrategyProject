extends Control

#needs to be the path to ClickedOnProvince
@onready var clickedOnProvinceLabel = $ProvinceMenu/ClickedOnProvince
@onready var resourcesInProvince = $ProvinceMenu/ResourceInProvince

##### Buttons #####
@onready var settleButton = $ProvinceMenu/SettleButton
@onready var buildMineButton = $ProvinceMenu/BuildMine
@onready var buildForgeButton = $ProvinceMenu/BuildForge
@onready var buildCropFieldButton = $ProvinceMenu/BuildCropField
@onready var buildForesterHutButton = $ProvinceMenu/BuildForesterHut
##### Buttons #####

var clickedOnNode
var locationOfData
var clickedHappened = false
var Region_Data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MainNode = self.get_parent().get_parent()
	Region_Data = MainNode.find_child("Region_Data")
	MainNode.connect("provinceWasClicked", Callable(self, "clickedNode"))

func clickedNode(nodeThatWasClicked):
	clickedHappened = true
	clickedOnNode = nodeThatWasClicked
	var size = Region_Data.allProvincesData.size()
	var provinceName
	for n in size:
		provinceName = Region_Data.allProvincesData[n]["ProvinceName"]
		if nodeThatWasClicked.name == provinceName:
			locationOfData = n
			break

func _process(delta: float) -> void:
	if clickedHappened:
		clickedOnProvinceLabel.text = "Province\n" + clickedOnNode.name
		resourcesInProvince.text = "Resources in province: \n" + "Wood: " + str(Region_Data.allProvincesData[locationOfData]["Wood"]) + "\n"+ "Stone: " + str(Region_Data.allProvincesData[locationOfData]["Stone"]) + "\n"+ "Metal: " + str(Region_Data.allProvincesData[locationOfData]["Metal"]) + "\n"+ "Settled: " + str(Region_Data.allProvincesData[locationOfData]["hasTown"]) + "\n"+ "Population: " + str(Region_Data.allProvincesData[locationOfData]["Population"]) + "\n"+ "Owner: " + str(Region_Data.allProvincesData[locationOfData]["Owner"])
		if Region_Data.allProvincesData[locationOfData]["hasTown"]:
			#turn on visability of the other buttons
			settleButton.visible = false
			buildMineButton.visible = true
			buildForgeButton.visible = true
			buildCropFieldButton.visible = true
			buildForesterHutButton.visible = true
		else:
			settleButton.visible = true
			buildMineButton.visible = false
			buildForgeButton.visible = false
			buildCropFieldButton.visible = false
			buildForesterHutButton.visible = false


func _on_settle_button_pressed() -> void:
	Region_Data.allProvincesData[locationOfData]["hasTown"] = true


func _on_build_mine_pressed() -> void:
	pass # Replace with function body.


func _on_build_forge_pressed() -> void:
	pass # Replace with function body.


func _on_build_crop_field_pressed() -> void:
	pass # Replace with function body.


func _on_build_forester_hut_pressed() -> void:
	pass # Replace with function body.
