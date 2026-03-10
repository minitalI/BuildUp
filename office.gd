extends Control

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.position.x < 0:
		$Camera2D.position = Vector2(-(get_viewport().size.x / 2), get_viewport().size.y / 2 + (0 - get_viewport().size.y * (GameManager.level - 1)))
		$GUI.position = Vector2(-get_viewport().size.x, -(get_viewport().size.y * (GameManager.level - 1)))
		
	if $Player.position.x > 0:
		$Camera2D.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2 + (0 - get_viewport().size.y * ((GameManager.level - 1) * 2)) / 2)
		$GUI.position = Vector2(0, -(get_viewport().size.y * (GameManager.level - 1)))
		
	if $Player.position.x > get_viewport().size.x:
		$Camera2D.position = Vector2(get_viewport().size.x + (get_viewport().size.x / 2),  get_viewport().size.y / 2 + (0 - get_viewport().size.y * (GameManager.level - 1)))
		$GUI.position = Vector2(get_viewport().size.x, -(get_viewport().size.y * (GameManager.level - 1)))
# things left to do:
# powers
# levels -- theres 2? 
# music
# sound effects
# background art
# make walls and floor look good.
# more items

# bugs to fix:
# adding ctrl to what you are holding does not make it super rotate, you have to stop your rotation and then start again
# currently no way to tell apart objects that have been placed already and ones that have just been grabbed, making the counter wrong.
# the borders mess up when the player is touching two items at once 
