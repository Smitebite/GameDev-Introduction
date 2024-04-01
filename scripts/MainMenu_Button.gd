## Description: Main menu button script for going back to the main menu.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 10, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends TextureButton

## Called when the main menu button is pressed to go back to the main menu.
func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
