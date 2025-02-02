(define (problem roverprob2036) (:domain Rover)
(:objects
	general - Lander
	colour high_res low_res - Mode
	rover0 - Rover
	rover0store - Store
	waypoint0 waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6 waypoint7 waypoint8 waypoint9 waypoint10 waypoint11 waypoint12 waypoint13 waypoint14 waypoint15 waypoint16 waypoint17 waypoint18 waypoint19 waypoint20 waypoint21 waypoint22 - Waypoint
	camera0 camera1 - Camera
	objective0 objective1 objective2 objective3 objective4 objective5 objective6 objective7 objective8 objective9 objective10 objective11 objective12 objective13 objective14 objective15 objective16 objective17 objective18 objective19 objective20 objective21 - Objective
	)
(:init
	(visible waypoint0 waypoint3)
	(visible waypoint3 waypoint0)
	(visible waypoint0 waypoint5)
	(visible waypoint5 waypoint0)
	(visible waypoint0 waypoint7)
	(visible waypoint7 waypoint0)
	(visible waypoint0 waypoint11)
	(visible waypoint11 waypoint0)
	(visible waypoint0 waypoint22)
	(visible waypoint22 waypoint0)
	(visible waypoint1 waypoint5)
	(visible waypoint5 waypoint1)
	(visible waypoint1 waypoint14)
	(visible waypoint14 waypoint1)
	(visible waypoint1 waypoint16)
	(visible waypoint16 waypoint1)
	(visible waypoint2 waypoint3)
	(visible waypoint3 waypoint2)
	(visible waypoint2 waypoint4)
	(visible waypoint4 waypoint2)
	(visible waypoint2 waypoint7)
	(visible waypoint7 waypoint2)
	(visible waypoint2 waypoint11)
	(visible waypoint11 waypoint2)
	(visible waypoint2 waypoint18)
	(visible waypoint18 waypoint2)
	(visible waypoint3 waypoint1)
	(visible waypoint1 waypoint3)
	(visible waypoint3 waypoint9)
	(visible waypoint9 waypoint3)
	(visible waypoint3 waypoint14)
	(visible waypoint14 waypoint3)
	(visible waypoint3 waypoint21)
	(visible waypoint21 waypoint3)
	(visible waypoint3 waypoint22)
	(visible waypoint22 waypoint3)
	(visible waypoint4 waypoint6)
	(visible waypoint6 waypoint4)
	(visible waypoint4 waypoint9)
	(visible waypoint9 waypoint4)
	(visible waypoint4 waypoint15)
	(visible waypoint15 waypoint4)
	(visible waypoint5 waypoint2)
	(visible waypoint2 waypoint5)
	(visible waypoint5 waypoint3)
	(visible waypoint3 waypoint5)
	(visible waypoint5 waypoint9)
	(visible waypoint9 waypoint5)
	(visible waypoint5 waypoint17)
	(visible waypoint17 waypoint5)
	(visible waypoint6 waypoint1)
	(visible waypoint1 waypoint6)
	(visible waypoint6 waypoint5)
	(visible waypoint5 waypoint6)
	(visible waypoint6 waypoint15)
	(visible waypoint15 waypoint6)
	(visible waypoint6 waypoint18)
	(visible waypoint18 waypoint6)
	(visible waypoint6 waypoint20)
	(visible waypoint20 waypoint6)
	(visible waypoint7 waypoint1)
	(visible waypoint1 waypoint7)
	(visible waypoint7 waypoint4)
	(visible waypoint4 waypoint7)
	(visible waypoint7 waypoint18)
	(visible waypoint18 waypoint7)
	(visible waypoint8 waypoint4)
	(visible waypoint4 waypoint8)
	(visible waypoint8 waypoint5)
	(visible waypoint5 waypoint8)
	(visible waypoint8 waypoint7)
	(visible waypoint7 waypoint8)
	(visible waypoint8 waypoint15)
	(visible waypoint15 waypoint8)
	(visible waypoint8 waypoint17)
	(visible waypoint17 waypoint8)
	(visible waypoint9 waypoint6)
	(visible waypoint6 waypoint9)
	(visible waypoint9 waypoint8)
	(visible waypoint8 waypoint9)
	(visible waypoint9 waypoint16)
	(visible waypoint16 waypoint9)
	(visible waypoint10 waypoint0)
	(visible waypoint0 waypoint10)
	(visible waypoint10 waypoint5)
	(visible waypoint5 waypoint10)
	(visible waypoint10 waypoint14)
	(visible waypoint14 waypoint10)
	(visible waypoint10 waypoint19)
	(visible waypoint19 waypoint10)
	(visible waypoint11 waypoint4)
	(visible waypoint4 waypoint11)
	(visible waypoint11 waypoint5)
	(visible waypoint5 waypoint11)
	(visible waypoint11 waypoint7)
	(visible waypoint7 waypoint11)
	(visible waypoint11 waypoint9)
	(visible waypoint9 waypoint11)
	(visible waypoint11 waypoint13)
	(visible waypoint13 waypoint11)
	(visible waypoint11 waypoint21)
	(visible waypoint21 waypoint11)
	(visible waypoint12 waypoint3)
	(visible waypoint3 waypoint12)
	(visible waypoint12 waypoint7)
	(visible waypoint7 waypoint12)
	(visible waypoint12 waypoint8)
	(visible waypoint8 waypoint12)
	(visible waypoint12 waypoint11)
	(visible waypoint11 waypoint12)
	(visible waypoint12 waypoint16)
	(visible waypoint16 waypoint12)
	(visible waypoint12 waypoint17)
	(visible waypoint17 waypoint12)
	(visible waypoint12 waypoint20)
	(visible waypoint20 waypoint12)
	(visible waypoint13 waypoint0)
	(visible waypoint0 waypoint13)
	(visible waypoint13 waypoint2)
	(visible waypoint2 waypoint13)
	(visible waypoint13 waypoint7)
	(visible waypoint7 waypoint13)
	(visible waypoint13 waypoint8)
	(visible waypoint8 waypoint13)
	(visible waypoint13 waypoint14)
	(visible waypoint14 waypoint13)
	(visible waypoint14 waypoint6)
	(visible waypoint6 waypoint14)
	(visible waypoint14 waypoint7)
	(visible waypoint7 waypoint14)
	(visible waypoint14 waypoint17)
	(visible waypoint17 waypoint14)
	(visible waypoint15 waypoint1)
	(visible waypoint1 waypoint15)
	(visible waypoint15 waypoint12)
	(visible waypoint12 waypoint15)
	(visible waypoint15 waypoint16)
	(visible waypoint16 waypoint15)
	(visible waypoint15 waypoint20)
	(visible waypoint20 waypoint15)
	(visible waypoint15 waypoint22)
	(visible waypoint22 waypoint15)
	(visible waypoint16 waypoint5)
	(visible waypoint5 waypoint16)
	(visible waypoint16 waypoint7)
	(visible waypoint7 waypoint16)
	(visible waypoint16 waypoint13)
	(visible waypoint13 waypoint16)
	(visible waypoint16 waypoint17)
	(visible waypoint17 waypoint16)
	(visible waypoint16 waypoint18)
	(visible waypoint18 waypoint16)
	(visible waypoint17 waypoint1)
	(visible waypoint1 waypoint17)
	(visible waypoint17 waypoint3)
	(visible waypoint3 waypoint17)
	(visible waypoint17 waypoint11)
	(visible waypoint11 waypoint17)
	(visible waypoint17 waypoint18)
	(visible waypoint18 waypoint17)
	(visible waypoint18 waypoint14)
	(visible waypoint14 waypoint18)
	(visible waypoint19 waypoint6)
	(visible waypoint6 waypoint19)
	(visible waypoint19 waypoint13)
	(visible waypoint13 waypoint19)
	(visible waypoint19 waypoint15)
	(visible waypoint15 waypoint19)
	(visible waypoint20 waypoint2)
	(visible waypoint2 waypoint20)
	(visible waypoint20 waypoint4)
	(visible waypoint4 waypoint20)
	(visible waypoint20 waypoint8)
	(visible waypoint8 waypoint20)
	(visible waypoint21 waypoint0)
	(visible waypoint0 waypoint21)
	(visible waypoint21 waypoint6)
	(visible waypoint6 waypoint21)
	(visible waypoint21 waypoint10)
	(visible waypoint10 waypoint21)
	(visible waypoint21 waypoint15)
	(visible waypoint15 waypoint21)
	(visible waypoint21 waypoint16)
	(visible waypoint16 waypoint21)
	(visible waypoint21 waypoint18)
	(visible waypoint18 waypoint21)
	(visible waypoint22 waypoint2)
	(visible waypoint2 waypoint22)
	(visible waypoint22 waypoint5)
	(visible waypoint5 waypoint22)
	(visible waypoint22 waypoint13)
	(visible waypoint13 waypoint22)
	(visible waypoint22 waypoint19)
	(visible waypoint19 waypoint22)
	(visible waypoint22 waypoint20)
	(visible waypoint20 waypoint22)
	(at_rock_sample waypoint0)
	(at_soil_sample waypoint1)
	(at_soil_sample waypoint2)
	(at_soil_sample waypoint3)
	(at_rock_sample waypoint3)
	(at_soil_sample waypoint4)
	(at_rock_sample waypoint4)
	(at_soil_sample waypoint5)
	(at_soil_sample waypoint6)
	(at_rock_sample waypoint7)
	(at_soil_sample waypoint8)
	(at_rock_sample waypoint8)
	(at_soil_sample waypoint9)
	(at_soil_sample waypoint10)
	(at_rock_sample waypoint10)
	(at_soil_sample waypoint11)
	(at_rock_sample waypoint12)
	(at_soil_sample waypoint13)
	(at_rock_sample waypoint13)
	(at_rock_sample waypoint14)
	(at_soil_sample waypoint17)
	(at_rock_sample waypoint17)
	(at_soil_sample waypoint18)
	(at_rock_sample waypoint18)
	(at_soil_sample waypoint19)
	(at_rock_sample waypoint20)
	(at_soil_sample waypoint21)
	(at_rock_sample waypoint21)
	(at_soil_sample waypoint22)
	(at_rock_sample waypoint22)
	(at_lander general waypoint8)
	(channel_free general)
	(at rover0 waypoint10)
	(available rover0)
	(store_of rover0store rover0)
	(empty rover0store)
	(equipped_for_rock_analysis rover0)
	(equipped_for_imaging rover0)
	(can_traverse rover0 waypoint10 waypoint0)
	(can_traverse rover0 waypoint0 waypoint10)
	(can_traverse rover0 waypoint10 waypoint19)
	(can_traverse rover0 waypoint19 waypoint10)
	(can_traverse rover0 waypoint10 waypoint21)
	(can_traverse rover0 waypoint21 waypoint10)
	(can_traverse rover0 waypoint0 waypoint5)
	(can_traverse rover0 waypoint5 waypoint0)
	(can_traverse rover0 waypoint0 waypoint7)
	(can_traverse rover0 waypoint7 waypoint0)
	(can_traverse rover0 waypoint0 waypoint11)
	(can_traverse rover0 waypoint11 waypoint0)
	(can_traverse rover0 waypoint0 waypoint22)
	(can_traverse rover0 waypoint22 waypoint0)
	(can_traverse rover0 waypoint19 waypoint6)
	(can_traverse rover0 waypoint6 waypoint19)
	(can_traverse rover0 waypoint19 waypoint13)
	(can_traverse rover0 waypoint13 waypoint19)
	(can_traverse rover0 waypoint21 waypoint3)
	(can_traverse rover0 waypoint3 waypoint21)
	(can_traverse rover0 waypoint21 waypoint15)
	(can_traverse rover0 waypoint15 waypoint21)
	(can_traverse rover0 waypoint21 waypoint16)
	(can_traverse rover0 waypoint16 waypoint21)
	(can_traverse rover0 waypoint21 waypoint18)
	(can_traverse rover0 waypoint18 waypoint21)
	(can_traverse rover0 waypoint5 waypoint2)
	(can_traverse rover0 waypoint2 waypoint5)
	(can_traverse rover0 waypoint5 waypoint8)
	(can_traverse rover0 waypoint8 waypoint5)
	(can_traverse rover0 waypoint5 waypoint9)
	(can_traverse rover0 waypoint9 waypoint5)
	(can_traverse rover0 waypoint5 waypoint17)
	(can_traverse rover0 waypoint17 waypoint5)
	(can_traverse rover0 waypoint7 waypoint1)
	(can_traverse rover0 waypoint1 waypoint7)
	(can_traverse rover0 waypoint7 waypoint4)
	(can_traverse rover0 waypoint4 waypoint7)
	(can_traverse rover0 waypoint7 waypoint12)
	(can_traverse rover0 waypoint12 waypoint7)
	(on_board camera0 rover0)
	(calibration_target camera0 objective17)
	(supports camera0 colour)
	(supports camera0 high_res)
	(supports camera0 low_res)
	(on_board camera1 rover0)
	(calibration_target camera1 objective18)
	(supports camera1 colour)
	(supports camera1 high_res)
	(supports camera1 low_res)
	(visible_from objective0 waypoint2)
	(visible_from objective0 waypoint19)
	(visible_from objective1 waypoint3)
	(visible_from objective1 waypoint12)
	(visible_from objective1 waypoint16)
	(visible_from objective1 waypoint21)
	(visible_from objective1 waypoint22)
	(visible_from objective2 waypoint0)
	(visible_from objective2 waypoint1)
	(visible_from objective2 waypoint2)
	(visible_from objective2 waypoint3)
	(visible_from objective2 waypoint4)
	(visible_from objective2 waypoint5)
	(visible_from objective2 waypoint6)
	(visible_from objective2 waypoint9)
	(visible_from objective2 waypoint11)
	(visible_from objective2 waypoint12)
	(visible_from objective2 waypoint16)
	(visible_from objective2 waypoint18)
	(visible_from objective2 waypoint21)
	(visible_from objective2 waypoint22)
	(visible_from objective3 waypoint2)
	(visible_from objective3 waypoint8)
	(visible_from objective3 waypoint22)
	(visible_from objective4 waypoint0)
	(visible_from objective4 waypoint1)
	(visible_from objective4 waypoint2)
	(visible_from objective4 waypoint3)
	(visible_from objective4 waypoint4)
	(visible_from objective4 waypoint7)
	(visible_from objective4 waypoint8)
	(visible_from objective4 waypoint11)
	(visible_from objective4 waypoint12)
	(visible_from objective4 waypoint14)
	(visible_from objective4 waypoint15)
	(visible_from objective4 waypoint17)
	(visible_from objective4 waypoint20)
	(visible_from objective4 waypoint21)
	(visible_from objective4 waypoint22)
	(visible_from objective5 waypoint0)
	(visible_from objective5 waypoint2)
	(visible_from objective5 waypoint3)
	(visible_from objective5 waypoint7)
	(visible_from objective5 waypoint13)
	(visible_from objective5 waypoint14)
	(visible_from objective5 waypoint16)
	(visible_from objective5 waypoint18)
	(visible_from objective5 waypoint20)
	(visible_from objective5 waypoint22)
	(visible_from objective6 waypoint1)
	(visible_from objective6 waypoint4)
	(visible_from objective6 waypoint11)
	(visible_from objective7 waypoint3)
	(visible_from objective7 waypoint7)
	(visible_from objective7 waypoint10)
	(visible_from objective7 waypoint12)
	(visible_from objective7 waypoint19)
	(visible_from objective8 waypoint1)
	(visible_from objective8 waypoint4)
	(visible_from objective8 waypoint6)
	(visible_from objective8 waypoint8)
	(visible_from objective8 waypoint10)
	(visible_from objective8 waypoint11)
	(visible_from objective8 waypoint13)
	(visible_from objective8 waypoint14)
	(visible_from objective8 waypoint15)
	(visible_from objective8 waypoint17)
	(visible_from objective8 waypoint18)
	(visible_from objective8 waypoint21)
	(visible_from objective9 waypoint0)
	(visible_from objective9 waypoint16)
	(visible_from objective10 waypoint4)
	(visible_from objective10 waypoint8)
	(visible_from objective10 waypoint12)
	(visible_from objective10 waypoint19)
	(visible_from objective10 waypoint20)
	(visible_from objective11 waypoint0)
	(visible_from objective11 waypoint2)
	(visible_from objective11 waypoint3)
	(visible_from objective11 waypoint9)
	(visible_from objective11 waypoint10)
	(visible_from objective11 waypoint13)
	(visible_from objective11 waypoint14)
	(visible_from objective11 waypoint17)
	(visible_from objective11 waypoint19)
	(visible_from objective11 waypoint21)
	(visible_from objective11 waypoint22)
	(visible_from objective12 waypoint0)
	(visible_from objective12 waypoint12)
	(visible_from objective12 waypoint16)
	(visible_from objective13 waypoint0)
	(visible_from objective13 waypoint1)
	(visible_from objective13 waypoint2)
	(visible_from objective13 waypoint3)
	(visible_from objective13 waypoint5)
	(visible_from objective13 waypoint8)
	(visible_from objective13 waypoint9)
	(visible_from objective13 waypoint11)
	(visible_from objective13 waypoint12)
	(visible_from objective13 waypoint13)
	(visible_from objective13 waypoint14)
	(visible_from objective13 waypoint17)
	(visible_from objective13 waypoint19)
	(visible_from objective14 waypoint2)
	(visible_from objective14 waypoint4)
	(visible_from objective14 waypoint6)
	(visible_from objective14 waypoint8)
	(visible_from objective14 waypoint9)
	(visible_from objective14 waypoint12)
	(visible_from objective14 waypoint14)
	(visible_from objective14 waypoint15)
	(visible_from objective14 waypoint21)
	(visible_from objective14 waypoint22)
	(visible_from objective15 waypoint0)
	(visible_from objective15 waypoint1)
	(visible_from objective15 waypoint2)
	(visible_from objective15 waypoint6)
	(visible_from objective15 waypoint9)
	(visible_from objective15 waypoint10)
	(visible_from objective15 waypoint13)
	(visible_from objective15 waypoint14)
	(visible_from objective15 waypoint15)
	(visible_from objective15 waypoint16)
	(visible_from objective15 waypoint17)
	(visible_from objective15 waypoint18)
	(visible_from objective15 waypoint20)
	(visible_from objective15 waypoint22)
	(visible_from objective16 waypoint0)
	(visible_from objective16 waypoint1)
	(visible_from objective16 waypoint2)
	(visible_from objective16 waypoint4)
	(visible_from objective16 waypoint6)
	(visible_from objective16 waypoint9)
	(visible_from objective16 waypoint10)
	(visible_from objective16 waypoint11)
	(visible_from objective16 waypoint14)
	(visible_from objective16 waypoint18)
	(visible_from objective17 waypoint8)
	(visible_from objective17 waypoint9)
	(visible_from objective17 waypoint12)
	(visible_from objective17 waypoint19)
	(visible_from objective17 waypoint20)
	(visible_from objective17 waypoint22)
	(visible_from objective18 waypoint0)
	(visible_from objective18 waypoint4)
	(visible_from objective18 waypoint5)
	(visible_from objective18 waypoint6)
	(visible_from objective18 waypoint7)
	(visible_from objective18 waypoint8)
	(visible_from objective18 waypoint11)
	(visible_from objective18 waypoint14)
	(visible_from objective18 waypoint15)
	(visible_from objective18 waypoint16)
	(visible_from objective18 waypoint17)
	(visible_from objective18 waypoint18)
	(visible_from objective18 waypoint19)
	(visible_from objective18 waypoint20)
	(visible_from objective18 waypoint22)
	(visible_from objective19 waypoint1)
	(visible_from objective19 waypoint4)
	(visible_from objective19 waypoint13)
	(visible_from objective20 waypoint0)
	(visible_from objective20 waypoint1)
	(visible_from objective20 waypoint2)
	(visible_from objective20 waypoint4)
	(visible_from objective20 waypoint5)
	(visible_from objective20 waypoint8)
	(visible_from objective20 waypoint9)
	(visible_from objective20 waypoint10)
	(visible_from objective20 waypoint12)
	(visible_from objective20 waypoint14)
	(visible_from objective20 waypoint15)
	(visible_from objective20 waypoint16)
	(visible_from objective20 waypoint18)
	(visible_from objective20 waypoint20)
	(visible_from objective20 waypoint22)
	(visible_from objective21 waypoint0)
	(visible_from objective21 waypoint3)
	(visible_from objective21 waypoint5)
	(visible_from objective21 waypoint6)
	(visible_from objective21 waypoint11)
	(visible_from objective21 waypoint13)
	(visible_from objective21 waypoint14)
	(visible_from objective21 waypoint15)
	(visible_from objective21 waypoint16)
	(visible_from objective21 waypoint17)
	(visible_from objective21 waypoint18)
	(visible_from objective21 waypoint20)
	(visible_from objective21 waypoint21)
)

(:goal (and
(communicated_rock_data waypoint18)
(communicated_rock_data waypoint0)
(communicated_rock_data waypoint22)
(communicated_rock_data waypoint7)
(communicated_rock_data waypoint13)
(communicated_rock_data waypoint12)
(communicated_rock_data waypoint10)
(communicated_rock_data waypoint4)
(communicated_rock_data waypoint21)
(communicated_rock_data waypoint3)
(communicated_rock_data waypoint17)
(communicated_rock_data waypoint8)
(communicated_image_data objective5 high_res)
(communicated_image_data objective2 low_res)
(communicated_image_data objective13 low_res)
(communicated_image_data objective16 high_res)
(communicated_image_data objective4 high_res)
(communicated_image_data objective3 high_res)
(communicated_image_data objective4 colour)
(communicated_image_data objective16 colour)
(communicated_image_data objective14 low_res)
(communicated_image_data objective2 high_res)
(communicated_image_data objective21 colour)
(communicated_image_data objective10 colour)
(communicated_image_data objective2 colour)
(communicated_image_data objective20 colour)
(communicated_image_data objective11 colour)
(communicated_image_data objective11 high_res)
(communicated_image_data objective12 colour)
(communicated_image_data objective20 high_res)
(communicated_image_data objective15 colour)
(communicated_image_data objective8 colour)
(communicated_image_data objective15 high_res)
(communicated_image_data objective18 high_res)
	)
)
)
