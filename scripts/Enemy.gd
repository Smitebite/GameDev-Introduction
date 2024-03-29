extends CharacterBody2D
# higher the speed slower the enemy is
var speed = 50
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false
var enemy_attacking = false 
var bullet_hit = false

#Tracks player postion uses postion for animation 
func _physics_process(_delta):
	deal_with_damage()
	if enemy_attacking:
		move_and_collide(Vector2(0,0)) # so zombie can hoplfully collide with walls :D
	
		position += (player.position - position)/speed 
		if(player.position.x - position.x) <0 :
			$AnimatedSprite2D.play("Zom_Attack_L")
		else:
			$AnimatedSprite2D.play("Zom_Attack_R")
	if player_chase == true and enemy_attacking == false :
		move_and_collide(Vector2(0,0)) # so zombie can hoplfully collide with walls :D
	
		position += (player.position - position)/speed 
		if(player.position.x - position.x) <0 :
			$AnimatedSprite2D.play("Zom_Walk_L")
		else:
			$AnimatedSprite2D.play("Zom_Walk_R")
	if player_chase == false:
		$AnimatedSprite2D.play("Zom_Idle_F") 

		
#checks if the player entered the range of the aggro raidus 
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	

#checks if the player left the range of the aggro raidus 
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false 
	

#makes this sprite defined as an enemy 
func enemy():
	pass 


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true 
		enemy_attacking = true
	if body.has_method("bullet"):
		bullet_hit = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false 
		enemy_attacking = false
	if body.has_method("bullet"):
		bullet_hit = false
		
func deal_with_damage():
	if player_inattack_zone and global.player_currect_attack == true:
		health = health -20
		print("Zombie health =" , health)
		if health <= 0:
			self.queue_free() #deletes the enemy
	if bullet_hit == true:
		health = health -50
		bullet_hit = false
		print("Zombie health = " , health)
		if health <= 0:
			self.queue_free() #deletes the enemy






func _on_enemy_hitbox_area_entered(area): #checks 
	if area.has_method("bullet"):
		bullet_hit = true
		deal_with_damage()
