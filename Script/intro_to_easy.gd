extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$VideoStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://Scene/Guide1.tscn")
