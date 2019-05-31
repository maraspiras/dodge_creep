extends Area2D

# collission
signal hit

export (int) var SPEED
var velocity = Vector2()
var screensize 

func _ready():
	# check for screenSize
	screensize = get_viewport_rect().size
	hide()
	
# event handler
func _process(delta):
	velocity = Vector2()
	
	# handle key events
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		$AnimatedSprite.play()
		velocity = velocity.normalized() * SPEED
		$Trail.emitting = true
	else:
		$AnimatedSprite.stop()
		$Trail.emitting = false
	
	# fix speed up from holding up and right at the same time
	position += velocity * delta
	
	# create clamp borders
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	# if dodgy is moving left to right then set animation to "right"
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	
	# if dodgy is moving up and down then set animation to "up"
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	

# run this function when hit box on dodgy's rect
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)

func start(pos):
	position = pos
	show()
	monitoring = true
