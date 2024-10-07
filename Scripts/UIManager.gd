extends Control

#needs to be the path to ClickedOnProvince
@onready var label = $HeaderUIPanel/ClickedOnProvince

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
		label.text = "Last Province Clicked On: " + clickedOnNode.name + "Metal: " + str(Region_Data.allProvincesData[locationOfData]["Metal"])
