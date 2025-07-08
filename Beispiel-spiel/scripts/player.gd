extends CharacterBody2D

var jumpForce = 250
var speed = 100

@onready var _animated_sprite = $sprite

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity")*delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		_animated_sprite.play("jump")
		velocity.y = -jumpForce
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		_animated_sprite.scale = Vector2(-1,1)
		_animated_sprite.play("walking")
		velocity.x = -speed
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		_animated_sprite.scale = Vector2(1,1)
		_animated_sprite.play("walking")
		velocity.x = speed
	else:
		_animated_sprite.play("idle")
		velocity.x = 0
		
	
	move_and_slide()
