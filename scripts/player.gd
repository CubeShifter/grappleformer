extends CharacterBody2D


const SPEED =75.0
const JUMP_VELOCITY := -225.0
const GRAVITY := 700
const WALL_KICK_SPEED := 170
const WALL_KICK_HEIGHT := -200
const acceleration = 750
const GRAPPLE_SPEED = 400
const GRAPPLE_HEIGHT = -200
const GRAPPLE_DELAY = 0.2
const GRAPPLE_ACELLERATION = 400

var speed := 0
var movement := 0
var movement_mult = 1
enum STATES {IDLE,WALKING,KICKING,GRAPPLING,SHMOVING, HOOKING_UP}
var state = STATES.IDLE
var spawn = Vector2(0,0)
var direction = 1
var potential_energy = 0.0
var target_pos = 0.0
var grapple_len := 0.0
var potential_mult := 0.0
var can_buffer := false
var hook

@onready var wall_kick: Timer = $WallKick
@onready var grapple_buffer: Timer = $"Grapple Buffer"
@onready var left_wall: RayCast2D = $LeftWall
@onready var right_wall: RayCast2D = $RightWall
@onready var grapple: RayCast2D = $Grapple
@onready var sprite: AnimatedSprite2D = $Sprite




func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor() and (state != STATES.GRAPPLING and state != STATES.SHMOVING and state != STATES.HOOKING_UP):
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y,200)
	
	
		
	
	elif not is_on_floor():
		velocity.y = 0
		
	if is_on_floor():
		@warning_ignore("narrowing_conversion")
		speed*=0.6	
	else:
		@warning_ignore("narrowing_conversion")
		speed*= 0.9
	
	if state == STATES.SHMOVING:
		speed = clamp((target_pos-position.x)/(GRAPPLE_SPEED*delta),-1,1)*GRAPPLE_SPEED
		potential_mult += speed*delta/grapple_len*0.8
		grapple.shorten_my_dihh(speed *delta)
		
		if abs(target_pos-self.position.x) < 0.1:
			grapple.hook()
			hook = grapple.get_hook()
			potential_mult = 1
			grapple_buffer.start()
			grapple.disable_my_dihh()
			state = STATES.HOOKING_UP
			can_buffer = true
			speed = 0
			
			
		
	
			
			
			

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			if velocity.x >0:
				speed = 40
			elif velocity.x< 0:
				speed = -40
		elif state == STATES.SHMOVING or can_buffer or state == STATES.HOOKING_UP:
			
			if state == STATES.HOOKING_UP and hook is Hook:
				
				speed = potential_energy*potential_mult + hook.get_energy().x
				velocity.y = GRAPPLE_HEIGHT + hook.get_energy().y
				hook.unhook()
				
			else:
				velocity.y = GRAPPLE_HEIGHT
				speed =potential_energy *potential_mult
			
			state = STATES.WALKING
			
			
			can_buffer = false
			grapple.disable_my_dihh()
		
			
		elif left_wall.is_colliding():
			
			state = STATES.KICKING
			
			speed = -WALL_KICK_SPEED
			
			velocity.y = WALL_KICK_HEIGHT
		elif right_wall.is_colliding():
			
			
			state = STATES.KICKING
			speed = WALL_KICK_SPEED
			velocity.y = WALL_KICK_HEIGHT
	
		
	
		
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	if Input.is_action_pressed("left") :	
		sprite.flip_h = true
		direction = -1
		velocity.x = speed+movement
		if  (state != STATES.GRAPPLING and state != STATES.SHMOVING and state != STATES.HOOKING_UP):
			movement = max(movement-delta*acceleration,-SPEED*movement_mult)
			velocity.x = speed +movement
	elif Input.is_action_pressed("right") :
		sprite.flip_h = false
		velocity.x = speed+movement
		direction = 1
		
		if  (state != STATES.GRAPPLING and state != STATES.SHMOVING and state != STATES.HOOKING_UP):
			movement = min(movement+delta*acceleration,SPEED*movement_mult)
		
			
	else:
		
		velocity.x = speed+movement
		
		
			
		if is_on_floor():
			@warning_ignore("narrowing_conversion")
			movement*=0.6
		else:
			@warning_ignore("narrowing_conversion")
			movement*= 0.9
	if Input.is_action_just_pressed("grapple") and (state != STATES.GRAPPLING and state != STATES.SHMOVING and state != STATES.HOOKING_UP):
		
		grapple.extend(direction)
		potential_energy=speed + direction*GRAPPLE_ACELLERATION
		speed=0
		movement = 0
		velocity = Vector2.ZERO
		state = STATES.GRAPPLING
	
	
	
	
			
	elif state == STATES.HOOKING_UP:
		if hook is Hook:
		
			velocity = (hook.get_centered_pos() - position)/delta
			
	
	move_and_slide()
	

func _on_wall_kick_timeout() -> void:
	state = STATES.IDLE
	


@warning_ignore("unused_parameter")
func _on_death_detector_body_entered(body: Node2D) -> void:
	position = spawn
	state = STATES.IDLE
	grapple.disable_my_dihh()
	speed = 0
	velocity.y = 0
	movement = 0
	
func ungrapple():
	velocity.y = 0
	state = STATES.IDLE

func start_shmoving(target:int):
	
	await get_tree().create_timer(GRAPPLE_DELAY).timeout
	@warning_ignore("narrowing_conversion")
	grapple_len = target - position.x
	potential_mult = 0
	target_pos = target
	state = STATES.SHMOVING
	

	


func _on_grapple_buffer_timeout() -> void:
	potential_mult = 0
	
	can_buffer = false

func explode():
	
	if Input.is_action_pressed("left"):
		
		
		speed = -550
		velocity.y = -200
		if Input.is_action_pressed("up"):
			speed = -250
			velocity.y = -250
		elif Input.is_action_pressed("down"):
			speed = -350
			velocity.y = 250
	elif Input.is_action_pressed("right"):
		speed = 550
		velocity.y = -200
		if Input.is_action_pressed("up"):
			speed = 250
			velocity.y = -250
		elif Input.is_action_pressed("down"):
			speed = 350
			velocity.y = 250
	elif Input.is_action_pressed("up"):
		speed = 0
		velocity.y = -320
	elif Input.is_action_pressed("down"):
		speed = 0
		velocity.y = 320
