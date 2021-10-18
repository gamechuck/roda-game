VAR number_of_fences_fixed = 0

// Player
VAR player_wearing_color = 0
VAR player_on_bike = 0

VAR player_noted_gummy = 0
VAR player_solved_traffic_lights_question = 0
VAR player_solved_bike_question = 0
VAR player_solved_zebra_question = 0

VAR player_inside_appartment = 0

VAR player_received_turbine_fence = 0
VAR player_received_smog_fence = 0
VAR player_received_helter_skelter_fence = 0
VAR player_received_wheelie_fence = 0

// SolidSnejk
VAR solid_snejk_intro_completed = 0
VAR operation_better_park_started = 0

VAR solid_snejk_outro_completed = 0

// Lizzy
VAR lizzy_intro_completed = 0

// Watto
VAR watto_question_solved = 0

// SolidSlug
VAR bike_fixed = 0
VAR bike_issue_found = 0
VAR permission_granted = 0

// ReturnedBike
VAR bike_returned = 0
VAR bike_taken = 0
VAR fix_quest_completed = 0
LIST checked_components = tyres, pedals, horn_and_brakes, saddle, lights

// Taxi
VAR taxi_received_belt = 0

// HelterSkelter
VAR helter_skelter_intro_completed = 0
VAR helter_skelter_gone_protesting = 0

// SeatSortingCar
VAR car_quest_completed = 0

// WindTurbine
VAR wind_turbine_powered = 0

// MrSmog
VAR mr_smog_defeated = 0
VAR mr_smog_outro_completed = 0

// FlowerBox
VAR rose_seeds_planted = 0

// FlowerCopper
VAR flower_copper_swayed = 0

// Loveinterest
VAR love_interest_gone_protesting = 0

// ParkLovers
VAR poster_designed = 0

// RodaShop
VAR roda_shop_gave_groceries = 0
VAR roda_shop_gave_seeds = 0
VAR roda_shop_gone_protesting = 0

// OldMan
VAR old_man_requested_groceries = 0
VAR old_man_received_groceries = 0
VAR old_man_gone_protesting = 0

// BlindGuy
VAR blind_guy_helped = 0
VAR blind_guy_gone_protesting = 0

// Student
VAR student_homework_done = 0
VAR student_gone_protesting = 0

// Animal Protection Services
VAR lunja_gave_nuts = 0
VAR squirrels_all_satiated = 0
VAR lunja_gone_protesting = 0

// Squirrel Tree
VAR squirrels_at_mountains_satiated = 0
VAR squirrels_at_square_satiated = 0
VAR squirrels_at_lake_satiated = 0

// Canster
VAR pump_received = 0
VAR canster_left_appeased = 0
VAR canster_middle_appeased = 0
VAR canster_right_appeased = 0

// Dog
VAR dog_visited_lake = 0
VAR dog_visited_park = 0

// Rosalina
VAR rosalina_requested_seeds = 0
VAR rosalina_gone_protesting = 0

// Dog Trainer Club
VAR dog_test_started = 0
VAR dog_test_passed = 0
VAR dog_walking_started = 0
VAR dog_walking_completed = 0
VAR dog_trainer_club_gone_protesting = 0

// Wheelie Appartment
VAR wheelie_appartment_opened = 0

// Monsters Without Borders
VAR monsters_without_borders_joined = 0
VAR monsters_without_borders_quest_completed = 0
VAR monsters_without_borders_gone_protesting = 0

// Wheelie
VAR wheelie_intro_at_park_completed = 0
VAR wheelie_intro_before_park_fixed_completed = 0
VAR wheelie_intro_after_park_fixed_completed = 0
VAR wheelie_intro_back_at_park_completed = 0

VAR wheelie_arrived_at_house = 0
VAR wheelie_arrived_at_park = 0

VAR wheelie_going_to_park = 0
VAR wheelie_going_to_house = 0

VAR wheelie_got_scared = 0

VAR used_item = "bush"
VAR interact_id = "player"

VAR conv_type = 0

EXTERNAL has_item(item_id)
=== function has_item(item_id) ===
~ return true

EXTERNAL get_level_state()
=== function get_level_state() ===
~ return 0

=== function set_squirrels_satiated(squirrels_id, satiated) ===
{squirrels_id:
	- "squirrels_at_lake":
		~ squirrels_at_lake_satiated = satiated
	- "squirrels_at_mountains":
		~ squirrels_at_mountains_satiated = satiated
	- "squirrels_at_square":
		~ squirrels_at_square_satiated = satiated
}

=== function get_squirrels_satiated(squirrels_id) ===
{squirrels_id:
	- "squirrels_at_lake":
		~ return squirrels_at_lake_satiated
	- "squirrels_at_mountains":
		~ return squirrels_at_mountains_satiated
	- "squirrels_at_square":
		~ return squirrels_at_square_satiated
}
~ return 0

=== function set_canster_appeased(canster_id, appeased) ===
{canster_id:
	- "canster_left":
		~ canster_left_appeased = appeased
	- "canster_middle":
		~ canster_middle_appeased = appeased
	- "canster_right":
		~ canster_right_appeased = appeased
}

=== function get_canster_appeased(canster_id) ===
{canster_id:
	- "canster_left":
		~ return canster_left_appeased
	- "canster_middle":
		~ return canster_middle_appeased
	- "canster_right":
		~ return canster_right_appeased
}
~ return 0

=== function is_correct_trash(container_id, item_id) ===
{container_id:
	- "container_plastic":
		~ return (item_id == "trash_cup" or item_id == "trash_bottle") 
	- "container_mixed":
		~ return (item_id == "trash_bag") 
	- "container_paper":
		~ return (item_id == "trash_paper") 
}
~ return 0

//--
// CUTSCENES
//--
// INTRO CUTSCENE
=== conv_intro ===
>>> UPDATE_UI: solid_snejk
Hey everyone, let's play football!
>>> UPDATE_UI: solid_slug
Yaaaaay! Pass the ball!
-> DONE

=== conv_intro_slug_no_ball ===
>>> UPDATE_UI: solid_slug
Come on, pass me the ball too!
...
-> DONE

=== conv_intro_smog_appears ===
>>> UPDATE_UI: solid_snejk
Wait, what's going on?
Where is all this smog coming from?
>>> UPDATE_UI: mr_smog
AHAHAHAHA!
-> DONE

=== conv_intro_mr_smog_taunts ===
>>> UPDATE_UI: mr_smog
Say goodbye to your precious park, kids!
Mister Smog is here to ruin the party!
-> DONE

=== conv_intro_mr_smog_exits ===
>>> UPDATE_UI: mr_smog
AHAHAHAHA!!!
-> DONE

=== conv_intro_outro ===
>>> UPDATE_UI: solid_snejk
...
-> DONE

// OUTRO CUTSCENE
=== conv_outro_intro ===
>>> UPDATE_UI: solid_snejk
Who turned off the lights?
-> DONE

=== conv_outro ===
>>> UPDATE_UI: mayor
What's going on here?
>>> UPDATE_UI: solid_snejk
WE WANT THE PARK TO BE RENOVATED!!!
>>> UPDATE_UI: mayor
What? You are not happy with the park you have?
Is it too small?
>>> UPDATE_UI: love_interest
YES!!!
>>> UPDATE_UI: mayor
You all want a much larger park?
>>> UPDATE_UI: solid_slug
YES!
>>> UPDATE_UI: mayor
A park with swings, slides and seesaws?
>>> UPDATE_UI: wheelie
YEEEEEEEEEEEEEES!!!
>>> UPDATE_UI: mayor
Without dirty cars everywhere?
>>> UPDATE_UI: happy_tree
THAT'S RIGHT!!!
>>> UPDATE_UI: mayor
All right! So it shall be!
I hope you will enjoy your new park!
Abrakadabra!
-> DONE

//--
// CHARACTERS
//--
=== conv_solid_snejk ===
//-- STATUS : 
// Solid Snejk asks you to gather the four missing fences and bring them to him.
// Afterwards he asks you to retrieve the happy tree that was also present in the park.
// After defeating Mr. Smog, operation better park starts in which you
// start gathering supporters for your cause.
// Naturally; he gives you hints and tips regarding which people to search out.
// People that can go protesting:
// - Old Man
// - Rosalina
// - Helter Skelter
// - Love Interest
// - Blind Guy
// - Dog Trainer Club
// - Park Lovers
// - Animal Protection Services
// - Monsters Without Borders
// - Roda Shop

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{operation_better_park_started:
	- 0: 
	{mr_smog_defeated:
		- 0:
		{number_of_fences_fixed:
			- 4: -> after_all_fences_fixed
			- else: 
			{has_item("fence"):
				- 0:
				{solid_snejk_intro_completed:
					- 0: -> before_solid_snejk_intro_completed
					- 1: -> after_solid_snejk_intro_completed
				}
				- 1: -> fix_fence
			}
		}
		- 1: -> after_mr_smog_defeated
	}
	- 1: -> after_operation_better_park_started
}

= before_solid_snejk_intro_completed
>>> UPDATE_UI: solid_snejk
~ solid_snejk_intro_completed = 1
Oh no! The fence in our park was blown away...
Let's go find the parts of the fence and fix it so we can play ball again!
-> after_solid_snejk_intro_completed

= after_solid_snejk_intro_completed
Hey, let's fix the fence together!
You bring me the parts of the fence and I'll set it up.
Mister Smog blew them away to all sides of the world...
-> DONE

= fix_fence
Super! You have found a piece of the fence!
I'll go put it up!
~ number_of_fences_fixed += 1
>>> REMOVE_ITEM: fence
{number_of_fences_fixed:
    - 4: -> after_all_fences_fixed
	- else: -> DONE
}

= after_all_fences_fixed
Wow! This place looks much nicer, doesn't it?
Although, I seem to recall there was a tree here once...
I wonder what happened to it?
Maybe you can find out what happened to our favourite tree?
After that, we can continue playing ball.
-> DONE

= after_mr_smog_defeated
I can't believe Mister Smog was in fact our lost tree!
Bluey, don't you think this park is too small to play football?
We should organise a protest for a bigger park!
-> before_poster_designed

= before_poster_designed
>>> UPDATE_UI: solid_snejk
~ operation_better_park_started = 1
I hear the park lovers are having a contest in making park posters.
>>> PAN_CAMERA_TO_POSITION: 3120 1216
Maybe you can help them make a poster?
>>> RESET_CAMERA
Also, we should tell everyone that we are organising a protest!
Would you walk around town and tell everyone to join us?
A larger and more beautiful park is something everyone can enjoy!
-> DONE

