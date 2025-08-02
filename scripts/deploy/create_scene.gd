
const utils = preload("res://scripts/lib/utils.gd")
const config = preload("res://scripts/config.gd")

# Entry Point

static func run():
    create_main_scene()

# Scene

static func get_viewport_size() -> Vector2:

    var viewport_width = "display/window/size/viewport_width"
    var viewport_height = "display/window/size/viewport_height"

    var w = utils.get_project_setting(viewport_width)
    var h = utils.get_project_setting(viewport_height)

    return Vector2(w, h)

static func create_main_scene():
    var stage_size = config.stage_size

    # root node
    var root = utils.create_node("Node2D")
    root.set_name("root")
    root.show()

    # stage node
    var stage_path = create_stage_scene()
    var stage = utils.load_scene(stage_path)
    utils.add_child(root, stage)

    # ship node
    var ship_path = create_ship_scene()
    var ship = utils.load_scene(ship_path)

    ship.set_position(stage_size / 2)

    utils.add_child(root, ship)

    # star node
    var star_path = create_star_scene()
    var star = utils.load_scene(star_path)

    star.set_position(Vector2(0, 0))

    utils.add_child(root, star)

    # HUD node
    var hud_path = create_hud_scene()
    var hud = utils.load_scene(hud_path)
    utils.add_child(root, hud)

    return utils.create_scene_from_node(root, "root")

static func create_stage_scene():
    var stage_size = config.stage_size

    # root node
    var stage = utils.create_node("Node2D")
    stage.set_name("stage")
    stage.show()

    # background color rect
    var bg = utils.create_node("ColorRect")
    bg.set_name("background")
    bg.set_color(Color.BLACK)
    bg.set_size(stage_size)
    utils.add_child(stage, bg)

    # particles
    var stars = utils.create_node("GPUParticles2D")
    stars.set_name("stars")

    stars.set_amount(config.stage_size.x)
    stars.set_lifetime(30)

    var rect = Rect2(0, 0, stage_size.x, stage_size.y)
    stars.set_visibility_rect(rect)

    ## material
    var material = ParticleProcessMaterial.new()
    var shape = ParticleProcessMaterial.EmissionShape.EMISSION_SHAPE_BOX
    material.set_emission_shape(shape)
    material.set_emission_box_extents(Vector3(stage_size.x, stage_size.y, 1))
    material.set_gravity(Vector3.ZERO)
    material.set_param_min(ParticleProcessMaterial.Parameter.PARAM_SCALE, 2)
    material.set_param_max(ParticleProcessMaterial.Parameter.PARAM_SCALE, 5)
    stars.set_process_material(material)

    utils.add_child(stage, stars)

    # add edges of the stage

    return utils.create_scene_from_node(stage, "stage")

static func create_ship_scene():

    # root node
    var ship = utils.create_node("RigidBody2D")
    ship.set_name("ship")
    ship.set_can_sleep(false)
    ship.set_contact_monitor(true)
    ship.set_max_contacts_reported(1)
    ship.set_gravity_scale(0.0)
    ship.set_angular_damp(2.0)
    ship.set_linear_damp(1.0)
    ship.set_script(load("res://scripts/ship.gd"))
    ship.show()

    # add camera
    var camera = utils.create_node("Camera2D")
    utils.add_child(ship, camera)

    # add ship polygon
    var poly = create_ship_polygon()
    utils.add_child(ship, poly)

    # add collision shape
    var col = utils.create_node("CollisionPolygon2D")
    col.set_polygon(poly.get_polygon())
    utils.add_child(ship, col)

    return utils.create_scene_from_node(ship, "ship")

static func create_ship_polygon():

    var p0 = Vector2(0, -30)
    var p1 = Vector2(-15, 30)
    var p2 = Vector2(15, 30)
    var color = Color.BLUE
    var poly = utils.create_triangle(p0, p1, p2, color)

    poly.set_name("ship")

    return poly

static func create_star_scene():

    # root node
    var star = utils.create_node("RigidBody2D")
    star.set_name("star")
    star.set_can_sleep(false)
    star.set_contact_monitor(true)
    star.set_max_contacts_reported(1)
    star.set_gravity_scale(0.0)
    star.set_angular_damp(2.0)
    star.set_linear_damp(1.0)
    star.set_script(load("res://scripts/star.gd"))
    star.show()

    # add star polygon
    var poly = create_star_polygon()
    utils.add_child(star, poly)

    # add collision shape
    var col = utils.create_node("CollisionPolygon2D")
    col.set_polygon(poly.get_polygon())
    utils.add_child(star, col)

    return utils.create_scene_from_node(star, "star")

static func create_star_polygon():

    var color = Color.YELLOW
    var poly = utils.create_circle(0, 0, 30, 30, color)

    poly.set_name("star")

    return poly

static func create_hud_scene():

    # root node
    var layer = utils.create_node("CanvasLayer")
    layer.set_name("HUD")
    layer.show()

    # minimap
    var minimap_path = create_minimap_scene()
    var minimap = utils.load_scene(minimap_path)
    utils.add_child(layer, minimap)

    return utils.create_scene_from_node(layer, "HUD")

static func create_minimap_scene():
    var x = config.minimap_x
    var y = config.minimap_y
    var width = config.minimap_width
    var height = config.minimap_height

    # root
    var minimap = utils.create_node("Node2D")
    minimap.set_name("minimap")
    minimap.set_position(Vector2(x, y))
    minimap.set_script(load("res://scripts/minimap.gd"))
    minimap.show()

    # background
    var bg = utils.create_node("ColorRect")
    bg.set_name("background")
    bg.set_color(Color.BLACK)
    bg.set_size(Vector2(width, height))
    utils.add_child(minimap, bg)

    # border
    var border = utils.create_rectangle_lines(0, 0, width, height, 2, Color.WHITE)
    border.set_name("border")
    utils.add_child(minimap, border)

    # ship
    var ship = utils.create_rectangle(0, 0, 8, 8, Color.LIGHT_SKY_BLUE)
    ship.set_name("ship")
    utils.add_child(minimap, ship)

    # star
    var star = utils.create_rectangle(0, 0, 8, 8, Color.YELLOW)
    star.set_name("star")
    utils.add_child(minimap, star)

    return utils.create_scene_from_node(minimap, "minimap")
