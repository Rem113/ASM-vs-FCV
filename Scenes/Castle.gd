extends StaticBody2D

class_name Castle

@export var health: int = 1000 : set = set_health

@onready var health_label: Label = $HealthLabel

func _ready():
	health_label.text = str(health)

func take_damage(amount: float):
	health -= amount

func set_health(value: int):
	health = value
	health_label.text = str(health)
