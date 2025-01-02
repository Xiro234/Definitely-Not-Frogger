extends Node2D

@onready var frog: Area2D = $Frog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.frog_runover.connect(_on_frog_runover)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_frog_runover():
	frog.dead = true
