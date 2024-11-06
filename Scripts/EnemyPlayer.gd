extends Node

@onready var mainNode = get_parent()
@onready var Region_Data = mainNode.find_child("Region_Data")

var enemySpawnReferenceNode
var enemyNode

func spawnEnemyStartNode(province, provinceData):
	enemySpawnReferenceNode = province
	enemyNode = load("res://Scenes/EnemyPlayer.tscn").instantiate()
	enemyNode.ProvinceStarted = enemySpawnReferenceNode
	enemyNode.provinceData = provinceData
	assignOwnerId()
	self.add_child(enemyNode)

func assignOwnerId():
	var unUsedId = makeSureIdIsntUsed()
	enemyNode.EnemyResources["OwnerIdNumber"] = unUsedId
	mainNode.idsOfPlayers.append(unUsedId)

## this function is broken
func makeSureIdIsntUsed():
	return mainNode.idsOfPlayers[mainNode.idsOfPlayers.size() - 1] + 1
