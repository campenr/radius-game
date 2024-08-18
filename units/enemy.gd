extends Node2D


const SPEED = 150


func _physics_process(delta):
	position -= transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
