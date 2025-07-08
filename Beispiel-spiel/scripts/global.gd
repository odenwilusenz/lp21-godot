extends Node

const menue = "res://menue.tscn"
const death = "res://death.tscn"
const gameover = "res://gameover.tscn"
const victory = "res://victory.tscn"

const levels = ["res://levels/level-01.tscn"]

var level
var lives

var current_scene = null

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func start_game():
	lives = 4
	level = 1
	start_level()

func end_game():
	load_scene(menue)

func start_level():
	load_scene(levels[level-1])

func end_level():
	level = level + 1
	
	if level > levels.size() :
		load_scene(victory)
		delay_call(3, end_game)
	else:
		load_scene(victory)
		delay_call(3, start_level)

func die():
	lives = lives - 1
	if lives < 0 :
		load_scene(gameover)
		delay_call(5, end_game)
	else :
		load_scene(death)
		delay_call(3, start_level)

func delay_call(delay, function):
	get_tree().create_timer(delay).timeout.connect(function)

func load_scene(scene) :
	_deferred_goto_scene.call_deferred(scene)

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
	
