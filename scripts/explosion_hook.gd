extends Hook

const DELAY := 1
var tick_delay := 1.0
var explosion_time := 0.5
@onready var explosion: Area2D = $Explosion
@onready var explosion_timer: Timer = $"Explosion Timer"
@onready var sprite_2d: Sprite2D = $Sprite2D
var exploding := false
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_parent().get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func unhook():
	player.explode()
	


		
