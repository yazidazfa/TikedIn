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
	var scene_path = "res://Scene/Easy.tscn"
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene not found or not imported: ", scene_path)


func _on_hard_btn_pressed():
	var scene_path = "res://Scene/Hard.tscn"
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene not found or not imported: ", scene_path)
