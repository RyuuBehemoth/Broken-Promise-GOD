extends CharacterBody2D
const speed = 30
var current_state = IDLE
	
var dir = Vector2.RIGHT
var start_pos
	
var is_roaming = true
var is_chatting = false

var PelaoCarbon
var player_in_chat_zone = false
	
enum{
	IDLE,NEW_DIR,MOVE
}

func _ready():
	randomize()
	start_pos = position
	
	
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("quieto")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("caminal_i")
		if dir.x == 1:
			$AnimatedSprite2D.play("caminal_d")
		if dir.y == -1:
			$AnimatedSprite2D.play("caminal_n")
		if dir.y ==1:
			$AnimatedSprite2D.play("caminal_s")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP,Vector2.LEFT,Vector2.DOWN])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("Interactuar") and player_in_chat_zone and !is_chatting:
		print("chatting with npc")
		$Dialogo.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("quieto")
				
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chatting:
		velocity = dir * speed
		move_and_slide()
	
func _on_pelao_np_zone_body_entered(body):
	if body.name == "PelaoCarbon":
		PelaoCarbon = body
		player_in_chat_zone = true


func _on_pelao_np_zone_body_exited(body):
	if body.name == "PelaoCarbon":
		player_in_chat_zone = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_dialogo_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true
