extends Node2D


const VERTICAL_SPEED = 1000
const HORIZONTAL_SPEED = 1000

const VERTICAL_BUFFER = 50
const HORIZONTAL_BUFFER = 75


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var viewport_bounds = get_viewport_rect().size
	
	if Input.is_action_pressed("up") and global_position.y > 0 + VERTICAL_BUFFER:
		position.y -= VERTICAL_SPEED * delta
	elif Input.is_action_pressed("down") and global_position.y < viewport_bounds.y - VERTICAL_BUFFER:
		position.y += VERTICAL_SPEED * delta
	
	if Input.is_action_pressed("left") and global_position.x > 0 + HORIZONTAL_BUFFER:
		position.x -= HORIZONTAL_SPEED * delta
	elif Input.is_action_pressed("right") and global_position.x < viewport_bounds.x - HORIZONTAL_BUFFER:
		position.x += HORIZONTAL_SPEED * delta
