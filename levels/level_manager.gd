extends Node


var level_data: Array = []


@onready var spawn_timer = $SpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_level(1)
	
	
func _load_level(level_number: int):
	
	var file = FileAccess.open("res://levels/level%s.csv" % level_number, FileAccess.READ)
	var level_data = _parse_level_file(file)

	_progress_level()
	
func _parse_level_file(file: FileAccess):

	# skip header
	file.get_csv_line()
	while true:
		var line = file.get_csv_line()
		# if we're on the last line then we can finish loading.
		if len(line) == 1:
			break
		level_data.append(line)
	
	return level_data


func _progress_level():
	var next = level_data.pop_front()

	print("spawn next step in level now!!")
	print('step data: ', next)

	var timeout = float(next[0])
	var spawn_node = next[1]
	var enemy = next[2]
	
	spawn_timer.wait_time = timeout
	spawn_timer.start()


func _on_spawn_timer_timeout():
	if len(level_data) > 0:
		_progress_level()
	else:
		spawn_timer.stop()
