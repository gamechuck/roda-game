VAR number_of_fences_fixed = 0

// Player
VAR player_wearing_color = 0
VAR player_on_bike = 0

VAR player_noted_gummy = 0
VAR player_solved_traffic_lights_question = 0
VAR player_solved_bike_question = 0
VAR player_solved_zebra_question = 1

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
VAR helter_skelter_gone_protesting = 1

// SeatSortingCar
VAR car_quest_completed = 0

// WindTurbine
VAR wind_turbine_powered = 0

// MrSmog
VAR mr_smog_defeated = 0

// FlowerBox
VAR rose_seeds_planted = 0

// FlowerCopper
VAR flower_copper_swayed = 0

// Loveinterest
VAR love_interest_gone_protesting = 1

// ParkLovers
VAR poster_designed = 1
VAR park_lovers_gone_protesting = 0

// RodaShop
VAR roda_shop_gone_protesting = 0
VAR roda_shop_gave_groceries = 0
VAR roda_shop_gave_seeds = 0

// OldMan
VAR old_man_requested_groceries = 0
VAR old_man_received_groceries = 0
VAR old_man_gone_protesting = 1

// BlindGuy
VAR blind_guy_accepted_aid = 0
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
VAR canster_middle_appeased = 1
VAR canster_right_appeased = 0

// Dog
VAR dog_visited_lake = 0
VAR dog_visited_park = 0

// Rosalina
VAR rosalina_requested_seeds = 0
VAR rosalina_gone_protesting = 1

// Dog Trainer Club
VAR dog_test_started = 0
VAR dog_test_passed = 0
VAR dog_walking_started = 0
VAR dog_walking_completed = 0
VAR dog_trainer_club_gone_protesting = 0

// Wheelie Appartment
VAR wheelie_appartment_opened = 1

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

//--
// CUTSCENES
//--
// INTRO CUTSCENE
=== conv_intro ===
>>> UPDATE_UI: solid_snejk
Ekipo, idemo igrati nogomet!
>>> UPDATE_UI: solid_slug
Daaaaa! Dodaj loptu!
-> DONE

=== conv_intro_slug_no_ball ===
>>> UPDATE_UI: solid_slug
Dajte, dodajte i meni loptu!
...
-> DONE

=== conv_intro_smog_appears ===
>>> UPDATE_UI: solid_snejk
Čekaj, što se događa?
Odakle sav ovaj smog?
>>> UPDATE_UI: mr_smog
AHAHAHAHA!
-> DONE

=== conv_intro_mr_smog_taunts ===
>>> UPDATE_UI: mr_smog
Pozdravite se sa svojim slatkim parkom, djeco!
Mister Smog je došao pokvariti vašu zabavu!
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
// Will be cut into pieces later...
=== conv_outro ===
What is going on here?
WE WANT A BETTER PARK!!!
What? Aren't you happy with the park you got?
Is it too small?
YES!!!
So you all want a much bigger park?
WE DO!
A park with swings, slides and seesaws?
YEEEEEEAAHHHHH!!!
No more dirty cars everywhere?
YEEEEEEAAHHHHH!!!
Okay!
It shall be done!
Simsalabimbom!
There you go!
Hope you enjoy your new park!
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
~ solid_snejk_intro_completed = 1
Oh ne! Otpuhane su ograde u našem parku...
Idemo naći dijelove ograde i popraviti je da se možemo opet loptati!
-> after_solid_snejk_intro_completed

= after_solid_snejk_intro_completed
Hej, popravimo ogradu zajedno!
Ti mi donesi dijelove ograde, a ja ću ih postaviti.
Mister Smog ih je otpuhao na sve strane svijeta...
-> DONE

= fix_fence
Super! Našao si komad ograde!
Idem ga postaviti!
~ number_of_fences_fixed += 1
>>> REMOVE_ITEM: fence
{number_of_fences_fixed:
    - 4: -> after_all_fences_fixed
	- else: -> DONE
}

= after_all_fences_fixed
Vau! Ovo mjesto sad izgleda mnogo ljepše, zar ne?
Iako, čini mi se da je tu nekada bilo jedno drvo...
Pitam se što mu se dogodilo?
Možda možeš otkriti što se dogodilo s našim omiljenim drvetom?
Nakon toga se možemo nastaviti loptati.
-> DONE

= after_mr_smog_defeated
Ne mogu vjerovati da je Mister Smog zapravo bio naše izgubljeno drvo!
Say, Plavko, don't you think this park is waaaay to small to play football?
We should organize a protest for a bigger park!
-> before_poster_designed

= before_poster_designed
~ operation_better_park_started = 1
I heard the Park Crowd guys are having a poster design contest?
>>> PAN_CAMERA_TO_POSITION: 3120 1216
Maybe you can go and see if you can design a poster?
>>> RESET_CAMERA
Also we should totally tell people to come and protest for us!
Could you go around and ask people if they want to join our protests?
A bigger and more beautiful park is for the good of everyone!
-> DONE

= after_operation_better_park_started
// First check if the poster has been designed!
{poster_designed:
	- 0: -> before_poster_designed
}
Let's see who we are still missing...
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
Seems like enough people are here for the protest!
Let's see if we can make a change together!
>>> PLAY_CUTSCENE: outro
-> DONE

= show_rosalina
>>> PAN_CAMERA_TO_POSITION: 4048 1728
How about this flower obsessed girl that lives in Vilko's appartment?
Maybe you can go and ask her?
I think her name was Rosalina or something?
>>> RESET_CAMERA
-> DONE

= show_old_man
>>> PAN_CAMERA_TO_POSITION: 4048 1728
There's this old man living in Vilko's appartment that might be able to help.
He's a bit grumpy though, so he won't be easily swayed!
But we do need all the help we can get!
>>> RESET_CAMERA
-> DONE

= show_student
>>> PAN_CAMERA_TO_POSITION: 4048 1728
I remember there being a student living in Vilko's appartment!
I don't know his name though because he never goes outside to play.
Try asking him to come and protest with us?
>>> RESET_CAMERA
-> DONE

= show_blind_guy
>>> PAN_CAMERA_TO_POSITION: 2192 1216
The blind man who visits the park every day will be pleased to get a better park.
He's next on my list of recruitment!
>>> RESET_CAMERA
-> DONE

= show_helter_skelter
>>> PAN_CAMERA_TO_POSITION: 2464 3744
I know this Helter Skelter guy is a bit of a hooligan, but...
I think he secretly also wants a better park!
Go and ask him!
>>> RESET_CAMERA
-> DONE

= show_love_interest
>>> PAN_CAMERA_TO_POSITION: 4048 1728
How about your sweetheart? I think you won't have any troubly swooning here for our cause!
Go and get her, tiger!
>>> RESET_CAMERA
-> DONE

= show_dog_trainer_club
>>> PAN_CAMERA_TO_POSITION: 3380 1728
The members of the dog trainer club are always nagging about there being not enough nature in the city.
Get them to join the protests!
>>> RESET_CAMERA
-> DONE

= show_animal_protection_services
>>> PAN_CAMERA_TO_POSITION: 2736 1216
Lunja cares for animals and I bet they would really like some more nature around here!
You might need to do some job for them though?
Can you go and check it out?
>>> RESET_CAMERA
-> DONE

= show_roda_shop
>>> PAN_CAMERA_TO_POSITION: 2576 1216
The people at the SUPER RODA will also see the benefit of getting a better park!
Go and recruit them for our park revolution!
>>> RESET_CAMERA
-> DONE

= show_monsters_without_borders
>>> PAN_CAMERA_TO_POSITION: 2192 1216
The guys running the Monster Rights organization are always looking for opportunities to help.
We are almost there! We just need those people to join us!
>>> RESET_CAMERA
-> DONE

= outro
{solid_snejk_outro_completed:
	- 0: -> before_solid_snejk_outro_completed
	- 1: -> after_solid_snejk_outro_completed
}

= before_solid_snejk_outro_completed
~ solid_snejk_outro_completed = 1
Wow, I can't believe how much bigger the park is now!
You should and explore! Everyone is here!
-> DONE

= after_solid_snejk_outro_completed
I'm still too amazed by this new park! 
I'm gonna stay here, but you can go and explore!
-> DONE

= use_item
{used_item:
	- "bike": -> bike
	- "pump": -> pump
	- "fence": -> fix_fence
	- else: -> default
}

= bike
Fora bicikl, frende!
-> DONE

= pump
Pumpa za bicikl? Isprobaj je na biciklu!
A ne na meni!
-> DONE

= default
Ne želim to uzeti...
-> DONE

