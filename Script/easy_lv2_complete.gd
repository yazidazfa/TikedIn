extends Node

var score_easy2_label = Label
@onready var complete = $TextureRect/complete
# Called when the node enters the scene tree for the first time.
func _ready():
	score_easy2_label = $TextureRect/Score1Label
	score_easy2_label.text = "Score: " + str(GlobalScore.score_easy2)
	complete.play()
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scene/Guide3.tscn")
