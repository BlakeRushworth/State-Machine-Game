extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed :=40.0

var animation_player
var player: CharacterBody2D

func Enter():
	print("emeny walk")
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("animation")

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	#print(float(direction.length()))
	
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
		animation_player.play("walk")
		#print("walking")
	else:
		enemy.velocity = Vector2()
	
	if direction.length() > 250:
		#print("Go to Idle, Blake!!")
		Transitioned.emit(self, "EnemyIdle")

func Exit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_area_entered(area):
	if area.is_in_group("arrow"):
		Transitioned.emit(self, "EnemyHit")
