class_name Player extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $PlayerSprite
@onready var attack_sprites: Sprite2D = $AttackSprites
@onready var state_machine: Player_State_Machine = $PlayerStateMachine
@onready var hit_box: HitBox = $HitBox

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false
var hit_points: int = 6
var max_hp: int = 6
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

signal direction_changed(new_direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

func _ready() -> void:
	PlayerManager.player = self
	state_machine.initialize_player_state_machine(self)
	hit_box.damaged.connect(_take_damage)
	update_hp(99)
	pass

func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		update_hp(-99)
		player_damaged.emit(%AttackHurtBox)
	pass

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
		
	var direction_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size() ))
	var new_dir = DIR_4[direction_id]
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	
	var sprite_scale = -1 if cardinal_direction == Vector2.LEFT else 1
	sprite.scale.x = sprite_scale
	attack_sprites.scale.x = sprite_scale

	return true
	
func update_animation(state: String) -> void:
	animation_player.play(state + "_" + anim_direction());
	pass	
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func _take_damage(hurt_box: HurtBox) -> void:
	if invulnerable == true:
		return
		
	if hit_points > 0:
		update_hp(-hurt_box.damage)
		player_damaged.emit(hurt_box)
	pass
	
func update_hp(delta: int) -> void:
	hit_points = clampi(hit_points + delta, 0, max_hp)
	PlayerHud.update_hp(hit_points, max_hp)
	pass
	
func make_invulnerable(_duration: float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass
	
func revive_player() -> void:
	update_hp(99)
	state_machine.change_state($PlayerStateMachine/Idle)
	pass
