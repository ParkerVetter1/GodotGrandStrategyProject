extends Node

var ProvinceStarted
var provinceData

var EnemyResources = {   "OwnerIdNumber" : null
						,"ProvincesOwned" : 0
						,"Population" : 0
						,"KingdomName": "Horde"
						##needs to be assigned at the instatiation with a color that is not assigned so there can be more than 1 bot
						,"ProvinceColor": Color.GREEN}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProvinceStarted.modulate = EnemyResources["ProvinceColor"]
	provinceData["Owner"] = EnemyResources["OwnerIdNumber"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
