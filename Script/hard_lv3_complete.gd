extends Node

var score_easy3_label = Label

# Called when the node enters the scene tree for the first time.
func _ready():
	score_easy3_label = $TextureRect/Score1Label
	score_easy3_label.text = "Score: " + str(GlobalScore.score_easy3)
	$TextureRect/TotalScore.text = "Score Keseluruhan: " + str(GlobalScore.total_score)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scene/main menu.tscn")
