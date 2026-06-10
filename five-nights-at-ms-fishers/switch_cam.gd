extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _switch_to_this_cam() -> void:
	$"../../cam_switch".play()
	$"../../../game_manager".switch_cams(get_meta("index"), get_meta("name"))
