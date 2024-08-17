extends Marker2D

@onready var timer = $Timer

@export var Enemy : PackedScene

var spawning_enabled : bool = true


func _ready():
	Enemy = load("res://units/enemy.tscn")
	

func _on_spawn_interval_timeout():
	spawning_enabled = !spawning_enabled


func _on_spawn_frequency_timeout():
	if not spawning_enabled:
		var e = Enemy.instantiate()
		add_child(e)
