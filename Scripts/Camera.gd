extends Camera2D

var speed = 120


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mainUI = 	%MainUi
	#mainUI.
	pass # Replace with function body.

func _process(delta):
	# Move the camera based on WASD input
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("MoveUp"): # 'W' by default
		direction -= transform.y
	if Input.is_action_pressed("MoveDown"): # 'S' by default
		direction += transform.y
	if Input.is_action_pressed("MoveLeft"): # 'A' by default
		direction -= transform.x
	if Input.is_action_pressed("MoveRight"): # 'D' by default
		direction += transform.x
	# Normalize the direction vector to ensure consistent movement speed
	direction = direction.normalized()
	
	if Input.is_action_pressed("Shift"):
		# Apply the movement to the cameraw
		translate(direction * (speed * 2) * delta)
	else:
		# Apply the movement to the camera
		translate(direction * speed * delta)		
	
