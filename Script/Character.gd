extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_character(character_path : String):
	$sprite.texture = load(character_path)

