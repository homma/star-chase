@tool

# project

static var project_name: String = "spaceship"
static var project_description: String = "a spaceship game"

# viewport

static var viewport_width: float = 1152 * 2
static var viewport_height: float = 648 * 2
static var viewport_size: Vector2 = Vector2(viewport_width, viewport_height)

# stage

static var stage_width: float = 40000
static var stage_height: float = 40000
static var stage_size: Vector2 = Vector2(stage_width, stage_height)

# HUD

## minimap

static var minimap_margin_top: float = 30
static var minimap_margin_right: float = 30
static var minimap_width: float = 300
static var minimap_height: float = 300
static var minimap_x: float = viewport_width - minimap_width - minimap_margin_right
static var minimap_y: float = minimap_margin_top

# ship

static var thrust: float = 3000
static var dash_thrust: float = thrust * 2
static var torque: float = 2000
