extends Node2D

var regionColors = [Color.RED, Color.AQUA, Color.BLUE, Color.DARK_ORANGE, Color.WHITE, Color.PURPLE, Color.LIGHT_PINK]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_child_entered_tree(node: Node) -> void:
	var randomNumb = randi() % regionColors.size() # returns a number between 0 and 7
	node.modulate = regionColors[randomNumb]
	regionColors.remove_at(randomNumb)
