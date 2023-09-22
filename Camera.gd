extends Camera2D

@onready var camera = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.set_enabled(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
