extends Node2D
enum TYPE {LOCKED,VERTICAL,HORIZONTAL}
enum CENTERING {TOPLEFT,TOPRIGHT,BOTTOMRIGHT,BOTTOMLEFT}
@export var type:TYPE = TYPE.LOCKED
@export var start:CENTERING
@export var pos := Vector2.ZERO
@export var size := Vector2(213,120)
@onready var collision: CollisionShape2D = $"Player Detector/Colliszon"
@onready var cam: Camera2D = $"../../cam"
@onready var player: CharacterBody2D = $"../../Player"
var is_current_room := false
var camera_pos := Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	collision.shape.size = size - Vector2(8,8)
	
	if start == CENTERING.TOPLEFT:
		camera_pos = -size/2 + position
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_detector_body_entered(body: Node2D) -> void:
	cam.limit_left = -size.x/2+position.x
	cam.limit_right = size.x/2+position.x
	cam.limit_top = -size.y/2+position.y
	cam.limit_bottom = size.y/2+position.y
	
	cam.kinda_smooth_transition(camera_pos)
	


func _on_player_detector_body_exited(body: Node2D) -> void:
	is_current_room = false
