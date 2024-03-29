extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

func _physics_process(_delta):
	if player_chase:
		move_and_collide(Vector2(0,0))
		
		position += (player.position - position)/speed 
		if(player.position.x - position.x) <0:
			$AnimatedSprite2D.play("Zom_Walk_L")
		else:
			$AnimatedSprite2D.play("Zom_Walk_R")
	else:
			$AnimatedSprite2D.play("Zom_Idle_F") 

		

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false 
