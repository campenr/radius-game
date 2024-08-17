extends Area2D

const SPEED = 750
var projectile_effects: Array[ProjectileEffect] = []


func spawn(owner: Node, spawn_with_projectile_effects: Array, parent_transform: Transform2D):
	var local_transform = parent_transform
	for effect in spawn_with_projectile_effects:
		var instance = effect.instantiate()
		projectile_effects.append(instance)
		add_child(instance)
		instance.set_owner(self)
		instance.modify_creation(owner, spawn_with_projectile_effects, local_transform)
	# Spawn the default projectile
	# TODO:: Projectile spawn modification may want to prevent the default from spawning
	#    how do?
	owner.add_child(self)
	projectile_effects = projectile_effects


func _physics_process(delta):
	var position_modifier = transform.x * SPEED * delta
	for effect in projectile_effects:
		position_modifier = effect.modify_physics(position_modifier)
	set_position(position + position_modifier)

func _on_area_entered(area):
	# TODO: apply effects on enemy hit. For now just despawn.
	queue_free()
	area.owner.queue_free()
