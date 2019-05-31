extends RigidBody2D

export (int) var MIN_SPEED
export (int) var MAX_SPEED

var mob_type = ["fly", "swim", "walk"]

func _ready():
	# pick a random type from the mob_type variable
	$AnimatedSprite.animation = mob_type[randi() % mob_type.size()]
	$AnimatedSprite.speed_scale = 3
	$AnimatedSprite.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # deletes the mob when it goes off the screen
