extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_used_cells():
		var scene  = load(get_cell_tile_data(i).get_custom_data("path"))
		var instance = scene.instantiate()
		instance.position = 8*i
		add_child(instance)
		
	enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
