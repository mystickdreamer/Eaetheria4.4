extends Node
class_name DiceRoller

#This script rolls a number of 10 sided dice and determines how many successes the roll has

#num_dice how many dice we are rolling
# difficulty minimum roll to succeed default is 7

func roll_dice(num_dice:int, difficulty:int) -> int:
	var eff_difficulty = 7 + difficulty
	var successes = 0
	print("Rolling num D: ", num_dice)
	for i in range(num_dice):
		
		var roll = randi() % 10 + 1
		if roll == 1:
			successes -= 1 # A roll of 1 removed successes
			print("rolled a 1")
		elif roll > eff_difficulty:
			print("Rolled a success")
			successes += 1 # Count as a success
			if roll == 10:
				successes += roll_dice(1, difficulty)
				
	return successes
