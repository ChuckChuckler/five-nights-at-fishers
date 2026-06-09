extends Sprite3D

@onready var spawn_e = $"../spawns_e/fang_spawn"
var level:float=22.0
var time_wait:float=(-0.78*level)+20
var time_before_disappear:float=0.368421*level+2.63158

var time_passed:int=0
var compare_time:int=0

var current_area:String="classroom e"

var fangs_door_closed:bool=false

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
		[$"../spawns_hallway_5a/fang_spawns/spawn_1","hallway 5a from stairs"]
	],
	"hallway 5a from stairs":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b"],
		[$"../spawns_hallway_5a/fang_spawns/spawn_3","hallway 5a to 5c"]
	],
	"hallway 5a to 5b":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_1","hallway 5b entrance"]
	],
	"hallway 5b entrance":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_2", "hallway 5b to classroom d"],
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b guaranteed return"]
	],
	"hallway 5a to 5b guaranteed return":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_1","hallway 5a from stairs guaranteed 5c"]
	],
	"hallway 5b to classroom d":[
		[$"../spawns_classroom_d/fang_spawn", "classroom d"]
	],
	"classroom d":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_2", "hallway 5b to classroom d guaranteed return"]
	],
	"hallway 5b to classroom d guaranteed return":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_1", "hallway 5b entrance guaranteed return"]	
	],
	"hallway 5b entrance guaranteed return":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b guaranteed return"]
	],
	"hallway 5a from stairs guaranteed 5c":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_3","hallway 5a to 5c"]
	],
	"hallway 5a to 5c":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_1","hallway 5c entrance"]
	],
	"hallway 5c entrance":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_2","hallway 5c towards 6"],
		[$"../spawns_classroom_a/fang_spawn", "classroom a"]
	],
	"classroom a":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_1","hallway 5c entrance guaranteed 6"]
	],
	"hallway 5c entrance guaranteed 6":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_2","hallway 5c towards 6"],
	],
	"hallway 5c towards 6":[
		[$"../spawns_hallway_4/fang_spawns/spawn_1","hallway 6 entrance"]
	],
	"hallway 6 entrance":[
		[$"../spawns_hallway_4/fang_spawns/spawn_2","hallway 6 to office"]
	],
	"hallway 6 to office":[
		[$"../spawns_office/spawns_left/fang_spawns/outside_door", "outside left door"]
	],
	"outside left window":[
		[$"../spawns_office/spawns_left/fang_spawns/outside_window", "outside left window"]
	],
	"outside left door":[
		[$"../spawns_office/spawns_left/fang_spawns/outside_door", "no"]
	],
	"door to right staircase":[
		[$"../spawns_hallway_2/fang_spawns/spawn_1","hallway 2a to stairs"]
	],
	"hallway 2a to stairs":[
		[$"../spawns_hallway_2/fang_spawns/spawn_2","hallway 2a to hall 2b"]
	],
	"hallway 2a to hall 2b":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_1","hallway 2b entrance"]
	],
	"hallway 2b entrance":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_2","hallway 2b towards hallway 3"],
	],
	"hallway 2b towards hallway 3":[
		[$"../spawns_b/fang_spawn","class b"],
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1"]
	],
	"class b":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_2", "hallway 2b towards hallway 3 guaranteed"]
	],
	"hallway 2b towards hallway 3 guaranteed":[
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1"]
	],
	"hallway 3 spawn 1":[
		[$"../spawns_hallway_3/fang_spawns/spawn_2","hallway 3 spawn 2"]
	],
	"hallway 3 spawn 2":[
		[$"../spawns_office/spawns_right/fang_spawns/outside_door","outside right door"],
	],
	"outside right window":[
		[$"../spawns_office/spawns_right/fang_spawns/outside_window","outside right window"],
	],
	"outside right door":[
		[$"../spawns_office/spawns_right/fang_spawns/outside_door", "no"]
	]
}
func _ready() -> void:
	$".".position=Vector3(spawn_e.position.x, spawn_e.position.y, spawn_e.position.z)
	compare_time=Time.get_ticks_msec()

func _process(delta: float) -> void:
	time_passed=Time.get_ticks_msec()-compare_time
	if current_area!="outside right door" and current_area!="outside left door":
		if time_passed/1000.0 >= time_wait-0.5 and time_passed/1000.0<=time_wait+0.5:
			compare_time=Time.get_ticks_msec()
			time_passed=0
			var moves = randi_range(1,3)<=2
			#var moves=true
			if moves:
				var chosen_move = routes[current_area][randi_range(0,routes[current_area].size()-1)]
				if chosen_move[1]!="no":
					$".".position=Vector3(chosen_move[0].position.x, chosen_move[0].position.y, chosen_move[0].position.z)
					current_area=chosen_move[1]
						
			else:
				print_debug("fang does not move")
	else:
		if ($"../wall_right/toggle_door".door_down and current_area=="outside right door") || ($"../wall_left/toggle_door".door_down and current_area=="outside left door"):
			fangs_door_closed=true
			if time_passed/1000.0 >= time_before_disappear-0.5 and time_passed/1000.0<=time_before_disappear+0.5:
				compare_time=Time.get_ticks_msec()
				time_passed=0
				current_area="classroom e"
				print_debug("he is gone..")
				$".".position=Vector3(spawn_e.position.x, spawn_e.position.y, spawn_e.position.z)
		else:
			fangs_door_closed=false
			if time_passed/1000.0 >= (time_wait*2)-0.5 and time_passed/1000.0<=(time_wait*2)+0.5:
				compare_time=Time.get_ticks_msec()
				time_passed=0
				print_debug("YOU ARE DEAD ELELELE")
				time_wait=-1

func door_triggered():
	time_passed=0
	compare_time=Time.get_ticks_msec()
	if current_area=="outside right door":
		if !$"../wall_right/toggle_door".door_down:
			$".".position=Vector3(routes["outside right window"][0][0].position.x, routes["outside right window"][0][0].position.y, routes["outside right window"][0][0].position.z)
		else:
			$".".position=Vector3(routes["outside right door"][0][0].position.x, routes["outside right door"][0][0].position.y, routes["outside right door"][0][0].position.z)
	elif current_area=="outside left door":
		if !$"../wall_left/toggle_door".door_down:
			$".".position=Vector3(routes["outside left window"][0][0].position.x, routes["outside left window"][0][0].position.y, routes["outside left window"][0][0].position.z)
		else:
			$".".position=Vector3(routes["outside left door"][0][0].position.x, routes["outside left door"][0][0].position.y, routes["outside left door"][0][0].position.z)
