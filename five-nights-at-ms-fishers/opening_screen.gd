extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$bgm.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _start() -> void:
	$screen/black_overlay.visible=true
	create_tween().tween_property($screen/black_overlay,"color",Color(0,0,0,1),2)
	$screen/start.start()
	LevelManager.fang_level=$screen/customize/fang_info/fang_difficulty.text
	LevelManager.person1_level=$screen/customize/idk_info/person1_difficulty.text
	LevelManager.person2_level=$screen/customize/idk_info2/person2_difficulty.text
	LevelManager.banajit_level=$screen/customize/banajit_info/banajit_difficulty.text

func _on_start_timeout() -> void:
	get_tree().change_scene_to_file("res://office.tscn")


func _on_customize_pressed() -> void:
	$har_har_har.play()
	$screen/customize.visible=true


func _on_exit_pressed() -> void:
	$screen/customize.visible=false
	$har_har_har.play()
