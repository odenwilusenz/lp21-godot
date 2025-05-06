extends CharacterBody2D

var gravity = 700
var jumpForce = 380
var speed = 250

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity*delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = -jumpForce
	
	var movement = Input.get_axis("left","right")
	velocity.x = speed*movement
	
	move_and_slide()
