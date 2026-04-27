extends RayCast2D

const MAX_STRETCH = 120
const SPEED = 400
var velocity = 0
enum STATES {}

@onready var line: Line2D = $Line
@onready var player: CharacterBody2D = $".."
@onready var grapple_image: Sprite2D = $GrappleImage
@onready var detector: RayCast2D = $"../Detector"

var colider
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_colliding():
		
			
		target_position.x += delta*SPEED*velocity
		
		target_position = target_position.round()
		force_raycast_update()
	if abs(target_position.x) > MAX_STRETCH:
		player.ungrapple()
		
		velocity=0
		target_position.x = 0
	if not velocity == 0 and is_colliding():
		colider = get_collider()
		player.start_shmoving(target_position.x+global_position.x)
		position.x = get_collision_normal().x
		position = position.round()
		velocity = 0
	detector.target_position.x = target_position.x
	if detector.is_colliding():
		disable_my_dihh()
		player.ungrapple()
		velocity =0
	grapple_image.change_position(target_position.x)
		
		
	
			
	
	
	
		
	
	
	

func extend(dir) -> void:
	
	target_position.x = 0
	velocity = dir
	
	
func disable_my_dihh():
	target_position.x = 0
	
	
func shorten_my_dihh(dih_new_len:float):
	target_position.x -= dih_new_len
	target_position = target_position.round()


func hook():
	if colider is Hook:
		colider.hooked()
	
func get_hook():
	return colider

	
