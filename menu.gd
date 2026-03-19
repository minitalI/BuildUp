extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.show_menu.connect(_on_show_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_show_menu():
	set_deferred("visible", not visible)
	


func _on_reset_level_pressed() -> void:
	# now that i think of this probably this should be done in game manager
	var objects = get_tree().get_nodes_in_group("grabbable objects")
	for object in objects:
		object.queue_free()
	
	var i = 0
	for object in GameManager.static_object_limits:
		GameManager.object_limits[i] = object
		i += 1
	get_tree().reload_current_scene()
	GameManager.set_object_limit()
	# okay well we want to get rid of the placed objects and then also reset object limits
	# so we may have to do this manually
	# groups! we can use groups to free each grabbable object, then reload. 


func _on_gameplay_pressed() -> void:
	pass # Replace with function body.
