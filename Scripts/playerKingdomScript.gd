extends Node

var OwnerIdNumber = 1
var playerColor = Color.RED

var kingdomResources = {"Wood" : 0
						,"Stone" : 0
						,"Metal" : 0
						,"ProvincesOwned" : 0
						,"Population" : 0
						,"KingdomName": "Player_Kingdom"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_region_data_send_province_data(Wood, Stone, Metal) -> void:
	kingdomResources["Wood"] += Wood
	kingdomResources["Stone"] += Stone
	kingdomResources["Metal"] += Metal
