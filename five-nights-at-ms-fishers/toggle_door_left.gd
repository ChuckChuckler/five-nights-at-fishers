extends StaticBody3D

var door_down=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _toggle_door_open_closed(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT and event.pressed:
		$"../../fang2".door_triggered()
		if !door_down:
			if $"../../gui/usage_bar_container".power_sources<$"../../gui/usage_bar_container".TOTAL_POWER_SOURCES:
				create_tween().tween_property($"../../door_left", "position", Vector3($"../../door_left".position.x, 1.828, $"../../door_left".position.z),1)
				$"../../gui/usage_bar_container".power_sources+=1
				door_down=true
		else:
			create_tween().tween_property($"../../door_left", "position", Vector3($"../../door_left".position.x, 6.589, $"../../door_left".position.z),1)
			$"../../gui/usage_bar_container".power_sources-=1
			door_down=false
