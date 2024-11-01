extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	getMapTexture()

# grabs map from the Map Data folder should be able to edit file and put in new maps now
func getMapTexture():
	for file_name in DirAccess.get_files_at("res://Map_Data/"):
		if (file_name.get_extension() == "import"):
			file_name = file_name.replace('.import', '')
			self.texture = ResourceLoader.load("res://Map_Data/"+file_name)
	self.visible = false
