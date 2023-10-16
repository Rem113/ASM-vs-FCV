extends CharacterBody2D

class_name Character

const GRAVITY: float = 200.0

@export var speed: float = 200.0
@export var health: int = 100
@export var attack: float = 30.0
@export var defense: float = 12.0

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("Walk")


func _process(_delta):
	velocity = Vector2.LEFT * speed
	velocity.y += GRAVITY
	move_and_slide()
