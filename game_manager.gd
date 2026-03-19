extends Node

const ROTATION_SCALE = 5
var rng = RandomNumberGenerator.new()
var objects_grabbed = 0
var objects_left = 2
var level = 4
var y_modifier = 0
var x_modifier = 0
var object_limits = [2, 2, 8, 0, 100, 0]
const static_object_limits = [2, 2, 8, 0, 100, 0] # could make this the same as object_limits in ready, but meh
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_position_modifiers()
	objects_left = object_limits[level]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_position_modifiers():
	y_modifier = 0
	x_modifier = 0
	var temp_pos = PlayerState.position
	
	while temp_pos.x != 0 or temp_pos.y != 0:
		var viewport_size = get_viewport().size
		if temp_pos.x >= viewport_size.x:
			temp_pos.x -= viewport_size.x
			x_modifier -= 1
			
		elif temp_pos.x < 0:
			temp_pos.x += viewport_size.x
			x_modifier += 1
		
		if int(temp_pos.x / viewport_size.x) == 0:
			temp_pos.x = 0
			
		if temp_pos.y >= viewport_size.y:
			temp_pos.y -= viewport_size.y
			y_modifier -= 1
			
		elif temp_pos.y < 0:
			temp_pos.y += viewport_size.y
			y_modifier += 1
		
		if int(temp_pos.y / viewport_size.y) == 0 and temp_pos.y >= 0:
			temp_pos.y = 0
			
func _process(delta: float) -> void:
	set_position_modifiers()
	if Input.is_action_just_pressed("menu"):
		SignalBus.show_menu.emit()
		# theoretically the menu just pops up in front of the game.
		# so do we just have an invisible menu thing 
		# that seems stupid
		# i suppose we could instance a new menu scene which seems somehow dumber.
		# changing the scene is not an option
		# well, in either case, probably a menu scene would be good.
		# and then a translucent grey block in the back.
		
		# really there is no reason to NOT just use y_modifier as level, but eh.
		# this checks if for some reason the level messed up, and changes that. 

func blueprint_item():
	var scene = PlayerState.get_adjustable_inventory_item()
	if scene != null:
		var item = scene.instantiate()
		item.z_index = 5
		item.position = get_viewport().get_mouse_position()
		# item needs to be above the background
		
		add_child(item)
		
		PlayerState.placing_item = true
		
		if level != y_modifier + 1:
			level = y_modifier + 1
		
		# maybe make an entirely different scene that can be moved, and then kill that instance, 
		# and then make a new instance. 

func place_item(position, rotation):
	var scene = PlayerState.get_inventory_item()
	var item = scene.instantiate()
		
	item.position =  position
	item.rotation = rotation
	item.z_index = 5
	item.name = PlayerState.inventory[PlayerState.inventory_location]
	PlayerState.remove_item_from_inventory()
		
	add_child(item)
		
	PlayerState.placing_item = false

func show_inventory():
	SignalBus.show_inventory.emit()

func level_up():
	set_position_modifiers()
	objects_left = object_limits[y_modifier]
	objects_grabbed = 0

func level_down():
	y_modifier -= 1
	# everything is fucked for no reaso n
	# what 
	# something something the thing that checks the level to make sure its chill is broken
	# something something adding level sometimes makes the level too high if processing has already happened
	# cos that adds one twice.
	objects_left = object_limits[y_modifier]
	objects_grabbed = 0

func set_object_limit():
	set_position_modifiers()
	objects_left = object_limits[y_modifier]
