extends Area2D
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var hopSound: AudioStreamPlayer = $HopSound
@onready var splatSound: AudioStreamPlayer = $SplatSound
@onready var sinkSound: AudioStreamPlayer = $SinkSound
const POS_INCREMENT = 16

var dead = false
var moving = false

func run_over() -> void:
	animatedSprite.play("run_over")
	splatSound.play()
	die()

func sink() -> void:
	animatedSprite.play("sink")
	sinkSound.play()
	die()

func die() -> void:
	dead = true

func _ready() -> void:
	animatedSprite.animation = "hop_up"
	animatedSprite.frame = 1

func _process(delta: float) -> void:
	if(dead):
		return

	var overlappingAreas := get_overlapping_areas()
	var onWater = false
	var floating = false
	var raftSpeed = 0
	var raftDirection = Vector2.ZERO
			
	for areaOverlap in overlappingAreas:
		if(areaOverlap.is_in_group("Water")):
			onWater = true

		if(areaOverlap.is_in_group("Raft")):
			floating = true
			raftSpeed = areaOverlap.speed
			raftDirection = areaOverlap.direction

	if(onWater && !floating):
		sink()

	if(floating):
		position = raftSpeed * delta * raftDirection + position

func _input(event: InputEvent) -> void:
	if(!dead):
		if(!moving):
			var tween := create_tween()
			tween.connect("finished", _on_tween_finished)
			if event.is_action_pressed("Up"):
				tween.tween_property(self, "position", position + Vector2.UP * POS_INCREMENT, 0.125)
				animatedSprite.stop()
				animatedSprite.play("hop_up")
				hopSound.play()
				moving = true

			elif event.is_action_pressed("Down"):
				tween.tween_property(self, "position", position + Vector2.DOWN * POS_INCREMENT, 0.125)
				animatedSprite.stop()
				animatedSprite.play("hop_down")
				hopSound.play()
				moving = true

			elif event.is_action_pressed("Left"):
				tween.tween_property(self, "position", position + Vector2.LEFT * POS_INCREMENT, 0.125)
				animatedSprite.stop()
				animatedSprite.play("hop_left")
				hopSound.play()
				moving = true
				
			elif event.is_action_pressed("Right"):
				tween.tween_property(self, "position", position + Vector2.RIGHT * POS_INCREMENT, 0.125)
				animatedSprite.stop()
				animatedSprite.play("hop_right")		
				hopSound.play()	
				moving = true
			
			else:
				tween.kill()

func _on_tween_finished() -> void:
	moving = false
	
func _on_area_entered(area: Area2D) -> void:
	if(dead):
		return

	if(area.is_in_group("Vehicle")):
		run_over()