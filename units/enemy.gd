extends Node2D


var base_speed = 0


func _ready():
	var config = ConfigFile.new()
	
	# Load data from a file.
	var err = config.load("res://units/enemies.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		print('Failed to load file')
		get_tree().quit(1)
		
	# Iterate over all sections.
	# only one enemy for now so the below is fine.
	for enemy in config.get_sections():
		# Fetch the data for each section.
		base_speed = config.get_value(enemy, "base_speed")


func _physics_process(delta):
	position -= transform.x * base_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	queue_free()