=== conv_solid_slug ===
//-- STATUS : READY FOR TRANSLATION
// Solid slug is missing his bike... Mr. Smog blew it away.
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
Vjetar ti je otpuhao ogradu daleko od parka?
A ja sam zagubio svoj bicikl...
Ako mi pomogneš naći bicikl, ja ću ti pomoći naći jedan dio ograde!
-> DONE

= has_broken_bike
Hvala što si mi našao bicikl!
>>> REMOVE_ITEM: broken_bike
~ bike_returned = 1
-> after_bike_returned

= after_bike_returned
Čini se da nešto ne valja s mojim biciklom...
Šteta... Možeš li mi pomoći otkriti što?
-> DONE

= after_bike_issue_found
Znači guma je ispuhana?
Šteta...
Možeš li negdje od nekoga nabaviti pumpu za bicikle?
-> DONE

= has_pump
Super, našao si pumpu za bicikle! Možeš li mi napumpati gumu, molim te?
-> DONE

= after_bike_fixed
Hvala što si popravio moj bicikl!
Možeš voziti moj bicikl ako želiš!
Samo ga uzmi i klikni na mene kad god se poželiš voziti.
~ permission_granted = 1
-> DONE

= after_operation_better_park_started
We want a better park!
Give us an actual football field so we can play in peace!
-> DONE

= outro
There are so many footballs around me!
I don't even know which one to kick first!
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
Zasad možeš zadržati moj bicikl!
-> DONE

= fence
Kladim se da bi crv zvan Solid Snejk znao što napraviti s tom ogradom...
-> DONE

= default
Ne treba mi to, hvala...
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
	- 1: Trebao bih provjeriti jesu li drugi dijelovi bicikla dobri...
	- 0: Trebao bih provjeriti je li sve kako treba na biciklu...
}
+ Guma?
	Oh, ne! Jedna guma je ispuhana!
	~ bike_issue_found = 1
	~ checked_components += tyres
	-> bike_minigame
+ Pedale?
	Čini se da su pedale dobro smontirane...
	I na pedalama je s prednje i stražnje strane po jedno mačje oko.
	Super!
	~ checked_components += pedals
	-> bike_minigame
+ Svjetla?
	Prednje svjetlo bijele boje za osvjetljavanje ceste.
	Stražnje svjetlo crvene boje s mačjim okom.
	Super!
	~ checked_components += lights
	-> bike_minigame
+ Zvonce?
	Zvonce je na upravljaču.
	TRUB, TRUB!
	Čini se da radi!
	I jedna kočnica za svaki kotač - dobro!
	~ checked_components += horn_and_brakes
	-> bike_minigame
+ Sjedalica?
	Sjedalo je dobro učvršćeno! Super!
	~ checked_components += saddle
	-> bike_minigame
= after_bike_issue_found
Čini se da je problem samo u ispuhanoj gumi...
Trebamo to popraviti!
>>> END_MINIGAME
-> DONE

= before_bike_fixed
Trebao bih naokolo potražiti pumpu za bicikl...
Tko bi mi mogao pomoći?
-> DONE

= after_bike_fixed
Mogao bi uzeti bicikl!
{permission_granted:
	- 0: -> before_permission_granted
	- 1: -> after_permission_granted
}

= before_permission_granted
Bolje da pitam Solid Slug-a prije nego što ga uzmem...
-> DONE

= after_permission_granted
Solid Slug je rekao da to mogu podnijeti!
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
Trebam prvo otkriti što ne valja s biciklom...
-> DONE

= pump_after_checkup
Vrijeme za napumpati praznu gumu!
\*PUMP*
\*PUMP PUMP*
\*PUMP PUMP PUMP*
...
...?
Eto, kao nova!
~ bike_fixed = 1
-> DONE

= default
Ne treba to biciklu...
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
Tražiš bicikl?
Pokazat ću ti gdje sam ga našao ako mi odgovoriš na ovo pitanje:
- (start_question)
Ako nema pločnika, kuda se pješaci kreću?
+ [Desnom stranom prometnice.] 
	Ha! Pogrešno!
	Tako ne vidiš aute koji dolaze i u većoj si opasnosti.
	Još ti moraš mnogo naučiti o ljudima i njihovim prometnim pravilima...
	-> start_question
+ [Lijevom stranom prometnice.]
	Tako je!
	Lijevom stranom - kako bi lakše vidio promet koji nailazi prema tebi.
	~ watto_question_solved = 1
	-> show_bike_location
+ [Sredinom prometnice.]
	Ha! Pogrešno! Sredinom ceste je najopasnije!
	-> start_question
+ [Skakućući s jedne strane prometnice na drugu.]
	POGREŠNO! POGREŠNO!
	-> start_question

= show_bike_location
Eno gdje stoji izgubljeni bicikl!
>>> PAN_CAMERA_TO_POSITION: 3584 3096
Sad ti je sigurno žao što nemaš moju leteću raketu.
Hehe, šteta ,zar ne...
>>> RESET_CAMERA
-> DONE

= after_bike_found
Vidim da si savladao šetanje po pločnicima i zebrama.
Ali onamo kamo ja idem, ne trebaju mi ceste!
-> DONE

= after_operation_better_park_started
You are recruiting people for your park revolution, eh?
Well too bad I like living here in this trash heap!
Good luck though, bye!
-> DONE

= use_item
{used_item:
	- "bike": -> bike
	- "pump": -> pump
	- "fence": -> fence
	- else: -> default
}

= bike
Ah... Vidim da si otkrio kako prijeći zebre.
Svaka čast!
-> DONE

= pump
S tim napumpaj gumu na biciklu, meni za raketu to ne treba.
-> DONE

= fence
Ne treba mi ta ograda.
-> DONE

= default
Ne treba mi ta stvar.
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
I don't even want to go back to Prometije!
This park you have here is amazing!
-> DONE

= intro
{get_level_state()}
Ja sam Veliki Lizijan! Čarobnjak iz daleke zemlje Prometije.
Došao sam tu na odmor, ali čini se da tu imate neke probleme.
Možda ti mogu pomoći? Imam moć s kojom ti mogu pokazati što tražiš!
Ali... prvo moraš odgovoriti na jednu od mojih zagonetki!
Žao mi je zbog toga, ali tako moje moći rade...
~ lizzy_intro_completed = 1
-> after_lizzy_intro_completed

= after_lizzy_intro_completed
Želiš li riješiti zagonetku?
Pokazat ću ti što tvoje srce želi!
+ [Želim riješiti zagonetku!]
	-> shuffle_riddle
+ [Ne treba mi tvoja pomoć!]
	Dobro onda! Ja sam tu do kraja godine pa se samo vrati ako se predomisliš!
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
Pri prelasku kolnika zebrom na biciklu trebamo:
+ [Naglo zakočiti prije prelaska.]
	pogrešno!
	To će samo zbuniti druge u prometu.
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started
+ [Na vrijeme se zaustaviti, sići s bicikla i hodati preko zebre gurajući bicikl.] 
	TOČNO!
	Na zebrama nije dopušteno voziti bicikl, moraš ga gurati.
	-> riddle_completed
+ [Ostati na biciklu i ubrzati kako bismo što prije prešli cestu] 
	Pogrešno!!!
	Ubrzavanje će samo još više povećati opasnost da te neki auto slučajno pokupi!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started
+ [Pjevati i ne obazirati se na druge sudionike u prometu.]
	To sigurno.
	Zapravo, To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started

// RIDDLE TWO
= second_riddle
- (riddle_started)
Zašto se prometni znakovi moraju poštivati?
+ [Zbog veselih boja.]
	Pogrešno!
	Razmisli malo bolje!
	-> riddle_started
+ [Zbog sigurnosti u prometu.] 
	TOČNO!
	Inače bismo svi bili u velikoj opasnosti!
	-> riddle_completed
+ [Zbog dosade kad sami hodamo.] 
	Pogrešno!!!
	Znakove treba poštovati i kad nam je dosadno i kad nam je zabavno!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started
+ [Zbog moguće kazne.]
	To sigurno.
	Zapravo, To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started

// RIDDLE THREE
= third_riddle
- (start_riddle)
Što može povećati pozornost pješaka u prometu?
+ [Razgovaranje s prijateljima.]
	Pogrešno!
	Samo će se zapričati i imati još manju pozornost!
	-> riddle_started
+ [Predviđanje i očekivanje opasnosti.] 
	TOČNO!
	Razmisli i pokušaj predvidjeti moguće opasnosti!
	-> riddle_completed
+ [Razgovor mobitelom.] 
	Pogrešno!!!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started
+ [Pretrčavanje preko kolnika.]
	To sigurno.
	Zapravo, To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started

