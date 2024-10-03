extends Control

@onready var label = $HeaderUIPanel/ClickedOnProvince

var clickedOnNode
var clickedHappened = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MainNode = self.get_parent().get_parent()
	MainNode.connect("provinceWasClicked", Callable(self, "clickedNode"))

func clickedNode(nameOfNodeClicked):
	clickedHappened = true
	clickedOnNode = nameOfNodeClicked

func _process(delta: float) -> void:
	if clickedHappened:
		label.text = "Last Province Clicked On: " + clickedOnNode.name + "Metal: " + str(clickedOnNode.resources["Metal"])
