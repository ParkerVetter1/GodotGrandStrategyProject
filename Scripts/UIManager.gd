extends Control

@onready var clickedOnProvinceLabel = $ProvinceMenu/ClickedOnProvince
@onready var resourcesInProvince = $ProvinceMenu/ResourceInProvince

@onready var kingdomNameLabel = $HeaderUIPanel/KingdomName
@onready var kingdomResourcesLabel = $HeaderUIPanel/KingdomResources

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
var playerKingdom_Data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MainNode = self.get_parent().get_parent()
	Region_Data = MainNode.find_child("Region_Data")
	playerKingdom_Data = MainNode.find_child("PlayerKingdomNode")
	MainNode.connect("provinceWasClicked", Callable(self, "clickedNode"))
	kingdomNameLabel.text = str(playerKingdom_Data.kingdomResources["KingdomName"])

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

func highlightCurrentlySelectedProvince():
	## Highlight Control ##
	var polygon2D = clickedOnNode.get_child(1)
	if polygon2D.is_class("Polygon2D"):
		polygon2D.color = Color(1,1,1,0.75)
	else:
		printerr("Cant Grab Polygon2D from Node in UIMANAGER Script")
	## Highlight Control ##

func _process(delta: float) -> void:
	kingdomResourcesLabel.text = "Kingdom Resources:\n" + "Wood: " + str(playerKingdom_Data.kingdomResources["Wood"]) + "|" + "Stone: " + str(playerKingdom_Data.kingdomResources["Stone"]) + "|" + "Metal: " + str(playerKingdom_Data.kingdomResources["Metal"]) + "\nProvincesOwned: " + str(playerKingdom_Data.kingdomResources["ProvincesOwned"]) + "|" + "Population: " + str(playerKingdom_Data.kingdomResources["Population"])
	## Button Control ##
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
	Region_Data.allProvincesData[locationOfData]["Owner"] = playerKingdom_Data.OwnerIdNumber
	clickedOnNode.modulate = playerKingdom_Data.playerColor


func _on_build_mine_pressed() -> void:
	Region_Data.allProvincesData[locationOfData]["hasMine"] = true


func _on_build_forge_pressed() -> void:
	Region_Data.allProvincesData[locationOfData]["hasForge"] = true


func _on_build_crop_field_pressed() -> void:
	Region_Data.allProvincesData[locationOfData]["hasCropField"] = true


func _on_build_forester_hut_pressed() -> void:
	Region_Data.allProvincesData[locationOfData]["hasForesterHut"] = true