// RIDDLE FOUR
= fourth_riddle
- (start_riddle)
Što je kolnik?
+ [Dio ceste kojim se kreću pješaci.]
	Pogrešno!
	To bi bio pločnik, a ne kolnik!
	-> riddle_started
+ [Dio ceste kojim se kreću vozila.] 
	TOČNO!
	-> riddle_completed
+ [Osoba koja voli Coca-colu.] 
	Pogrešno!!!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> riddle_started
+ [Slovenski atletičar koji je 1960. sudjelovao na Olimpijskim igrama.]
	Opa, još jedan obožavatelj lika i djela Mirka Kolnika!
	Zapravo, točan odgovor je: "Kolnik je dio ceste kojim se kreću vozila."
	Ali nagradit ću tvoje znanje regionalnih atletičara i smatrati ovo točnim.
	Čestitam!!!
	-> riddle_completed

= riddle_completed
Dobro ti ide odgovaranje na moje zagonetke!
{ player_received_smog_fence && player_received_turbine_fence && player_received_wheelie_fence && player_received_helter_skelter_fence:
	- 0: -> show_missing_fence_locations
	- else: -> pan_to_love_interest
}

// Here the lizard will show you (the camera will pan) to one of the locations of the fence.
// If there are no more fences, he'll pan the camera to your love interest.. because that is
// what you desire most! <3
= show_missing_fence_locations
Hmmm, vidim sada... Ti tragaš za ogradom, koju želiš popraviti da bude kao nekad!
Da vidimo...
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
Opa! Čini se da je jedan dio ograde pao na krov ove zgrade!
Morat ćeš otkriti tko je vlasnik zgrade pa ti možda on može spustiti taj dio ograde.
>>> RESET_CAMERA
-> DONE

= pan_to_helter_skelter_fence
// Pan the camera to the Helter Skelter:
>>> PAN_CAMERA_TO_POSITION: 2464 3744
Čini se da je neki ljutko sa skejtom našao ogradu i prisvojio je sebi.
Morat ćeš ga zamoliti da ti je vrati koristeći svojom karizmom i rječitošću, čini se!
>>> RESET_CAMERA
-> DONE

= pan_to_smog_fence
// Pan the camera to the fence hidden in the smog:
>>> PAN_CAMERA_TO_POSITION: 1440 1760
Moj magični vid jedva može vidjeti kroz sav ovaj smog!
Ova regija čini se vrlo opasnom i mislim da ćeš u njoj morati nositi raznobojnu odjeću da te auti bolje vide!
I ne samo to...
Tamo je sve puno duhova!!!
>>> RESET_CAMERA
-> DONE

= pan_to_turbine_fence
// Pan the fence lying at the turbine:
>>> PAN_CAMERA_TO_POSITION: 1056 672
Hmm... komad ograde pao je blizu stare zračne turbine na vrhu planine...
To je prilično daleko... Ali mislim da će ti neko motorno vozilo pomoći da dođeš do gore.
Mlad si i pametan, otkrit ćeš već put do gore!
>>> RESET_CAMERA
-> DONE

= pan_to_love_interest
// Pan the game's love interest!
>>> PAN_CAMERA_TO_POSITION: 2336 2848
Da vidimo što najviše voliš...
Opa! Kakvo ljupko čudovište! Nemoj zaboraviti: moraš izraziti svoje osjećaje!
Ja sam to zaboravio previše puta i sada sam vrlo usamljen čarobnjak.
>>> RESET_CAMERA
-> DONE

= use_item

{used_item:
	- "bike": -> bike
	- "fence": -> fence
	- else: -> default
}

= bike
Ah, vidim, našao si bicikl.
Zapamti: 
Uvijek, nosi biciklističku kacigu kada voziš bicikl!
-> DONE

= fence
Kako divna ograda!
Da je bar mogu ponijeti doma sa sobom...
Ali ova ograda je tu za sve nas! Ne smije se odnositi!
-> DONE

= default
Makni mi to s očiju!
-> DONE

=== conv_minigame_car ===
//-- STATUS : COMPLETED!
// This car has some problems with arranging it's passengers... 
// After correctly arranging everyone the driver gives you a seat belt.

{car_quest_completed:
	- 0: -> before_car_quest_completed
	- 1: -> after_car_quest_completed
}

= before_car_quest_completed
Hej, simpatično čudovište! Žalim slučaj, malo sam zauzet...
Ali čekaj malo, možda mi možeš pomoći!
Pokušavam posložiti sva ta čudovišta na prava mjesta, ali ne znam koji pojas ide za koju dob.
Pomozi mi, molim te!
+ [Kako da ne, ja sam za sortiranje čudovišta prema pojasevima prirodno nadaren!]
	-> after_car_quest_started
+ [Nemam vremena, imam ja i svoj zadatak koji trebam riješiti!]
	Ajoj! Ja neću moći poletjeti dok to ne razriješim.
	-> DONE

= after_car_quest_started
Okej, hvala ti puno!
>>> BEGIN_MINIGAME: car_minigame
- (sorting_started)
Stavi pravo čudovište na pravo mjesto!
+ Ne, ne, ne, pa čak i ja vidim da to nije dobro...
    Pokušajmo opet.
    -> sorting_started
+ Vau! To je savršeno!
    Sve si napravio točno!
    -> sorting_completed
= sorting_completed
Prije vožnje svi moraju vezati pojaseve!
Ja svoj već imam, ali molim te provjeri za druge!
- (belting_started)
Podsjeti sva čudovišta da vežu pojaseve!
+ Mislim da ipak netko još nema pojas!
    Provjeri ponovno!
    -> belting_started
+ Bravo! Sada su svi vezani pojasevima!
    Sada napokon neću više morati plaćati kazne!
    Da ne spominjem povećanu sigurnost!
    -> belting_completed
= belting_completed
>>> END_MINIGAME
Uzmi ovaj sigurnosni pojas kao nagradu za pomoć!
>>> ADD_ITEM: seat_belt
~ car_quest_completed = 1
-> DONE

= after_car_quest_completed
Hvala još jednom!
Sad napokon možemo na more!
-> DONE

=== conv_skater ===
// Regular skater who runs into you and bumps you back to a safe zone.

{Makni se, luzeru! | Haha, prespor si! Odi doma mamici!} 
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
Kako si prošao sve moje skejter minione???
Ja sam im jasno i glasno rekao da nikoga ne puštaju!
Sigurno si došao po komadić ograde koji sam našao?!
E, pa neću ga nikada dati nikome! Taj komadić ograde je sada MOJ!
Jer ja sam HELTER SKEJTER, Strah i Trepet skejtera od Smogograda do Oblak planine!
~ helter_skelter_intro_completed = 1
-> before_player_received_helter_skelter_fence

= before_player_received_helter_skelter_fence
+ [Ne zafrkavaj ti mene, ja sam veliko i opasno Čudovište!]
	Nisi ni blizu velik i opasan kao ja!
	A sad briši dok te nisam ozlijedio!
	-> DONE
+ [Ako si ti strah i trepet, ja sam semafor!]
	Pa tako i izgledaš, kao mali plavi semafor!
	Ali hmmm, semafori nisu plavi...
	Nema veze, makni mi se s očiju!
	-> DONE
+ [Molim Vas, gospodine Helter Skejter, možete li nam ipak dati komadić ograde, jako nam je to važno?]
	Što?!
	Je li to... pristojnost!?
	U mojem parku?!?!
	To nisam čuo od...
	Od...
	Od kad sam išao svojoj dragoj bakici na kolače...
	Ah, kako je to bilo lijepo.
	Hvala što si me podsjetio na sretnije vrijeme mojeg djetinjstva dok nisam bio vođa bande skejtera.
	Evo, uzmi tu ogradu.
	Zbogom, čudovište!
	>>> ADD_ITEM: fence
	A vi, skejteri, prestanite ga udarati!
	~ player_received_helter_skelter_fence = true
	>>> HIDE: SkaterLoop
	>>> HIDE: SkaterLoop2
	>>> HIDE: SkaterLoop3
	-> DONE

= after_helter_skelter_intro_completed
Opet ti, što hoćeš?
-> before_player_received_helter_skelter_fence

= after_player_received_helter_skelter_fence
Ispada da lijepe riječi otvaraju mnoga neobična vrata, pa čak i vrata do mojeg crnog skejterskog srca. 
Tko bi rekao!
+ {operation_better_park_started}[Would you be willing to come and protest for a better park?]
	Protesting for a better park?
	How about I come and protest for a better skater park instead?
	I'm getting tired of skating in these trashy suburbs.
	I'll be there together with my minions!
	~ helter_skelter_gone_protesting = 1
