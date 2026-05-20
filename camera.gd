extends Camera3D

var is_anim_running:bool = false

var is_going_right:bool = false
var is_going_left:bool = false

var is_on_right:bool = false
var is_on_left:bool = false

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
			is_going_right = true
			
			if is_on_left: #center if so
				is_on_left=false
				tween.tween_property(self, "rotation_degrees:y", 0, 1.5)
				tween.tween_callback(func():
					tween.kill()
					is_going_right=false
					is_on_right=false
				)
				
			else: #alll the way to the right
				tween.tween_property(self, "rotation_degrees:y", -75.3,2)
				tween.tween_callback(func():
					tween.kill()
					is_going_right=false
					is_on_right=true
				)
		elif cursor_x <= 100 and cursor_x >= 0 and !is_going_left:
			var tween = create_tween()
			is_going_left = true
			
			if is_on_right: #center...
				is_on_right=false
				tween.tween_property(self, "rotation_degrees:y", 0, 1.5)
				tween.tween_callback(func():
					tween.kill()
					is_going_left=false
					is_on_left=false
				)
				
			else: #slideee to the left
				tween.tween_property(self, "rotation_degrees:y", 75.3,2)
				tween.tween_callback(func():
					tween.kill()
					is_going_left=false
					is_on_left=true
				)
