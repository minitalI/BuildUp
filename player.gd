extends CharacterBody2D

var touching_ground = false
@export var run_speed = 350
@export var jump_speed = -1000
@export var gravity = 2500
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_input(delta):
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	var duck = Input.is_action_pressed('duck')
	var run = Input.is_action_pressed("run")
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor() and jump:
		velocity.y = jump_speed
		
	if right:
		velocity.x += run_speed
		if not ($AnimatedSprite2D.animation == "jump" and not is_on_floor()):
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.play()
		
	if left:
		velocity.x -= run_speed
		if not ($AnimatedSprite2D.animation == "jump" and not is_on_floor()):
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.play()
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		
	if velocity == Vector2(0,0):
		$AnimatedSprite2D.animation = "idle"
	else:
		time = 0
		
	if velocity.y != 0:
		$AnimatedSprite2D.animation = "jump"
	
	if time >= 30:
		$AnimatedSprite2D.animation = "sit"
	# okay cool character body, how do we get it to detect walls
	
	# something about the run animation isn't sitting right with me. its either too static or too move-y
	# like with the alt #2 sprite, it looks like they are dancing.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	# check if not touching ground, if so add like 10 to velocity.y
	get_input(delta)
	move_and_slide()
# this needs to be changed to detect only ground, but works for now. 
