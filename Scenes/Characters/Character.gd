extends CharacterBody2D

class_name Character

const GRAVITY: float = 200.0

@export var speed: float = 200.0
@export var health: int = 100
@export var attack: float = 30.0
@export var defense: float = 12.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer

var target: Node2D = null

func _ready():
	animated_sprite.play("Walk")


func _process(_delta):
	velocity = Vector2.LEFT * speed
	velocity.y += GRAVITY
	move_and_slide()


func _on_attack_hitbox_body_entered(body):
	if body is Castle:
		_start_attacking(body)

# TODO: Add character
func _start_attacking(castle: Castle):
	animated_sprite.play("Idle")
	target = castle
	_attack()

func _attack():
	target.take_damage(attack)
	attack_timer.start()


func _on_attack_timer_timeout():
	if target != null:
		_attack()