-> DONE

= protesting
We want a better skate park!
No more skating in the trash!
-> DONE

= use_item
{used_item:
	- else: -> default
}

= default
Zadrži si te gluposti!
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
Moj posao je voziti ljude do planine.
Nažalost, nemam više pojaseva za putnike tako da...
+ {has_item("seat_belt") == 0}[Ma baš me briga!]
	Okej, ali to je izuzetno opasno...
	Idemo!
	>>> PLAY_CUTSCENE: drop_player
	Ups! Ispao si!
	Trebao si koristiti pojas!
	-> DONE
+ {has_item("seat_belt") == 1}[Imam svoj pojas tako da - sve je okej!]
	Oh... okej!
	Čekaj da ga uglavim u vozilo...
	>>> REMOVE_ITEM: seat_belt
	~ taxi_received_belt = 1
	-> after_taxi_received_belt
+ [To je preopasno! Neću!]
	Mudar izbor.
	Možda možeš naći pojas viška negdje...
	-> DONE

= after_taxi_received_belt
Mogu te odvesti do planine!
+ [Odvedi me u planinu.]
	{dog_walking_started && not dog_walking_completed:
		- 1: -> with_dog 
	}
	>>> TELEPORT_TO_WAYPOINT: taxi_at_mountain
	OK!
	Zabavi se!
	-> DONE
+ [Ništa sada, možda poslije...]
	OK!
	-> DONE

= with_dog
I'm sorry, I can't take the dog with me!
Come back when you brought that beautiful dog back to the dog trainer's club!
-> DONE

= use_item
{used_item:
	- "seat_belt": -> seat_belt
	- else: -> default
}

= seat_belt
Fora pojas! Taman ono što trebam!
Sad ću napokon opet moći sigurno voziti ljude do planine!
Samo mi se javi kad god želiš do planine!
-> DONE

= default
Nije mi to interesantno.
-> DONE

=== conv_taxi_at_mountain ===
//-- STATUS : COMPLETED!
// This taxi waits for you at the mountain and can take you back to the parking.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Želiš nazad u grad?
+ [Da!]
	OK! Idemo!
	>>> TELEPORT_TO_WAYPOINT: taxi_at_park
	Zabavi se!
	-> DONE
+ [Ne!]
	OK! Čekam te ovdje!
	-> DONE

= use_item
Ne treba mi to.
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
Nisi smeće! Bljak!
>>> PLAY_CUTSCENE: spit_out_player
-> DONE

