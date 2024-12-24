extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const max_jumps : int = 2

var jump_counter : int = 0


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
	elif velocity.x < 0:
		$Animator.flip_h = true
		
func can_jump() -> bool:
	if is_on_floor() or jump_counter < max_jumps:
		return true 
	else:
		return false
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jump_counter = 0

#aquí se gestiona el salto (en el if de abajo xd)
	if Input.is_action_just_pressed("Jump") and can_jump(): 
		velocity.y = JUMP_VELOCITY
		jump_counter += 1

	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	animate()
	flip()
	
