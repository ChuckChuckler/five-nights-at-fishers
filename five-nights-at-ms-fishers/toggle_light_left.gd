extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _toggle_light_on_off(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		$click.play()
		if !$"../../door_light_left".visible:
			if $"../../gui/usage_bar_container".power_sources<$"../../gui/usage_bar_container".TOTAL_POWER_SOURCES:
				$"../fake_shadow".visible=false
				$"../../door_light_left".visible=true
				$"../../gui/usage_bar_container".power_sources+=1
				$"../../fang2".left_light_triggered(2)
				$"../../fang3".left_light_triggered(3)
		else:
			$"../fake_shadow".visible=true
			$"../../door_light_left".visible=false
			$"../../gui/usage_bar_container".power_sources-=1
			
