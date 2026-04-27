extends Camera2D
const VERTICAL_MARGIN = 32
const HORIZONTAL_MARGIN = 48
@onready var player: CharacterBody2D = $"../Player"
# Called when the node enters the scene tree for the first time.

	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var math := -global_position.x+player.position.x- 213/2
	if abs(math) > 80:
		global_position.x = player.position.x + abs(math)/math*80+ 213/2
	


func kinda_smooth_transition(pos:Vector2):
	var tween = create_tween()
	tween.tween_property(self,"position",pos,0.3)
