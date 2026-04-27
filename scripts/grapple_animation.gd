extends Sprite2D
@onready var sprite_2d: Sprite2D = $"../Sprite2D"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func change_position(pos:int):
	if pos:
		
		sprite_2d.position.x = pos/abs(pos)*1 + pos
		sprite_2d.flip_h = (pos/abs(pos)-1)/2
		scale.x = pos	
	
	else:
		scale.x = 0
		sprite_2d.position.x =0
	
	

	
