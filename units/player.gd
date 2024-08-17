extends Node2D


const VERTICAL_SPEED = 1000
const HORIZONTAL_SPEED = 1000

const VERTICAL_BUFFER = 50
const HORIZONTAL_BUFFER = 75

@export var Projectile : PackedScene
@onready var projectile_spawner = $ProjectileSpawner
var DoubleLaserEffect : PackedScene = preload("res://projectiles/double_laser.tscn")
var HugeLaserEffect : PackedScene = preload("res://projectiles/huge_laser.tscn")
var FastLaserEffect : PackedScene = preload("res://projectiles/fast_laser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Projectile = load("res://units/projectile.tscn")

func fire():
	print('fired!')
	var p = Projectile.instantiate()
	# Effects must be instantiated for each projectile.
	# Finding a way to manage "which effects we need to instantiate" and
	#    "Which effects are actually on this projectile" is key
	var effects = [DoubleLaserEffect, HugeLaserEffect, FastLaserEffect]
	p.spawn(owner, effects, transform)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var viewport_bounds = get_viewport_rect().size
	
	if Input.is_action_pressed("up") and global_position.y > 0 + VERTICAL_BUFFER:
		position.y -= VERTICAL_SPEED * delta
	elif Input.is_action_pressed("down") and global_position.y < viewport_bounds.y - VERTICAL_BUFFER:
		position.y += VERTICAL_SPEED * delta
	
	if Input.is_action_pressed("left") and global_position.x > 0 + HORIZONTAL_BUFFER:
		position.x -= HORIZONTAL_SPEED * delta
	elif Input.is_action_pressed("right") and global_position.x < viewport_bounds.x - HORIZONTAL_BUFFER:
		position.x += HORIZONTAL_SPEED * delta

	if Input.is_action_just_pressed("fire"):
		print('fired!')
		var p = Projectile.instantiate()
		p.spawn(owner, projectile_effects)
		# TODO:: This transform should probably be modifiable by projectile effects too?
		p.transform = projectile_spawner.global_transform
