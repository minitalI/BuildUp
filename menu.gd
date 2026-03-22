extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.show_menu.connect(_on_show_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	z_index = 2

func _on_show_menu():
	set_deferred("visible", not visible)
	GameManager.in_menu = not GameManager.in_menu
	


func _on_reset_level_pressed() -> void:
	# now that i think of this probably this should be done in game manager
	GameManager.in_menu = false
	GameManager.reset_level()
	# okay well we want to get rid of the placed objects and then also reset object limits
	# so we may have to do this manually
	# groups! we can use groups to free each grabbable object, then reload. 


func _on_gameplay_pressed() -> void:
	pass # Replace with function body.
