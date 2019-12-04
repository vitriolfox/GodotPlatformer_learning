extends KinematicBody2D
class_name Actor

#defining the moving speed for the actors move_and_slide function
export var velocity: = Vector2.ZERO

#defining the fall down speed for the actors _physics_pricess function
export var gravity: = 3000.0

#defining the maximum speed on the x and y axis
export var speedLimit: = Vector2(300.0, 1000.0)

