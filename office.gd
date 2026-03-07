extends Control

# we need multiple things for this bad boy.
# first, we need to be able to change shorts. for simplicity, this could be done by just having 
# several mostly identical scenes we switch between, with the layout premade. the other option is to
# make and unmake the obstacles each time the short is switched.
# the trigger should be easy, since there is ltierally a button for that; play the animation, when the things go offscreeen,
# unmake them, then make the new ones

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
