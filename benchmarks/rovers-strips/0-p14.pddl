(define (problem roverprob2032) (:domain Rover)
(:objects
	general - Lander
	colour high_res low_res - Mode
	rover0 - Rover
	rover0store - Store
	waypoint0 waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6 waypoint7 waypoint8 waypoint9 waypoint10 waypoint11 waypoint12 waypoint13 waypoint14 waypoint15 waypoint16 waypoint17 waypoint18 - Waypoint
	camera0 camera1 - Camera
	objective0 objective1 objective2 objective3 objective4 objective5 objective6 objective7 objective8 objective9 objective10 objective11 objective12 objective13 objective14 objective15 objective16 objective17 - Objective
	)
(:init
	(visible waypoint0 waypoint3)
	(visible waypoint3 waypoint0)
	(visible waypoint0 waypoint11)
	(visible waypoint11 waypoint0)
	(visible waypoint1 waypoint0)
	(visible waypoint0 waypoint1)
	(visible waypoint1 waypoint7)
	(visible waypoint7 waypoint1)
	(visible waypoint1 waypoint8)
	(visible waypoint8 waypoint1)
	(visible waypoint1 waypoint16)
	(visible waypoint16 waypoint1)
	(visible waypoint1 waypoint18)
	(visible waypoint18 waypoint1)
	(visible waypoint2 waypoint4)
	(visible waypoint4 waypoint2)
	(visible waypoint2 waypoint15)
	(visible waypoint15 waypoint2)
	(visible waypoint3 waypoint1)
	(visible waypoint1 waypoint3)
	(visible waypoint3 waypoint4)
	(visible waypoint4 waypoint3)
	(visible waypoint4 waypoint5)
	(visible waypoint5 waypoint4)
	(visible waypoint4 waypoint11)
	(visible waypoint11 waypoint4)
	(visible waypoint4 waypoint14)
	(visible waypoint14 waypoint4)
	(visible waypoint4 waypoint17)
	(visible waypoint17 waypoint4)
	(visible waypoint5 waypoint1)
	(visible waypoint1 waypoint5)
	(visible waypoint5 waypoint7)
	(visible waypoint7 waypoint5)
	(visible waypoint5 waypoint9)
	(visible waypoint9 waypoint5)
	(visible waypoint5 waypoint14)
	(visible waypoint14 waypoint5)
	(visible waypoint5 waypoint15)
	(visible waypoint15 waypoint5)
	(visible waypoint6 waypoint5)
	(visible waypoint5 waypoint6)
	(visible waypoint6 waypoint7)
	(visible waypoint7 waypoint6)
	(visible waypoint6 waypoint15)
	(visible waypoint15 waypoint6)
	(visible waypoint7 waypoint13)
	(visible waypoint13 waypoint7)
	(visible waypoint7 waypoint18)
	(visible waypoint18 waypoint7)
	(visible waypoint8 waypoint3)
	(visible waypoint3 waypoint8)
	(visible waypoint8 waypoint6)
	(visible waypoint6 waypoint8)
	(visible waypoint8 waypoint7)
	(visible waypoint7 waypoint8)
	(visible waypoint8 waypoint9)
	(visible waypoint9 waypoint8)
	(visible waypoint8 waypoint12)
	(visible waypoint12 waypoint8)
	(visible waypoint8 waypoint14)
	(visible waypoint14 waypoint8)
	(visible waypoint8 waypoint18)
	(visible waypoint18 waypoint8)
	(visible waypoint9 waypoint0)
	(visible waypoint0 waypoint9)
	(visible waypoint9 waypoint4)
	(visible waypoint4 waypoint9)
	(visible waypoint9 waypoint6)
	(visible waypoint6 waypoint9)
	(visible waypoint9 waypoint7)
	(visible waypoint7 waypoint9)
	(visible waypoint9 waypoint11)
	(visible waypoint11 waypoint9)
	(visible waypoint10 waypoint5)
	(visible waypoint5 waypoint10)
	(visible waypoint10 waypoint9)
	(visible waypoint9 waypoint10)
	(visible waypoint10 waypoint16)
	(visible waypoint16 waypoint10)
	(visible waypoint11 waypoint8)
	(visible waypoint8 waypoint11)
	(visible waypoint11 waypoint10)
	(visible waypoint10 waypoint11)
	(visible waypoint11 waypoint17)
	(visible waypoint17 waypoint11)
	(visible waypoint12 waypoint11)
	(visible waypoint11 waypoint12)
	(visible waypoint13 waypoint0)
	(visible waypoint0 waypoint13)
	(visible waypoint13 waypoint2)
	(visible waypoint2 waypoint13)
	(visible waypoint13 waypoint8)
	(visible waypoint8 waypoint13)
	(visible waypoint13 waypoint11)
	(visible waypoint11 waypoint13)
	(visible waypoint13 waypoint14)
	(visible waypoint14 waypoint13)
	(visible waypoint13 waypoint16)
	(visible waypoint16 waypoint13)
	(visible waypoint14 waypoint2)
	(visible waypoint2 waypoint14)
	(visible waypoint14 waypoint7)
	(visible waypoint7 waypoint14)
	(visible waypoint14 waypoint10)
	(visible waypoint10 waypoint14)
	(visible waypoint14 waypoint12)
	(visible waypoint12 waypoint14)
	(visible waypoint14 waypoint15)
	(visible waypoint15 waypoint14)
	(visible waypoint15 waypoint7)
	(visible waypoint7 waypoint15)
	(visible waypoint15 waypoint8)
	(visible waypoint8 waypoint15)
	(visible waypoint15 waypoint9)
	(visible waypoint9 waypoint15)
	(visible waypoint15 waypoint11)
	(visible waypoint11 waypoint15)
	(visible waypoint15 waypoint18)
	(visible waypoint18 waypoint15)
	(visible waypoint16 waypoint8)
	(visible waypoint8 waypoint16)
	(visible waypoint16 waypoint12)
	(visible waypoint12 waypoint16)
	(visible waypoint16 waypoint18)
	(visible waypoint18 waypoint16)
	(visible waypoint17 waypoint6)
	(visible waypoint6 waypoint17)
	(visible waypoint17 waypoint8)
	(visible waypoint8 waypoint17)
	(visible waypoint18 waypoint0)
	(visible waypoint0 waypoint18)
	(visible waypoint18 waypoint4)
	(visible waypoint4 waypoint18)
	(visible waypoint18 waypoint14)
	(visible waypoint14 waypoint18)
	(visible waypoint18 waypoint17)
	(visible waypoint17 waypoint18)
	(at_soil_sample waypoint0)
	(at_soil_sample waypoint1)
	(at_soil_sample waypoint2)
	(at_rock_sample waypoint3)
	(at_soil_sample waypoint4)
	(at_soil_sample waypoint5)
	(at_rock_sample waypoint5)
	(at_soil_sample waypoint8)
	(at_soil_sample waypoint10)
	(at_rock_sample waypoint10)
	(at_rock_sample waypoint11)
	(at_soil_sample waypoint13)
	(at_rock_sample waypoint15)
	(at_soil_sample waypoint16)
	(at_soil_sample waypoint17)
	(at_rock_sample waypoint17)
	(at_rock_sample waypoint18)
	(at_lander general waypoint2)
	(channel_free general)
	(at rover0 waypoint6)
	(available rover0)
	(store_of rover0store rover0)
	(empty rover0store)
	(equipped_for_soil_analysis rover0)
	(equipped_for_imaging rover0)
	(can_traverse rover0 waypoint6 waypoint5)
	(can_traverse rover0 waypoint5 waypoint6)
	(can_traverse rover0 waypoint6 waypoint7)
	(can_traverse rover0 waypoint7 waypoint6)
	(can_traverse rover0 waypoint6 waypoint8)
	(can_traverse rover0 waypoint8 waypoint6)
	(can_traverse rover0 waypoint6 waypoint9)
	(can_traverse rover0 waypoint9 waypoint6)
	(can_traverse rover0 waypoint6 waypoint17)
	(can_traverse rover0 waypoint17 waypoint6)
	(can_traverse rover0 waypoint5 waypoint4)
	(can_traverse rover0 waypoint4 waypoint5)
	(can_traverse rover0 waypoint5 waypoint10)
	(can_traverse rover0 waypoint10 waypoint5)
	(can_traverse rover0 waypoint5 waypoint14)
	(can_traverse rover0 waypoint14 waypoint5)
	(can_traverse rover0 waypoint7 waypoint1)
	(can_traverse rover0 waypoint1 waypoint7)
	(can_traverse rover0 waypoint7 waypoint13)
	(can_traverse rover0 waypoint13 waypoint7)
	(can_traverse rover0 waypoint7 waypoint15)
	(can_traverse rover0 waypoint15 waypoint7)
	(can_traverse rover0 waypoint8 waypoint3)
	(can_traverse rover0 waypoint3 waypoint8)
	(can_traverse rover0 waypoint8 waypoint11)
	(can_traverse rover0 waypoint11 waypoint8)
	(can_traverse rover0 waypoint8 waypoint12)
	(can_traverse rover0 waypoint12 waypoint8)
	(can_traverse rover0 waypoint8 waypoint16)
	(can_traverse rover0 waypoint16 waypoint8)
	(can_traverse rover0 waypoint9 waypoint0)
	(can_traverse rover0 waypoint0 waypoint9)
	(can_traverse rover0 waypoint17 waypoint18)
	(can_traverse rover0 waypoint18 waypoint17)
	(can_traverse rover0 waypoint4 waypoint2)
	(can_traverse rover0 waypoint2 waypoint4)
	(on_board camera0 rover0)
	(calibration_target camera0 objective3)
	(supports camera0 colour)
	(supports camera0 high_res)
	(supports camera0 low_res)
	(on_board camera1 rover0)
	(calibration_target camera1 objective5)
	(supports camera1 low_res)
	(visible_from objective0 waypoint3)
	(visible_from objective0 waypoint6)
	(visible_from objective0 waypoint13)
	(visible_from objective0 waypoint15)
	(visible_from objective1 waypoint2)
	(visible_from objective1 waypoint3)
	(visible_from objective1 waypoint5)
	(visible_from objective1 waypoint6)
	(visible_from objective1 waypoint8)
	(visible_from objective1 waypoint9)
	(visible_from objective1 waypoint10)
	(visible_from objective2 waypoint6)
	(visible_from objective2 waypoint15)
	(visible_from objective3 waypoint1)
	(visible_from objective3 waypoint7)
	(visible_from objective3 waypoint9)
	(visible_from objective3 waypoint11)
	(visible_from objective3 waypoint12)
	(visible_from objective3 waypoint14)
	(visible_from objective3 waypoint17)
	(visible_from objective4 waypoint4)
	(visible_from objective4 waypoint7)
	(visible_from objective4 waypoint14)
	(visible_from objective4 waypoint16)
	(visible_from objective5 waypoint1)
	(visible_from objective5 waypoint3)
	(visible_from objective5 waypoint4)
	(visible_from objective5 waypoint5)
	(visible_from objective5 waypoint7)
	(visible_from objective5 waypoint8)
	(visible_from objective5 waypoint9)
	(visible_from objective5 waypoint13)
	(visible_from objective5 waypoint14)
	(visible_from objective5 waypoint15)
	(visible_from objective5 waypoint16)
	(visible_from objective5 waypoint18)
	(visible_from objective6 waypoint4)
	(visible_from objective6 waypoint16)
	(visible_from objective7 waypoint3)
	(visible_from objective7 waypoint4)
	(visible_from objective7 waypoint6)
	(visible_from objective7 waypoint11)
	(visible_from objective7 waypoint13)
	(visible_from objective7 waypoint14)
	(visible_from objective7 waypoint15)
	(visible_from objective7 waypoint16)
	(visible_from objective7 waypoint17)
	(visible_from objective8 waypoint0)
	(visible_from objective8 waypoint3)
	(visible_from objective8 waypoint5)
	(visible_from objective8 waypoint6)
	(visible_from objective9 waypoint2)
	(visible_from objective9 waypoint3)
	(visible_from objective9 waypoint4)
	(visible_from objective9 waypoint5)
	(visible_from objective9 waypoint6)
	(visible_from objective9 waypoint7)
	(visible_from objective9 waypoint8)
	(visible_from objective9 waypoint11)
	(visible_from objective9 waypoint13)
	(visible_from objective10 waypoint6)
	(visible_from objective10 waypoint14)
	(visible_from objective10 waypoint15)
	(visible_from objective11 waypoint0)
	(visible_from objective11 waypoint2)
	(visible_from objective11 waypoint4)
	(visible_from objective11 waypoint5)
	(visible_from objective11 waypoint7)
	(visible_from objective11 waypoint8)
	(visible_from objective11 waypoint9)
	(visible_from objective11 waypoint11)
	(visible_from objective11 waypoint14)
	(visible_from objective11 waypoint15)
	(visible_from objective11 waypoint17)
	(visible_from objective11 waypoint18)
	(visible_from objective12 waypoint0)
	(visible_from objective12 waypoint2)
	(visible_from objective12 waypoint3)
	(visible_from objective12 waypoint4)
	(visible_from objective12 waypoint6)
	(visible_from objective12 waypoint11)
	(visible_from objective12 waypoint12)
	(visible_from objective12 waypoint13)
	(visible_from objective12 waypoint14)
	(visible_from objective12 waypoint15)
	(visible_from objective13 waypoint2)
	(visible_from objective13 waypoint5)
	(visible_from objective13 waypoint6)
	(visible_from objective13 waypoint7)
	(visible_from objective13 waypoint11)
	(visible_from objective13 waypoint12)
	(visible_from objective13 waypoint14)
	(visible_from objective13 waypoint16)
	(visible_from objective14 waypoint1)
	(visible_from objective14 waypoint2)
	(visible_from objective14 waypoint3)
	(visible_from objective14 waypoint4)
	(visible_from objective14 waypoint10)
	(visible_from objective14 waypoint13)
	(visible_from objective14 waypoint16)
	(visible_from objective14 waypoint17)
	(visible_from objective14 waypoint18)
	(visible_from objective15 waypoint2)
	(visible_from objective15 waypoint3)
	(visible_from objective15 waypoint4)
	(visible_from objective15 waypoint6)
	(visible_from objective15 waypoint7)
	(visible_from objective15 waypoint8)
	(visible_from objective15 waypoint9)
	(visible_from objective15 waypoint10)
	(visible_from objective15 waypoint13)
	(visible_from objective15 waypoint14)
	(visible_from objective15 waypoint16)
	(visible_from objective15 waypoint17)
	(visible_from objective15 waypoint18)
	(visible_from objective16 waypoint0)
	(visible_from objective16 waypoint16)
	(visible_from objective17 waypoint9)
	(visible_from objective17 waypoint11)
	(visible_from objective17 waypoint14)
	(visible_from objective17 waypoint15)
	(visible_from objective17 waypoint17)
)

(:goal (and
(communicated_soil_data waypoint16)
(communicated_soil_data waypoint0)
(communicated_soil_data waypoint5)
(communicated_soil_data waypoint8)
(communicated_soil_data waypoint13)
(communicated_soil_data waypoint10)
(communicated_soil_data waypoint1)
(communicated_soil_data waypoint2)
(communicated_soil_data waypoint4)
(communicated_soil_data waypoint17)
(communicated_image_data objective7 low_res)
(communicated_image_data objective14 low_res)
(communicated_image_data objective11 high_res)
(communicated_image_data objective5 low_res)
(communicated_image_data objective11 low_res)
(communicated_image_data objective13 low_res)
(communicated_image_data objective4 low_res)
(communicated_image_data objective15 low_res)
	)
)
)
