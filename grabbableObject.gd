extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("input_pickable", true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	print("mouse entered great job")
	# change sprite outline. 

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		print("Wow you clicked me!")
		# grab the thing. 

# or should it be like, if they are next to it and press c or smthn, it picks up?
# that kinda seems better, so you have to explore the scene before climbing.
# also, there should be multiple screens to the left and right.
# like if you go all the way to the left, it pans and reveals the new area. 
