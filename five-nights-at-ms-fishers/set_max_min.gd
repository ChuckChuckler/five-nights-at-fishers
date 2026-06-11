extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_changed() -> void:
	if $".".text!="":
		if int($".".text)<1:
			$".".text="1"
		elif int($".".text)>20:
			$".".text="20"
