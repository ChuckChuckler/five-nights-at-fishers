extends Sprite3D

var level:float=15
var time_wait:float
var time_before_disappear:float

var time_passed:int=0
var compare_time:int=0

var current_area:String="door to e"
@onready var current_spawn=$"."
@onready var potential_spawnpoints_names = ["door to e", "hallway 1 from e", "door to left staircase", "door to right staircase", "hallway 5a from stairs", "hallway 2a to stairs"]
@onready var potential_spawnpoints_spawns = [$"../spawns_lobby/fang_spawns/from_e", $"../spawns_hallway_1/fang_spawns/spawn_1", $"../spawns_lobby/fang_spawns/to_staircase_left", $"../spawns_lobby/fang_spawns/to_staircase_right", $"../spawns_hallway_5a/fang_spawns/spawn_1", $"../spawns_hallway_2/fang_spawns/spawn_1"]

var game_stopped=false

var first_sound_played_2=false
var first_sound_played_3=false

@onready var routes={
	"classroom e":[
		[$"../spawns_hallway_1/fang_spawns/spawn_1","hallway 1 to e",-15]
	],
	"hallway 4":[
		["ahh", "no"]
	],
	"hallway 1 to e":[
		[$"../spawns_hallway_1/fang_spawns/spawn_2","hallway 1 from e",-15]
	],
	"hallway 1 from e":[
		[$"../spawns_lobby/fang_spawns/from_e","door to e",-15]
	],
	"door to e":[
		[$"../spawns_lobby/fang_spawns/to_staircase_left","door to left staircase",-15],
		[$"../spawns_lobby/fang_spawns/to_staircase_right","door to right staircase",-15],
	],
	"door to left staircase":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_1","hallway 5a from stairs",-10]
	],
	"hallway 5a from stairs":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b",-10],
		[$"../spawns_hallway_5a/fang_spawns/spawn_3","hallway 5a to 5c",-10]
	],
	"hallway 5a to 5b":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_1","hallway 5b entrance",-10]
	],
	"hallway 5b entrance":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_2", "hallway 5b to classroom d",-10],
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b guaranteed return",-10]
	],
	"hallway 5a to 5b guaranteed return":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_1","hallway 5a from stairs guaranteed 5c",-10]
	],
	"hallway 5b to classroom d":[
		[$"../spawns_classroom_d/fang_spawn", "classroom d",-10]
	],
	"classroom d":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_2", "hallway 5b to classroom d guaranteed return",-10]
	],
	"hallway 5b to classroom d guaranteed return":[
		[$"../spawns_hallway_5b/fang_spawns/spawn_1", "hallway 5b entrance guaranteed return",-10]	
	],
	"hallway 5b entrance guaranteed return":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_2","hallway 5a to 5b guaranteed return",-10]
	],
	"hallway 5a from stairs guaranteed 5c":[
		[$"../spawns_hallway_5a/fang_spawns/spawn_3","hallway 5a to 5c",-10]
	],
	"hallway 5a to 5c":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_1","hallway 5c entrance",-10]
	],
	"hallway 5c entrance":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_2","hallway 5c towards 6",-5],
		[$"../spawns_classroom_a/fang_spawn", "classroom a",-5]
	],
	"classroom a":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_1","hallway 5c entrance guaranteed 6",-5]
	],
	"hallway 5c entrance guaranteed 6":[
		[$"../spawns_hallway_5c/fang_spawns/spawn_2","hallway 5c towards 6",-5],
	],
	"hallway 5c towards 6":[
		[$"../spawns_hallway_6/fang_spawns/spawn_1","hallway 6 entrance",0]
	],
	"hallway 6 entrance":[
		[$"../spawns_hallway_6/fang_spawns/spawn_2","hallway 6 to office",0]
	],
	"hallway 6 to office":[
		[$"../spawns_office/spawns_left/outside_door", "outside left door",0]
	],
	"outside left window":[
		[$"../spawns_office/spawns_left/outside_window", "outside left window",0]
	],
	"outside left door":[
		[$"../spawns_office/spawns_left/outside_door", "no",0]
	],
	"door to right staircase":[
		[$"../spawns_hallway_2/fang_spawns/spawn_1","hallway 2a to stairs",-10]
	],
	"hallway 2a to stairs":[
		[$"../spawns_hallway_2/fang_spawns/spawn_2","hallway 2a to hall 2b",-10]
	],
	"hallway 2a to hall 2b":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_1","hallway 2b entrance",-5]
	],
	"hallway 2b entrance":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_2","hallway 2b towards hallway 3",-5],
	],
	"hallway 2b towards hallway 3":[
		[$"../spawns_b/fang_spawn","class b",-5],
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1",0]
	],
	"class b":[
		[$"../spawns_hallway_2b/fang_spawns/spawn_2", "hallway 2b towards hallway 3 guaranteed",-5]
	],
	"hallway 2b towards hallway 3 guaranteed":[
		[$"../spawns_hallway_3/fang_spawns/spawn_1", "hallway 3 spawn 1",0]
	],
	"hallway 3 spawn 1":[
		[$"../spawns_hallway_3/fang_spawns/spawn_2","hallway 3 spawn 2",0]
	],
	"hallway 3 spawn 2":[
		[$"../spawns_office/spawns_right/outside_door","outside right door",0],
	],
	"outside right window":[
		[$"../spawns_office/spawns_right/outside_window","outside right window",0],
	],
	"outside right door":[
		[$"../spawns_office/spawns_right/outside_door", "no",0]
	]
}
func _ready() -> void:
	time_wait=(-0.32*level)+8.31
	time_before_disappear=0.368421*level+2.63158
	var randindex = randi_range(0,potential_spawnpoints_names.size()-1)
	while potential_spawnpoints_names[randindex]==$"../fang".current_area || potential_spawnpoints_names[randindex]==$"../fang2".current_area || potential_spawnpoints_names[randindex]==$"../fang3".current_area:
		randindex=randi_range(0,potential_spawnpoints_names.size()-1)
	
	current_area=potential_spawnpoints_names[randindex]
	current_spawn=potential_spawnpoints_spawns[randindex]
	$".".position=Vector3(current_spawn.position.x, current_spawn.position.y, current_spawn.position.z)
	compare_time=Time.get_ticks_msec()

