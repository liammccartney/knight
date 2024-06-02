extends CharacterBody2D


const SPEED = 150.0

var can_double_jump = true

@onready var sprite = $AnimatedSprite2D

@export_group("Jump")
@export var jump_height_px = 50
@export var jump_time_up = 0.6
@export var jump_time_down = 0.3

@onready var jump_velocity = -(2.0 * jump_height_px) / jump_time_up
@onready var jump_gravity = (2.0 * jump_height_px) / (jump_time_up * jump_time_up)
@onready var fall_gravity = (2.0 * jump_height_px) / (jump_time_down * jump_time_down)


var gravity: float:
	get:
		return jump_gravity if velocity.y < 0.0 else fall_gravity 
func _ready():
	print("Jump Height:", jump_height_px)
	print("Jump t Peak:", jump_time_up)
	print("Jump t Descent:", jump_time_down)
	print("Jump Velocity:", round(jump_velocity))
	print("Jump Gravity:", round(jump_gravity))
	print("Fall Gravity:", round(fall_gravity))

func get_horizontal_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
	
	return horizontal

func jump():
	velocity.y = jump_velocity
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jump()
		
	if not is_on_floor() and Input.is_action_just_pressed("jump") and can_double_jump:
		can_double_jump = false
		jump()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true
	
	if is_on_floor():
		can_double_jump = true
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		sprite.play("jump")
		
	velocity.x = get_horizontal_velocity() * SPEED

	move_and_slide()