= after_operation_better_park_started
// First check if the poster has been designed!
{poster_designed:
	- 0: -> before_poster_designed
}
Let's see who is missing on the protest...
// Figure out if everyone is protesting...
{rosalina_gone_protesting:
	- 0: -> show_rosalina 
}
{old_man_gone_protesting:
	- 0: -> show_old_man 
}
{student_gone_protesting:
	- 0: -> show_student 
}
{blind_guy_gone_protesting:
	- 0: -> show_blind_guy 
}
{helter_skelter_gone_protesting:
	- 0: -> show_helter_skelter 
}
{love_interest_gone_protesting:
	- 0: -> show_love_interest 
}
{dog_trainer_club_gone_protesting:
	- 0: -> show_dog_trainer_club 
}
{lunja_gone_protesting:
	- 0: -> show_animal_protection_services 
}
{roda_shop_gone_protesting:
	- 0: -> show_roda_shop 
}
{monsters_without_borders_gone_protesting:
	- 0: -> show_monsters_without_borders 
}
// If we arrived here, everyone has gone protesting and it is time to start the ending cutscene!
It seems there are enough people for the protest!
Let's make the world a better place!
>>> PLAY_CUTSCENE: outro
-> DONE

= show_rosalina
>>> PAN_CAMERA_TO_POSITION: 4048 1728
What do you think about calling over the girl from Vilko's building, the one who loves flowers?
She might come to the protest.
I think she is called Rosey, ask her if she'd help us.
>>> RESET_CAMERA
-> DONE

= show_old_man
>>> PAN_CAMERA_TO_POSITION: 4048 1728
There is that old man in Vilko's building who might help us.
He is a bit grumpy but kind at heart. Ask him if he'd help us out.
>>> RESET_CAMERA
-> DONE

= show_student
>>> PAN_CAMERA_TO_POSITION: 4048 1728
I think there is a pupil living in Vilko's building too.
I don't know his name because he is constantly at home trying to finish his homework.
Ask him if he'd join us!
>>> RESET_CAMERA
-> DONE

= show_blind_guy
>>> PAN_CAMERA_TO_POSITION: 2336 1888
A blind person walks through the park every day. He would definitely love for the park to be renovated.
Call him too!
>>> RESET_CAMERA
-> DONE

= show_helter_skelter
>>> PAN_CAMERA_TO_POSITION: 2464 3744
I know Helter Skater is often a hooligan, but...
I think he too is yearning for a nicer park!
Go ask him!
>>> RESET_CAMERA
-> DONE

= show_love_interest
>>> PAN_CAMERA_TO_POSITION: 4048 1728
How about your crush?
I think your crush would love to answer your call!
>>> RESET_CAMERA
-> DONE

= show_dog_trainer_club
>>> PAN_CAMERA_TO_POSITION: 3380 1728
Volunteers that train therapy dogs want more nature in the city.
Ask them if they'd join us?
>>> RESET_CAMERA
-> DONE

= show_animal_protection_services
>>> PAN_CAMERA_TO_POSITION: 2736 1216
Laika is an organisation that takes care of animals, they would definitely want a bigger park.
Maybe you can ask them to come, although they are probably very busy...
Perhaps they will have more time for us if you help them with their work.
>>> RESET_CAMERA
-> DONE

= show_roda_shop
>>> PAN_CAMERA_TO_POSITION: 2576 1216
The shop workers also want a better park! Ask them too to show up for our park revolution!
>>> RESET_CAMERA
-> DONE

= show_monsters_without_borders
>>> PAN_CAMERA_TO_POSITION: 2192 1216
The folks from the monster rights organisation are always looking for a chance to help our neighbourhood.
If they would come too, we would definitely have enough people!
>>> RESET_CAMERA
-> DONE

= outro
{solid_snejk_outro_completed:
	- 0: -> before_solid_snejk_outro_completed
	- 1: -> after_solid_snejk_outro_completed
}

= before_solid_snejk_outro_completed
>>> UPDATE_UI: solid_snejk
~ solid_snejk_outro_completed = 1
It's incredible how beautiful the park is now.
And you helped make it that way!
Walk around and explore! Everyone is here!
-> DONE

= after_solid_snejk_outro_completed
I am still amazed by the park!
I will stay here but you can go around and explore!
-> DONE

= use_item
{used_item:
	- "bike": -> bike
	- "pump": -> pump
	- "fence": -> fix_fence
	- else: -> default
}

= bike
Cute bike, friend!
-> DONE

= pump
Bike pump? Try it on a bike!
Not on me!
-> DONE

= default
I don't want to take that...
-> DONE

=== conv_solid_slug ===
//-- STATUS : READY FOR TRANSLATION
// Solid Slug is missing his bike... Mr. Smog blew it away.
// He asks you to find his bike somewhere and bring it back to him.
// Afterwards, when you fixed his bike, he tells you that you can use his bike.
//-- RELEVANT VARIABLES:
// operation_better_park_started
// bike_fixed
// bike_issue_found
// bike_returned

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{operation_better_park_started:
	- 0: 
	{bike_fixed:
		- 0:
		{bike_issue_found:
			- 0: 
			{bike_returned:
				- 0: 
				{has_item("broken_bike"):
					- 0: -> main_intro
					- 1: -> has_broken_bike
				}
				- 1: -> after_bike_returned
			}
			- 1:
			{has_item("pump"):
				- 0: -> after_bike_issue_found
				- 1: -> has_pump
			}
		}
		- 1: -> after_bike_fixed
	}
	- 1: -> after_operation_better_park_started
}

= main_intro
The wind blew your fence away?
And I lost my bike...
If you help me find my bike, I'll help you find a piece of the fence.
-> DONE

= has_broken_bike
Thanks for finding my bike!
>>> REMOVE_ITEM: broken_bike
~ bike_returned = 1
-> after_bike_returned

= after_bike_returned
It seems something is wrong with the bike...
Such a shame... Can you help me figure out what?
-> DONE

= after_bike_issue_found
So the tire was flat?
Such a shame...
Can you get a bike pump from someone?
-> DONE

= has_pump
Great, you found a bike pump! Can you pump up the bike tire, please?
-> DONE

= after_bike_fixed
Thanks for fixing my bike!
You can ride it if you want!
Just take it and click on yourself any time you wish to drive.
~ permission_granted = 1
-> DONE

= after_operation_better_park_started
We want a better park!
Give us a proper football terrain so we can play in peace!
-> DONE

= outro
So many footballs around me!
I don't know which one to kick first...
-> DONE

= use_item
{used_item:
	- "pump": -> pump
	- "broken_bike": -> has_broken_bike
	- "bike": -> bike
	- "fence": -> fence
	- else: -> default
}

= pump
{bike_issue_found:
	- 1: -> has_pump
	- 0: -> default
}
-> DONE

= bike
You can keep my bike for now!
-> DONE

= fence
I bet the snake named Solid Snejk would know what to do with that fence...
-> DONE

= default
I don't need it, thanks...
-> DONE

=== conv_returned_bike ===
//-- STATUS : COMPLETED!
// A broken bike which has to be fixed using the pump.
// This bike first has to be found and carried to solid slug.
// After the bike is fixed and you talked to sold slug, you can pick it up.
//-- RELEVANT VARIABLES:
// bike_issue_found
// bike_fixed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{bike_fixed:
	- 0:
	{bike_issue_found:
		- 0: -> before_bike_issue_found
		- 1:
		{has_item("pump"):
			0: -> before_bike_fixed
			1: -> pump_after_checkup
		}
	}
	- 1: -> after_bike_fixed
}

= before_bike_issue_found
>>> BEGIN_MINIGAME: bike_minigame
- (bike_minigame)
{checked_components == LIST_ALL(checked_components):
	- 1: -> after_bike_issue_found
}
{bike_issue_found:
	- 1: I should check if the other bike parts are working...
	- 0: I should check if the bike works...
}
+ Tire?
	Oh, no! One of the tires is flat!
	~ bike_issue_found = 1
	~ checked_components += tyres
	-> bike_minigame
+ Pedals?
	The pedals seem to be set up fine...
	And there is a cat eye on the front and the back of them.
	Super!
	~ checked_components += pedals
	-> bike_minigame
+ Lights?
	The front light is white, to light the road.
	The backlight is red, with a cat eye.
	Super!
	~ checked_components += lights
	-> bike_minigame
+ The bell?
	The bell is on the steering wheel.
	HONK, HONK!
	Seems to be working!
	And a break for every wheel - good!
	~ checked_components += horn_and_brakes
	-> bike_minigame
+ Seat?
	The seat is set up properly! Super!
	~ checked_components += saddle
	-> bike_minigame
= after_bike_issue_found
It seems the problem is only in the flat tire...
We need to fix it!
>>> END_MINIGAME
-> DONE

= before_bike_fixed
I should look around for the bike pump...
Who could help me with this?
-> DONE

= after_bike_fixed
I could take the bike!
{permission_granted:
	- 0: -> before_permission_granted
	- 1: -> after_permission_granted
}

= before_permission_granted
I should ask Solid Slug before taking it...
-> DONE

= after_permission_granted
Solid Slug said I could!
~ bike_taken = 1
>>> ADD_ITEM: bike
-> DONE

= use_item
{used_item:
	- "pump": -> pump
	- else: -> default
}

= pump
{bike_issue_found:
	- 0: -> pump_before_checkup
	- 1: -> pump_after_checkup
}

= pump_before_checkup
I should first figure out what's wrong with the bike.
-> DONE

= pump_after_checkup
Time to pump up the flat tire!
\*PUMP*
\*PUMP PUMP*
\*PUMP PUMP PUMP*
...
...?
There, good as new!
~ bike_fixed = 1
-> DONE

= default
The bike doesn't need that...
-> DONE

=== conv_watto ===
//-- STATUS : READY FOR TRANSLATION
// Watto shows you where the bike is and is useless afterwards.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{operation_better_park_started:
	- 0: 
	{bike_returned || has_item("broken_bike"):
		- 0: -> before_bike_found
		- 1: -> after_bike_found
	}
	- 1: -> after_operation_better_park_started
}

= before_bike_found
{watto_question_solved:
	- 0: -> pop_question
	- 1: -> show_bike_location
}

= pop_question
Looking for a bicycle?
I'll show you where I found it if you answer my question:
- (start_question)
If there is no pedestrian crossing, where do pedestrians walk?
+ [Right side of the street.] 
	Ha! Wrong!
	That way you don't see the cars that are coming and you are in greater danger.
	You have much to learn about humans and their traffic laws...
	-> start_question
+ [Left side of the street.]
	That's right!
	The left side - so you can more easily see the oncoming traffic.
	~ watto_question_solved = 1
	-> show_bike_location
+ [The middle of the street.]
	Ha! Wrong! Walking in the middle of the street is the most dangerous of all!
	-> start_question
+ [Jumping from one side of the street to the other.]
	WRONG! WRONG!
	-> start_question

= show_bike_location
There is the bike you seek!
>>> PAN_CAMERA_TO_POSITION: 3584 3096
You must be sorry you don't have my flying rockets.
Hehe, a pitty, isn't it...
>>> RESET_CAMERA
-> DONE

= after_bike_found
I see you've mastered walking on pedestrian crossings and crosswalks.
But where I'm going, I don't need roads!
-> DONE

= after_operation_better_park_started
You're gathering people for your protest, right?
Well, I love living in garbage.
But best of luck.
-> DONE

= use_item
{used_item:
	- "bike": -> bike
	- "pump": -> pump
	- "fence": -> fence
	- else: -> default
}

= bike
Ah... I see you've mastered the art of crosswalks.
Well done!
-> DONE

= pump
Pump your bike tire with that, my rocket doesn't need it.
-> DONE

