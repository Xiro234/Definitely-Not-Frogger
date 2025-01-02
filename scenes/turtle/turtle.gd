extends Area2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var underwaterTimer: Timer = $UnderwaterTimer
@export var diveFrequency: float = 2

var speed: int = 100
var direction: Vector2 = Vector2.LEFT
var dives = false

var isUnderwater = false

var previousDiveTime = -10000

func _ready() -> void:
	if(dives):
		animatedSprite.play("diver")

func _process(delta: float) -> void:
	if(dives):
		var currTime = Time.get_ticks_msec()

		if(currTime > previousDiveTime + diveFrequency * 1000):
			changeWaterState()
			underwaterTimer.start()
			previousDiveTime = currTime
			
	var new_position = speed * delta * Vector2.LEFT + position

	if(new_position.x < -150):
		queue_free()
	else:
		position = new_position

func changeWaterState():
	isUnderwater = !isUnderwater

	if(!isUnderwater):
		add_to_group("Raft")
	else:
		remove_from_group("Raft")

func _on_underwater_timer_timeout() -> void:
	changeWaterState()
