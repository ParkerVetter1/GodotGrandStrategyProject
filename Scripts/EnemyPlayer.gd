extends Node

@onready var mainNode = get_parent()

var enemySpawnReferenceNode

var EnemyResources = {   "OwnerIdNumber" : null
						,"ProvincesOwned" : 0
						,"Population" : 0
						,"KingdomName": "Horde"}

func spawnEnemyStartNode(province):
	enemySpawnReferenceNode = province

func assignOwnerId():
	EnemyResources["OwnerIdNumber"] = makeSureIdIsntUsed()

func makeSureIdIsntUsed():
	for i in mainNode.idsOfPlayers.size():
		## start at the number two becuase player is 1 and noone can be 0
		var n = 2
		if !mainNode.idsOfPlayers[i] == 0:
			mainNode.idsOfPlayers[i] = n
			return n
		n += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
