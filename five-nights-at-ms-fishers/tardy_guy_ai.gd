extends Sprite3D
var difficulty=15

const TIME_MAX=40
var time_min=40

var game_stopped=false

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
	if !game_stopped:
		$running_rapidly.volume_db=-80
		if !$"../wall_right/toggle_door".door_down:
			if !$"../jumps care".visible:
				$"../cameras".visible=false
				$"../jumps care".visible=true
				$"../jumps care/tardy".visible=true
				$"../jumps care/boom".play()
				$"../jumps care/jumps care timer".start()
				game_stopped=true
		else:
			$thud.play()
			$".".position=Vector3(-40.77,0,0)
			$appearance.start()


func _trigger_grace_period() -> void:
	if !game_stopped:
		$running_rapidly.volume_db=0
		$ding.play()
		$running_rapidly.play()
		$".".position=Vector3(-40.77,0,0)
		$grace.start()
