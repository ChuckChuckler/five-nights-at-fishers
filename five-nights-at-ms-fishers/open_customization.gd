extends Button

@onready var customize_screens = [$"../../fang_info",$"../../idk_info",$"../../idk_info2",$"../../banajit_info"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _open_screen() -> void:
	$"../../../click".play()
	customize_screens[$".".get_meta("index")].visible=true


func _on_back_pressed() -> void:
	$"../../../click".play()
	customize_screens[$".".get_meta("index")].visible=false
