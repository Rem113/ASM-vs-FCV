extends Node2D

var character_scene: PackedScene = preload("res://Scenes/Characters/Character.tscn")

@onready var spawn_area_fcv = $SpawnAreaFCV

var spawn_queue_fcv: Array[Node2D] = []

var spawn_area_busy = false

func _on_spawn_timer_fcv_timeout():
	var new_character = character_scene.instantiate()
	new_character.position = spawn_area_fcv.position
	
	if spawn_area_busy:
		spawn_queue_fcv.push_back(new_character)
	else:
		add_child(new_character)


func _on_spawn_area_fcv_body_entered(body):
	spawn_area_busy = true


func _on_spawn_area_fcv_body_exited(body):
	spawn_area_busy = false
	
	if !spawn_queue_fcv.is_empty():
		var new_character = spawn_queue_fcv.pop_front()
		add_child(new_character)


func _on_castle_asm_destroyed():
	remove_child($CastleASM)
