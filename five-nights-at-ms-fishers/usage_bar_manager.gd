extends ColorRect

var power_sources:float=1.0
const TOTAL_POWER_SOURCES:float=5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$usage_bar.size.x=$".".size.x*(power_sources/TOTAL_POWER_SOURCES)
	if power_sources==1:
		$usage_bar.color=Color(0.446, 0.772, 0.487, 1.0)
	elif power_sources==2:
		$usage_bar.color=Color(0.624, 0.732, 0.412, 1.0)
	elif power_sources==3:
		$usage_bar.color=Color(0.691, 0.713, 0.355, 1.0)
	elif power_sources==4:
		$usage_bar.color=Color(0.832, 0.65, 0.351, 1.0)
	elif power_sources==5:
		$usage_bar.color=Color(0.998, 0.373, 0.278, 1.0)
