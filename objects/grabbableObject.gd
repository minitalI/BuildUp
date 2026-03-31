extends StaticBody2D
var time_since_hovered = 0
var grabbed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time_since_hovered > (delta * 2):
		if self != null:
			if $AnimatedSprite2D != null:
				$AnimatedSprite2D.animation = "default"
		# collisions are only detected when you are actively moving at the object, not good. 
	time_since_hovered += delta

func grab():
	if grabbed != true:
		if GameManager.objects_left > 0:
			print("aur naur yew grabbed mey!!")
			# okay, how do we make the inventory work
			# currently, it is a variable in playerInfo
			# this makes sense.
			# i think it ought to be a scene called inventory, and it references the script
			# lets say you have to push a button to bring it up, and then it goes through the list of 
			# items in the player's inventory.
			# then you click it and then place it. 
			# which blows because that's harder to do.
			PlayerState.inventory.append(self.name)
			grabbed = true
			GameManager.objects_grabbed += 1
			GameManager.object_limits[GameManager.level - 1] -= 1
			GameManager.objects_left -= 1
			self.queue_free()

func show_hovered():
	time_since_hovered = 0
	$AnimatedSprite2D.animation = "hovered"
	$AnimatedSprite2D.play()
# also, there should be multiple screens to the left and right.
# like if you go all the way to the left, it pans and reveals the new area. 
