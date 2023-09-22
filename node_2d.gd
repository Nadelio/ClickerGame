extends Node2D
# This class contains controls that should always be accessible, like pausing
# the game or toggling the window full-screen.




func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()
