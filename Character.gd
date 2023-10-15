extends CharacterBody2D

@export var speed: int = 100
var collision = false
@onready var jeu = self.get_node("../")

@export var hp = 100
@export var attack = 50
var count = 0

@export var team = TeamGlobal.TEAM.ASM
var target_enemy = []

func _ready():
	$AnimatedSprite2D.play("Move_n")
	if team == TeamGlobal.TEAM.VISITEUR:
#		attack = 500
		speed *= -1
		set_modulate(Color(1, 1, 1))
		$AnimatedSprite2D.flip_h = false
		$Area2D.position.x *= -1

func _process(delta):
	$Label.text = str(hp)
	if !collision:
#		move_and_slide(Vector2.RIGHT*speed)
		position += Vector2.RIGHT*speed*delta

func take_hit(damage: int):
	hp -= damage
	if hp <= 0:
		if team == TeamGlobal.TEAM.VISITEUR:
			jeu.set_argent(20)
			jeu.set_warrior_exp(10)
		queue_free()

func move():
	collision = false
	$AnimatedSprite2D.play("Move_n")

func _on_Area2D_body_entered(body):
	if body == self:
		return
	if body.team != team:
		collision = true
		target_enemy.push_back(body)
		$AnimatedSprite2D.play("Attack")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite2D.animation == "Attack":
		if team == TeamGlobal.TEAM.ASM and !jeu.enemy_array.is_empty():
			jeu.enemy_array.back().take_hit(attack)
		if !jeu.ally_array.is_empty() and team == TeamGlobal.TEAM.VISITEUR:
			jeu.ally_array.back().take_hit(attack)

func _on_Area2D_body_exited(body):
	jeu.ally_array.erase(body)
	jeu.enemy_array.erase(body)
	
	if team == TeamGlobal.TEAM.ASM and jeu.enemy_array.is_empty():
		move()
	if team == TeamGlobal.TEAM.VISITEUR and jeu.ally_array.is_empty():
		move()
	
