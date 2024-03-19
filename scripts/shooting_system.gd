extends Marker2D


class_name ShootingSystem

signal shot
signal gun_reload(ammo_in_magazine: int, ammo_left: int)
var reload_time = 1
var reload_status = false

@export var magazine_size = 10
@export var ammo_in_magazine = 0
	
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
func _ready():
	ammo_in_magazine = magazine_size
	
func _input(event):
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	if Input.is_action_just_pressed("Reload"):
		reload()
		
func reload():
	if reload_status == true:
		return
	print('reloading')
	reload_status = true
	ammo_in_magazine = magazine_size
	get_tree().create_timer(reload_time, false).timeout.connect(func(): reload_status = false)
	
func shoot():
	if ammo_in_magazine <= 0 or reload_status == true:
		reload()
		return
	else:
		var bullet = bullet_scene.instantiate() as Bullet
		get_tree().root.add_child(bullet)
		var move_direction = (get_global_mouse_position() - global_position).normalized()
		bullet.move_direction = move_direction
		bullet.global_position = global_position
		bullet.rotation = move_direction.angle()
	
		ammo_in_magazine -= 1
		print(ammo_in_magazine)
	
# https://www.youtube.com/watch?v=nqaSLUdEPL0
