extends Node

var OwnerIdNumber = 1

var kingdomResources = {"Wood" : 150
						,"Stone" : 150
						,"Metal" : 0
						,"ProvincesOwned" : 0
						,"Population" : 0
						,"KingdomName": "Player_Kingdom"
						,"ProvinceColor": Color.RED}

func _ready() -> void:
	get_parent().idsOfPlayers.append(OwnerIdNumber)

func _on_region_data_send_province_data(Wood, Stone, Metal, Population) -> void:
	kingdomResources["Wood"] += Wood
	kingdomResources["Stone"] += Stone
	kingdomResources["Metal"] += Metal
	kingdomResources["Population"] += Population
