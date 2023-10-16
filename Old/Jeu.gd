extends Node2D


var character_scene = preload("res://Scenes/Characters/Character.tscn")
var chateau_scene = preload("res://Scenes/Characters/Chateau.tscn")

var asm_spawn_queue = []
var visiteur_spawn_queue = []
var ally_array = []
var enemy_array = []

var argent = 100: get = get_argent, set = set_argent
var income = 10: get = get_income, set = set_income
var warrior_exp = 0: get = get_warrior_exp, set = set_warrior_exp
var warrior_lvl = 0: get = get_warrior_lvl, set = set_warrior_lvl

func set_argent(amount : int):
	argent += amount
	$Argent.text = str(argent)
	
func get_argent():
	return argent
	
func set_warrior_exp(amount : int):
	warrior_exp += amount
	
func get_warrior_exp():
	return warrior_exp

func set_warrior_lvl(amount : int):
	warrior_lvl += amount
	
func get_warrior_lvl():
	return warrior_lvl

func set_income(amount : int):
	income += amount
	
func get_income():
	return income
	
func _ready():
	$Argent.text = str(argent)
	var chateau_asm = chateau_scene.instantiate()
	var chateau_visiteur = chateau_scene.instantiate()
	
	chateau_asm.position.x += 168
	chateau_asm.position.y += 408
	chateau_visiteur.position.x += 856
	chateau_visiteur.position.y += 408
	chateau_visiteur.team = TeamGlobal.TEAM.VISITEUR
	
	add_child(chateau_asm)
	add_child(chateau_visiteur)

func _process(_delta):
	if warrior_exp >= 100:
		set_warrior_exp(-100)
		set_warrior_lvl(1)
#func _on_Timer_timeout():
#	var character_asm = character_scene.instance()
#	var character_visiteur = character_scene.instance()
#
#	character_asm.position.y = get_viewport_rect().size.y/2
#
#	character_visiteur.team = TeamGlobal.TEAM.VISITEUR
#	character_visiteur.position = get_viewport_rect().size
#	character_visiteur.position.y = get_viewport_rect().size.y/2
#
#	asm_spawn_queue.push_back(character_asm)
#	visiteur_spawn_queue.push_back(character_visiteur)

#func _on_BossSpawner_timeout():
#	var character_asm = character_scene.instance()
#
#	character_asm.position.y = get_viewport_rect().size.y/2
#	character_asm.scale *= 3
#	character_asm.attack = 40
#	character_asm.hp = 500
#	character_asm.get_node("AnimatedSprite").set_modulate(Color.red)
#
#	asm_spawn_queue.push_back(character_asm)


func _on_SpawnerTimer_timeout():
	set_argent(income)
	
	var next_asm_spawn = asm_spawn_queue.pop_front()
#	if next_asm_spawn != null:
#		print(next_asm_spawn.get_node(".").attack)
	
	if next_asm_spawn != null:
		add_child(next_asm_spawn)
		ally_array.push_back(next_asm_spawn)
	
	var next_visiteur_spawn = visiteur_spawn_queue.pop_front()
	
	if next_visiteur_spawn != null:
		add_child(next_visiteur_spawn)
		enemy_array.push_back(next_visiteur_spawn)


func _on_Button_pressed():
	if argent >= 50:
		var character_asm = character_scene.instantiate()
		character_asm.get_node("AnimatedSprite2D").flip_h = true
#		character_asm.position.y = get_viewport_rect().size super.y - 120
		character_asm.position.y = get_viewport_rect().size.y/2
		character_asm.get_node(".").attack *= (warrior_lvl*0.1+1)
		character_asm.get_node(".").hp *= (warrior_lvl*0.2+1)
		asm_spawn_queue.push_back(character_asm)
		set_argent(-50)


func _on_MobSpawner_timeout():
	var character_visiteur = character_scene.instantiate()

	character_visiteur.team = TeamGlobal.TEAM.VISITEUR
	character_visiteur.position = get_viewport_rect().size
	character_visiteur.position.y -= 120
#	character_visiteur.position.y = get_viewport_rect().size.y/2

	visiteur_spawn_queue.push_back(character_visiteur)


func _on_ButtonExp_pressed():
	if argent >= 50:
		set_warrior_exp(50)
		set_argent(-50)


func _on_ButtonIncome_pressed():
	if argent >= 50:
		set_income(10)
		set_argent(-50)
