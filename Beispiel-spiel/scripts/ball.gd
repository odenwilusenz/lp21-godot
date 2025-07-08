extends CharacterBody2D

enum DIRECTION {LEFT, RIGHT}
@export var direction: DIRECTION

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _raycast = $"AnimatedSprite2D/raycast-front"
@onready var _floor = $"AnimatedSprite2D/raycast-floor"

func _physics_process(delta: float) -> void:
	
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity")*delta
	
	if not _floor.is_colliding() :
		velocity.y = -70
		if direction == DIRECTION.LEFT:
			direction = DIRECTION.RIGHT
		else :
			direction = DIRECTION.LEFT
	
	if _raycast.is_colliding() :
		velocity.y = -70
		if direction == DIRECTION.LEFT:
			direction = DIRECTION.RIGHT
		else :
			direction = DIRECTION.LEFT
	
	if direction == DIRECTION.LEFT:
		_animated_sprite.scale = Vector2(1,1)
		velocity.x = -50
	else:
		_animated_sprite.scale = Vector2(-1,1)
		velocity.x = 50	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" :
		var distance = self.global_position - body.global_position
		distance.y -5
		distance = distance.abs()
		
		if distance.x > distance.y :
			Global.die()
		else :
			body.velocity.y = -150
			queue_free()
