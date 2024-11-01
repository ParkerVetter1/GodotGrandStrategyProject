extends Node2D

@onready var mapImage = %SpriteMap
@onready var Region_Data_Script = %Region_Data

var idsOfPlayers = []

signal provinceWasClicked

var loadTxtFile = false

var referenceToRegionsNodes = []
var referenceToAllProvinces = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mapImage.visible
	load_regions()
	#load province data into other script
	Region_Data_Script.createProvinceData()

#the last clickedProvince
func clickedNode(node):
	emit_signal("provinceWasClicked", node) # Emit the signal

func getClickedCallFromEachNode():
	var k = -1
	for n in referenceToRegionsNodes:
		for i in n.get_child_count():
			k = k + 1
			referenceToAllProvinces[k].connect("WasClicked", Callable(self, "clickedNode"))

########### Regions loading ###########

func load_regions():
	var image = mapImage.get_texture().get_image()
	var pixel_color_dict = get_pixel_color_dict(image)
	var province_dict
	if loadTxtFile:
		province_dict = import_file("res://Map_Data/ProvinceColorCodes.txt")
	
	for province_color in pixel_color_dict:
		var province = load("res://Scenes/Province_Area.tscn").instantiate()
		if !loadTxtFile:
			# Set name using the province color code directly
			province.set_name(province_color)
		else:
			# If using an imported dictionary, ensure it gives a unique string name for each color
			province.set_name(province_dict[province_color] if province_color in province_dict else province_color)
		
		var polygons = get_polygons(image, province_color, pixel_color_dict)
		
		for polygon in polygons:
			var province_collision = CollisionPolygon2D.new()
			var province_polygon = Polygon2D.new()
			
			province_collision.polygon = polygon
			province_polygon.polygon = polygon
			
			province.add_child(province_collision)
			province.add_child(province_polygon)
			loadProvinceIntoRegions(province)
		referenceToAllProvinces.append(province)
	getClickedCallFromEachNode()

func loadProvinceIntoRegions(province):
	if !(province.name == "000000"):
		get_node("Regions").add_child(province)
	##findRegionNode(province.name, province)

# will return a string if the node is found otherwise will make it
func findRegionNode(possibleName, province):
	var regionName : String = possibleName
	regionName = regionName.substr(0, regionName.length() - 2)
	var node
# Iterate over the nodes directly
	for n in referenceToRegionsNodes:
		if n.name == regionName:  # Compare directly with the node's name
			node = n
			break
	if node != null: #if child with name regionName is in list do
		node.add_child(province) # add child to the regionName node
	else: #if cant find then make a new region node
		referenceToRegionsNodes.append(createRegion(regionName)) #make region node
		referenceToRegionsNodes[-1].add_child(province)

func createRegion(name : String):
	var region = load("res://Scenes/Region.tscn").instantiate()
	region.name = name
	get_node("Regions").add_child(region)
	return region

########### Regions loading ###########

########### file import/ setup poylgons loading ###########

func get_pixel_color_dict(image):
	var pixel_color_dict = {}
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var pixel_color = image.get_pixel(int(x), int(y)).to_html(false)
			if pixel_color not in pixel_color_dict:
				pixel_color_dict[pixel_color] = []
			pixel_color_dict[pixel_color].append(Vector2(x, y))
	return pixel_color_dict

func get_polygons(image, region_color, pixel_color_dict):
	var targetImage = Image.create(image.get_size().x, image.get_size().y, false, Image.FORMAT_RGBA8)
	for value in pixel_color_dict[region_color]:
		targetImage.set_pixel(value.x, value.y, "#ffffff")
	
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(targetImage)
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()), 0.1)
	return polygons

func import_file(filepath):
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file != null:
		return JSON.parse_string(file.get_as_text())
	else:
		print("Failed to open file:", filepath)
		return null

########### file import/ setup poylgons loading ###########
