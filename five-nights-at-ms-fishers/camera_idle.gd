extends Camera3D

const VELOCITY:float=5

const TAR_1:float=91.4
const TAR_2:float=113.6

var current_target:float=TAR_1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees.y=move_toward(rotation_degrees.y,current_target,delta*VELOCITY)
	if rotation_degrees.y-TAR_1<1 and current_target==TAR_1:
		current_target=TAR_2
	elif TAR_2-rotation_degrees.y<1 and current_target==TAR_2:
		current_target=TAR_1
