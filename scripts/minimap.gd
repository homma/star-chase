extends Node2D

const config = preload("res://scripts/config.gd")
const global = preload("res://scripts/global.gd")

@onready var ship = $ship

func _process(_delta):
    var stage_w = config.stage_width
    var stage_h = config.stage_height
    var minimap_w = config.minimap_width
    var minimap_h = config.minimap_height
    var ship_x = global.ship_position.x
    var ship_y = global.ship_position.y

    var x = minimap_w * ship_x / stage_w
    var y = minimap_h * ship_y / stage_h

    if ship:
        ship.position = Vector2(x, y)
