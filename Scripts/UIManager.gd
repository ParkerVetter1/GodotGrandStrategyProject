extends Control

@onready var label = $HeaderUIPanel/ClickedOnProvince
var clickedOnNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MainNode = self.get_parent().get_parent()
	MainNode.connect("provinceWasClicked", Callable(self, "clickedNode"))

func clickedNode(nameOfNodeClicked):
	clickedOnNode = nameOfNodeClicked
	#label.text = "Last Province Clicked On: " + nameOfNodeClicked.name + "Metal: " + str(nameOfNodeClicked.resources["Metal"])

func _process(delta: float) -> void:
	label.text = "Last Province Clicked On: " + clickedOnNode.name + "Metal: " + str(clickedOnNode.resources["Metal"])
