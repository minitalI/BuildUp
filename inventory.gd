extends Control

var shown = false
var items = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.show_inventory.connect(load_inventory)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shown == true:
		for item in items:
			if item != null:
				item.queue_free()
		items = []
		
		var scene = preload("res://objects/grabbableObject.tscn")
		var i = 0
		for item_name in PlayerState.inventory:
			if item_name == null:
				PlayerState.inventory.remove_at(i)
		i = 0
		
		for item_name in PlayerState.inventory:
			match item_name:
				"chair":
					scene = preload("res://objects/chair/chair.tscn")
				"table":
					scene = preload("res://objects/table/table.tscn")
				"filing cabinet":
					pass
			var item = scene.instantiate()
			item.position = Vector2(1110 - (int((i/10))*10), 40 + (i * 100))
			add_child(item)
			items.append(item)
			i += 1
		

func load_inventory():
	if shown == false:
		var scene = preload("res://objects/grabbableObject.tscn")
		var i = 0
		
		for item_name in PlayerState.inventory:
			match item_name:
				"chair":
					scene = preload("res://objects/chair/chair.tscn")
				"table":
					scene = preload("res://objects/table/table.tscn")
				"filing cabinet":
					pass
					
			var item = scene.instantiate()
			item.position = Vector2(1110 - (int((i/10))*10), 40 + (i * 100))
			add_child(item)
			items.append(item)
			i += 1
		shown = true
			
	else:
		for item in items:
			if item != null:
				item.queue_free()
		items = []
		shown = false
		
