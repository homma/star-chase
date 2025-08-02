
const utils = preload("res://scripts/lib/utils.gd")
const config = preload("res://scripts/config.gd")

# Entry Point

static func run():
    set_project()

# Project Setting

static func set_project():
    set_project_info()
    set_window_size()
    create_input_mapping()

static func set_project_info():
    var name_path = "application/config/name"
    var name = config.project_name
    utils.set_project_setting(name_path, name)

    var desc_path = "application/config/description"
    var description = config.project_description
    utils.set_project_setting(desc_path, description)

static func set_window_size():
    var width_path = "display/window/size/viewport_width"
    var width = config.viewport_width
    utils.set_project_setting(width_path, width)
    
    var height_path = "display/window/size/viewport_height"
    var height = config.viewport_height
    utils.set_project_setting(height_path, height)

static func create_input_mapping():
    # needs editor restart to be visible in the editor
    create_input_turn_left()
    create_input_turn_right()
    create_input_thrust()

static func create_input_turn_left():
    var path = "input/turn_left"

    var input = {}
    input.deadzone = 0.2

    var arrow_key = InputEventKey.new()
    arrow_key.set_physical_keycode(KEY_LEFT)

    var char_key = InputEventKey.new()
    char_key.set_physical_keycode(KEY_A)

    var stick = InputEventJoypadMotion.new()
    stick.set_axis(JoyAxis.JOY_AXIS_LEFT_X)
    stick.set_axis_value(-1)

    input.events = [arrow_key, char_key, stick]

    utils.set_project_setting(path, input)

static func create_input_turn_right():
    var path = "input/turn_right"

    var input = {}
    input.deadzone = 0.2

    var arrow_key = InputEventKey.new()
    arrow_key.set_physical_keycode(KEY_RIGHT)

    var char_key = InputEventKey.new()
    char_key.set_physical_keycode(KEY_D)

    var stick = InputEventJoypadMotion.new()
    stick.set_axis(JoyAxis.JOY_AXIS_LEFT_X)
    stick.set_axis_value(1)

    input.events = [arrow_key, char_key, stick]

    utils.set_project_setting(path, input)

static func create_input_thrust():
    var path = "input/thrust"

    var input = {}
    input.deadzone = 0.2

    var arrow_key = InputEventKey.new()
    arrow_key.set_physical_keycode(KEY_UP)

    var char_key = InputEventKey.new()
    char_key.set_physical_keycode(KEY_W)

    var button = InputEventJoypadButton.new()
    button.set_button_index(JoyButton.JOY_BUTTON_A)

    input.events = [arrow_key, char_key, button]

    utils.set_project_setting(path, input)
