extends Node

var alt_music: bool
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stop_songs():
	for kid in get_tree().get_nodes_in_group("Music"): 
		kid.stop()
		
func play_song(song_type):
	
	match song_type:
	#	"Up and Up":
	#		if $"Up and Up!".playing == false:
	#			$"Up and Up!".play()
	#	"Leap of Faith":
	#		if $"Leap of Faith".playing == false:
	#			$"Leap of Faith".play()
	#	"Impending Doom?!":
	#		if $"Impending Doom?!".playing == false:
	#			$"Impending Doom?!".play()
	#	"Menu-chan's Theme":
	#		if $"Menu-chan's Theme (Is it Love?)".playing == false:
	#			$"Menu-chan's Theme (Is it Love?)".play()
	#	"Menu-chan's Animosity":
	#		if $"Menu-chan's Animosity".playing == false:
	#			$"Menu-chan's Animosity".play()
	
		"Main":
			if $"Up and Up!".playing == false and alt_music == false:
				stop_songs()
			
				$"Up and Up!".play()
				print("played upn up")
				
			if alt_music and $"Impending Doom?!".playing == false:
					stop_songs()
					$"Impending Doom?!".play()
					
		"Final":
			if $"Leap of Faith".playing == false:
				stop_songs()
				$"Leap of Faith".play()
			
		"Menu":
			if $"Menu-chan's Theme (Is it Love?)".playing == false and alt_music == false:
				stop_songs()
				$"Menu-chan's Theme (Is it Love?)".play()
				print("Played menu chan")
				
			if alt_music and $"Menu-chan's Animosity".playing == false:
				stop_songs()
				$"Menu-chan's Animosity".play()

func play_sfx(effect):
	match effect:
		"Click":
			$Click.play()
		"Grab":
			$Grab.play()
		"Place":
			$Place.play()
		"Fall":
			$Fall.play()
