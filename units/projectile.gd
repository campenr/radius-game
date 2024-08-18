extends Area2D

const SPEED = 750
var projectile_effects: Array[ProjectileEffect] = []


func spawn(owner: Node, spawn_with_projectile_effects: Array[ProjectileEffect], parent_transform: Transform2D):
	# Execute any spawn modification effects for the projectile
	print("spawned!")
	projectile_effects = spawn_with_projectile_effects
	var local_transform = parent_transform
	for effect in projectile_effects:
		add_child(effect)
		effect.set_owner(self)
		effect.modify_creation(owner, projectile_effects, local_transform)
	# Spawn the default projectile
	# TODO:: Projectile spawn modification may want to prevent the default from spawning
	#    how do?
	owner.add_child(self)
	projectile_effects = projectile_effects
	transform = local_transform

func scale_projectile(new_scale: Vector2):
	$Sprite2D.scale = new_scale
	$CollisionShape2D.scale = new_scale

func _ready():
	if scale != Vector2.ONE:
		scale_projectile(scale)

func _physics_process(delta):
	var position_modifier = transform.x * SPEED * delta
	for effect in projectile_effects:
		position_modifier = effect.modify_physics(position_modifier)
	set_position(position + position_modifier)

func _on_area_entered(area):
	# TODO: apply effects on enemy hit. For now just despawn.
	queue_free()
	area.owner.queue_free()

func _integrate_forces(delta):
	scale = Vector2(100, 100)
