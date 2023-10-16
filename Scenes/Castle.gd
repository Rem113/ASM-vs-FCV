extends StaticBody2D

func _on_attack_area_body_entered(body):
	if body is Character:
		body.get_node("AnimatedSprite2D").play("Idle")
