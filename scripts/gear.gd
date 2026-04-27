extends Hook

@onready var line_2d: Line2D = $Line2D
@onready var sprite: AnimatedSprite2D = $Sprite


# Called when the node enters the scene tree for the first time.
enum states {CHILLING,SHMOVING,FINISHED,RECOILING,WAITING}
var state := states.CHILLING
@export var end := Vector2.ZERO
const SPEED := 200
const RECOIL_SPEED := 60
const FINISH_TIME := 1
const RECOIL_TIME := 0.3
const START_DELAY := 0.2
var len:float
var old_pos:Vector2
var end_pos:Vector2
var velocity := Vector2.ZERO
var pos := Vector2.ZERO
var speed := Vector2.ZERO

func _ready() -> void:
	line_2d.set_point_position(1,end*8+Vector2(8,8))
	
	len = (end*8).length()
	old_pos = self.position
	end_pos = old_pos + end*8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == states.SHMOVING:
		velocity = end.normalized()*SPEED
		speed =(1-((position-end_pos).length())/((old_pos-end_pos).length()))*end.normalized()*500 * Vector2(1,0.20)
		sprite.play("forwards")
		if (position-old_pos).length() >= (end*8).length():
			
			state = states.FINISHED
			await get_tree().create_timer(FINISH_TIME).timeout
			state = states.RECOILING
			
	if state == states.RECOILING:
		velocity = -end.normalized()*RECOIL_SPEED
		speed = -end.normalized()*RECOIL_SPEED
		sprite.play("backwards")
		if (position-end_pos).length() >= (old_pos-end_pos).length():
			speed = Vector2.ZERO
			state = states.WAITING
			await get_tree().create_timer(RECOIL_TIME).timeout
			state = states.CHILLING
	if state == states.FINISHED or state == states.WAITING:
		sprite.play("idle")
		velocity = Vector2.ZERO
		
	position += velocity*delta
	
func hooked():
	if state == states.CHILLING:
		await get_tree().create_timer(START_DELAY).timeout
		state = states.SHMOVING

	
func get_energy():
	return speed 
