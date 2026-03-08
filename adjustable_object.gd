extends StaticBody2D

var ADJUSTMENT_VECTOR = .01
var position_adjusted = false
var rotation_adjusted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position_adjusted == false:
		adjust_position()

	elif rotation_adjusted == false:
		adjust_rotation()
	
	if position_adjusted and rotation_adjusted:
		GameManager.place_item(self.position, self.rotation)
	
func adjust_position():
	position = get_viewport().get_mouse_position()
		
	if Input.is_action_just_pressed("grab"):
		position_adjusted = true
	
	if Input.is_action_just_pressed("exit"):
		self.queue_free()
		
func adjust_rotation():
	var right = Input.is_action_pressed("rotate right")
	var left = Input.is_action_pressed("rotate left")
	
	if right:
		rotation += ADJUSTMENT_VECTOR
	if left:
		rotation -= ADJUSTMENT_VECTOR
		
	if Input.is_action_just_pressed("grab"):
		rotation_adjusted = true
		
	if Input.is_action_pressed("quit"):
		position_adjusted = false
		rotation_adjusted = false
		
