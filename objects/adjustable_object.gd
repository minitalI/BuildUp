extends StaticBody2D

var ADJUSTMENT_VECTOR = .01
var position_adjusted = false
var rotation_adjusted = false
var placed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position_adjusted == false:
		adjust_position()

	elif rotation_adjusted == false:
		adjust_rotation()
	
	if position_adjusted and rotation_adjusted and placed == false:
		# timer so that grab doesn't make it so that you also make place another item 
		await get_tree().create_timer(.01).timeout
		
		GameManager.place_item(self.position, self.rotation)
		placed = true
		self.queue_free()
	
func adjust_position():
		
	position = Vector2(get_viewport().get_mouse_position().x - (get_viewport().size.x * (GameManager.x_modifier)), get_viewport().get_mouse_position().y - (get_viewport().size.y * (GameManager.y_modifier)))
		
	if Input.is_action_just_pressed("grab"):
		position_adjusted = true
	
	if Input.is_action_just_pressed("exit"):
		PlayerState.inventory.append(self.name)
		self.queue_free()
	
	if Input.is_action_just_pressed("next"):
		PlayerState.set_inventory_location(PlayerState.inventory_location + 1)
		GameManager.blueprint_item()
		self.queue_free()
		
	if Input.is_action_just_pressed("instant place"):
		GameManager.place_item(self.position, self.rotation)
		self.queue_free()
		
func adjust_rotation():
	var right = Input.is_action_pressed("rotate right")
	var left = Input.is_action_pressed("rotate left")
	var superright = Input.is_action_pressed("super rotate right")
	var superleft = Input.is_action_pressed(("super rotate left"))
	
			
	if superright:
		rotation += ADJUSTMENT_VECTOR * 2
	if superleft:
		rotation -= ADJUSTMENT_VECTOR * 2

	if right:
		rotation += ADJUSTMENT_VECTOR
	if left:
		rotation -= ADJUSTMENT_VECTOR
		
	if Input.is_action_just_pressed("grab"):
		rotation_adjusted = true
		
	if Input.is_action_just_pressed("quit"):
		position_adjusted = false
		rotation_adjusted = false
		
