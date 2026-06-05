extends Node3D

var current_hour:int=0

const START_POWER:float=1000.0
var current_power:float=1000.0

@onready var rooms = [$"../classroom_a",$"../classroom_b",$"../lobby",$"../classroom_d",$"../classroom_e",$"../tardy_office", $"../hallway_1", $"../hallway_2A", $"../hallway_2B",$"../hallway_3"]
@onready var cams = [$"../classroom_a".get_node("SubViewport"), $"../classroom_b".get_node("SubViewport"),$"../lobby".get_node("SubViewport"),$"../classroom_d".get_node("SubViewport"),$"../classroom_e".get_node("SubViewport"),$"../tardy_office".get_node("SubViewport"),$"../hallway_1".get_node("SubViewport"),$"../hallway_2A".get_node("SubViewport"),$"../hallway_2B".get_node("SubViewport"),$"../hallway_3".get_node("SubViewport")]

@onready var cam_display = $"../cameras/cam1"

var current_room=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam_display.texture=cams[current_room].get_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _next_hour() -> void:
	current_hour+=1
	$"../gui/time".text=str(current_hour)+" AM"


func _timeout_counter() -> void:
	current_power-=$"../gui/usage_bar_container".power_sources
	$"../gui/power_left".text="Power left: " + str(int(current_power/START_POWER*100)) + " %"


func _open_camera() -> void:
	if !$"../cameras".visible:
		if $"../gui/usage_bar_container".power_sources<$"../gui/usage_bar_container".TOTAL_POWER_SOURCES:
			$"../cameras".visible=true
			$"../gui/usage_bar_container".power_sources+=1
	else:
		$"../cameras".visible=false
		$"../gui/usage_bar_container".power_sources-=1
		
func switch_cams(index:int, room_name:String)->void:
	current_room=index
	cam_display.texture=cams[current_room].get_texture()
	$"../cameras/place_name".text=room_name
