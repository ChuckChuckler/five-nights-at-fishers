extends Sprite3D

@onready var spawn_e = $"../spawns_e/fang_spawn"
var level:float=22.0
var time_wait:float=(-0.78*level)+20
var time_before_disappear:float=0.368421*level+2.63158

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
		#[$"../spawns_lobby/fang_spawns/to_staircase_left","door to left staircase"],
		[$"../spawns_lobby/fang_spawns/to_staircase_right","door to right staircase"],
	],
	"door to right staircase":[
		[$"../spawns_hallway_2/fang_spawns/spawn_1","hallway 2a to stairs"]
	],
	"hallway 2a to stairs":[
		[$"../spawns_hallway_2/fang_spawns/spawn_2","hallway 2a to hall 2b"]
	],
	"hallway 2a to hall 2b":[
		[$"../spawns_hallway_2b/fang_spawn","hallway 2b to class b"]
	],
	"hallway 2b to class b":[
		[$"../spawns_b/fang_spawn","class b"],
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1"]
	],
	"class b":[
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1"]
	],
	"hallway 3 spawn 1":[
		[$"../spawns_hallway_3/fang_spawns/spawn_2","hallway 3 spawn 2"]
	],
	"hallway 3 spawn 2":[
		[$"../spawns_office/spawns_right/fang_spawns/outside_door","outside right door"],
		[$"../spawns_office/spawns_right/fang_spawns/outside_window", "outside right window"]
	],
	"outside right window":[
		[$"../spawns_office/spawns_right/fang_spawns/outside_door","outside right door"],
	],
	"outside right door":[
		["ahh", "no"]
	],
	"door to left staircase":[
		["idk", "no"]
	]
}
func _ready() -> void:
	$".".position=Vector3(spawn_e.position.x, spawn_e.position.y, spawn_e.position.z)
	print_debug(time_before_disappear)
	compare_time=Time.get_ticks_msec()

func _process(delta: float) -> void:
	time_passed=Time.get_ticks_msec()-compare_time
	if current_area!="outside right door":
		if time_passed/1000.0 >= time_wait-0.5 and time_passed/1000.0<=time_wait+0.5:
			compare_time=Time.get_ticks_msec()
			time_passed=0
			#var moves = randi_range(1,3)<=2
			var moves=true
			if moves:
				var chosen_move = routes[current_area][randi_range(0,routes[current_area].size()-1)]
				if chosen_move[1]!="no":
					$".".position=Vector3(chosen_move[0].position.x, chosen_move[0].position.y, chosen_move[0].position.z)
					current_area=chosen_move[1]
						
			else:
				print_debug("fang does not move")
	else:
		if $"../wall_right/toggle_door".door_down:
			if time_passed/1000.0 >= time_before_disappear-0.5 and time_passed/1000.0<=time_before_disappear+0.5:
				compare_time=Time.get_ticks_msec()
				time_passed=0
				current_area="classroom e"
				$".".position=Vector3(spawn_e.position.x, spawn_e.position.y, spawn_e.position.z)
			