= fence
I don't need that fence.
-> DONE

= default
I don't need that thing.
-> DONE

=== conv_lizzy ===
//-- STATUS : COMPLETED!
// A wizard who has the power to show you the location of the fences!
// After you get all the fences, he shows you the location of the love interest instead.
// 

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: 
	{lizzy_intro_completed:
		- 0: -> intro
		- 1: -> after_lizzy_intro_completed
	}
}

= outro
This park you've built is really unique.
I don't even want to return to my homeland of Trafficia.
-> DONE

= intro
I am the Great Lizian! A wizard from the faraway land of Trafficia.
I came for vacation, but it seems you have some problems here.
Perhaps I can help? I have the power to show you what you seek!
But... First, you must answer one of my riddles!
I'm sorry about that but it's just how my powers work...
~ lizzy_intro_completed = 1
-> after_lizzy_intro_completed

= after_lizzy_intro_completed
Would you like to solve a riddle?
If you do, I'll show you your heart's desire!
+ [I wish to solve the riddle!]
	-> shuffle_riddle
+ [I don't need your help!]
	Very well! I am here for the rest of the year so feel free to return if you change your mind!
	-> DONE

// There should be at least ~ four (more is always kewl) riddles here, I'll make a switch to randomly choose one!
= shuffle_riddle
{shuffle:
	- -> first_riddle
	- -> second_riddle
	- -> third_riddle
	- -> fourth_riddle
}

// RIDDLE ONE
= first_riddle
- (riddle_started)
When crossing the road on a bike, we need to:
+ [Suddenly stop before crossing.]
	Wrong!
	That would only confuse others in traffic.
	I better not help you if you are so irresponsible!
	-> riddle_started
+ [Stop on time, get off the bike, walk across the pedestrian crossing pushing the bike.] 
	EXACTLY!
	It is forbidden to cross the pedestrian crossing while on a bike, it must be pushed.
	-> riddle_completed
+ [Stay on the bike and speed up to cross the road faster.] 
	Wrong!!!
	Speeding up will only increase the danger of some car hitting you by accident!
	I better not help you if you are so irresponsible!
	-> riddle_started
+ [Sing and take no notice of others in traffic.]
	Surely, yes.
	Actually: surely NO!
	I better not help you if you are so irresponsible!
	-> riddle_started

// RIDDLE TWO
= second_riddle
- (riddle_started)
Why should traffic signs be respected?
+ [For their cheerful colors.]
	Wrong!
	Think it through!
	-> riddle_started
+ [For safety in traffic.] 
	RIGHT!
	Otherwise, we would all be in grave danger!
	-> riddle_completed
+ [Because we are bored.] 
	Wrong!!!
	The signs should be respected when we are bored and when we are not bored!
	I better not help you if you are so irresponsible!
	-> riddle_started
+ [For fear of punishment.]
	Surely, yes.
	Actually: surely NO!
	I better not help you if you are so irresponsible!
	-> riddle_started

// RIDDLE THREE
= third_riddle
- (start_riddle)
What can increase the alertness of pedestrians in traffic?
+ [Talking to friends.]
	Wrong!
	Your small talk will likely decrease your alertness further.
	-> riddle_started
+ [Focusing and expecting danger.] 
	Correct!
	Think and try to anticipate possible dangers!
	-> riddle_completed
+ [Talking on the phone.] 
	Wrong!!!
	I better not help you if you are so irresponsible!
	-> riddle_started
+ [Running across the street.]
	Surely, yes.
	Actually: surely NO!
	I better not help you if you are so irresponsible!
	-> riddle_started

// RIDDLE FOUR
= fourth_riddle
- (start_riddle)
What is the driveway?
+ [Part of the road for pedestrians.]
	Wrong!
	That's the sidewalk, not the driveway!
	-> riddle_started
+ [Part of the road for vehicles.]
	CORRECT!
	-> riddle_completed
+ [A person who loves driving.] 
	Wrong!!!
	I better not help you if you are so irresponsible!
	-> riddle_started
+ [A Slovene athlete who participated in the Olympics in 1960.]
	This joke doesn't even make sense in English.
	The correct answer is: "The driveway is the part of the road for cars."
	But you shall receive a correct answer to this, so that localisation may run more smoothly.
	Congratulations!!!
	-> riddle_completed

= riddle_completed
You are good at answering my riddles!
{ player_received_smog_fence && player_received_turbine_fence && player_received_wheelie_fence && player_received_helter_skelter_fence:
	- 0: -> show_missing_fence_locations
	- else: -> pan_to_love_interest
}

// Here the lizard will show you (the camera will pan) to one of the locations of the fence.
// If there are no more fences, he'll pan the camera to your love interest.. because that is
// what you desire most! <3
= show_missing_fence_locations
Hmmm, I see now... You seek a fence, which you wish to repair to its former glory!
Let's see...
- (choice_shuffle)
{shuffle:
- {player_received_wheelie_fence: 
	- 0: -> pan_to_wheelie_fence
	- else: -> choice_shuffle
	}
- {player_received_helter_skelter_fence: 
	- 0:-> pan_to_helter_skelter_fence
	- else: -> choice_shuffle
	}
- {player_received_turbine_fence: 
	- 0: -> pan_to_turbine_fence
	- else: -> choice_shuffle
	}
- {player_received_smog_fence: 
	- 0: -> pan_to_smog_fence
	- else: -> choice_shuffle
	}
}
-> DONE

= pan_to_wheelie_fence
// Pan the camera to Wheelie's appartment:
>>> PAN_CAMERA_TO_POSITION: 4020 1742
Wow! A part of the fence seems to have fallen on the roof of this building!
You will have to find out who the owner of the building is so that he might bring you that part of the fence.
>>> RESET_CAMERA
-> DONE

= pan_to_helter_skelter_fence
// Pan the camera to the Helter Skelter:
>>> PAN_CAMERA_TO_POSITION: 2464 3744
It seems a grumpy skater has found the part of the fence and took it as his own.
You will have to get it back using your charisma and the power of kind words, it seems.
>>> RESET_CAMERA
-> DONE

= pan_to_smog_fence
// Pan the camera to the fence hidden in the smog:
>>> PAN_CAMERA_TO_POSITION: 1440 1760
My magic sight can barely traverse all this smog!
This region seems dangerous and I think you will need to wear colorful clothing so that cars may see you better there...
And not only that...
The region is full of ghosts!!!
>>> RESET_CAMERA
-> DONE

= pan_to_turbine_fence
// Pan the fence lying at the turbine:
>>> PAN_CAMERA_TO_POSITION: 1056 672
Hmm... A piece of the fence fell near the old wind turbine at the top of the mountain...
That is quite far... But I believe a motor vehicle will help you get there.
You are young and resourceful, I'm sure you will find a way to get there!
>>> RESET_CAMERA
-> DONE

= pan_to_love_interest
// Pan the game's love interest!
>>> PAN_CAMERA_TO_POSITION: 2336 2848
Let's see what you love the most...
Wow! What a lovely monster! Don't forget: you must express your feelings!
I forgot that too many times and now I am a very lonely wizard.
>>> RESET_CAMERA
-> DONE

= use_item

{used_item:
	- "bike": -> bike
	- "fence": -> fence
	- else: -> default
}

= bike
Ah, I see you've found the bike.
Remember:
Always wear the bike helmet when riding a bike!
-> DONE

= fence
What a beautiful fence!
I wish I could take it home with me...
Alas, this fence is here for all of us! It must not be taken away!
-> DONE

= default
Get that out of my sight!
-> DONE

=== conv_minigame_car ===
//-- STATUS : COMPLETED!
// This car has some problems with arranging it's passengers... 
// After correctly arranging everyone the driver gives you a seatbelt.

{car_quest_completed:
	- 0: -> before_car_quest_completed
	- 1: -> after_car_quest_completed
}

= before_car_quest_completed
Hey, you simpatico monster! I am sorry, but I'm a bit busy right now...
But hold on, you might be able to help me!
I'm trying to put all the monsters in their proper places, but I don't know which seatbelt is for which monster.
Help me, please!
+ [Of course, I have a natural talent for sorting monsters by seatbelt types!]
	-> after_car_quest_started
+ [Sorry, I have no time - I have my own quest as well!]
	Oh my! I won't be able to lift off till I resolve this.
	-> DONE

= after_car_quest_started
Ok, thanks a lot!
>>> BEGIN_MINIGAME: car_minigame
- (sorting_started)
Put the right monster in the right place!
+ No, no, no, even I can see that that's not good...
    Let's try again.
    -> sorting_started
+ Wow! Perfect!
    You've done it all correctly!
    -> sorting_completed
= sorting_completed
Before the ride, everyone must buckle their seatbelts!
I have mine already, but please check the others!
- (belting_started)
Remind all monsters to buckle their seatbelts!
+ I think somebody is still unbuckled!
    Check again!
    -> belting_started
+ Bravo! Now everyone is buckled up!
    Finally, I will no longer need to pay fines!
    Not to mention the added safety!
    -> belting_completed
= belting_completed
>>> END_MINIGAME
Take this seatbelt as a reward for your generous help!
>>> ADD_ITEM: seat_belt
~ car_quest_completed = 1
-> DONE

= after_car_quest_completed
Thanks again!
We can finally visit the seaside now!
-> DONE

=== conv_skater ===
// Regular skater who runs into you and bumps you back to a safe zone.

{Move it, loser! | Haha, too slow! Go home to mommy!} 
>>> RESPAWN_PLAYER
-> DONE

=== conv_helter_skelter ===
//-- STATUS : READY FOR TRANSLATION
// The boss of the skaters gives you some questions and if you answer correctly he gives you a piece of the fence.
// After starting up the park revolution, you can recruit him to come and protest.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{helter_skelter_gone_protesting:
	- 0:
	{player_received_helter_skelter_fence:
		- 0: 
		{helter_skelter_intro_completed:
			- 0: -> intro
			- 1: -> after_helter_skelter_intro_completed
		}
		- 1: -> after_player_received_helter_skelter_fence
	}
	- 1: -> protesting
}

= intro
?
How did you get past all my skater minions???
I told them loud and clear - they should let nobody near!
You must have come for the piece of the fence I found?!
Well, I will never part with it! That part is now MINE!
For I am HELTER SKATER, The Fear of skaters from Smogtown to Cloud Mountain!
~ helter_skelter_intro_completed = 1
-> before_player_received_helter_skelter_fence

= before_player_received_helter_skelter_fence
+ [Do not tempt me, I am a large and fierce monster!]
	You are not remotely large nor fierce as I!
	Now scram before I hurt you!
	-> DONE
+ [Hah. If you are The Fear, I am the Traffic Light.]
	That's how you look, like a little blue traffic light!
	But hmm, traffic lights aren't blue...
	Either way, get off my sight!
	-> DONE
+ [Please, mister Helter Skater, could you give us the fence part, it is very important to us?]
	What?!
	Is that... Decency!?
	In my park?!?!
	I haven't heard this since...
	Since...
	Since I went to my dear granny for milk and cookies...
	Ah, what a nice time that was.
	Thank you for reminding me of a happier time of my childhood before I became a skater band leader.
	Here, take the fence.
	Farewell, monster!
	>>> ADD_ITEM: fence
	And you, skaters, stop harassing him!
	~ player_received_helter_skelter_fence = true
	>>> HIDE: SkaterLoop
	>>> HIDE: SkaterLoop2
	>>> HIDE: SkaterLoop3
	-> DONE

