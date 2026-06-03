extends Sprite3D

@onready var spawn_e = $"../spawns_e/fang_spawn"
var level:float=20.0
var time_wait:float=(-0.78*level)+20

var time_passed:int=0
var compare_time:int=0

var current_area:String="classroom e"

@onready var routes={
	"classroom e":[
		[$"../spawns_hallway_1/fang_spawns/spawn_1","hallway 1 to e"]
	],
	"hallway 1 to e":[
		[$"../spawns_hallway_1/fang_spawns/spawn_2","hallway 1 from e"]
	],
	"hallway 1 from e":[
		[$"../spawns_lobby/fang_spawns/from_e","door to e"]
	],
	"door to e":[
		[$"../spawns_lobby/fang_spawns/to_staircase_left","door to left staircase"],
		[$"../spawns_lobby/fang_spawns/to_staircase_right","door to right staircase"],
	],
	"door to left staircase":[
		[$"../spawns_b/fang_spawn","no"]
	],
	"door to right staircase":[
		["idk", "no"]
	]
}
func _ready() -> void:
	$".".position=Vector3(spawn_e.position.x, spawn_e.position.y, spawn_e.position.z)
	compare_time=Time.get_ticks_msec()

func _process(delta: float) -> void:
	time_passed=Time.get_ticks_msec()-compare_time
	if time_passed/1000.0 >= time_wait-0.5 and time_passed/1000.0<=time_wait+0.5:
		compare_time=Time.get_ticks_msec()
		time_passed=0
		var moves = randi_range(1,3)<=2
		if moves:
			var chosen_move = routes[current_area][randi_range(0,routes[current_area].size()-1)]
			if chosen_move[1]!="no":
				$".".position=Vector3(chosen_move[0].position.x, chosen_move[0].position.y, chosen_move[0].position.z)
				current_area=chosen_move[1]
		else:
			print_debug("fang does not move")
