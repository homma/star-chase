extends Line2D

const global = preload("res://scripts/global.gd")

func _physics_process(_delta):
    var star_position = global.star_position
    var star_angle = global_position.angle_to_point(star_position)
    var perpendicular = PI / 2 # deg_to_rad(90)
    # rotation = star_angle + perpendicular - global_rotation
    rotation = 0
    rotation = star_angle + perpendicular - global_rotation
