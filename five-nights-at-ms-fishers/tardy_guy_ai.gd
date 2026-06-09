extends Sprite3D
var difficulty=1

const TIME_MAX=50
var time_min=40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if difficulty>0 and difficulty<=5:
		time_min=45
		$kill.wait_time=20
	elif difficulty>5 and difficulty<=10:
		time_min=40
		$kill.wait_time=17
	elif difficulty>10 and difficulty<=15:
		time_min=30
		$kill.wait_time=13
	else:
		time_min=20
		$kill.wait_time=10
	
	generate_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func generate_time():
	$appearance.wait_time=randi_range(time_min, TIME_MAX)
	$appearance.start()
	


func _go_in_hall() -> void:
	$".".position=$"../tardy_hall_spawn/tardy_spawn".position
	$".".rotation_degrees.y=$"../tardy_hall_spawn/tardy_spawn".rotation_degrees.y
	$kill.start()


func _on_kill_timeout() -> void:
	if !$"../wall_right/toggle_door".door_down:
		$"../game_manager".trigger_game_over()
	else:
		$".".position=Vector3(-40.77,0,0)
		$appearance.start()


func _trigger_grace_period() -> void:
	$".".position=Vector3(-40.77,0,0)
	$grace.start()
