extends Node

var score_easy1_label = Label

# Called when the node enters the scene tree for the first time.
func _ready():
	score_easy1_label = $TextureRect/Score1Label
	score_easy1_label.text = "Total Score: " + str(GlobalScore.score_easy1)



#func _on_button_pressed():
	#get_tree().change_scene_to_file(scene_path)