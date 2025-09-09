@tool
extends EditorPlugin
#Very simple plugin for saving polygon PackedVector2Array as Resource
#Made by ATGolden


# A class member for the inspector
var inspector_plugin


func _enter_tree():
	# Initialization of the plugin goes here.
	# Load the dock scene and instantiate it.
	inspector_plugin = preload("res://addons/save_polygon_plugin/inspector_plugin.gd").new()

	# Add the loaded scene to the docks.
	add_inspector_plugin(inspector_plugin)
	# Note that LEFT_UL means the left of the editor, upper-left dock.


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_inspector_plugin(inspector_plugin)
	# Erase the control from the memory.
