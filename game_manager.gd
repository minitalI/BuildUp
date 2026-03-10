extends Node

var ROTATION_SCALE = 5
var rng = RandomNumberGenerator.new()
var objects_grabbed = 0
var objects_left = 2
var level = 1
var object_limits = [2, 2, 12]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func blueprint_item():
	var scene = PlayerState.get_adjustable_inventory_item()
	if scene != null:
		var item = scene.instantiate()
		item.position = get_viewport().get_mouse_position()
		add_child(item)
		PlayerState.placing_item = true
		
		# okay, so placing the item.
		# you should press a button to start placing it. probably the grab button again.
		# and then, you should have a fair amount of maneuverability in placing it. 
		# so, probably it'll be it is placed where your mouse is.
		# you do some type of input, probably click, to lock that in, and then you can place like qw to rotate left or right
		# then, click again, and thats locked in.
		# pressing esc goes back.
		
		# maybe make an entirely different scene that can be moved, and then kill that instance, 
		# and then make a new instance. 

func place_item(position, rotation):
	var scene = PlayerState.get_inventory_item()
	var item = scene.instantiate()
		
	item.position =  position
	item.rotation = rotation
	var spice_number = str(randi_range(1,9999999))
	item.name = PlayerState.inventory[PlayerState.inventory_location] + spice_number
	PlayerState.remove_item_from_inventory()
		
	add_child(item)
		
	PlayerState.placing_item = false

func show_inventory():
	SignalBus.show_inventory.emit()

func level_up():
	level += 1
	objects_left = object_limits[level - 1]
	objects_grabbed = 0

func level_down():
	level -= 1
	objects_left = object_limits[level - 1]
	objects_grabbed = 0
