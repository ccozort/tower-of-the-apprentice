class_name Enemy
extends CharacterBody2D
var stats: EnemyStats

var cloned_stats = stats.duplicate()

#for the deep cloning
var deep_cloned = stats.duplicate(true)
