## Description: Ammo count script for handling how much ammo the character has left.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 29, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends Label

var magazine_size = 10
var ammo_count = magazine_size
var reload_status = false
var reload_time = .75

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(ammo_count)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_just_pressed("Shoot"):
		shoot()

	if Input.is_action_just_pressed("Reload"):
		reload()
		
		
func done_reload():
	ammo_count = 10
	text = str(ammo_count)
	reload_status = false

func shoot():
	if ammo_count > 0:
		if reload_status:
			pass
		else:
			ammo_count -= 1
			if ammo_count == 0:
				reload()
	else:
		reload()
	text = str(ammo_count)
func reload():
	reload_status = true
	get_tree().create_timer(reload_time, false).timeout.connect(func(): done_reload())
	