= use_item
{
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup": -> trash
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
Njam njam, hvala na smeću!
Zauzvrat, evo tebi nešto što je netko bacio, a uopće nije smeće!
Zapravo je korisna pumpa za bicikl!
>>> ADD_ITEM: pump
~ pump_received = 1
-> DONE

= after_pump_received
Njam njam!
Ja volim smeće!
-> DONE

=== conv_canster_appeased ===
//-- STATUS: COMPLETED!
// The canster has previously been given some trash and is now happy!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Hvala na smeću!
-> DONE

= use_item

{
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup": -> trash
	- else: -> default
}

= trash
Oprosti, puna sam...
Ali možda negdje postoji još jedna kanta za smeće?
-> DONE

= default
Nisi smeće! Bah!
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
Sad kad nema ograde, ne možemo igrati nogomet...
Dok se stvari ne riješe, idem ja doma.
No na putu do moja kuće je hrpa gladnih kanti za smeće!
Možeš li ih, molim te, nahraniti smećem? Inače krenu jesti nas čudovišta!
-> after_wheelie_intro_at_park_completed

= after_wheelie_intro_at_park_completed
Hej, jesi li nahranio sve kante za smeće?
+ [Da, sad je put siguran!]
	Super, idemo!
	~ wheelie_going_to_house = 1
	-> DONE
+ [Ne još, možda kasnije.]
	Okej, samo mi javi kad pročistiš put do mene doma!
	-> DONE

= before_wheelie_intro_before_park_fixed_completed
Hvala na praćenju do kuće!
Idem vidjeti što mi rade mama i tata doma dok mene nema!
// Goes in and checks with his mom.
>>> PLAY_CUTSCENE: fade_to_black_and_back
Hej, čini se da je na krovu ostao otpuhan dio ograde.
Slobodno ga uzmi pa možda popraviš ogradu!
>>> ADD_ITEM: fence
~ player_received_wheelie_fence = 1
~ wheelie_intro_before_park_fixed_completed = 1
Also, if you want to go inside my appartment, you are welcome to enter!
~ wheelie_appartment_opened = 1
-> after_wheelie_intro_before_park_fixed_completed

= after_wheelie_intro_before_park_fixed_completed
Hvala što si me dopratio.
Mislim da ću ostati ovdje dok se ne popravi ograda u parku.
Dođi po mene kad je popravite! Bok, bok!
-> DONE

= before_wheelie_intro_after_park_fixed_completed
~ canster_left_appeased = 0
~ canster_middle_appeased = 0
~ canster_right_appeased = 0
Vau, popravio si ograde!
Želio bih opet ići igrati nogomet s vama, ali...
Opet su kante za smeće postale gladne!
Možeš li ih opet nahraniti smećem molim te?
Jako ih se bojim!
~ wheelie_intro_after_park_fixed_completed = 1
-> after_wheelie_intro_after_park_fixed_completed

= after_wheelie_intro_after_park_fixed_completed
Jesu li sve kante nahranjene?
+ [Da, sad je sigurno!]
	Super! Idemo!
	~ wheelie_going_to_park = 1
	// You escort wheelie back to the park! 
	-> DONE
+ [Ne još, radim na tome!]
	Okej, samo mi javi! Znaš kakve te kante znaju biti kad su gladne!
	-> DONE

= before_wheelie_intro_back_at_park_completed
Hvala što si me otpratio do našeg predivnog parka!
Mislim da ću ostati ovdje i uživati u parku zauvijek!
Evo, možeš uzeti moju bateriju. Ne treba mi više!
>>> ADD_ITEM: battery
~ wheelie_intro_back_at_park_completed = 1
-> before_mr_smog_defeated

= before_mr_smog_defeated
{mr_smog_defeated:
	- 1: -> after_mr_smog_defeated
}
Predivan dan!
Jedino što fali ono je veliko drvo koje je nekad tu bilo posađeno.
Pitam se što se dogodilo s tim drvetom...
-> DONE

= after_mr_smog_defeated
Hvala ti što si nam vratio naše sretno drvo!
Taj njegov glupavi osmijeh uvijek mi razveseli dan!
-> DONE

= protesting
No more angry trash cans blocking my path!
Give us a clean park! No more trash everywhere!
-> DONE

= outro
This park is awesome!
There's no more trash!
-> DONE

= use_item
{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
Zadrži bateriju, ne trebam je više!
-> DONE

= default
Ne treba mi to!
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
Obično vjetrenjače pretvaraju vjetar u energiju, ali ova je drugačija!
Ova vjetrenjača pretvara energiju u vjetar!
Tu je velika rupa, i ima simbol za bateriju.
Možda bih, kad bih imao neku bateriju sa sobom, mogao pokrenuti tu vjetrenjaču.
-> DONE

= after_wind_turbine_powered
Vau, stvorilo se toliko vjetra da je sav smog u gradu otpuhan!
Ljudi će napokon moći disati!
-> DONE

= use_item
{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
~ wind_turbine_powered = 1
>>> REMOVE_ITEM: battery
Vau, sad radi!
-> after_wind_turbine_powered

= default
To neće pomoći, ovdje trebam staviti neki izvor napajanja.
-> DONE

=== conv_bus ===
//-- STATUS: COMPLETED!
// This bus blocks the view for incoming cars, you'll have to take the other zebra!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Hej, čudovište! Žao mi je što sam ti na putu.
Ali ja jako kasnim za voznim redom, čak 23 sata!
Ali nema veze - ako još sat vremena pričekam ovdje, taman ću biti na vrijeme!
E da, pazi na aute!
Ne mogu te vidjeti kad prelaziš zebru jer je moj bus tu parkiran!
Probaj prijeći cestu s druge strane gdje je zebra!
-> DONE

= use_item
{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
Baterija, kažeš? Simpatično. Možda je možeš uglaviti u onu vjetrenjaču sjeverno odavde.
-> DONE

= default
Simpatično.
A sad me pusti na miru!
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
Hej, ti! Kako ti se sviđa moja nova jakna? Baš je šarena, zar ne?
Mislim da bi ti dobro stajala!
Hoćeš da se mijenjamo za jakne?
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Hey, would you join me in a protest to get a better park?]
	~ love_interest_gone_protesting = 1
	Anything for you!
	I'll start protesting immediately!
	-> DONE
+ [Da, mijenjajmo se!]
	~ player_wearing_color = 1
	Super! Samo mi javi kad se zaželiš svoje stare jakne!
	-> DONE
+ [Ne, volim svoju jaknu.]
	Okej!
	-> DONE

= wearing_color
Hej! Hoćeš se opet mijenjati za jakne?
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Hey, would you join me in a protest to get a better park?]
	~ love_interest_gone_protesting = 1
	Anything for you!
	I'll start protesting immediately!
	-> DONE
+ [Da, vrati mi moju jaknu!]
	~ player_wearing_color = 0
	Naravno, izvoli!
	-> DONE
+ [Ne, sviđa mi se tvoja jakna!]
	Okej, nosi je koliko želiš!
	-> DONE

= protesting
Give us a better park now!
{player_wearing_color:
	- 0: -> wearing_plain
	- 1: -> wearing_color
}

= outro
Now that you are done with all your protesting, maybe...
We can enjoy some well-deserved time together?
-> DONE

= use_item
Hvala, ali sve što trebam od tebe je tvoja ljubav!
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
Woof!
The dog looks like it wants to go to some water?
I should go to the lake next to Wheelie's appartment!
-> DONE

= visit_park
Woof!
The dog looks like it wants to go to the park!
I should go and show solid snejk my new friend!
-> DONE

= go_back_home
Woof!
The dog looks a bit tired...
I should go back to the dog trainer's club!
-> DONE

= use_item
The dog curiously sniffs the object.
But her strict discipline stops her from gnawing on it!
-> DONE

== conv_dog_at_lake ===
// -- STATUS: READY FOR TRANSLATION
// Conversation that pops up when you arrive at the lake with the dog.
//-- RELEVANT VARIABLES:
// dog_visited_lake

The dog looks happy to be at the lake!
I should walk around a bit and then see if she wants to go somewhere else.
~ dog_visited_lake = 1
-> DONE

== conv_dog_at_park ===
// -- STATUS: READY FOR TRANSLATION
// Conversation that pops up when you arrive at the park with the dog.
//-- RELEVANT VARIABLES:
// dog_visited_park

The dog looks delighted to see the park!
I should walk around a bit and then see if she wants to go somewhere else.
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
STANI!
Ne možeš tako ući u Smogograd!
Zar ne vidiš kakav je unutra smog?! Nitko te neće vidjeti s takvom odjećom!
Vrati se kad budeš imao nešto svjetlije na sebi!
Zapamti: kad si u mračnim ulicama, moraš biti vidljiv autima!
-> DONE

= wearing_color
Pozdrav, čudovište! Čini se da imaš jako šarenu jaknu na sebi.
Smiješ ući u Smogograd dokle god nosiš nešto tako vidljivo!
Zapamti: kad si u mračnim ulicama, moraš biti vidljiv autima!
-> DONE

= after_wind_turbine_powered
Opa! Čini se da je netko upalio vjetrenjaču na planini!
Sav smog je nestao i sad možeš nositi što god želiš!
-> DONE

= use_item
Ne treba mi to, hvala! Ja samo pazim na sigurnost u prometu.
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
Opsjeo me zli smog!
Ali sad sam opet sretno drvo!
Hvala vam na pomoći!
-> DONE

= outro
The park is now beautiful!
And I have so many new tree friends!
Thank you for all your hard work!
-> DONE

= use_item
I'm just a tree and have no need of such an item!
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
>>> PAN_CAMERA_TO_POSITION: 672 2720
MUHUHAHAHA
Sto mu smogova, nikad nećeš pobijediti moju smogastu smogovitost!
>>> RESET_CAMERA
-> DONE

= after_mr_smog_defeated
>>> UPDATE_UI: happy_tree
>>> PAN_CAMERA_TO_POSITION: 672 2720
Ajme, sav me smog napustio!
Sada sam ponovno sretno drvo!
Idem natrag u svoj rodni park!
>>> RESET_CAMERA
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
The soil is fertile and ready to be used.
Unfortunately nothing seems to be growing here?
-> DONE

= after_rose_seeds_planted
The roses smell nice and look good!
A fine addition to the building's facade!
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
What are you doing? 
Planting seeds in those flower boxes is not allowed!
Flowers will be planted in those boxes when city hall comes around to it.
+ [Comes around to it? How long has that been?]
	I think those boxes have been empty since before I became a cop.
	++ [How long have you been a cop?]
		...
		More than ten years at least...
		Look kid, If you really want to plant those rose seeds...
		I'm not gonna stop you...
		Maybe it's due time someone made those flower boxes actually useful?
		~ flower_copper_swayed = 1
		-> DONE
	++ [I guess they can stay empty a bit longer then?]
		Indeed, the bureaucracy will catch up one day and they'll plant something beautiful here.
		Just not this day...
		-> DONE
+ [Apologies officer, I'll wait until the proper bureaucracy is approved by city hall...]
	Good citizen! Bureaucracy was invented for a reason you know!
	-> DONE

= after_flower_copper_swayed
The monster roses grow immediately in the fertile soil.
Rosalina will be pleased!
>>> REMOVE_ITEM: rose_seeds
~ rose_seeds_planted = 1
-> DONE

= default
I don't think I can plant this stuff?
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
I'm just hanging out here to make sure noone does anything illegal.
I got my eyes on you!
-> DONE

= after_rose_seeds_planted
Oh, great bureaucracy why have you forsaken me?
-> DONE

= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default 
}

= rose_seeds
Nice seeds you got there buddy.
Now now, don't get any big ideas and plant them.
and certainly DO NOT plant them in this flower box.
That box is city property and you can't plant anything in them!
-> DONE

= default
Don't shove that stuff into my face!
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
Hello! Welcome to the Dog Trainer's club!
We train dogs for therapeutic purposes.
These dogs are invaluable for blind people and other people with disabilities!
You look like a thrustworthy kid, would you be willing to help us out?
+ [Actually I don't think I have time right now...]
	That's too bad!
	Please do come back whenever you change your mind!
	-> DONE
+ {operation_better_park_started}[Would you be willing to come and protest for a better park?]
	Here's the deal: You help us out, and we help you out?
	Sounds good to you? OK!
	-> before_dog_test_started
+ [It would be my honor.]
	-> before_dog_test_started

= before_dog_test_started
See these dogs need to be walked daily and you look like just the person to do it!
But before that... we'll need to make sure you know what you are doing!
We have a few questions that will test your dog knowledge to the limits.
Are you ready to become a certified junior dog trainer?
-> after_dog_test_started

= before_dog_test_passed
Welcome again! Would you like to try the test again?
-> after_dog_test_started

= after_dog_test_started
++ [Bring it on!]
	Okay, lets go through the test together.
	~ dog_test_started = 1
	-> start_dog_test
++ [Maybe later?]
	That's also okay for me!
	Please do come back any time you wish!
	-> DONE

= start_dog_test
The first question to become a certified junior dog trainer is the following:
...
+ [A]
	-> wrong_answer
+ [B]
	-> second_question
+ [C]
	-> wrong_answer

= second_question
+ [A]
	-> wrong_answer
+ [B]
	-> third_question
+ [C]
	-> wrong_answer

= third_question
+ [A]
	-> wrong_answer
+ [B]
	That's the correct answer!
	It seems that you truly have what it takes to become a dog trainer!
	You are now a certified junior dog trainer! Congratulations!
	~ dog_test_passed = 1
	-> after_dog_test_passed
+ [C]
	-> wrong_answer

= wrong_answer
That's completely wrong!
I'm afraid I'll have to stop the test here.
Don't worry though: you can try to take the test again anytime!
-> DONE

= after_dog_test_passed
Okay! I'll allow you to walk the dog!
~ dog_walking_started = 1
~ player_on_bike = 0
This one is called Lepa! Have fun walking her!
If you are unsure where to go, please ask her!
She might not be able to talk, but dogs have other means of showing us where they want to go!
Come back when she is tired!
-> DONE

= before_dog_walking_completed
Lepa doesn't look tired of walking yet.
Come back when she is tired!
-> DONE

= after_dog_tired
~ dog_walking_completed = 1
Wow, Lepa looks really tired from all that walking!
Good job! The exercise is good for her!
-> after_dog_walking_completed

= after_dog_walking_completed
Thanks a thousand times for walking Lepa for us!
Was there anything we could help you with?
+ {operation_better_park_started}[Would it be possible to help me protest for better park?]
	Gladly! We'll come and join your protests!
	Having more nature around here is also good for our dogs!
	~ dog_trainer_club_gone_protesting = 1
	-> DONE
+ [Nah, I'm good!]
	Okay! come back whenever you need a favor cause we owe you one!
	-> DONE

= protesting
Hello? Ah it's you!
Everyone has gone protesting!
I'm just making sure the dogs are okay here.
-> DONE

= outro
All the dogs are fine here if that is what you were wondering about.
they are also delighted with the changes to the park!
The huge selection of trees makes them extremely happy!
-> DONE

= use_item
We don't have any need for that!
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
We are the Park Crowd!
We love the park and have big things planned for expanding the park soon.
Maybe come back in the near future?
-> DONE

= before_poster_designed
We are the Park Crowd!
I see you have decided to fight the good fight and join us in our park campaign.
We would like to make a poster to put on the town's billboards.
Unfortunately everyone here is having some trouble designing a poster.
Would you be interested in designing a poster for us?
+ [Yes! I'm an expert at making posters]
	Perfect! Here's a blank canvas!
	Tell me when you are done with the design!
	-> start_poster_minigame
+ [No, I'll pass on this opportunity!]
	Oh... well someone else will come along then!
	-> DONE

= after_poster_designed
Would you like to redesign your poster?
+ [Yes, I have an idea for a better design.]
	Okay! I can't wait to see how the new one will look!
	-> start_poster_minigame
+ [No, the current is perfect as is.]
	Well.. I'll always be here if you want to design a new one!
	-> DONE

= start_poster_minigame
>>> BEGIN_MINIGAME: poster_minigame
+ That looks like awesome!
	We'll distribute your design on all the city's billboards!
	If you don't like the design, you can always come back and design a new one!
	~ poster_designed = 1
	>>> END_MINIGAME
	-> DONE

= outro
Thanks for helping us in our park revolution!
We have big plans for an even bigger park!
However, at the moment we are taking a vacation to enjoy the current park!
-> DONE

= use_item
We don't have any need for that!
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
Vilko invited me into his appartment!
Do I dare enter?
+ [Yess, I'll check it out!]
	{player_on_bike:
		- 1: -> on_bike
	}
	{dog_walking_started && not dog_walking_completed:
		- 1: -> with_dog
	}
	~ player_inside_appartment = 1
	>>> TELEPORT_TO_WAYPOINT: wheelie_elevator
	-> DONE
+ [No, I don't like entering people's houses willy-nilly!]
	Yeah, I better stay outside.
	-> DONE

= on_bike
I'm not a savage.. I should hop off my bike when I enter other people's houses!
-> DONE

= with_dog
I can't take Lepa into this appartment, that would be inappropriate.
-> DONE

=== conv_wheelie_elevator
//-- STATUS: READY FOR TRANSLATION
// The elevator necessary to leave Wheelie's appartment again...

Do I take the elevator back down?
+ [Yes, It's time to go back outside!]
	~ player_inside_appartment = 0
	>>> TELEPORT_TO_WAYPOINT: wheelie_appartment
	-> DONE
+ [No, I still have unfinished business here!]
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
Welcome to the SUPER RODA!
We help people with... 
//TODO for Aleks: Some more stuff explaining about what RODA is?
Is there anything we might be able to help you with today?
+ {rosalina_requested_seeds}[I've been told I could get a free sample of flower seeds here?]
	Yes! This is one of our actions to make the city more livable!
	{roda_shop_gave_seeds:
		- 0: -> before_roda_shop_gave_seeds
		- 1: -> after_roda_shop_gave_seeds
	}
+ {old_man_requested_groceries && not roda_shop_gave_groceries}[The old man told me to get his groceries here?]
	That is correct! We were waiting for someone to come and pick it up.
	Here you go! Please bring this to the old man ASAP!
	>>> ADD_ITEM: grocery_bag
	~ roda_shop_gave_groceries = 1
	-> DONE
+ {operation_better_park_started && not roda_shop_gone_protesting}[Would you be willing to come and protest for a better park?]
	That sounds like something that will greatly benefit the community!
	We'll immediately send some of our people!
	~ roda_shop_gone_protesting = 1
	-> DONE
+ [Nothing! I'm just browsing!]
	Okay! Don't be afraid to ask me if you need anything!
	-> DONE

= before_roda_shop_gave_seeds
Here you go: one free sample of monster rose seeds for you!
>>> ADD_ITEM: rose_seeds
~ roda_shop_gave_seeds = 1
-> DONE

= after_roda_shop_gave_seeds
I can see you already received your free seeds sample!
My apologies, but I can only give one sample per person....
-> DONE

= use_item
Thanks, but we don't need this!
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
{blind_guy_accepted_aid:
	-> DONE
}

{blind_guy_gone_protesting:
	- 0:
	{blind_guy_helped:
		- 0: -> before_blind_guy_helped
		- 1: -> after_blind_guy_helped
	}
	- 1: -> protesting
}

= before_blind_guy_helped
Hello? Sir?
Would you be willing to help me cross the street?
As you can probably see, I'm blind...
However, that doesn't stop me from wanting to go to the park!
If only those stupid cars would stop for a second!
+ [Of course, I'll help you cross the street!]
	Thank you kind, sir!
	>>> PLAY_CUTSCENE: escort_blind_guy
	-> success
+ [Apologies, I'm far too busy right now...]
	Oh well, I guess I'll have to keep waiting here!
	-> DONE

= success
Thank you for helping me cross the street!
I have no idea how long I would've been waiting for those cars to stop without you!
And I am happy that I will never have ot find out!
How can I ever thank you?
Oh yes! Maybe I can show you how to write "Thank you" in Braille?
~ blind_guy_helped = 1
-> show_braille

= after_blind_guy_helped
Oh, hello? Are you that young lad that helped me cross the street earlier?
Would you like me to show you Braille again?
+ {operation_better_park_started}[I'm organizing a huge protest for a bigger park, would you care to join?]
	A bigger park would mean that I wouldn't need to cross the street anymore to reach the park!
	You wouldn't believe how much time I spent every day just waiting for those bloody cars to stop!
	I will gladly join your little revolution!
	~ blind_guy_gone_protesting = 1
	-> DONE
+ [It would be my honor!]
	-> show_braille
+ [Actually I have to go!]
	Okay! Come back anytime! I enjoy talking to you!
	-> DONE

= show_braille
>>> BEGIN_MINIGAME: braille_minigame
Braille is a script that blind people like me can read with their fingers!
Next time you are in an elevator you should definitely check out the buttons.
If you look closely you will see some Braille written next to each floor number!
That's so even blind people can take the elevator without any hassle.
Pretty cool, eh?
>>> END_MINIGAME
-> DONE

= protesting
Stop the noise and air polution!
Give us a bigger park!
-> DONE

= outro
I might not be able to see the new park.
But I can definetely say that the air quality has greatly improved around here!
Also, there's no more sound polution by those blasted cars!
Blessed be this day!
-> DONE

= use_item
Let me feel that thing...
{used_item == "trash_cup" || used_item == "trash_bottle" || used_item == "trash_bag":
	- 1: -> trash
	- 0: -> no_trash
}

= trash
Are you trying to get rid of your trash through me!?
The nerve! Take it back immediately!
-> DONE

= no_trash
That's a neat little bauble you got here!
Unfortunately, I can't do anything useful with it!
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
We guard the rights of every monster big or small.
How can we help you today?
+ {operation_better_park_started}[Could you guys join the protests for a better park?]
	{monsters_without_borders_joined:
		- 0: -> before_monsters_without_borders_joined
		- 1: -> after_monsters_without_borders_joined
	}
+ {not monsters_without_borders_joined}[Can I join your organization?]
	We are rather strict in allowing new memberships.
	You'll have to take a test to become a real Monster Without Borders
	Are you sure you are ready to take this test?
	++ [Da, bring it on!]
		Let me see where I put those documents again.
		-> start_monsters_without_borders_test
	++ [Nope, maybe later!]
		Okay! Come back anytime!
		-> DONE
+ [Nothing! I was just exploring!]
	Okay, I'll let you explore in peace then.
	-> DONE

= start_monsters_without_borders_test
Let's see...
First question for your application is...
-> first_question

// TODO: Add some actual questions here!
= first_question
+ [A]
	-> failure
+ [B]
	-> second_question
+ [C]
	-> failure

= second_question
+ [A]
	-> failure
+ [B]
	-> success
+ [C]
	-> failure

= success
You are an exemplary monster!
We would be honored to let you join our organization.
Congratulations, you are now a Monster Without Border!
-> DONE

= failure
Oh! You clearly don't have what it takes to become on of us.
Too bad! Bye!
-> DONE

= before_monsters_without_borders_joined
Could I see your MWB membership card?
You don't have one? You aren't a member of our organization?
I'm afraid we can only respond to your request if you are a member of MWB.
-> DONE

= after_monsters_without_borders_joined
~ monsters_without_borders_gone_protesting = 1
For sure! This seems like this will help a lot of monsters!
Well send some people immediately!
-> DONE

= protesting
Oh? Sorry, everyone went protesting for a better park.
I'm just here holding down the fort!
-> DONE

= outro
The rights of every monster has been respected and given us a new park!
This makes the Monster Without Borders very happy!
-> DONE

= use_item
We don't need that!
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
Bokić! Ja sam Ružica i volim cvijeće!
Vidiš ovu rahlu zemlju ispred zgrade?
Ne mogu vjerovati da su zaboravili posaditi cvijeće u nju!
Možeš mi učiniti uslugu?
Možeš li nabaviti neke sjemenke iz cvjećarnice?
Any type of flower is good!
+ {mr_smog_defeated == 0}[Žao mi je, trenutno pokušavam popraviti park kojeg je Mister Smog otpuhao!]
	Ah...
	Pa, kada to završiš, javi se, bit ću tu!
	-> DONE
+ {operation_better_park_started}[Žao mi je, trenutno pokušavam prikupiti čudovišta da prosvjedujemo za uređenje parka!]
	To zvuči baš fora! Parkovi su puni cvijeća!
	Hej, imam ideju!
	Ako mi pomogneš posaditi cvijeće ispred naše zgrade, doći ću ti na skup!
	-> DONE
+ [Može, idem sada do cvjećarnice po sjemenke!]
	Hvala ti!
	Dućani i cvjećarne imaju sjemenke za razna cvijeća, ali ja najviše volim crvene ruže!
	Ovaj kvart će izgledati puno bolje čim posadimo cvijeće.
	~ rosalina_requested_seeds = 1
	-> DONE

= before_rose_seeds_planted
Možeš naći sjemenke u dućanu Super Roda.
Mislim čak da su ih dijelili besplatno.
Molim te požuri dok ih još ima!
-> DONE

= after_rose_seeds_planted
Puno hvala!
Nemaš pojma koliko sam sada sretna!
+ {operation_better_park_started}[Hoćeš li sada doći podržati naš prosvjed za uređenje parka?]
	Naravno, bilo bi mi jako drago.
	Parkovi su pluća grada!
	~ rosalina_gone_protesting = 1
	-> DONE
+ [It was my pleasure!]
	-> DONE

= protesting
Parkovi su pluća grada!
Neka cvate tisuću cvijetova!
-> DONE

// INTERACT - OUTRO //
= outro
All these flowers are soo beautiful!
I'm glad we got this new park!
Everyone needs more flowers in their life!
-> DONE

// USE ITEM //
= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default
}

= rose_seeds
Pa to su ružine sjemenke, moje omiljene!
Možeš ih molim te posaditi u zemlju ispred zgrade?
Ja bih ih posadila ali bojim se policije.
-> DONE

= default
Hvala na poklonu ali mene zanima samo cvijeće!
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
DAAA?
Jeste li mi donijeli moje namirnice?
+ {has_item("grocery_bag")}[Kako da ne, izvolite gospodine!]
	-> grocery_bag
+ [Ne, ja sam samo vaš čudovišni susjed.]
	Balavac jedan!
	Vrati se kad mi doneseš namirnice!
	Trebali su mi ih dostaviti iz SuperRoda dućana još prije sat vremena!
	~ old_man_requested_groceries = 1
	-> DONE
+ [Kriva vrata, ispričavam se.]
	Balavac jedan neotesani!
	-> DONE

= after_old_man_received_groceries
Još si tu?
Trebaš nešto od mene?
+ [Hoćete li doći na prosvjed za uređenje parka?]
	A tako... Ja na prosvjed?
	Pa, mislim da mladi danas zaslužuju puno bolji park od ovog rugla koje ste dobili.
	Da, doći ću na prosvjed!
	Vidimo se!
	~ old_man_gone_protesting = 1
	-> DONE
+ [Ne, vidimo se!]
	Uživaj u mladosti dok je još imaš!
	-> DONE

= protesting
Kuc kuc...
Hm....
Nema nikog doma!
Možda je dedica već na prosvjedu!
-> DONE

// USE ITEM //
= use_item
{used_item:
	- "grocery_bag": -> grocery_bag
	- else: -> default
}

= grocery_bag
Moje namirnice!
>>> REMOVE_ITEM: grocery_bag
~ old_man_received_groceries = 1
Znači donio si mi ih skroz iz Super Roda dućana?
Čini se da bon ton još nije zaboravljen!
Ako ti ikad zatreba neka usluga, samo me pitaj!
{operation_better_park_started:
	0: -> DONE
	1: -> after_old_man_received_groceries
}

= default
To nisu moje namirnice.
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
In my days this was just a bunch of fields!
Back to better days! Back to the fields!
-> DONE

= outro
I reckon this park looks even better than the fields of my youth!
-> DONE

= use_item
Bah, the junk they make these days!
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
Bok! Mi smo Lunja, udruga za zaštitu životinja.
Gdje god životinje pate, mi smo tu da im pomognemo!
Nažalost imamo previše posla, tako puno životinja treba našu pomoć...
+ {operation_better_park_started}[Hoćete li doći na prosvjed za uređenje parka?]
	Uređenje parka, pa to je super ideja!
	Veći park znači više zelenih površina za naše životinje!
	Nažalost, imamo previše posla i ne stignemo...
	-> DONE
+ [Mogu li vam pomoći?]
	Ti bi volontirao za nas?
	Pa puno ti hvala, udrugama uvijek treba pomoći!
	Hmm, što bismo ti mogli dati kao zadatak...
	Ah, pa naravno... Treba nahraniti naše gradske vjeverice!
	Postavili smo kućice za vjeverice na razna drveća po gradu.
	Možeš im ostaviti žireve i lješnjake!
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	~ lunja_gave_nuts = 1
	-> DONE
+ [Sretno!]
	Zapamti: životinje i čudovišta su dio iste planete i mi smo odgovorni jedno za drugo.
	-> DONE

= before_all_squirrels_satiated
Hvala što si nam pomogao nahraniti vjeverice!
Čini se da još nisi nahranio sve vjeverice...
Požuri, sigurno su jako gladne!
-> DONE

= after_all_squirrels_satiated
Sve vjeverice su nahranjene.
Hvala na pomoći!
+ {operation_better_park_started}[Hoćete li vi sada meni pomoći i doći na prosvjed za uređenje parka?]
	Naravno da hoćemo!
	Veći park znači više zelenih površina za naše životinje!
	Idemo iz ovih stopa!
	~ lunja_gone_protesting = 1
	-> DONE
+ [Volontiranje je baš zabavno!]
	Drago mi je da ti se sviđa!
	-> DONE

= protesting
Dućan je prazan...
Sigurno su svi volonteri iz Lunje otišli na prosvjed.
-> DONE

= outro
Lots of animals can now live in our park!
I don't think the squirrels will need us tomorrow
Cause they have lots of other food options available!
-> DONE

= use_item
Ne treba nam to, hvala!
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
Ne mogu van!
Moram dovršiti zadaću ali ne mogu se koncentrirati...
Vrti mi se u glavi od svih ovih ispušnih plinova iz letećih autiju...
+ [Hoćeš da ti pomognem?]
	Joj, stvarno ti puno hvala!
	Ova zadaća me muči već satima.
	-> first_question
+ [Sretno ti...]
	Hvala, trebat će mi puno sreće...
-> DONE

// TODO : Add some actual questions here!

= first_question
Prvo pitanje: RODA PITANJE 1 MORAM PITAT BRANKU XXX
+ [A]
	Mislim da to nije točno...
	-> first_question
+ [B]
	Hvala ti puno, to je točno.
	Baš si genije, pomozi mi još s par pitanja molim te!
	-> second_question
+ [C]
	Mislim da to nije točno...
	-> first_question

= second_question
Drugo pitanje: RODA PITANJE 1 MORAM PITAT BRANKU XXX
+ [A]
	Mislim da to nije točno...
	-> second_question
+ [B]
	Hvala ti puno, to je točno.
	Baš si genije, pomozi mi još samo s jednim pitanjem!
	-> third_question
+ [C]
	Mislim da to nije točno...
	-> second_question

= third_question
Drugo pitanje: RODA PITANJE 1 MORAM PITAT BRANKU XXX
+ [A]
	Mislim da to nije točno...
	-> third_question
+ [B]
	Hvala ti puno, to je točno.
	Baš si genije, sve mi je sada jasno!
	Hvala do neba!
	~ student_homework_done = 1
	-> after_student_homework_done
+ [C]
	Mislim da to nije točno...
	-> third_question

= after_student_homework_done
Još jednom puno hvala na pomoći s domaćom zadaćom!
Ako ikad zatrebaš nešto od mene, tu sam!
+ [Nema frke, sretno u školi!]
	Također!
	-> DONE
+ {operation_better_park_started}[Bi li došao podržati naš prosvjed za uređenje parka?]
	Naravno! Taj park je presitan čak i za naš mali grad.
	Mi zaslužujemo puno veći i maestralniji park.
	Vidimo se tamo!
	~ student_gone_protesting = 1
	-> DONE

= protesting
Hoćemo veći park!
Nećemo aute!
Od plinova iz autiju vam se zavrti u glavi i ne možete riješiti zadaću!
-> DONE

= outro
No more dirty fumes from cars!
Now I can do my homework outside in the park!
I'm already done completing my homework for the remainder of this year!
-> DONE

= use_item
Ne treba mi to...
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
Nasred drveta viri mala vjeveričja kućica!
Kako slatko, unutra je mala obitelj vjeverica...
Čini se kao da su jako gladne.
{has_item("squirrel_nuts"):
	- 0: -> has_no_nuts
	- 1: -> has_nuts
}

= has_no_nuts
Kad bih bar imao žireve za njih...
-> DONE

= has_nuts
Srećom, volonteri iz Lunje su mi dali puno žireva.
Evo maleni, nemojte više gladovati, uzmite malo žireva!
>>> REMOVE_ITEM: squirrel_nuts
~ set_squirrels_satiated(interact_id, 1)
Opa, gladna vjeverica mi je iskočila van i uzela žir direktno iz ruke.
Jedna gladna vjeverica manje na ovom okrutnom svijetu.
-> DONE

= squirrel_satiated
Vjeverice se čine sretno i sito.
Ako im dam previše žireva postat će debele i nesretne.
Moj moto je: Svakome prema njegovim potrebama.
{has_item("squirrel_nuts"):
	- 1: -> find_other_squirrel_tree
}
-> DONE

= find_other_squirrel_tree
Sigurno uokolo ima još drveća s gladnim vjevericama.
-> DONE

= outro
The squirrels inside of this little house look happy and healthy!
I guess there's enough food now for these squirrels to survive without Lunja's aid!
-> DONE

= use_item
{used_item:
	- "squirrel_nuts": -> interact
	- else: -> default
}

= default
Mislim da to nije dobra hrana za vjeverice.
-> DONE

//--
// PICKUPS
//--
=== conv_broken_bike ===
// The broken bike of Solid Slug
Ovo je Slagačev bicikl!
Vau, otpuhan je skroz do tu...
Bolje da mu ga odnesem.
-> DONE

=== conv_trash_bag ===
// Trash necessary to feed the cansters...
Netko se jako potrudio da stavi hrpu raznog smeća u torbu...
Ali onda su je zaboravili baciti u smeće!
-> DONE

=== conv_trash_cup ===
// Trash necessary to feed the cansters...
Netko je ostavio ovu polupraznu čašu na podu!
Ili polupunu?
U svakom slučaju, trebao bih je baciti u kantu za smeće!
-> DONE

=== conv_trash_bottle ===
// Trash necessary to feed the cansters...
Ova boca ima nešto malo Coca-cole, ali uopće više nije gazirana!
Možda najbolje da je bacim u smeće.
-> DONE

=== conv_fence_at_turbine ===
// A fence piece lying next to the wind farm.
~ player_received_turbine_fence = true
Vau, ovaj komad ograde otpuhan je skroz do tu...
Bolje da ga odnesem nazad do parka.
-> DONE

=== conv_fence_at_smog ===
// A fence piece lying in the smoggy part of town.
~ player_received_smog_fence = 1
Komadić ograde! Gotovo da mi je izmaknuo u ovom smogu!
Najbolje da ga odnesem Solid Snejku!
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
Greškica.
-> DONE

= use_item
{used_item:
	- "bike": -> bike
	- "battery": -> battery
	- "fence": -> fence
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
Dosta je bilo bicikla za sada.
-> DONE

= hop_on_bike
{dog_walking_started && not dog_walking_completed:
	- 1: -> with_dog
}
{player_inside_appartment:
	- 1: -> inside_appartment
}
~ player_on_bike = 1
Vrijeme je za malo bicikliranja!
-> DONE

= with_dog
I can't drive my bike when I'm walking this dog!
-> DONE

= inside_appartment
I can't drive my bike inside of people's houses!
-> DONE

= bike_question
Drago mi je da mi je Slug dopustio da koristim njegov bicikl.
Ali zbog sigurnosti u prometu mogu ga koristiti samo u određenim situacijama.
- (multiple_choice)
Gdje sve smijem koristiti bicikl?
+ [Svugdje! Čak i nasred ceste!]
	Ne, ne, ne...
	Točno se sjećam da postoje mjesta na kojima je voziti bicikl preopasno za mene ili druge...
	Da ga vozim nasred ceste, pokupili bi me auti!
	-> multiple_choice
+ [Na biciklističkim stazama i po parkovima.] 
	Da, tako je!
	To je najtočnije.
	~ player_solved_bike_question = 1
	-> hop_on_bike
+ [Po biciklističkim stazama, parkovima i preko bilo koje zebre, ali ne po pločniku i kolniku.] 
	Mislim da ne smijem ići preko bilo koje zebre...
	Ako nema biciklističke staze, moram se spustiti s bicikla i zebru prijeći gurajući bicikl.
	-> multiple_choice

= pump
Pumpa?
Ovo bi se moglo iskoristiti da napumpam probušenu gumu!
...Ali nikad ne znaš što nas čeka u ovakvim igrama...
-> DONE

= seat_belt
Trebao bih nositi ovakav pojas kad god se vozim u autu.
Pa čak i u... taksiju!
-> DONE

= battery
Baterija? I još je puna!
Baš me zanima zašto bi trebalo toliko energije?
-> DONE

= fence
Dio otpuhane ograde našeg parka...
Bolje da to iz ovih stopa odnesem Solid Snejku da on to popravi.
-> DONE

= broken_bike
Ovo je Slagačev bicikl.
Bolje da mu ga što prije odnesem, izgleda malo potrgan...
-> DONE

= trash
Trebao bih naći kantu za smeće u koju ću ovo baciti!
-> DONE

= grocery_bag
I have to deliver this bag of groceries to the old man living in Vilko's appartment!
-> DONE

= rose_seeds
I bet Rosalina will love it when I plant those seeds in the flower box in front of her appartment.
-> DONE

= squirrel_nuts
These nuts need to be fed to squirrels.
I need to search for trees with squirrel houses!
-> DONE

= default
{used_item}
Pitam se što da radim s ovim?
-> DONE

=== conv_gummy ===
Uhuhuh, što je ovo posvuda na podu?!
Ljepljive žvakaće gume? Fuj!
Morat ću usporiti dok se tu šetam...
Možda bi bilo lakše biciklom.
~ player_noted_gummy = 1
-> DONE

=== conv_zebra ===
Kako prelazim zebru?
Ovo je važno da me ne pregaze auti!
- (multiple_choice)
Ako se točno sjećam, da sigurno prijeđem preko zebre, moram...
+ [Što brže pretrčati na drugu stranu!]
	...
	Ne, preko zebre se nikada ne trči! To je jako opasno.
	-> multiple_choice
+ [Pogledati lijevo, desno, pa opet lijevo i onda prijeći!]
	Da, tako je!
	Lijevo-desno-lijevo! I onda opet na pola zebre!
	~ player_solved_zebra_question = 1
	-> DONE
+ [Pogledati desno, pa lijevo pa opet desno i onda prijeći!] 
	Ne, nije dobro, mislim da sam pogriješio smjer...
	-> multiple_choice

=== conv_traffic_lights ===
Tu su sada neki semafori!
Skroz sam zaboravio kako prelaziti preko zebre dok radi semafor...
- (multiple_choice)
Kako se ono prelazi cesta koja ima semafore?
+ [Hodati jako sporo da nas vozači bolje vide!s]
	...
	Ne, to nije točno.
	-> multiple_choice
+ [Čekati da na pješačkom semaforu bude zeleno i onda prijeći.]
	Da, tako je!
	Točno to trebam napraviti.
	~ player_solved_traffic_lights_question = 1
	-> DONE
+ [Čekati da na semaforu za aute bude zeleno i onda prijeći.] 
	Ne bi li to značilo da će me auti pregaziti jer je njima zeleno?
	Moram bolje promisliti.
	-> multiple_choice