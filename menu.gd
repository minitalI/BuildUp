extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.buttons_appear.emit()
	SignalBus.show_menu.connect(_on_show_menu)
	z_index = 2
	AudioManager.play_song("Menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_show_menu():
	AudioManager.play_song("Menu")
	$Audio/AltMusic.button_pressed = AudioManager.alt_music
	GameManager.in_menu = not GameManager.in_menu
	set_deferred("visible", not visible)
	
	# this seems like a potential eventual problem child wee woo eww woo
	if visible == true: # this also does not make sense why thats how it works but this works properly
		AudioManager.play_song("Main")


func _on_reset_level_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	GameManager.reset_level(null)


func _on_gameplay_pressed() -> void:
	# make this better when you have the time
	AudioManager.play_sfx("Click")
	var kids = $Audio.get_children()
	for kid in kids:
		kid.set_deferred("visible", false)
		
	kids = $Controls.get_children()
	for kid in kids:
		kid.set_deferred("visible", false)

		
	kids = $Gameplay.get_children()
	for kid in kids:
		kid.set_deferred("visible", true)


func _on_level_1_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	GameManager.reset_level(1)

func _on_level_2_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	GameManager.reset_level(2)
	
	
func _on_level_3_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	GameManager.reset_level(3)

func _on_level_4_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	GameManager.reset_level(4)

func _on_visibility_changed() -> void:
	print("wow this is useless im not using it")
	#GameManager.in_menu = not GameManager.in_menu


func _on_main_menu_pressed() -> void:
	AudioManager.play_sfx("Click")
	GameManager.quit_to_menu()


func _on_audio_pressed() -> void:
	AudioManager.play_sfx("Click")
	var kids = $Gameplay.get_children()
	for kid in kids:
		kid.set_deferred("visible", false)
		
	kids = $Controls.get_children()
	for kid in kids:
		kid.set_deferred("visible", false)
	
	kids = $Audio.get_children()
	for kid in kids:
		kid.set_deferred("visible", true)

func _on_alt_music_toggled(toggled_on: bool) -> void:
	AudioManager.play_sfx("Click")
	if toggled_on:
		AudioManager.alt_music = true
	else:
		AudioManager.alt_music = false
	AudioManager.play_song("Menu")


func _on_controls_pressed() -> void:
	AudioManager.play_sfx("Click")
		# make this better when you have the time
	var kids = $Audio.get_children()
	for kid in kids:
		kid.set_deferred("visible", false)
		
	kids = $Gameplay.get_children()
	for kid in kids:
		kid.set_deferred("visible", false)

		
	kids = $Controls.get_children()
	for kid in kids:
		kid.set_deferred("visible", true)


func _on_level_5_pressed() -> void:
	AudioManager.play_sfx("Click")
	await get_tree().process_frame
	GameManager.reset_level(5)
