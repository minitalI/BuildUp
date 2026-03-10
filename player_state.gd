extends Node
var inventory = []
var inventory_location = 0
var placing_item = false
var objects_grabbed = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_inventory_location(num):
	inventory_location = num

func get_adjustable_inventory_item():
	var scene = null
	if inventory_location >= inventory.size():
		set_inventory_location(0)
		
	if inventory != []:
		match inventory[inventory_location]:
				"chair":
					scene = preload("res://objects/chair/adjustableChair.tscn")
				"table":
					scene = preload("res://objects/table/adjustableTable.tscn")
					
	return scene
	
func get_inventory_item():
	var scene = null
	if inventory_location >= inventory.size():
		set_inventory_location(0)
		
	if inventory != []:
		match inventory[inventory_location]:
				"chair":
					scene = preload("res://objects/chair/chair.tscn")
				"table":
					scene = preload("res://objects/table/Table.tscn")
	return scene
	
func remove_item_from_inventory():
	inventory.remove_at(inventory_location)
	set_inventory_location(0)
