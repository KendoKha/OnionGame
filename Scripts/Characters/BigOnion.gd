extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const max_jumps : int = 2

var jump_counter : int = 0
var sliding : bool = false

@onready var rayCast : RayCast2D = $RayCast2D;

signal _transform

func animate():
	if velocity.y > 0:
		$Animator.play("fall")
	elif velocity.y < 0 and jump_counter > 1:
		$Animator.play("double_jump")
	elif velocity.y < 0:
		$Animator.play("jump")
	elif velocity.x == 0:
		$Animator.play("idle")
	else:
		$Animator.play("run")
	
func flip():
	if velocity.x > 0:
		$Animator.flip_h = false
		rayCast.target_position.x = 12
	elif velocity.x < 0:
		$Animator.flip_h = true
		rayCast.target_position.x = -12
		
func can_jump() -> bool:
	if is_on_floor() or jump_counter < max_jumps:
		return true 
	else:
		return false
	
func _physics_process(delta: float) -> void:
	if rayCast.is_colliding():
		sliding = true
	else:
		sliding = false
	
	if not is_on_floor():
		if sliding and velocity.y > 0:
			velocity = get_gravity() * delta * 2
			jump_counter = 1
		else:
			velocity += get_gravity() * delta
	if is_on_floor():
		jump_counter = 0

#aquí se gestiona el salto (en el if de abajo xd)
	if Input.is_action_just_pressed("Jump") and can_jump(): 
		velocity.y = JUMP_VELOCITY
		jump_counter += 1
	
	if Input.is_action_just_pressed("Transform") and is_on_floor_only():
		SignalBus._transform.emit()

	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	animate()
	flip()
	