func _process(delta: float) -> void:
	time_passed=Time.get_ticks_msec()-compare_time
	if !game_stopped:
		if current_area!="outside right door" and current_area!="outside left door" and current_area!="outside left window" and current_area!="outside right window":
			if time_passed/1000.0 >= time_wait-0.5 and time_passed/1000.0<=time_wait+0.5:
				compare_time=Time.get_ticks_msec()
				time_passed=0
				var moves = randi_range(1,3)<=2
				#var moves=true
				if moves:
					var move_index = randi_range(0,routes[current_area].size()-1)
					var chosen_move = routes[current_area][move_index]
					if chosen_move[1]!="no":
						if chosen_move[1]==$"../fang".current_area || chosen_move[1]==$"../fang2".current_area || chosen_move[1]==$"../fang3".current_area:
							if routes[current_area].size()==2:
								if move_index==0:
									move_index=1
								else:
									move_index=0
								
								chosen_move=routes[current_area][move_index]
								$".".position=Vector3(chosen_move[0].position.x, chosen_move[0].position.y, chosen_move[0].position.z)
								rotation_degrees.y=chosen_move[0].rotation_degrees.y
								current_area=chosen_move[1]
								$"footsteps".volume_db=chosen_move[2]
								$"footsteps".play()
						else:
							$"footsteps".volume_db=chosen_move[2]
							$"footsteps".play()
							$".".position=Vector3(chosen_move[0].position.x, chosen_move[0].position.y, chosen_move[0].position.z)
							rotation_degrees.y=chosen_move[0].rotation_degrees.y
							current_area=chosen_move[1]
		else:
			if ($"../wall_right/toggle_door".door_down and (current_area=="outside right door" || current_area=="outside right window")) || ($"../wall_left/toggle_door".door_down and (current_area=="outside left door" || current_area=="outside left window")):
				if time_passed/1000.0 >= time_before_disappear-0.5 and time_passed/1000.0<=time_before_disappear+0.5:
					$"footsteps".volume_db=-10
					$"footsteps".play()
					compare_time=Time.get_ticks_msec()
					time_passed=0
					var randindex = randi_range(0,potential_spawnpoints_names.size()-1)
					while potential_spawnpoints_names[randindex]==$"../fang".current_area:
						randindex=randi_range(0,potential_spawnpoints_names.size()-1)
					
					current_area=potential_spawnpoints_names[randindex]
					current_spawn=potential_spawnpoints_spawns[randindex]
					
					$".".position=Vector3(current_spawn.position.x, current_spawn.position.y, current_spawn.position.z)
					
					if $".".get_meta("type")==2:
						first_sound_played_2=false
					else:
						first_sound_played_3=false
			else:
				if time_passed/1000.0 >= (time_wait*2)-0.5 and time_passed/1000.0<=(time_wait*2)+0.5:
					compare_time=Time.get_ticks_msec()
					time_passed=0
					time_wait=-1
					if !$"../jumps care".visible:
						$"../cameras".visible=false
						$"../jumps care".visible=true
						if $".".get_meta("type")==2:
							$"../jumps care/deffs".visible=true
						elif $".".get_meta("type")==3:
							$"../jumps care/mims".visible=true
						$"../jumps care/boom".play()
						$"../jumps care/jumps care timer".start()
						
						game_stopped=true

func door_triggered():
	compare_time=Time.get_ticks_msec()
	time_passed=0
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
			
func left_light_triggered(triggered:int):
	if triggered==2:
		if current_area=="outside left door" and !first_sound_played_2:
			if $"../wall_left/toggle_door".door_down:
				$".".position=Vector3(routes["outside left window"][0][0].position.x, routes["outside left window"][0][0].position.y, routes["outside left window"][0][0].position.z)
			$in_door.play()
			first_sound_played_2=true
	else:
		if current_area=="outside left door" and !first_sound_played_3:
			if $"../wall_left/toggle_door".door_down:
				$".".position=Vector3(routes["outside left window"][0][0].position.x, routes["outside left window"][0][0].position.y, routes["outside left window"][0][0].position.z)
			$in_door.play()
			first_sound_played_3=true

func right_light_triggered(triggered:int):
	if triggered==2:
		if current_area=="outside right door" and !first_sound_played_2:
			if $"../wall_right/toggle_door".door_down:
				$".".position=Vector3(routes["outside right window"][0][0].position.x, routes["outside right window"][0][0].position.y, routes["outside right window"][0][0].position.z)
			$in_door.play()
			first_sound_played_2=true
	else:
		if current_area=="outside right door" and !first_sound_played_3:
			if $"../wall_right/toggle_door".door_down:
				$".".position=Vector3(routes["outside right window"][0][0].position.x, routes["outside right window"][0][0].position.y, routes["outside right window"][0][0].position.z)
			$in_door.play()
			first_sound_played_3=true
