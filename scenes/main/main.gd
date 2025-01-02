extends Node2D

@onready var frogSpawn: Marker2D = $FrogSpawn
@onready var frog: Area2D = $Frog

func _ready() -> void:
	Signals.respawn.connect(_on_respawn)

func _process(delta: float) -> void:
	pass

func _on_respawn():
	frog.position = frogSpawn.position
	frog.reset()
