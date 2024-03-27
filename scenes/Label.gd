extends Label

func _ready():
	# Assuming the shooting system scene is named "ShootingSystem"
	var shootingSystem = get_node("res://Character/ShootingSystem")  # Replace SceneName with your actual scene's name
	shootingSystem.connect("playerShot", self, "_onPlayerShot")

func _onPlayerShot():
	# Update the ammo counter label
	$Label.text = "Ammo: " + str(shootingSystem.ammoCount)
