extends Camera3D

const VELOCITY:float=5

@onready var TAR_1:float=get_meta("TAR_1")
@onready var TAR_2:float=get_meta("TAR_2")

var current_target:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_target=TAR_1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees.y=move_toward(rotation_degrees.y,current_target,delta*VELOCITY)
	if is_equal_approx(rotation_degrees.y, TAR_1) and current_target==TAR_1:
		current_target=TAR_2
	elif is_equal_approx(rotation_degrees.y, TAR_2) and current_target==TAR_2:
		current_target=TAR_1
