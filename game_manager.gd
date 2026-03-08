extends Node

var ROTATION_SCALE = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func blueprint_item():
	if PlayerState.inventory != []:
		var scene = preload("res://adjustableObject.tscn")
		
		#match item_name:
			#"chair":
		scene = preload("res://adjustableChair.tscn")

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
	var scene = preload("res://Chair.tscn")
		
	PlayerState.inventory = []
	var item = scene.instantiate()
	item.position =  position
	item.rotation = rotation
	add_child(item)
	PlayerState.placing_item = false

func show_inventory():
	SignalBus.show_inventory.emit()
