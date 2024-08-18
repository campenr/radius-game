class_name EffectDoubleLaser
extends ProjectileEffect

var Projectile : PackedScene = preload("res://units/projectile.tscn")

@export var laser_offset = Vector2(0, -50)
const is_double_laser = true

func check_not_double_laser(effect: PackedScene) -> bool:
	# TODO:: Filter on type? This implementation is Bad
	if "is_double_laser" in effect:
		return not effect.is_double_laser

	# TODO:: Hacky? but const on the node does not work for packed scenes
	return effect.resource_path != "res://projectiles/double_laser.tscn"

func modify_creation(owner: Node, projectile_effects: Array, transform: Transform2D):
		var p = Projectile.instantiate()
		# TODO:: Stacking double-lasers? would mean we only want to filter 1 out of this list.
		var non_recursive_effects = projectile_effects.filter(check_not_double_laser)
		var doubled_transform = transform
		# TODO:: Do we want to offset the laser, or do we want to angle out of the same point of origin?
		doubled_transform.origin += laser_offset
		p.spawn(owner, non_recursive_effects, doubled_transform)
