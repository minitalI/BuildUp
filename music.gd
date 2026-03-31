extends HSlider

@export var bus_name: String = "Master"

var bus_index: int
var number: int

func _ready() -> void:
	print(AudioServer.bus_count)
	bus_index = AudioServer.get_bus_index(bus_name)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
func _on_value_changed(value: float) -> void:
	number = value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_changed() -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
