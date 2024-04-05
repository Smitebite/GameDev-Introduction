## Description: Main menu script for the title in binary scrolling.
## Author: Seth Daniels, Nico Gatapia, Jacob Horton, Elijah Toliver, Gilbert Vandegrift
## Date Created: March 10, 2024
## Date Modified: March 10, 2024
## Version: Development
## Godot Version: 4.2.1
## License: MIT License

extends Node2D

# Speed of the scroll in pixels per second for each pair
var speed_code_binary = 100.0
var speed_of_binary = 25.0
var speed_the_binary = 50.0
var speed_undead_binary = 200.0
var speed_title_binary = 100.0

func _ready():
	# Initialize positions of the "code" binary textures
	$code_binary_1.position.x = 0
	$code_binary_2.position.x = $code_binary_1.texture.get_width()
	
	# Initialize positions of the "of" binary textures
	$of_binary_1.position.x = 0
	$of_binary_2.position.x = -$of_binary_1.texture.get_width()
	
	# Initialize positions of the "the" binary textures
	$the_binary_1.position.x = 0
	$the_binary_2.position.x = $the_binary_1.texture.get_width()
		
	# Initialize positions of the "undead" binary textures
	$undead_binary_1.position.x = 0
	$undead_binary_2.position.x = $undead_binary_1.texture.get_width()
			
	# Initialize positions of the "title" binary textures
	$title_binary_1.position.x = 0
	$title_binary_2.position.x = -$title_binary_1.texture.get_width()

func _process(delta):
	# Move "code" binary textures to the left
	$code_binary_1.position.x -= speed_code_binary * delta
	$code_binary_2.position.x -= speed_code_binary * delta

	# Check and reset positions
	var code_texture_width = $code_binary_1.texture.get_width()
	if $code_binary_1.position.x <= -code_texture_width:
		$code_binary_1.position.x = $code_binary_2.position.x + code_texture_width
	if $code_binary_2.position.x <= -code_texture_width:
		$code_binary_2.position.x = $code_binary_1.position.x + code_texture_width


	# Move "of" binary textures to the right
	$of_binary_1.position.x += speed_of_binary * delta
	$of_binary_2.position.x += speed_of_binary * delta

	# Check and reset positions
	var of_texture_width = $of_binary_1.texture.get_width()
	if $of_binary_1.position.x >= of_texture_width:
		$of_binary_1.position.x = $of_binary_2.position.x - of_texture_width
	if $of_binary_2.position.x >= of_texture_width:
		$of_binary_2.position.x = $of_binary_1.position.x - of_texture_width
		
	
	# Move "the" binary textures to the left
	$the_binary_1.position.x -= speed_the_binary * delta
	$the_binary_2.position.x -= speed_the_binary * delta

	# Check and reset positions
	var the_texture_width = $the_binary_1.texture.get_width()
	if $the_binary_1.position.x <= -the_texture_width:
		$the_binary_1.position.x = $the_binary_2.position.x + the_texture_width
	if $the_binary_2.position.x <= -the_texture_width:
		$the_binary_2.position.x = $the_binary_1.position.x + the_texture_width
	
	
	# Move "the" binary textures to the left
	$undead_binary_1.position.x -= speed_undead_binary * delta
	$undead_binary_2.position.x -= speed_undead_binary * delta

	# Check and reset positions
	var undead_texture_width = $undead_binary_1.texture.get_width()
	if $undead_binary_1.position.x <= -undead_texture_width:
		$undead_binary_1.position.x = $undead_binary_2.position.x + undead_texture_width
	if $undead_binary_2.position.x <= -undead_texture_width:
		$undead_binary_2.position.x = $undead_binary_1.position.x + undead_texture_width
	
	
	# Move "title" binary textures to the right
	$title_binary_1.position.x += speed_title_binary * delta
	$title_binary_2.position.x += speed_title_binary * delta

	# Check and reset positions
	var title_texture_width = $title_binary_1.texture.get_width()
	if $title_binary_1.position.x >= title_texture_width:
		$title_binary_1.position.x = $title_binary_2.position.x - title_texture_width
	if $title_binary_2.position.x >= title_texture_width:
		$title_binary_2.position.x = $title_binary_1.position.x - title_texture_width
	







