extends CharacterBody2D
@export var animation:Node
@export var area_2d: Area2D
@export var texto: CanvasGroup

const SPEED = 300.0

func _ready():
	area_2d.body_entered.connect(_on_area_2d_body_entered)


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
	if (velocity.x > 0):
		animation.play("derecha")
	else: if (velocity.x < 0):
		animation.play("izquierda")
	else: if (velocity.y < 0):
		animation.play("arriba")
	else: if (velocity.y > 0):
		animation.play("abajo")
	else: if (velocity.x == 0):
		animation.play("quietoparao")

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("skibidi")
