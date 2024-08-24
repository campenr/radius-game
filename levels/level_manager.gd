extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_level(1)
	
func _load_level(level_number: int):
	
	var file = FileAccess.open("res://levels/level%s.csv" % level_number, FileAccess.READ)
	var level_data = _parse_level_file(file)
	
	print(level_data)
	
	
func _parse_level_file(file: FileAccess):

	var level_data = []

	# skip header
	file.get_csv_line()
	while true:
		var line = file.get_csv_line()
		# if we're on the last line then we can finish loading.
		if len(line) == 1:
			break
		level_data.append(line)
	
	return level_data
