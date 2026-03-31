extends Control

var area_type = "Main"
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	AudioManager.play_song(area_type)
	var scene = preload("res://player.tscn")
	var player = scene.instantiate()
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# hopefully this just works, cant test rn.
	if $Player.position.x < 0:
		$Camera2D.position = Vector2(-(get_viewport().size.x / 2), get_viewport().size.y / 2 + (0 - get_viewport().size.y * (GameManager.y_modifier)))
		$GUI.position = Vector2(-get_viewport().size.x, -(get_viewport().size.y * (GameManager.y_modifier)))
		
	if $Player.position.x > 0:
		$Camera2D.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2 + (0 - get_viewport().size.y * ((GameManager.y_modifier) * 2)) / 2)
		$GUI.position = Vector2(0, -(get_viewport().size.y * GameManager.y_modifier))
		
	if $Player.position.x > get_viewport().size.x:
		$Camera2D.position = Vector2(get_viewport().size.x + (get_viewport().size.x / 2),  get_viewport().size.y / 2 + (0 - get_viewport().size.y * GameManager.y_modifier))
		$GUI.position = Vector2(get_viewport().size.x, -(get_viewport().size.y * GameManager.y_modifier))

# things left to do:


# bugs to fix:
# adding ctrl to what you are holding does not make it super rotate, you have to stop your rotation and then start again
# if the player lands somewhere where they are standing in the level checkpoint, they will level up

# polish to add:
# make the walls in the middle of the office like doors, floor to cieling, with a gap for a vent, or something of the sort
# make in between animations
# standardize the height of rooms, where the floor goes down into each room, how far the walls are, ect.
