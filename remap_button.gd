extends Button
class_name RemapButton

@export var action: String
var default_inputs = {}
var inputs = []

func _init():
	toggle_mode = true
	theme_type_variation = "RemapButton"


func _ready():
	#for input in InputMap.
	print(InputMap.get_actions())
	var i = 0
	for input in InputMap.get_actions():
		i += 1
		# the number of built in actions there are is 85
		if i >= 82:
			inputs.append(input)
			
	for input in inputs:
		default_inputs[input] = InputMap.action_get_events(input)[0].as_text()
		
	set_process_unhandled_input(false)
	update_key_text()


func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		text = "... AWAITING INPUT ..."
		release_focus()
	else:
		update_key_text()
		grab_focus()


func _unhandled_input(event):
	if event.pressed:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		button_pressed = false


func update_key_text():
	text = "%s" % str(InputMap.action_get_events(action)[0].as_text().to_upper())
