extends CharacterBody2D

var touching_ground = false

@export var run_speed = 350
@export var jump_speed = -1000
@export var gravity = 2500
var coyote = 10

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
		PlayerState.off_floor_time += delta
	
	if is_on_floor():
		PlayerState.off_floor_time = 0
		
	if PlayerState.off_floor_time < delta * coyote and jump:
		velocity.y += jump_speed * Input.get_action_strength("jump")
		
	elif "Double Jump" in PlayerState.inventory:
		velocity.y = jump_speed

	if right:
		velocity.x += run_speed

	if left:
		velocity.x -= run_speed
	
	if run: 
		velocity.x *= 1.1
	
	if duck:
		if velocity.y > 0:
			velocity.y *= 1.1
	var item_hovered = false
	
	for scene in get_tree().get_nodes_in_group("grabbable objects"):
		var distance_difference = (scene.position.x - self.position.x)
		var distance_differencey = (scene.position.y - self.position.y)
		if (distance_difference <= 75 and distance_difference >= 0) or (distance_difference <= 0 and distance_difference >= -75):
			if distance_differencey <= 100 and distance_differencey >= -20:
				scene.show_hovered()
				item_hovered = true
				
				if grab and PlayerState.placing_item == false and GameManager.in_menu == false:
					scene.grab()
					
	if is_on_wall_only():
					if jump:
						velocity = Vector2(run_speed*10, jump_speed / 2)
						$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
						
						
	if grab and item_hovered == false:
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
	get_input(delta)
	do_animations()
	move_and_slide()
	PlayerState.position = position
	
	# check collision
