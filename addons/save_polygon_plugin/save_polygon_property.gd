extends EditorProperty


var vbox_container: VBoxContainer = VBoxContainer.new()
var save_polygon_button: Button = Button.new()
var load_polygon_button: Button = Button.new()
var file_dialogue: EditorFileDialog
var last_dir: String


func _init() -> void:
	
	label = "Save/Load Polygon"
	add_child(vbox_container)
	
	
	#Save polygon button
	save_polygon_button.text = "Save Polygon"
	
	vbox_container.add_child(save_polygon_button)
	add_focusable(save_polygon_button)
	
	save_polygon_button.connect("pressed", _on_save_polygon_button_pressed)
	
	
	#Load polygon button
	load_polygon_button.text = "Load Polygon"
	
	vbox_container.add_child(load_polygon_button)
	add_focusable(load_polygon_button)
	
	load_polygon_button.connect("pressed", _on_load_polygon_button_pressed)


func _on_save_polygon_button_pressed():
	
	if file_dialogue == null:
		
		file_dialogue = EditorFileDialog.new()
		file_dialogue.access = EditorFileDialog.ACCESS_FILESYSTEM
		file_dialogue.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
		file_dialogue.filters = PackedStringArray(["*.tres ; Resource File", "*.json ; JSON File"])
		file_dialogue.file_selected.connect(_on_file_selected)
		add_child(file_dialogue)
	else:
		file_dialogue.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	
	
	if last_dir != null:
		file_dialogue.current_dir = last_dir
	
	file_dialogue.popup_centered_ratio(0.7)  # opens the dialog


func _on_load_polygon_button_pressed():
	
	if file_dialogue == null:
		
		file_dialogue = EditorFileDialog.new()
		file_dialogue.access = EditorFileDialog.ACCESS_FILESYSTEM
		file_dialogue.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
		file_dialogue.filters = PackedStringArray(["*.tres ; Resource File", "*.json ; JSON File"])
		file_dialogue.file_selected.connect(_on_file_selected)
		add_child(file_dialogue)
	else:
		file_dialogue.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	
	
	if last_dir != null:
		file_dialogue.current_dir = last_dir
	
	file_dialogue.popup_centered_ratio(0.7)  # opens the dialog


func _on_file_selected(path: String):
	
	if file_dialogue.file_mode == EditorFileDialog.FILE_MODE_SAVE_FILE:
		
		var object = get_edited_object()
		
		var resource := PolygonResource.new()
		if object.polygon is PackedVector2Array:
			#resource.polygon is PackedVector2Array, you can add other types if needed
			resource.polygon = object.polygon
		
		ResourceSaver.save(resource, path)   # saves with chosen name
		last_dir = path
		
		print("Saved polygon to: ", path)
	
	elif file_dialogue.file_mode == EditorFileDialog.FILE_MODE_OPEN_FILE:
		
		var object = get_edited_object()
		
		var resource := load(path)
		if object.polygon is PackedVector2Array:
			#resource.polygon is PackedVector2Array, you can add other types if needed
			object.polygon = resource.polygon
		
		last_dir = path
		
		print("Loaded polygon from: ", path)

