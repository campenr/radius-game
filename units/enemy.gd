extends Node2D


const SPEED = 150


func _physics_process(delta):
	position -= transform.x * SPEED * delta
