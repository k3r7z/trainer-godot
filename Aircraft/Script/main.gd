extends Area2D

@export var thrust = 1000.0				# Newtons
@export var drag = 100.0				# Newtons	
@export var mass = 840					# kg
@export var acceleration = Vector2.ZERO	# m/s²
@export var velocity = Vector2(0,5.0)	# m/s
@export var heading = 0					# deg
const MINIMUM_SPEED = 5.0				# m/s
const MAXIMUM_SPEED = 66.88				# m/s
const MAXIMUM_ACCELERATION = 2.0		# m/s^2
var screen_size



func clamp_velocity(velocity: Vector2) -> Vector2:
	var magnitude = velocity.length_squared()
	magnitude = clamp(magnitude, MINIMUM_SPEED, MAXIMUM_SPEED)
	return velocity.normalized() * magnitude
	
func clamp_acceleration(acceleration: Vector2) -> Vector2:
	var magnitude = acceleration.length_squared()
	magnitude = clamp(magnitude, 0.0, MAXIMUM_ACCELERATION)
	return acceleration.normalized() * magnitude
	


func _ready():
	screen_size = get_viewport_rect().size
	
	
func _process(delta: float):
	const rotation_speed = 0.1
	if Input.is_action_pressed("turn_left"):
		rotation -= rotation_speed * delta
		
	if Input.is_action_pressed("turn_right"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("increase_speed"):
		var force = rotation * thrust
		acceleration = force / mass
		
	if Input.is_action_pressed("decrease_speed"):
		var force = rotation * drag
		acceleration = force / mass

		acceleration = clamp_acceleration(acceleration)
	
	velocity += acceleration * delta
	velocity = clamp_velocity(velocity)

	position += velocity * delta
