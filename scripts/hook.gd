extends StaticBody2D
class_name Hook

var momentum = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += momentum*delta
	
	
func get_energy():
	return Vector2.ZERO

func hooked():
	pass
func get_centered_pos():
	return position + Vector2(8,14)
func unhook():
	pass
