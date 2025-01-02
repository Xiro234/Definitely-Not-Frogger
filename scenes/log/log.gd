extends Area2D
@onready var sprite2D: Sprite2D = $Sprite2D

var speed: int = 100
var direction: Vector2 = Vector2.LEFT
var number = 1

func loadTexture(num: int):
	$Sprite2D.set_texture(load("res://scenes/log/sprites/log" + str(num) + ".png"))

func _ready() -> void:
	loadTexture(number)

func _process(delta: float) -> void:
	var new_position = speed * delta * direction + position

	if(direction.x == -1 && new_position.x < -150):
		queue_free()
	elif(direction.x == 1 && new_position.x > 150):
		queue_free()
	else:
		position = new_position