= after_helter_skelter_intro_completed
You again, what do you want?
-> before_player_received_helter_skelter_fence

= after_player_received_helter_skelter_fence
It turns out that nice words open many curious doors, even the door to my black skater heart.
Who would have thought!
+ {operation_better_park_started}[Will you join me in a protest for a better park?]
	Protest to renovate your park?
	Why wouldn't I come protest to renovate my skater park?
	I will come, and my skater minions will follow!
	>>> FADE_TO_OPAQUE
	~ helter_skelter_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Thanks for your help!]
    Yes, it turns out that nice words open the doors to many curious doors, even the door to my black skater heart.
    Who would have thought!
    -> DONE

= protesting
We want a better skater park!
We've had enough skating on garbage!
-> DONE

= use_item
{used_item:
	- else: -> default
}

= default
Keep these trinkets to yourself!
-> DONE

=== conv_taxi_at_park ===
//-- STATUS : COMPLETED!
// The taxi at the park can take you to the mountain.
// Unfortunately, he is missing a seat belt and driving without a belt
// results in you falling out of the car!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{taxi_received_belt:
	- 0: -> before_taxi_received_belt
	- 1: -> after_taxi_received_belt
}

= before_taxi_received_belt
My job is to ferry people to the mountain.
Alas, I have no seatbelt for passengers so...
+ {has_item("seat_belt") == 0}[I don't care for seatbelts!]
	Ok, but that's very dangerous...
	Let's go!
	>>> PLAY_CUTSCENE: drop_player
	Oops! You fell out!
	Should've worn a seatbelt!
	-> DONE
+ {has_item("seat_belt") == 1}[I have my own seatbelt so it's okay!]
	Oh... ok!
	Wait, let me put adjust it in the car...
	>>> REMOVE_ITEM: seat_belt
	~ taxi_received_belt = 1
	-> after_taxi_received_belt
+ [It's too dangerous! I won't do it without a seatbelt!]
	Wise choice.
	Perhaps you can find an extra seatbelt somewhere...
	-> DONE

= after_taxi_received_belt
I can take you to the mountain now!
+ [Take me to the mountain.]
	{dog_walking_started && not dog_walking_completed:
		- 1: -> with_dog 
	}
	>>> TELEPORT_TO_WAYPOINT: taxi_at_mountain
	OK!
	Have fun!
	-> DONE
+ [Not yet, maybe later...]
	OK!
	-> DONE

= with_dog
Sorry, you can't take your dog inside my taxi. Come back when that wonderful canine has been walked.
-> DONE

= use_item
{used_item:
	- "seat_belt": -> seat_belt
	- else: -> default
}

= seat_belt
Cool belt! Exactly what I need!
I will finally be able to safely transport people to the mountain with that!
Just let me know when you'd like to go!
-> DONE

= default
Not interesting.
-> DONE

=== conv_taxi_at_mountain ===
//-- STATUS : COMPLETED!
// This taxi waits for you at the mountain and can take you back to the parking.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Would you like to go back to town?
+ [Yes!]
	OK! Let's go!
	>>> TELEPORT_TO_WAYPOINT: taxi_at_park
	Have fun!
	-> DONE
+ [No!]
	OK! I'm waiting here!
	-> DONE

= use_item
I don't need that.
-> DONE

=== conv_canster ===
//-- STATUS: COMPLETED!
// This trashbin eats you if it isn't appeased with some trash tribute!
// The first canster that you feed also gives you the pump.

{get_canster_appeased(interact_id):
	- 0: -> conv_canster_not_appeased
	- 1: -> conv_canster_appeased
}

=== conv_canster_not_appeased ===
//-- STATUS: COMPLETED!
// The canster is angry and eats you... unless your active item is trash.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
>>> PLAY_CUTSCENE: eat_player
!!?
Bah! You're no trash!
>>> PLAY_CUTSCENE: spit_out_player
-> DONE

= use_item
{
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup" or used_item == "trash_paper": -> trash
	- else: -> interact
}

= trash
>>> REMOVE_ITEM: {used_item}
~ set_canster_appeased(interact_id, 1)
{pump_received:
	- 0: -> before_pump_received
	- 1: -> after_pump_received
}

= before_pump_received
Nom nom, thanks for the trash!
In return, here is something that somebody threw away and isn't trash at all!
Actually, it's a useful bike pump!
>>> ADD_ITEM: pump
~ pump_received = 1
-> DONE

= after_pump_received
Yum yum!
I love trash!
-> DONE

=== conv_canster_appeased ===
//-- STATUS: COMPLETED!
// The canster has previously been given some trash and is now happy!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Thanks for the trash!
-> DONE

= use_item

{
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup" or used_item == "trash_paper": -> trash
	- else: -> default
}

= trash
Sorry, I'm full...
But perhaps there is another trash can somewhere?
-> DONE

= default
Bah! That's not trash!
-> DONE

=== conv_wheelie ===
//-- STATUS: READY FOR TRANSLATION
// Wheelie is a kid in a wheelchair who wants to go home.
// You have to escort him and make sure he doesn't get scared away by cansters.
// You'll have to escort him twice... one time to his house and afterwards back to the park.
// When arriving at his house, he goes and comes back out with a fence.
// Afterwards, when getting back to the park he gives you the battery.
//-- RELEVANT VARIABLES:
// wheelie_intro_at_park_completed
// wheelie_intro_before_park_fixed_completed
// wheelie_intro_after_park_fixed_completed
// wheelie_intro_back_at_park_completed

// wheelie_arrived_at_house
// wheelie_arrived_at_park

// wheelie_going_to_park
// wheelie_going_to_house

// wheelie_got_scared

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{operation_better_park_started:
	- 1: -> protesting
}

// Make wheelie 'unclickable' when he is moving!
{wheelie_got_scared || wheelie_going_to_house || wheelie_going_to_park:
	- 1: -> DONE
}

{wheelie_arrived_at_park:
	- 1: 
	{mr_smog_defeated:
		- 0: 
		{wheelie_intro_back_at_park_completed:
			- 0: -> before_wheelie_intro_back_at_park_completed
			- 1: -> before_mr_smog_defeated
		}
		- 1: -> after_mr_smog_defeated
	}
}

{wheelie_arrived_at_house:
	- 0: 
	{wheelie_intro_at_park_completed:
		- 0: -> before_wheelie_intro_at_park_completed
		- 1: -> after_wheelie_intro_at_park_completed
	} 
	- 1: 
	{number_of_fences_fixed:
		- 4:
		{wheelie_intro_after_park_fixed_completed:
			- 0: -> before_wheelie_intro_after_park_fixed_completed
			- 1: -> after_wheelie_intro_after_park_fixed_completed
		}
		- else:
		{wheelie_intro_before_park_fixed_completed:
			- 0: -> before_wheelie_intro_before_park_fixed_completed
			- 1: -> after_wheelie_intro_before_park_fixed_completed
		}
	}
}

= before_wheelie_intro_at_park_completed
~ wheelie_intro_at_park_completed = 1
Now that the fence is gone, we can't play football.
Until things are resolved, I will head home.
Alas, on my way home there is a lot of hungry trash cans!
Can you please feed them with trash? Otherwise, they start eating us monsters!
-> DONE

= after_wheelie_intro_at_park_completed
Hey, have you fed all the trash cans?
+ [Yes, the road is clear!]
	Super, let's go!
	~ wheelie_going_to_house = 1
	-> DONE
+ [Not yet, maybe later.]
	Ok, just let me know when you've cleared the way home for me!
	-> DONE

= before_wheelie_intro_before_park_fixed_completed
Thanks for following me all the way home!
I'll go see what my mother and father are doing while I'm gone!
// Goes in and checks with his mom.
>>> PLAY_CUTSCENE: fade_to_black_and_back
Hey, it seems that there was a piece of fence on the roof of our building.
Here, take it, maybe you'll fix the whole fence one day.
>>> ADD_ITEM: fence
~ player_received_wheelie_fence = 1
~ wheelie_intro_before_park_fixed_completed = 1
Whenever you wish to enter my building, feel free to do so!
~ wheelie_appartment_opened = 1
-> after_wheelie_intro_before_park_fixed_completed

= after_wheelie_intro_before_park_fixed_completed
Thanks for following me home.
I think I'll stay here until the fence in the park is fixed.
Come get me when it's fixed! Bye bye!
-> DONE

= before_wheelie_intro_after_park_fixed_completed
~ canster_left_appeased = 0
~ canster_middle_appeased = 0
~ canster_right_appeased = 0
Wow, you've fixed the fences!
I'd love to come to play football with you, but...
The cans are hungry again!
Can you please feed them with trash again?
I'm so scared of them...
~ wheelie_intro_after_park_fixed_completed = 1
-> after_wheelie_intro_after_park_fixed_completed

= after_wheelie_intro_after_park_fixed_completed
Are all the cans fed now?
+ [Yes, now it's secure!]
	Super! Let's go!
	~ wheelie_going_to_park = 1
	// You escort wheelie back to the park! 
	-> DONE
+ [Not yet, I'm working on it!]
	OK, just let me know! You know how those cans can be when they go hungry!
	-> DONE

= before_wheelie_intro_back_at_park_completed
Thanks for following me back to our wonderful park!
I think I'll stay here and enjoy the park forever!
Here, you can take my battery. I don't need it anymore!
>>> ADD_ITEM: battery
~ wheelie_intro_back_at_park_completed = 1
-> DONE

= before_mr_smog_defeated
{mr_smog_defeated:
	- 1: -> after_mr_smog_defeated
}
It really is a wonderful day.
The only thing missing is the big tree that was once planted here.
I wonder what happened to it...
-> DONE

= after_mr_smog_defeated
Thanks for returning our happy tree to the park!
That silly smile of his always brightens my day!
-> DONE

= protesting
Enough hungry trash cans on my way home!
Give us a clean park with no garbage everywhere!
-> DONE

= outro
This park is awesome!
There is no trash anywhere at all.
-> DONE

= use_item
{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
Keep the battery, I no longer need it!
-> DONE

= default
I don't need it!
-> DONE

=== conv_wind_turbine ===
//-- STATUS: COMPLETED!
// The wind turbine can be powered by a battery you get from Vilko.
// Turning it on removes the smog from the smoggy part of town.
//-- RELEVANT VARIABLES:
// wind_turbine_powered

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{wind_turbine_powered:
	- 0: -> before_wind_turbine_powered
	- 1: -> after_wind_turbine_powered
}

= before_wind_turbine_powered
Usually, wind turbines convert wind into energy, but this one is different!
This turbine converts energy into the wind!
This big hole has a battery symbol.
Perhaps, if I had a battery to put here, I could start up the turbine.
-> DONE

= after_wind_turbine_powered
Wow, all that wind blew away the whole smog in the city!
People will finally be able to breathe!
-> DONE

= use_item
{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
~ wind_turbine_powered = 1
>>> REMOVE_ITEM: battery
Wow, it works now!
-> after_wind_turbine_powered

= default
That won't help, I need to put a power source in the hole.
-> DONE

=== conv_bus ===
//-- STATUS: COMPLETED!
// This bus blocks the view for incoming cars, you'll have to take the other zebra!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Hey, monster! Sorry for being in your way.
But I'm 23 hours behind schedule!
Never mind though - if I wait one more hour here, I'll be right on time!
Oh, also - look out for cars!
They can't see you when you're crossing the road because my bus is parked here!
Try to cross the road in front of the bus where they can see you.
-> DONE

= use_item
{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
Battery, you say? Simpatico. Try putting it in the wind turbine up north.
-> DONE

= default
Simpatico.
Now leave me alone.
-> DONE

=== conv_love_interest ===
//-- STATUS: READY FOR TRANSLATION
// The love interest trades you her colorful jacket in exchange for your plain one.
// You need this jacket to get into the smoggy part of town.
// Afterwards you can ask her to join the protests!

//-- RELEVANT VARIABLES
// love_interest_gone_protesting
// player_wearing_color

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{love_interest_gone_protesting:
	- 0: 
	{player_wearing_color:
		- 0: -> wearing_plain
		- 1: -> wearing_color
	}
	- 1: -> protesting
}

= wearing_plain
Hey, you! How do you like my new jacket? It's colorful, isn't it?
I think it would fit you too!
Do you want to trade jackets?
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Actually, I wanted to ask you to join our park protest.]
	You know I'd do anything for you!
	I'll be there right away!
	>>> FADE_TO_OPAQUE
	~ love_interest_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Yes, let's swap!]
	~ player_wearing_color = 1
	Great! Just let me know when you want your old jacket back!
	-> DONE
+ [No, I love my own jacket.]
	Ok!
	-> DONE

= wearing_color
Hey! Wanna swap jackets again?
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Actually, I wanted to ask you to join our park protest.]
	You know I'd do anything for you!
	I'll be there right away!
	>>> FADE_TO_OPAQUE
	~ love_interest_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Yes, return my jacket!]
	~ player_wearing_color = 0
	Of course, here you go!
	-> DONE
+ [No, I kinda like your jacket!]
	Ok, wear it all you want!
	-> DONE

= protesting
Renovate our park! 
Park park park!
{player_wearing_color:
	- 0: -> wearing_plain
	- 1: -> wearing_color
}

= outro
Now that we're done with this whole park story, perhaps...
We could enjoy the park together!
-> DONE

= use_item
Thanks, but all I need from you is your love!
-> DONE

=== conv_dog ===
//-- STATUS: READY FOR TRANSLATION
// A dog that you have to walk around the city. 
// She will tell you were to go by using her pleading puppy eyes.
// After a while the dog will become tired and wants to go back home.
//-- RELEVANT VARIABLES:
// dog_visited_lake
// dog_visited_park

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{dog_visited_lake && dog_visited_park:
	- 0: 
	{dog_visited_lake:
		- 0: -> visit_lake
		- 1: -> visit_park
	}
	- 1: -> go_back_home
}

= visit_lake
Woof woof!
The doggie looks like she wants water!
I'll take her to the lake near Vilko's place!
-> DONE

= visit_park
Woof woof!
The doggie wants to go to the park!
I'll walk her over to the worm called Solid Slug.
-> DONE

= go_back_home
Woof woof!
The doggie looks tired...
I'll return her to the organisation for training therapy dogs.
-> DONE

= use_item
The doggie is sniffing your inventory item.
But she is too well trained to chew it!
-> DONE

== conv_dog_at_lake ===
// -- STATUS: READY FOR TRANSLATION
// Conversation that pops up when you arrive at the lake with the dog.
//-- RELEVANT VARIABLES:
// dog_visited_lake

The doggie looks happy on the lake.
I'll walk her around a bit more and see where she wants to go next.
~ dog_visited_lake = 1
-> DONE

== conv_dog_at_park ===
// -- STATUS: READY FOR TRANSLATION
// Conversation that pops up when you arrive at the park with the dog.
//-- RELEVANT VARIABLES:
// dog_visited_park

The doggie is so happy in the park!
I'll walk her around a bit more and see where she wants to go next.
~ dog_visited_park = 1
-> DONE

=== conv_copper ===
//-- STATUS: 
// The copper blocks you from entering the smoggy part of town until you are wearing something colorful.
// He also tells you about the windmill as a hint.
//-- RELEVANT VARIABLES
// wind_turbine_powered
// player_wearing_color

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{wind_turbine_powered:
	- 0:
	{player_wearing_color:
		- 0: -> wearing_plain
		- 1: -> wearing_color
	}
	- 1: -> after_wind_turbine_powered
}

= wearing_plain
STOP!
You can't enter Smog City dressed like that!
Can't you see the smog inside? Nobody will see you in clothes like that!
Come back when you have something shinier on you!
Remember: when you are in dark places, you must be visible to cars!
-> DONE

= wearing_color
Hello, monster! It seems you are wearing a colorful jacket.
You may enter Smog city as long as you're wearing something very visible.
Remember: when you are in dark places, you must be visible to cars!
-> DONE

= after_wind_turbine_powered
Wow! It seems somebody turned on the wind turbine on the mountain!
All the smog is gone and you can now wear whatever you want while in Smog City!
-> DONE

= use_item
I don't need that, thanks! I'm only looking after your safety in traffic.
-> DONE

=== conv_happy_tree ===
//-- STATUS: READY FOR TRANSLATION
// This tree appears after defeating Mr. Smog and thanks you for freeing him.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
I was possessed by evil smog.
But I'm a happy tree again!
Thanks for your help!
-> DONE

= outro
The park is beautiful!
And there are so many trees to befriend!
Thanks for your effort!
-> DONE

= use_item
I am just a tree and I don't need these things.
-> DONE

=== conv_mr_smog ===
//-- STATUS: COMPLETED!
// Mr. Smog is an angry boss who tries to murder you with his smog bullets.
//-- RELEVANT VARIABLES:
// mr_smog_defeated

{mr_smog_defeated:
	- 0: -> before_mr_smog_defeated
	- 1: -> after_mr_smog_defeated
}

= before_mr_smog_defeated
>>> PAN_CAMERA_TO_POSITION: 704 2720
MUHUHAHAHA
By a hundred smogs, you will never defeat my smoggy smogness!
>>> RESET_CAMERA
-> DONE

= after_mr_smog_defeated
>>> UPDATE_UI: happy_tree
>>> PAN_CAMERA_TO_POSITION: 704 2720
Oh my, all the smog has left me!
I am a happy tree again!
I shall go back to my beloved park!
>>> FADE_TO_OPAQUE
~ mr_smog_outro_completed = 1
>>> RESET_CAMERA
>>> FADE_TO_TRANSPARENT
-> DONE

=== conv_flower_box ===
//-- STATUS:
// Here you can plant the rose seeds you get from the shop and this pleases Rosalina.
// The police officer will appear here and disagree with your actions, but won't interfere.
//-- RELEVANT VARIABLES:
// 

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> after_rose_seeds_planted
	- else: -> main
}

= main
{rose_seeds_planted:
	- 0: -> before_rose_seeds_planted
	- 1: -> after_rose_seeds_planted
}

= before_rose_seeds_planted
The earth is fertile and perfect for plants!
Alas, nothing grows here?
-> DONE

= after_rose_seeds_planted
The roses smell nice.
They fit the color of the building.
-> DONE

= use_item

{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default
}

= rose_seeds
{flower_copper_swayed:
	- 0: -> before_flower_copper_swayed
	- 1: -> after_flower_copper_swayed
}

= before_flower_copper_swayed
>>> UPDATE_UI: copper
Hey, what are you doing!?
Planting flowers is not forbidden!
Flowers will be planted when pots are discussed on the city's daily schedule!
+ [Daily schedule? How long has it been without flowers?]
	Hmm... I think the pots are here since before I was a cop.
	++ [When did you become a cop?]
		...
		Over 10 years ago...
		Well alright, my monstery friend, if you must plant the roses...
		I won't stop you from that.
		Perhaps it is time somebody planted something in those pots.
		~ flower_copper_swayed = 1
		-> DONE
	++ [If the pots have been empty for so long, it doesn't hurt for them to stay empty a little bit longer...]
		Exactly. Pots will make their way on the city's daily schedule eventually.
		But not today.
		-> DONE
+ [Sorry, I'll wait until it becomes an issue for city bureaucracy...]
	That is good, obedient citizen! Bureaucracy was made for good reason!
	-> DONE

= after_flower_copper_swayed
Monstery roses grow very fast in this fertile land!
Rosey will be so happy!
>>> REMOVE_ITEM: rose_seeds
~ rose_seeds_planted = 1
-> DONE

= default
I don't think I can plant that...
-> DONE

=== conv_flower_copper ===
//-- STATUS: READY FOR TRANSLATION
// Copper who warns you not to plant the seeds in the flower box.
// He only appears once you have the rose seeds.
//-- RELEVANT VARIABLES:
// rose_seeds_planted
// roda_shop_gave_seeds

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{rose_seeds_planted:
	- 0: -> before_rose_seeds_planted
	- 1: -> after_rose_seeds_planted
}

= before_rose_seeds_planted
I am only monitoring the situation so that somebody doesn't do something illegal.
I am watching you!
-> DONE

= after_rose_seeds_planted
When I see these wonderful flowers, I find that it is sometimes useful to avoid bureaucracy.
If we listened to the rules a bit less, and our hearts more, the world would be full of fragrant roses.
-> DONE

= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default 
}

= rose_seeds
Simpatico seeds.
But don't plant them without the approval of the communal bureaucracy!
ESPECIALLY not in that pot over there.
That pot is city property and you may plant nothing inside it!
-> DONE

= default
Thank you, citizen, but I require nothing except honoring the law.
-> DONE

=== conv_dog_trainer_club ===
//-- STATUS: READY FOR TRANSLATION
// These guys ask you questions about training dogs and then ask you to walk a dog for them.
// Afterwards you can ask her to join you in the park protests.
//-- RELEVANT VARIABLES:
// dog_trainer_club_gone_protesting
// dog_test_started
// dog_test_passed
// dog_walking_started
// dog_walking_completed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{dog_trainer_club_gone_protesting:
	- 0:
		{dog_test_started:
			- 0: -> main_intro
			- 1:
				{dog_test_passed:
					- 0: -> before_dog_test_passed
					- 1:
						{dog_walking_started:
							- 0: -> after_dog_test_passed
							- 1:
								{dog_walking_completed:
									- 0:
									{dog_visited_lake && dog_visited_park:
										- 0: -> before_dog_walking_completed
										- 1: -> after_dog_tired
									}
									- 1: -> after_dog_walking_completed
								}
						}
				}
		}
	- 1: -> protesting
}

= main_intro
Hello and welcome to Dog School!
We train therapy dogs.
They are extremely important for those who are blind and those with disabilities!
You are a good monster, would you help us train a dog?
+ [In fact, I don't think I have the time...]
	Too bad.
	Come back if your schedule clears up!
	-> DONE
+ {operation_better_park_started}[Would you come protest for a better park?]
	We could, but first we need to walk this therapy dog.
	If you help us, we will come to the protest!
	-> before_dog_test_started
+ [It would be my honor.]
	-> before_dog_test_started

= before_dog_test_started
You see, dogs must be walked daily so they may better remember the layout of the city.
But, before that, we need to check your knowledge of therapy dogs!
Are you ready to take our therapy dog trainer exam?
-> after_dog_test_started

= before_dog_test_passed
Hi, will you try taking our therapy dog trainer exam again?
-> after_dog_test_started

= after_dog_test_started
++ [Yes!!!]
	Let's go!
	~ dog_test_started = 1
	-> start_dog_test
++ [Maybe later.]
	Later is fine too.
	Come whenever you wish!
	-> DONE

= start_dog_test
First question:
What is volunteering?
+ [Well paid overtime.]
	Wrong!
	-> wrong_answer
+ [Willing investment of time, effort, knowledge or skills for the benefit of others or the community, such as volunteering in organisations, dog shelters, socialising therapy dogs, etc.]
	That's right!
	-> second_question
+ [Unpaid overtime.]
	Wrong!
	-> wrong_answer
+ [Investment of time, effort, knowledge or skills for the benefit of others or the community, against your will.]
	Wrong!
	-> wrong_answer

= second_question
Second question:
What do therapy dogs do?
+ [Carry newspapers and things from the store.]
	Wrong.
	-> wrong_answer
+ [Help kids with disabilities, people in wheelchairs and can help blind people.]
	Correct!
	-> third_question
+ [They look for truffles in the forest or go hunting with hunters.]
	Wrong.
	-> wrong_answer

= third_question
You've answered all the questions correctly, which means you are officially...
A therapy dog trainer!!! Congratulations!
~ dog_test_passed = 1
-> after_dog_test_passed

= wrong_answer
No, that's wrong!
We'll have to stop the questioning immediately.
But do not despair - you can always retake the exam.
-> DONE

= after_dog_test_passed
Now you can help us walk this wonderful dog.
~ dog_walking_started = 1
Her name is Lepa. Enjoy!
If you don't know where to go, just ask her.
She might not be able to talk but dogs have a way of telling us where they want to go!
Come back when she's tired.
-> DONE

= before_dog_walking_completed
Lepa is not tired yet, walk some more!
Ask her where she would like to go if you don't know where to go.
-> DONE

= after_dog_tired
~ dog_walking_completed = 1
Lepa is really tired from this walk.
Well done! A bit of training is always good for you!
-> after_dog_walking_completed

= after_dog_walking_completed
Thanks for walking Lepa!
Is there something we can do for you?
+ {operation_better_park_started}[Can you come to the protest for a better park?]
	Of course, we will come!
	A nicer park means more nature in the city for our therapy dogs to enjoy.
	~ dog_trainer_club_gone_protesting = 1
	-> DONE
+ [Nothing for now.]
	Just ask us if you need anything.
	We owe you a favour now!
	-> DONE

= protesting
Oh, hi.
Everyone else has already gone to the protest.
I'm just here to watch the dogs.
-> DONE

= outro
All the dogs are accounted for if that's what you're interested in.
And they are very happy with the renovated park!
The variety of trees makes them very happy!
-> DONE

= use_item
We don't need that, thank you.
-> DONE

=== conv_park_lovers ===
//-- STATUS: READY FOR TRANSLATION
// The park crowd wants you to design a poster for them.
// Afterwards you can recruit them for the park revolution protests.
//-- RELEVANT VARIABLES:
// operation_better_park_started
// poster_designed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}
= main
{operation_better_park_started:
	- 0: -> before_operation_better_park_started
	- 1:
	{poster_designed:
		- 0: -> before_poster_designed
		- 1: -> after_poster_designed
	}
}

= before_operation_better_park_started
We are park lovers!
We love our park and can't wait to start our park-loving plan.
But the time is not right. We will tell you all about it one day.
-> DONE

= before_poster_designed
We are park lovers!
We hear you are a park lover too.
We want to create a poster that we would hang all over town.
Alas, we need a good designer!
Would you help us?
+ [Yes! I am an expert in designing posters.]
	Perfect, here's an empty poster!
	Let us know when you're done with the design.
	-> start_poster_minigame
+ [I don't think I can help out this time.]
	Don't worry, we'll find someone.
	-> DONE

= after_poster_designed
Would you like to re-design the poster?
+ [Yes, I have an idea for a better design!]
	Great, we can't wait to see that too.
	-> start_poster_minigame
+ [No need to fix perfection.]
	All right, we'll be here if you wish to change something.
	-> DONE

= start_poster_minigame
>>> BEGIN_MINIGAME: poster_minigame
+ It looks AWESOME!
	We'll copy this poster and hang it all over town!
	If you don't like the design, we can always change it - just ask us!
	~ poster_designed = 1
	>>> END_MINIGAME
	-> DONE

= outro
Thanks for helping renovate the park.
But - the park revolution never sleeps - we now have even greater plans for our park!
-> DONE

= use_item
We don't need that!
-> DONE

=== conv_wheelie_appartment ===
//-- STATUS: READY FOR TRANSLATION
// The door to Wheelie's appartment is opened by Wheelie after you escort him here.
//-- RELEVANT VARIABLES: 
// wheelie_appartment_opened

{wheelie_appartment_opened:
	- 0: -> DONE
	- 1: -> after_wheelie_appartment_opened
}

= after_wheelie_appartment_opened
Vilko invited me into his building!
Should I enter?
+ [Yes, I'll go in!]
	{player_on_bike:
		- 1: -> on_bike
	}
	{dog_walking_started && not dog_walking_completed:
		- 1: -> with_dog
	}
	~ player_inside_appartment = 1
	>>> TELEPORT_TO_WAYPOINT: wheelie_elevator
	-> DONE
+ [Not yet.]
	Perhaps another time.
	-> DONE

= on_bike
But I'm no savage... I should first get off the bike before entering someone's house.
-> DONE

= with_dog
Not with Lepa, it wouldn't be appropriate.
-> DONE

=== conv_wheelie_elevator
//-- STATUS: READY FOR TRANSLATION
// The elevator necessary to leave Wheelie's appartment again...

Should I take the elevator down?
+ [Yes, it's time to go outside.]
	~ player_inside_appartment = 0
	>>> TELEPORT_TO_WAYPOINT: wheelie_appartment
	-> DONE
+ [No, I'll stay here some more.]
	-> DONE

=== conv_roda_shop ===
//-- STATUS: READY FOR TRANSLATION
// RODA's shop is where you can get the old man's groceries and the rose seeds.
//-- RELEVANT VARIABLES:
// roda_shop_gone_protesting
// roda_shop_gave_groceries
// roda_shop_gave_seeds

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Welcome to the SUPER RODA store!
We dream of one day opening an organisation called Roda to help parents and children!
How can we help you?
+ {rosalina_requested_seeds}[Can I get free rose seeds?]
	Of course you can! We can't wait to help make the city livelier and greener.
	{roda_shop_gave_seeds:
		- 0: -> before_roda_shop_gave_seeds
		- 1: -> after_roda_shop_gave_seeds
	}
+ {old_man_requested_groceries && not roda_shop_gave_groceries}[An elderly gentleman from Vilko's flat said you had groceries for him.]
	That's right, it's all ready for him.
	Here's a grocery bag, feel free to bring it over to him!
	>>> ADD_ITEM: grocery_bag
	~ roda_shop_gave_groceries = 1
	-> DONE
+ {operation_better_park_started && not roda_shop_gone_protesting}[Will you join our protest for a better park?]
	That sounds like something the whole community could benefit from.
	We will be there right away!
	~ roda_shop_gone_protesting = 1
	-> DONE
+ [Nothing, just looking...]
	Don't hesitate to ask us anything!
	-> DONE

= before_roda_shop_gave_seeds
Here you go: free seeds to grow monstery roses!
>>> ADD_ITEM: rose_seeds
~ roda_shop_gave_seeds = 1
-> DONE

= after_roda_shop_gave_seeds
Actually, we've already given you seeds to grow monstery roses.
We can't give you more than one bag, we have to think of others too.
-> DONE

= use_item
Thanks but we don't need that!
-> DONE

=== conv_blind_guy ===
//-- STATUS: READY FOR TRANSLATION
// Blind guy who wants to cross the street but can't because he's scared of traffic.
// You help him cross the street and he joins you in protests for a better park.
//-- RELEVANT VARIABLES:
// blind_guy_helped
// blind_guy_gone_protesting

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{blind_guy_gone_protesting:
	- 0:
	{blind_guy_helped:
		- 0: -> before_blind_guy_helped
		- 1: -> after_blind_guy_helped
	}
	- 1: -> protesting
}

= before_blind_guy_helped
Fellow monster!
Would you help me cross the road?
As you can see, I'm blind as a bat!
But that doesn't stop me from enjoying the smells and sounds of our wonderful park.
If only these fast cars were a bit slower, I'd be less afraid of crossing the road...
+ [I'll help you cross the road!]
	Thanks so much!
	>>> PLAY_CUTSCENE: escort_blind_guy
	-> success
+ [I can't help you now, perhaps another time.]
	Fine, I'll wait a little bit more then, perhaps the traffic will subside.
	-> DONE

= success
Thanks for helping me across the road!
I don't know how long I would have been staying there if you hadn't come across!
How could I thank you?
Ah, I know! I could show you how to spell "Thank you" in Braille!
~ blind_guy_helped = 1
-> show_braille

= after_blind_guy_helped
Do I smell the same monster who helped me cross the road?
Would you like me to show you Braille again?
+ {operation_better_park_started}[We're organising a protest to help renovate the park. Would you join?]
	A larger park would mean I no longer have to cross the road to get to it!
	You wouldn't believe how much time I spend daily just waiting on the crosswalk...
	I'd be happy to help!
	>>> FADE_TO_OPAQUE
	~ blind_guy_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Yes!]
	-> show_braille
+ [I have to go!]
	Fine, come back any time!
	-> DONE

= show_braille
>>> BEGIN_MINIGAME: braille_minigame
Braille is a system that blind people like me use for reading and writing.
It is read by moving your fingers over the letters and feeling the symbols.
Next time you are in an elevator, take a look at the buttons.
They often have the floor numbers written in Braille as well.
This is so that blind people can choose the right floor easily.
Neat, isn't it?
>>> END_MINIGAME
-> DONE

= protesting
No more noise polution! No more smog!
Build us a bigger park!
-> DONE

= outro
Perhaps I can't see the new park.
But I can definitely feel that the quality of the air has improved.
Also, the noise pollution from all those cars is gone!
Well done, great initiative!
-> DONE

= use_item
Wait, I need to feel what you are giving me...
{used_item == "trash_cup" || used_item == "trash_bottle" || used_item == "trash_bag":
	- 1: -> trash
	- 0: -> no_trash
}

= trash
You want to get rid of your trash by giving it to me?
No can do!
-> DONE

= no_trash
That's a cute trinket but I don't need it.
Thanks anyway!
-> DONE

=== conv_monsters_without_borders ===
//-- STATUS: READY FOR TRANSLATION
// Monsters without Borders protects the civil rights of monsters big and small!
// They ask you some questions about monster rights and then let you join their organization.
//-- RELEVANT VARIABLES:
// monsters_without_borders_joined
// monsters_without_borders_gone_protesting

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{monsters_without_borders_gone_protesting:
	- 0: -> intro
	- 1: -> protesting
}

= intro
Welcome to Monsters Without Borders!
We fight for the rights of all monsters, whether they are big or small.
How can we help you?
+ {operation_better_park_started}[Can you come to the protest for a better park?]
	{monsters_without_borders_joined:
		- 0: -> before_monsters_without_borders_joined
		- 1: -> after_monsters_without_borders_joined
	}
+ {not monsters_without_borders_joined}[Can I become a member?]
	Not anyone can become a member.
	First, you must pass an entrance exam.
	Are you ready?
	++ [Yes, let's go!]
		Ok, let me find the form...
		-> start_monsters_without_borders_test
	++ [Not yet.]
		No problem, come back whenever you wish.
		-> DONE
+ [Just taking a stroll...]
	That's fine, just you walk!
	-> DONE

= start_monsters_without_borders_test
First question...
-> first_question

// TODO: Add some actual questions here!
= first_question
What is participation?
+ [When citizens don't participate in decisions important for the community they live in, such as renovating a park or equipping a playground.]
	Wrong.
	-> failure
+ [When citizens actively participate in decisions important for the community they live in, such as renovating a park or equipping a playground.]
	Correct.
	-> second_question
+ [When citizens participate in protests.]
	Wrong.
	-> failure

= second_question
What is social sustainability or social cohesion?
+ [When the society we live in ensures the welfare of only some citizens.]
	Wrong.
	-> failure
+ [When the society we live in is capable of ensuring the welfare of all its members, by lowering inequalities and divisions and by caring about all its members.]
	Correct!
	-> success
+ [When the society we live in is not capable of ensuring the wellbeing of its members.]
	Wrong.
	-> failure
+ [When society instigates inequalities and divisions between citizens.]
	Wrong.
	-> failure

= success
Monstrously good!
We would be honored to have you as a member!
Congratulations, you too are now a Monster Without Borders!
~ monsters_without_borders_joined = 1
-> DONE

= failure
Perhaps another time.
-> DONE

= before_monsters_without_borders_joined
Are you a member of Monsters Without Borders?
No?
Then we can't help you yet.
Luckily, it's easy to become our member.
-> DONE

= after_monsters_without_borders_joined
Of course, we will help you! It's just the thing for all the monsters in this neighbourhood!
We'll be sending our members there immediately!
~ monsters_without_borders_gone_protesting = 1
-> DONE

= protesting
Everybody is on the par protest.
I'm here since I haven't paid my membership fee yet.
-> DONE

= outro
The rights of every monster must be respected, even the right to a renovated park!
This makes us happy!
-> DONE

= use_item
We don't need that.
-> DONE

=== conv_rosalina ===
//-- STATUS : READY FOR TRANSLATION
// Rosalina wants to plant roses in front of the building, but she's afraid of authority.
// Afterwards you can ask her to join you in the park protests.
//-- RELEVANT VARIABLES:
// rosalina_gone_protesting
// rosalina_requested_seeds
// rose_seeds_planted

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
// Check the current stage!
{get_level_state():
	- 2: -> outro
	- else: -> main
}

// INTERACT - MAIN //
= main
{rosalina_gone_protesting:
	- 0:
		{rosalina_requested_seeds:
			- 0: -> main_intro
			- 1:
			{rose_seeds_planted:
				- 0: -> before_rose_seeds_planted
				- 1: -> after_rose_seeds_planted
			}
		}
	- 1: -> protesting
}

= main_intro
Hi! I'm Rosey and I love flowers!
Did you see the fertile earth in the pots in front of the building?
I can't believe they forgot to plant flowers there!
Can you do me a favour?
Can you get some flower seeds from the store?
Any flower will do!
+ {mr_smog_defeated == 0}[I'm sorry, I'm trying to fix the park that Mister Smog blew away!]
	Ah...
	Well, when you finish that, let me know, I'll be here!
	-> DONE
+ {operation_better_park_started}[I'm sorry, I'm trying to gather all the monsters around to protest for a better park!]
	That sounds great! Parks are filled with flowers!
	Hey, I have an idea!
	If you help me plant the flowers in front of our building, I'll go to your protest!
	-> DONE
+ [Okay, I'll go get the seeds from the shop right away!]
	Thanks!
	Stores and flower shops have seeds of various flowers, but I prefer red roses!
	This neighbourhood will look much better once we plant them.
	~ rosalina_requested_seeds = 1
	-> DONE

= before_rose_seeds_planted
You can find the flower seeds in the Super Roda store.
I think they were even giving them away for free.
Please hurry while they still have them!
-> DONE

= after_rose_seeds_planted
Thanks a lot!
You have no idea how happy I am now!
+ {operation_better_park_started}[Will you come support our protest for a better park now?]
	Of course, I'd be glad.
	Parks are the lungs of the city!
	>>> FADE_TO_OPAQUE
	~ rosalina_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [It was my pleasure!]
	-> DONE

= protesting
Parks are the lungs of the city!
Let a thousand blossoms bloom!
-> DONE

// INTERACT - OUTRO //
= outro
These flowers are wonderful!
I'm so glad we have a new park.
Everybody needs more flowers in their life!
-> DONE
-> DONE

// USE ITEM //
= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default
}

= rose_seeds
These are rose seeds, my favourite!
Can you plant them in the pots in front of the building?
I would do it, but I'm afraid of the police.
-> DONE

= default
Thanks for the gift but I'm only interested in flowers!
-> DONE

=== conv_bell_old_man ===
//-- STATUS : READY FOR TRANSLATION
// The old man wants his groceries so you deliver them?
// Afterwards you can ask him to join you in the park protests.
//-- RELEVANT VARIABLES:
// old_man_gone_protesting
// old_man_requested_groceries
// old_man_received_groceries

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{old_man_gone_protesting:
	- 0:
		{old_man_received_groceries:
			- 0: -> before_old_man_received_groceries
			- 1: -> after_old_man_received_groceries
		}
	- 1: -> protesting
}

= before_old_man_received_groceries
YEES?
Have you brought me my groceries?
+ {has_item("grocery_bag")}[Of course, here you go, sir!]
	-> grocery_bag
+ [No, I'm just your friendly neighbourhood monster.]
	Come back when you have my groceries!
	They should have brought them from Super Roda na hour ago!
	~ old_man_requested_groceries = 1
	-> DONE
+ [Wrong door, sorry.]
	All right.
	-> DONE

= after_old_man_received_groceries
Are you still there?
Do you need anything from me?
+ [Will you come to the protest for a better park?]
	Ah, I see... Me, to a protest?
	Well, I do believe young ones today deserve a much better park than the one they have now.
	Yes, I'll come to the protest!
	See you!
	~ old_man_gone_protesting = 1
	-> DONE
+ [No, see you around!]
	Enjoy your youth!
	-> DONE

= protesting
Knock knock...
Hm....
Nobody is home!
Maybe the old man already went to the protest!
-> DONE

// USE ITEM //
= use_item
{used_item:
	- "grocery_bag": -> grocery_bag
	- else: -> default
}

= grocery_bag
My groceries!
>>> REMOVE_ITEM: grocery_bag
~ old_man_received_groceries = 1
So you brought them all the way from the Super Roda store?
It seems good manners are not altogether forgotten yet!
If you ever need a favour, just ask me!
{operation_better_park_started:
	- 0: -> DONE
	- 1: -> after_old_man_received_groceries
}

= default
Those aren't my groceries.
-> DONE

=== conv_old_man ===
//-- STATUS : READY FOR TRANSLATION
// The old man that appears in the park to protest together with you!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
When I was young, these were all green fields.
Back to better days! Back to the fields!
-> DONE

= outro
This park looks even nicer now than the green pastures of my childhood.
-> DONE

= use_item
Bah, what will they think of next...
-> DONE

=== conv_animal_protection_services ===
//-- STATUS : READY FOR TRANSLATION
// These guys ask you to go and feed  all of the squirrel houses scattered across the map.
// Afterwards you can ask them to join you in the park protests.
//-- RELEVANT VARIABLES:
// lunja_gone_protesting
// lunja_gave_nuts
// squirrels_at_lake_satiated
// squirrels_at_square_satiated
// squirrels_at_moujntains_satiated

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{lunja_gone_protesting:
	- 0:
		{lunja_gave_nuts:
			- 0: -> intro
			- 1:
			{squirrels_at_lake_satiated && squirrels_at_mountains_satiated && squirrels_at_square_satiated:
				- 0: -> before_all_squirrels_satiated
				- 1: -> after_all_squirrels_satiated
			}
		}
	- 1: -> protesting
}

= intro
Hi! We are Laika, an organisation for the protection of animals.
Wherever animals suffer, we are there to help!
Unfortunately, we have too much work, so many animals need our help...
+ {operation_better_park_started}[Will you come to the protest for a better park?]
	Renovating the park is a great idea!
	A bigger park means more greenery for our animals!
	Alas, we have too much work as it is...
	-> DONE
+ [Can I help you?]
	You would volunteer for us?
	Well thanks a lot, volunteers always need help!
	Hmm, how could you help us...
	Ah, but of course... The city squirrels need feeding!
	We've set up squirrel houses to some city trees.
	You can leave nuts and acorns for them!
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	~ lunja_gave_nuts = 1
	-> DONE
+ [Good luck!]
	Remember: animals and monsters share the same planet.
	-> DONE

= before_all_squirrels_satiated
Thanks for helping us feed the squirrels!
But it seems you haven't fed ALL the squirrels yet...
Hurry up, they must be very hungry!
-> DONE

= after_all_squirrels_satiated
All the squirrels have been fed.
Thanks for your help!
+ {operation_better_park_started}[Will you now help me and come to the protest for a better park?]
	Of course, we will!
	A bigger park means more greenery for our animals!
	We shall leave post-haste!
	~ lunja_gone_protesting = 1
	-> DONE
+ [Volunteering is really fun!]
	I'm glad you like it!
	-> DONE

= protesting
It's empty...
Probably all the volunteers from Laika left for the protest.
-> DONE

= outro
Many animals now live in this park.
I think squirrels won't need our help anymore!
There is so much food here!
-> DONE

= use_item
We don't need that, thanks!
-> DONE

=== conv_student ===
//-- STATUS : READY FOR TRANSLATION
// A student monster who has serious issues with his homework. 
// Afterwards you can ask him to join you in the park protests.
//-- RELEVANT VARIABLES:
// student_gone_protesting
// student_homework_done

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{get_level_state():
	- 2 : -> outro
	- else: -> main
}

= main
{student_gone_protesting:
	- 0:
		{student_homework_done:
			- 0: -> before_student_homework_done
			- 1: -> after_student_homework_done
		}
	- 1: -> protesting
}

= before_student_homework_done
I can't go out!
I must finish my homework but I can't concentrate...
My head is so dizzy from all the smog coming out of the flying cars' vents...
+ [Can I help you?]
	Oh, would you?
	This homework has been bugging me for hours.
	-> first_question
+ [Good luck...]
	Thanks, I'll need it...
-> DONE

// TODO : Add some actual questions here!

= first_question
First question: What is solidarity?
+ [When some members of our community worry about everything, and others do nothing.]
	I don't think that's correct...
	-> first_question
+ [When we do good and are ready to help those who need it the most, such as students with difficulty learning or the elderly.]
	Thanks a lot, that's correct.
	You're such a genius, help me with another question!
	-> second_question
+ [When we worry only about ourselves because our responsibilities don't give us time to worry about those who need our help.]
	I don't think that's correct.
	-> first_question
+ [When we worry about others too much so we don't have time to worry about ourselves.]
	I don't think that's correct...
	-> first_question

= second_question
Second question: What is inclusion?
+ [When all citizens are the same.]
	I don't think that's correct...
	-> second_question
+ [When all citizens, regardless of race, color, creed, gender, faith, political or other belief, national or social origin, social standing, disability, sexual orientation or age are included in social activities - such as people with disabilities, Roma, LGBTIQ persons and other vulnerable groups in society.]
	Thanks a lot, that's true.
	You are a genius, it's all clear to me now!
	Thanks so much!
	~ student_homework_done = 1
	-> after_student_homework_done
+ [When citizens are not included in social activities due to their race, color, creed, gender, faith, political or other belief, national or social origin, social standing, disability, sexual orientation or age.]
	I don't think that's correct.
	-> second_question
+ [When all citizens are different.]
	I don't think that's correct.
	-> second_question

= after_student_homework_done
Thanks again for all the help with homework!
If you ever need anything else from me, I'm here!
+ [Don't sweat it, good luck in school!]
	Likewise!
	-> DONE
+ {operation_better_park_started}[Would you help support our protest for a better park?]
	Of course! That park is too small even for our small city!
	We deserve a much bigger park.
	See you there!
	>>> FADE_TO_OPAQUE
	~ student_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE

= protesting
We want a bigger park!
We don't want cars!
Gases from cars make you dizzy and you can't finish your homework!
-> DONE

= outro
No more of those horrible car gases!
I can do my homework outside in the park!
I've already finished all of my homework for the rest of the year!
-> DONE

= use_item
I don't need that...
-> DONE

=== conv_squirrel_tree ===
//-- STATUS : READY FOR TRANSLATION
// Squirrel trees scattered around the map with squirrels that can be fed with nuts.
// Each tree can obviously only be fed once!
//-- RELEVANT VARIABLES:
// Depending on the actual squirrel tree:
// squirrels_at_square_satiated
// squirrels_at_lake_satiated
// squirrels_at_mountains_satiated

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_level_state():
	- 2: -> outro
	- else: -> main
}

= main
{get_squirrels_satiated(interact_id):
	- 0: -> squirrel_not_satiated
	- 1: -> squirrel_satiated
}

= squirrel_not_satiated
There is a little squirrel house on the tree!
How cute, a small squirrel family is inside...
Looks like they are very hungry.
{has_item("squirrel_nuts"):
	- 0: -> has_no_nuts
	- 1: -> has_nuts
}

= has_no_nuts
If I only had some nuts for them...
-> DONE

= has_nuts
Luckily, volunteers from Laika gave me plenty of nuts.
Here, little ones, go hungry no more, take these nuts!
>>> REMOVE_ITEM: squirrel_nuts
~ set_squirrels_satiated(interact_id, 1)
Wow, a hungry squirrel jumped out and took one acorn straight from my hand.
That's one less hungry squirrel in this cruel world.
-> DONE

= squirrel_satiated
Squirrels seem content and full.
If I give them too many acorns and nuts, they will become fat and discontent.
My motto is: To each according to their needs.
{has_item("squirrel_nuts"):
	- 1: -> find_other_squirrel_tree
}
-> DONE

= find_other_squirrel_tree
There must surely be other trees around with hungry squirrels.
-> DONE

= outro
Squirrels in this little house look happy and healthy!
I think now there is enough food around for squirrels to survive without the help of the Laika organisation!
-> DONE

= use_item
{used_item:
	- "squirrel_nuts": -> interact
	- else: -> default
}

= default
I don't think that's proper squirrel food.
-> DONE

=== conv_dog_people ===
// People from the Dog Trainer Club that are protesting...

We want a bigger park so that dogs can enjoy nature too!
-> DONE

=== conv_roda_people ===
// People from the RODA shop that are protesting...

We want more nature for our children!
More toys in the park!
-> DONE

=== conv_rights_people ===
// People from the Monsters Without Borders that are protesting...

People want a bigger park!
The city must heed our wishes!
-> DONE

=== conv_animal_people ===
// People from Lunja, the Animal Protection Services, that are protesting...

Enough smog and cars! More space for animals and nature!
-> DONE

=== conv_container ===
// A container in which you can throw trash!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
This is a trash container.
-> DONE

= use_item
{is_correct_trash(interact_id, used_item):
	- 0: -> wrong_trash
	- 1: -> correct_trash
}

= wrong_trash
I don't think that's the correct trash for this container.
-> DONE

= correct_trash
That's it, the correct trash should go in the correct container.
>>> REMOVE_ITEM: {used_item}
-> DONE

//--
// PICKUPS
//--
=== conv_broken_bike ===
// The broken bike of Solid Slug
This is the bike of Solid Slug!
Wow, it has been blown all the way over here...
I better bring it to him.
-> DONE

=== conv_trash_bag ===
// Trash necessary to feed the cansters...
Somebody went to all this trouble to put all the garbage in a bag...
But then they forgot to throw it in the trash!
-> DONE

=== conv_trash_cup ===
// Trash necessary to feed the cansters...
Somebody left this half-empty glass on the floor!
Or half-full?
In any case, I should throw it in the garbage bin!
-> DONE

=== conv_trash_bottle ===
// Trash necessary to feed the cansters...
This bottle has some juice, but I'm not drinking that!
It'll be best if I throw it in the trash.
-> DONE

=== conv_trash_paper ===
// Trash necessary to feed the cansters... or throw in the bin somewhere?
Somebody threw paper on the floor instead of in the trash.
-> DONE

=== conv_fence_at_turbine ===
// A fence piece lying next to the wind farm.
~ player_received_turbine_fence = true
Wow, this piece of the fence was blown away all the way here...
I better bring it back to the park.
-> DONE

=== conv_fence_at_smog ===
// A fence piece lying in the smoggy part of town.
~ player_received_smog_fence = 1
A piece of the fence! I almost missed it in all this smog!
I better bring it to Solid Snejk!
-> DONE

//--
// PLAYER
//--
=== conv_player ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Error.
-> DONE

= use_item
{used_item:
	- "bike": -> bike
	- "battery": -> battery
	- "fence": -> fence
	- "seat_belt": -> seat_belt
	- "broken_bike": -> broken_bike
	- "trash_bag": -> trash
	- "trash_cup": -> trash
	- "trash_bottle": -> trash
	- "pump": -> pump
	- "grocery_bag": -> grocery_bag
	- "rose_seeds": -> rose_seeds
	- "squirrel_nuts": -> squirrel_nuts
	- else: -> default
}

= bike
{player_solved_bike_question:
	- 0: -> bike_question
	- 1: 
	{player_on_bike:
		- 0: -> hop_on_bike
		- 1: -> step_off_bike
	}
}

= step_off_bike
~ player_on_bike = 0
Enough bicycling for now.
-> DONE

= hop_on_bike
{dog_walking_started && not dog_walking_completed:
	- 1: -> with_dog
}
{player_inside_appartment:
	- 1: -> inside_appartment
}
~ player_on_bike = 1
Time for some bicycling!
-> DONE

= with_dog
I can't ride a bike while I walk the dog!
-> DONE

= inside_appartment
I can't ride a bike inside!
-> DONE

= bike_question
I'm glad Slug let me use his bike.
But for safety's sake, I can only use it in certain situations.
- (multiple_choice)
Where can I use the bike?
+ [Everywhere! Even on the middle of the road!]
	No, no, no...
	I distinctly remember there are places where riding a bike is dangerous for me and others...
	If I drove it in the middle of the road, cars would hit me!
	-> multiple_choice
+ [On bike paths and in parks.] 
	Yes, that's right.
	~ player_solved_bike_question = 1
	-> hop_on_bike
+ [On bike paths, parks and over any pedestiran crossing, but not on pedestrian or car roads.]
	I don't think I can go over any pedestrian crossing...
	If there is no bike lane, I should get off the bike and cross the crossing by pushing the bike.
	-> multiple_choice

= pump
A pump?
This could be used to pump a flat tire!
...But you never know what awaits in these games...
-> DONE

= seat_belt
I should wear this seatbelt when I'm driving in a car.
Or even... in a taxi!
-> DONE

= battery
A battery? And it's still full!
I wonder why it would need so much energy?
-> DONE

= fence
A part of the fence that got blown away from our park...
It's best if I brought it to Solid Snejk immediately to fix it.
-> DONE

= broken_bike
This is Slug's bike.
It's best if I bring it to him as soon as possible, it looks a bit broken...
-> DONE

= trash
I should find a trash can to throw this in!
-> DONE

= grocery_bag
I should bring this bag with groceries to the elderly gentleman from Vilko's building.
-> DONE

= rose_seeds
I'm sure Rosey will love it when I plant these seeds in the pot outside her building.
-> DONE

= squirrel_nuts
These nuts are squirrel food.
I must find the trees with squirrel houses.
-> DONE

= default
{used_item}
I wonder what to do with this?
-> DONE

=== conv_gummy ===
Uh, what's all this on the floor?!
Chewing gum? Yuck!
I'll have to slow down while walking here...
Perhaps it would be easier with a bike.
~ player_noted_gummy = 1
-> DONE

=== conv_zebra ===
How do I cross the pedestrian crossing?
This is important so I don't get hit by cars!
- (multiple_choice)
If I remember correctly, to cross the pedestrian crossing, I must...
+ [Run to the other side as fast as I can!]
	...
	No, you should never run across the pedestrian crossing! It's too dangerous.
	-> multiple_choice
+ [Look left, right, then left again, and then cross!]
	Yes, that's it!
	Left-right-left! And then again on the middle of the crossing!
	~ player_solved_zebra_question = 1
	-> DONE
+ [Look right, then left, then right again, and then cross!] 
	No, that's not right, I think I've got the directions confused...
	-> multiple_choice

=== conv_traffic_lights ===
Traffic lights!
I've completely forgotten how to cross the street while traffic lights are involved...
- (multiple_choice)
How does one cross the road which has traffic lights?
+ [Walk very slowly so that drivers see you better!]
	...
	No, that's not it.
	-> multiple_choice
+ [Wait for the traffic light for pedestrians to show green and then cross.]
	Yes, that's right!
	That's exactly what I must do.
	~ player_solved_traffic_lights_question = 1
	-> DONE
+ [Wait for the traffic light for cars to be green and then cross.] 
	Wouldn't that mean the cars would hit me since it's green for them?
	I need to think this through.
	-> multiple_choice