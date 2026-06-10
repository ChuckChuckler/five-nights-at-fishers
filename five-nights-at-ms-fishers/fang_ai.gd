extends Sprite3D

@onready var spawn_e = $"../spawns_e/fang_spawn"
var level:float=1
var time_wait:float=(-0.315789*level+8.31579)*1.5
var time_before_disappear:float=0.368421*level+2.63158

var time_passed:int=0
var compare_time:int=0

var current_area:String="classroom e"
var current_index:int=4

var fangs_door_closed:bool=false

@onready var routes={
	"classroom e":[
		[$"../spawns_hallway_1/fang_spawns/spawn_1","hallway 1 to e",6]
	],
	"hallway 1 to e":[
		[$"../spawns_hallway_1/fang_spawns/spawn_2","hallway 1 from e",6]
	],
	"hallway 1 from e":[
		[$"../spawns_lobby/fang_spawns/from_e","door to e",2]
	],
	"door to e":[
		[$"../spawns_lobby/fang_spawns/to_staircase_left","door to left staircase",2],
		[$"../spawns_lobby/fang_spawns/to_staircase_right","door to right staircase",2],
	],
	"door to left staircase":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_1","hallway 5a from stairs",11]
	],
	"hallway 5a from stairs":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b",11],
		[$"../spawns_hallway_5a/fang_spawns/spawn_3","hallway 5a to 5c",11]
	],
	"hallway 5a to 5b":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_1","hallway 5b entrance",12]
	],
	"hallway 5b entrance":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_2", "hallway 5b to classroom d",12],
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b guaranteed return",11]
	],
	"hallway 5a to 5b guaranteed return":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_1","hallway 5a from stairs guaranteed 5c",11]
	],
	"hallway 5b to classroom d":[
		[$"../spawns_classroom_d/fang_spawn", "classroom d",3]
	],
	"classroom d":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_2", "hallway 5b to classroom d guaranteed return",12]
	],
	"hallway 5b to classroom d guaranteed return":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_1", "hallway 5b entrance guaranteed return",12]	
	],
	"hallway 5b entrance guaranteed return":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b guaranteed return",11]
	],
	"hallway 5a from stairs guaranteed 5c":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_3","hallway 5a to 5c",11]
	],
	"hallway 5a to 5c":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_1","hallway 5c entrance",13]
	],
	"hallway 5c entrance":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_2","hallway 5c towards 6",13],
		[$"../spawns_classroom_a/fang_spawn", "classroom a",0]
	],
	"classroom a":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_1","hallway 5c entrance guaranteed 6",13]
	],
	"hallway 5c entrance guaranteed 6":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_2","hallway 5c towards 6",13],
	],
	"hallway 5c towards 6":[
		[$"../spawns_hallway_6/fang_spawns/spawn_1","hallway 6 entrance",14]
	],
	"hallway 6 entrance":[
		[$"../spawns_hallway_6/fang_spawns/spawn_2","hallway 6 to office",14]
	],
	"hallway 6 to office":[
		[$"../spawns_office/spawns_left/outside_door", "outside left door",-1]
	],
	"outside left window":[
		[$"../spawns_office/spawns_left/outside_window", "outside left window",-1]
	],
	"outside left door":[
		[$"../spawns_office/spawns_left/outside_door", "no",-1]
	],
	"door to right staircase":[
		[$"../spawns_hallway_2/fang_spawns/spawn_1","hallway 2a to stairs",7]
	],
	"hallway 2a to stairs":[
		[$"../spawns_hallway_2/fang_spawns/spawn_2","hallway 2a to hall 2b",7]
	],
	"hallway 2a to hall 2b":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_1","hallway 2b entrance",8]
	],
	"hallway 2b entrance":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_2","hallway 2b towards hallway 3",8],
	],
	"hallway 2b towards hallway 3":[
		[$"../spawns_b/fang_spawn","class b",1],
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1",9]
	],
	"class b":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_2", "hallway 2b towards hallway 3 guaranteed",8]
	],
	"hallway 2b towards hallway 3 guaranteed":[
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1",9]
	],
	"hallway 3 spawn 1":[
		[$"../spawns_hallway_3/fang_spawns/spawn_2","hallway 3 spawn 2",9]
	],
	"hallway 3 spawn 2":[
		[$"../spawns_office/spawns_right/outside_door","outside right door",-1],
	],
	"outside right window":[
		[$"../spawns_office/spawns_right/outside_window","outside right window",-1],
	],
	"outside right door":[
		[$"../spawns_office/spawns_right/outside_door", "no",-1]
	]
}
func _ready() -> void:
	$".".position=Vector3(spawn_e.position.x, spawn_e.position.y, spawn_e.position.z)
	compare_time=Time.get_ticks_msec()

func _process(delta: float) -> void:
	time_passed=Time.get_ticks_msec()-compare_time
	if current_area!="outside right door" and current_area!="outside left door":
		if $"../game_manager".current_room!=current_index || !$"../cameras".visible:
			if time_passed/1000.0 >= time_wait-0.5 and time_passed/1000.0<=time_wait+0.5:
				compare_time=Time.get_ticks_msec()
				time_passed=0
				var moves = randi_range(1,3)<=2
				#var moves=true
				if moves:
					var chosen_move = routes[current_area][randi_range(0,routes[current_area].size()-1)]
					if chosen_move[1]!="no":
						$".".position=Vector3(chosen_move[0].position.x, chosen_move[0].position.y, chosen_move[0].position.z)
						rotation_degrees.y=chosen_move[0].rotation_degrees.y
						current_area=chosen_move[1]
						current_index=chosen_move[2]
						$hehehehe.play()
		else:
			compare_time=Time.get_ticks_msec()
	else:
		if time_passed/1000.0 >= (time_wait*2)-0.5 and time_passed/1000.0<=(time_wait*2)+0.5:
			compare_time=Time.get_ticks_msec()
			print_debug("YOU ARE DEAD ELELELE")
			time_wait=-1
			$"../game_manager".trigger_game_over()
