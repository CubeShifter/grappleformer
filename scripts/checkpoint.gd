extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == StringName("Player"):
		body.spawn = position + Vector2(4,4)
