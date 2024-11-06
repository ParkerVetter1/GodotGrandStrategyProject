extends Area2D

@onready var province_name = name

signal WasClicked

@onready var shader = load("res://Layouts/Outline.gdshader")
@onready var shaderMaterial = load("res://Layouts/OutlineMaterial.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#shaderMaterial.shader = shader
	#get_child(1).material = shaderMaterial
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_child_entered_tree(node: Node) -> void:
	if node.is_class("Polygon2D"):
		node.color = Color(1,1,1,0.5)
		##need to add border to all the polygons
		##node.set_script()

func _on_mouse_entered() -> void:
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(1,1,1,1)

func _on_mouse_exited() -> void:
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(1,1,1,0.5)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		#print(str(province_name) + " Clicked")
		emit_signal("WasClicked", self) # Emit the signal
