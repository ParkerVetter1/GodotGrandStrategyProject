extends Node2D

@onready var mapImage = %SpriteMap
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mapImage.visible = false
	load_regions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_regions():
	var image = mapImage.get_texture().get_image()
	var pixel_color_dict = get_pixel_color_dict(image)
	var province_dict = import_file("res://Map_Data/ProvinceColorCodes.txt")
	
	for province_color in province_dict:
		var province = load("res://Scenes/Province_Area.tscn").instantiate()
		province.set_name(province_dict[province_color])
		
		var polygons = get_polygons(image, province_color, pixel_color_dict)
		
		for polygon in polygons:
			var province_collision = CollisionPolygon2D.new()
			var province_polygon = Polygon2D.new()

			province_collision.polygon = polygon
			province_polygon.polygon = polygon

			province.add_child(province_collision)
			province.add_child(province_polygon)
		loadProvinceIntoRegions(province)

func loadProvinceIntoRegions(province):
	findRegionNode(province.name, province)

# will return a string if the node is found otherwise will make it
func findRegionNode(possibleName, province):
	var regionName : String = possibleName
	regionName = regionName.substr(0, regionName.length() - 2)
	var node = get_node("Regions").find_child(regionName)
	if node != null: #if child with name regionName is in list do
		node.add_child(province) # add child to the regionName node
	else: #if cant find then make a new region node
		var newRegion = createRegion(regionName) #make region node
		newRegion.add_child(province)

func createRegion(name : String):
	var region = load("res://Scenes/Region.tscn").instantiate()
	region.name = name
	get_node("Regions").add_child(region)
	return region

func get_pixel_color_dict(image):
	var pixel_color_dict = {}
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var pixel_color = "#" + str(image.get_pixel(int(x), int(y)).to_html(false))
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
