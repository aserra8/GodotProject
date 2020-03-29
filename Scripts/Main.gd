extends Node2D

signal effect

var score
var blackHoleNum
var coinCounter = 0
var speedCoinCounter = 0

export (PackedScene) var Mob
export (PackedScene) var Boss
export (PackedScene) var Coin
export (PackedScene) var SpeedCoin
export (PackedScene) var BlackHole


func _ready():
	randomize()


func game_over():
	$MobTimer.stop()
	$HUD.show_game_over()


func new_game():
	score = 0
	coinCounter = 0
	speedCoinCounter = 0
	
	blackHoleNum = int($HUD/BlackHoleLabel.text)
	
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	if (blackHoleNum != 0):
		for n in range(blackHoleNum):	
			GenerateBlackHoles()


func GenerateBlackHoles():
	var blackHole
	$MobPath/MobSpawnLocation.set_offset(randi())
	if ($HUD/CheckButton.is_pressed()):
		blackHole = BlackHole.instance()
		add_child(blackHole)
		blackHole.position = $MobPath/MobSpawnLocation.position
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		blackHole.rotation = direction
		blackHole.linear_velocity = Vector2(rand_range(80, 80), 0)
		blackHole.linear_velocity = blackHole.linear_velocity.rotated(direction)
	else:
		blackHole = BlackHole.instance()
		add_child(blackHole)
		blackHole.position = $MobPath/MobSpawnLocation.position
		
	$HUD.connect("start_game", blackHole, "_on_start_game")
	
	
func _on_Player_coin():
	score += 5
	

func _on_StartTimer_timeout():
	$MobTimer.start()
	
	
func _on_EffectTimer_timeout():
	emit_signal('effect')


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	var mob
	var boss
	var coin
	var speedCoin
	
	if (rand_range(0, 1) < 0.8):
		mob = Mob.instance()
		score += 1
		coinCounter += 1
		speedCoinCounter += 1
	else:
		mob = Boss.instance()
		score += 2
		coinCounter += 2
		speedCoinCounter += 2
		
	add_child(mob)
	$HUD.update_score(score)
	
	if (coinCounter >= 20):
		coinCounter = 0
		coin = Coin.instance()
		add_child(coin)
		coin.position = $MobPath/MobSpawnLocation.position
		
	if (speedCoinCounter >= 30):
		speedCoinCounter = 0
		speedCoin = SpeedCoin.instance()
		add_child(speedCoin)
		speedCoin.position = $MobPath/MobSpawnLocation.position
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	$HUD.connect("start_game", mob, "_on_start_game")
	$HUD.connect("start_game", boss, "_on_start_game")
	$HUD.connect("start_game", coin, "_on_start_game")
	$HUD.connect("start_game", speedCoin, "_on_start_game")


func _on_Player_speedCoin():
	$EffectTimer.start()
