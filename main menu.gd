extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mulai_btn_pressed():
	print("Loading another scene...")
	$btn_transition.play("btn_transition")

func _on_exit_btn_pressed():
	print("Exiting the program...")
	get_tree().quit()  # Exit the game


func _on_easy_btn_pressed():
	get_tree().change_scene_to_file("res://Easy.tscn")


func _on_hard_btn_pressed():
	get_tree().change_scene_to_file("res://Hard.tscn")
