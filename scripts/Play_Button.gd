## Description: Play button script for going to the game saves menu.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 10, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends TextureButton

## Called when the play button is pressed to go to the game saves menu.
func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/saves_menu.tscn")
