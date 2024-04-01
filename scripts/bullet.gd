## Description: Bullet script for handling movement of bullets.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 29, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends Area2D

class_name Bullet
var speed = 1000
var move_direction: Vector2 = Vector2.ZERO
var MIDI_MESSAGE_PROGRAM_CHANGE

func _process(delta):
	global_position += move_direction * delta * speed


func bullet():
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


