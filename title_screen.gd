extends Control
# or something to that effect.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_song("Menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_game_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	get_tree().change_scene_to_file("office.tscn")


func _on_options_pressed() -> void:
	AudioManager.play_sfx("Click")
	get_tree().change_scene_to_file("menu.tscn")


func _on_quit_game_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	get_tree().quit()
