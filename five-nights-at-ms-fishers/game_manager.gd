extends Node3D

var current_hour:int=0

const START_POWER:float=1000.0
var current_power:float=1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _next_hour() -> void:
	current_hour+=1
	$"../gui/time".text=str(current_hour)+" AM"


func _timeout_counter() -> void:
	current_power-=$"../gui/usage_bar_container".power_sources
	$"../gui/power_left".text="Power left: " + str(int(current_power/START_POWER*100)) + " %"
