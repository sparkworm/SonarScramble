class_name SoundManager
extends Node

var music_players: Array
var sfx_alert_players: Array
var sfx_ambiant_players: Array
var sfx_movement_players: Array
var sfx_scan_players: Array
var sfx_ui_players: Array

var active_scene: GameScene

func update(new_active_scene: GameScene = null) -> void:
	active_scene = new_active_scene
	var active_tree: SceneTree = get_parent().get_tree()#active_scene.get_tree()
	#print(get_parent().get_tree_string_pretty())
	music_players = active_tree.get_nodes_in_group("music")
	sfx_alert_players = active_tree.get_nodes_in_group("sfx_alert")
	sfx_ambiant_players = active_tree.get_nodes_in_group("sfx_ambiant")
	sfx_movement_players = active_tree.get_nodes_in_group("sfx_movement")
	sfx_scan_players = active_tree.get_nodes_in_group("sfx_scan")
	sfx_ui_players = active_tree.get_nodes_in_group("music")
	
	for i in music_players:
		i.volume_db = Settings.sound_settings["music"]
		#print(i)
	for i in sfx_alert_players:
		i.volume_db = Settings.sound_settings["sfx_alert"]
		#print(i)
	for i in sfx_ambiant_players:
		i.volume_db = Settings.sound_settings["sfx_ambiant"]
		#print(i)
	for i in sfx_movement_players:
		i.volume_db = Settings.sound_settings["sfx_movement"]
		#print(i)
	for i in sfx_scan_players:
		i.volume_db = Settings.sound_settings["sfx_scan"]
		#print(i)
	for i in sfx_ui_players:
		i.volume_db = Settings.sound_settings["sfx_ui"]
		#print(i)
