class_name Enemy
extends CharacterBody2D


@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
# This guy doesn't actually attack, he just tries to get close to the player
@export var follow_radius := 25.0

@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(delta):
	move_and_slide()

func _ready():
	pass
