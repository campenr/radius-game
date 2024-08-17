class_name ProjectileEffect
extends Node
# A ProjectileEffect is a set of post-processors meant to be run on every instance of a Projectile.
# This by itself does nothing but is meant to be extended by various types of projectile effect.
# Each effect will compound on the others. Each function will be called by the Projectile scene,
#    in order of Effect Priority
# TODO:: Effect Priority as an enum? (to discourage "priority: 9999999")

# Each modifier is a combination of a double value and a modification type.
# This is to indicate if a modification is additive or multiplicitive.
# The default for all modifiers is MULTIPLICITIVE : 1, ultimately resulting in no effect.
# (To subtract and divide, use negative values and decimals < 1)
enum MODIFICATION_TYPE {
	ADD,
	MULTIPLY
}
@export var effect_priority = -1
@export var speed_modifier_type = MODIFICATION_TYPE.MULTIPLY
@export var speed_modifier = 1
@export var damage_modifier_type = MODIFICATION_TYPE.MULTIPLY
@export var damage_modifier = 1
@export var scale_modifier_type = MODIFICATION_TYPE.MULTIPLY
@export var scale_modifier = 1


# Modify the logic that adds the projectile as a child to the scene.
# This can be used to change spawn locations, quantities, etc.
func modify_creation(owner: Node):
	pass

# Modify the physics logic of the projectile. This function will be called
#    during the _physics_process.
# Uses exported variables by default, and should only be overridden if you're
#    doing something really interesting.
func modify_physics(position_modifier: Vector2) -> Vector2:
	# TODO:: How does godot mutability work? we do NOT want to modify the original modifier
	var return_modifier = position_modifier
	if speed_modifier_type == MODIFICATION_TYPE.MULTIPLY:
		return_modifier *= speed_modifier
	elif speed_modifier_type == MODIFICATION_TYPE.ADD:
		return_modifier += speed_modifier
	return return_modifier


# Simple changes to the appearance using built-in features.
# By default, 
func modify_appearance():
	pass


# To change the sprite itself, elements of the animation, or otherwise add effects
# Hard changes, rather than additions, will not
func modify_animation():
	pass


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	var projectile = get_owner()
	if projectile:
		# Projectile scenes are instantiated before being added to the tree
		# This function will effectively be called twice, but some operations
		#    require the parent node to be present first.
		projectile.scale_projectile(modify_appearance(projectile.scale))
