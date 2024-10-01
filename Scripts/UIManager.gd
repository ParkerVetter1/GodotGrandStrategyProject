extends Control

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MainNode = self.get_parent().get_parent()
	MainNode.connect("provinceWasClicked", Callable(self, "clickedNode"))

func clickedNode(nameOfNodeClicked):
	label.text = label.text + nameOfNodeClicked

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
