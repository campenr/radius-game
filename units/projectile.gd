extends Area2D

const SPEED = 750


func _physics_process(delta):
	position += transform.x * SPEED * delta


func _on_area_entered(area):
	# TODO: apply effects on enemy hit. For now just despawn.
	queue_free()
	area.owner.queue_free()
