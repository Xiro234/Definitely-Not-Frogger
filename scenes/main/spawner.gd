extends Marker2D

@export var direction = Vector2.LEFT
@export var entity: PackedScene
@export var spriteNumber: int = 1

@export var entitySpeed = 100
@export var timeBetweenGroups: float = 5
@export var distanceBetweenEntities = 100
@export var groupCount = 3

var previousGroupTime = -10000

var turtleDiverCount = 0

func _process(delta: float) -> void:
	var currTime = Time.get_ticks_msec()

	if(currTime > previousGroupTime + timeBetweenGroups * 1000):
		spawnGroup()
		previousGroupTime = currTime

func spawnGroup():
	for i in range(groupCount):
		var entityInstance = entity.instantiate()
		if(entityInstance.is_in_group("Numbered Sprite")):
			entityInstance.number = spriteNumber
			entityInstance.position = position + Vector2(i * distanceBetweenEntities * -direction.x, 0)
			entityInstance.direction = direction
			entityInstance.speed = entitySpeed
		else:
			entityInstance.position = position + Vector2(i * distanceBetweenEntities * -direction.x, 0)
			entityInstance.speed = entitySpeed

		if(entityInstance.is_in_group("Turtle")):
			if(turtleDiverCount > 2):
				turtleDiverCount = 0
				entityInstance.dives = true
			else:
				turtleDiverCount += 1
			
			print(turtleDiverCount)

		get_parent().add_child(entityInstance)
