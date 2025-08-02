extends Node2D

const config = preload("res://scripts/config.gd")
const global = preload("res://scripts/global.gd")

@onready var ship = $ship
@onready var star = $star

func _process(_delta):
    var stage_w = config.stage_width
    var stage_h = config.stage_height
    var minimap_w = config.minimap_width
    var minimap_h = config.minimap_height

    # plot ship
    var ship_x = global.ship_position.x
    var ship_y = global.ship_position.y

    var mini_ship_x = minimap_w * ship_x / stage_w
    var mini_ship_y = minimap_h * ship_y / stage_h

    if ship:
        ship.position = Vector2(mini_ship_x, mini_ship_y)

    # plot star
    var star_x = global.star_position.x
    var star_y = global.star_position.y

    var mini_star_x = minimap_w * star_x / stage_w
    var mini_star_y = minimap_h * star_y / stage_h

    if star:
        star.position = Vector2(mini_star_x, mini_star_y)
