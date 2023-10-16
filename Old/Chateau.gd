extends Area2D


@export var hp = 1000

@export var team = TeamGlobal.TEAM.ASM

func _ready():
	pass # Replace with function body.


func take_hit(damage: int):
	hp -= damage
	if hp <= 0:
		$CollisionShape2D.disabled = true
#		attacker.move()
		queue_free()

func _process(_delta):
	$TileMap/Label.text = str(hp)
	if hp <= 0:
		$"../SpawnerTimer".stop()
		$"../MobSpawner".stop()


func _on_Chateau_body_entered(body):
	if body.team != team:
		body.get_node(".").target_enemy.push_back(self)
		body.get_node("AnimatedSprite2D").play("Attack")
		body.get_node(".").collision = true
