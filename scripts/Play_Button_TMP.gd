## Description: Temporary play button script for playtesting.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 10, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends TextureButton

## Called when the tmp play button is pressed to go the game scene.
func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/eaton_1.tscn")
