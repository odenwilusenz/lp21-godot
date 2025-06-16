extends AnimatedSprite2D

var touching_player = false

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("interact") and touching_player:
		Global.end_level()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" :
		touching_player = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player" :
		touching_player = false
