extends Hook

@export var end:= Vector2.ZERO
@export var delay := 0.5
const speed = 50
var start_pos : Vector2
var tween : Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = create_tween().set_loops(0)
	start_pos = position
	
	
	tween.tween_property(self,"position",start_pos+end*8,(end*8).length()/speed)
	tween.tween_interval(delay)
	tween.tween_property(self,"position",start_pos,(end*8).length()/speed)
	tween.tween_interval(delay)


	
