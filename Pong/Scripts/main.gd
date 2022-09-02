# Thanks to Clear Code for the pong tutorial
# Video link - https://www.youtube.com/watch?v=kr1BoEbuveI&list=WL&index=14&t=3239s&ab_channel=ClearCode

# Edited by Edward Cruz

extends Node


var PlayerScore : int = 0
var OpponentScore : int = 0

func _ready():
	$player.position.x = 35
	$Opponent.position.x = 1020 - 35
	$Ball.position = Vector2(640, 380)

func _process(delta):
	$PlayerScore.text = "PLAYER: " + str(PlayerScore)
	$OpponentScore.text = "CPU: " + str(OpponentScore)
	$CountdownLabel.text = str(int($CountdownTimer.time_left) + 1)

func _on_CountdownTimer_timeout():
	get_tree().call_group('BallGroup','restart_ball')
	$CountdownLabel.visible = false

func score_achieved():
	$Ball.position = Vector2(510, 300)
	
	get_tree().call_group('BallGroup','stop_ball')
	$CountdownTimer.start()
	$CountdownLabel.visible = true
	$ScoreSound.play()
	$player.position.x = 35
	$Opponent.position.x = 1020 - 35

func _on_right_goal_body_entered(body):
	if (body == get_node("Ball")):
		score_achieved()
		PlayerScore += 1
		print("PlayerScore: " + str(PlayerScore))


func _on_left_goal_body_entered(body):
	if (body == get_node("Ball")):
		score_achieved()
		OpponentScore += 1
		print("OpponentScore: " + str(OpponentScore))
