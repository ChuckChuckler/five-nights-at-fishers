extends Camera3D

var is_anim_running:bool = false

var is_going_right:bool = false
var is_going_left:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var screen_x:float=get_viewport().get_visible_rect().size.x
	var cursor_x:float=get_viewport().get_mouse_position().x
	if cursor_x >= 0 and cursor_x <= screen_x:
		if cursor_x >= screen_x-100 and cursor_x <= screen_x and !is_going_right:
			var tween = create_tween()
			tween.tween_property(self, "rotation_degrees:y", -75.3,2)
			is_going_right = true
			tween.tween_callback(func():
				tween.kill()
				is_going_right=false
			)
		elif cursor_x <= 100 and cursor_x >= 0 and !is_going_left:
			var tween = create_tween()
			tween.tween_property(self, "rotation_degrees:y", 75.3,2)
			is_going_left = true
			tween.tween_callback(func():
				tween.kill()
				is_going_left=false
			)
