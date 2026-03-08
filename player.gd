extends CharacterBody2D

var touching_ground = false

@export var run_speed = 350
@export var jump_speed = -1000
@export var gravity = 2500

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	run_speed = 350
	jump_speed = -1000
	gravity = 2500

func get_input(delta):
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	var duck = Input.is_action_pressed('duck')
	var run = Input.is_action_pressed("run")
	var grab = Input.is_action_just_pressed("grab")
	var inventory = Input.is_action_just_pressed("inventory")
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor() and jump:
		velocity.y = jump_speed

	if right:
		velocity.x += run_speed

	if left:
		velocity.x -= run_speed
	
	# weirdly, holding duck messes with your ability to jump and move in the air.
	# its somethign with accepting inputs rather than being a code issue. 
	
	if duck:
		if velocity.y > 0:
			velocity.y *= 1.1

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		# problems with displaying outline:
		# for some reason, it makes grab not grab
		# it does not leave after it changes to that outline; there is not a way to tell if the player has left.
		# perhaps grab the name of the collider, and then check next collision if thats in the list
		if collision.get_collider() != null:
			if collision.get_collider().has_method("show_hovered"):
				collision.get_collider().show_hovered()
					
			if grab:
				if collision.get_collider().has_method("grab"):
					collision.get_collider().grab()
					
				else:
					if PlayerState.inventory != [] and PlayerState.placing_item == false:
						GameManager.blueprint_item()
			if inventory:
				GameManager.show_inventory()



func do_animations():
	if velocity == Vector2(0,0):
		$AnimatedSprite2D.animation = "idle"
	else:
		# reset the sit timer
		time = 0
		
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		
	# jump first so it has precendence
	if velocity.y != 0:
		if Input.is_action_pressed("duck"):
			$AnimatedSprite2D.animation = "duck"
		else:
			$AnimatedSprite2D.animation = "jump"
		
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
	
	elif Input.is_action_pressed("duck"):
		$AnimatedSprite2D.animation = "duck"
			
	elif Input.is_action_pressed("grab"):
		$AnimatedSprite2D.animation = "grab"

	if time >= 30:
		$AnimatedSprite2D.animation = "sit"
		
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	time += delta
	# check if not touching ground, if so add like 10 to velocity.y
	get_input(delta)
	do_animations()
	move_and_slide()

# this needs to be changed to detect only ground, but works for now. 
