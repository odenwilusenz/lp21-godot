extends Node

enum STATES {MENUE, LOAD_LEVEL, RUNNING, DEATH, GAME_OVER, VICTORY, GAME_END}
var state = STATES.MENUE

const levels = ["res://levels/level-1.tscn"]
var level = 1

var current_scene = null

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func start_game():
	state = STATES.LOAD_LEVEL
	_deferred_goto_scene.call_deferred("res://levels/template.tscn")

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	state = STATES.RUNNING
	
