extends CharacterBody2D

var player
var player_in_chat_zone

func _process(delta):
	$AnimatedSprite2D.play("Johnsin_Idle_L")
	if Input.is_action_just_pressed("chat"):
		print("chatting")
		$Dialogue.start()
		


func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = false


func _on_dialogue_dialogue_finished():
	pass
