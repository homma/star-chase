@tool
extends EditorScript

const utils = preload("res://scripts/lib/utils.gd")
const set_project = preload("res://scripts/deploy/set_project.gd")
const create_scene = preload("res://scripts/deploy/create_scene.gd")

# Entry Point

func _run():
    set_project.run()
    create_scene.run()
