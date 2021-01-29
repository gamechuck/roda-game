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
VAR operation_better_park_started = 1

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
VAR mr_smog_outro_completed = 0

// FlowerBox
VAR rose_seeds_planted = 0

// FlowerCopper
VAR flower_copper_swayed = 0

// Loveinterest
VAR love_interest_gone_protesting = 1

// ParkLovers
VAR poster_designed = 1

// RodaShop
VAR roda_shop_gave_groceries = 0
VAR roda_shop_gave_seeds = 0
VAR roda_shop_gone_protesting = 1

// OldMan
VAR old_man_requested_groceries = 0
VAR old_man_received_groceries = 0
VAR old_man_gone_protesting = 1

// BlindGuy
VAR blind_guy_helped = 0
VAR blind_guy_gone_protesting = 1

// Student
VAR student_homework_done = 0
VAR student_gone_protesting = 1

// Animal Protection Services
VAR lunja_gave_nuts = 0
VAR squirrels_all_satiated = 0
VAR lunja_gone_protesting = 1

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
VAR rosalina_gone_protesting = 1

// Dog Trainer Club
VAR dog_test_started = 0
VAR dog_test_passed = 0
VAR dog_walking_started = 0
VAR dog_walking_completed = 0
VAR dog_trainer_club_gone_protesting = 1

// Wheelie Appartment
VAR wheelie_appartment_opened = 0

// Monsters Without Borders
VAR monsters_without_borders_joined = 0
VAR monsters_without_borders_quest_completed = 0
VAR monsters_without_borders_gone_protesting = 1

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
=== conv_outro_intro ===
>>> UPDATE_UI: solid_snejk
Tko je ugasio svijetla?
-> DONE

=== conv_outro ===
>>> UPDATE_UI: mayor
Što se ovdje događa?
>>> UPDATE_UI: solid_snejk
MI ŽELIMO UREĐENJE PARKA!!!
>>> UPDATE_UI: mayor
Što? Niste sretni s parkom kojeg imate?
Je li premali?
>>> UPDATE_UI: love_interest
DA!!!
>>> UPDATE_UI: mayor
Svi želite puno veći park?
>>> UPDATE_UI: solid_slug
ŽELMO!
>>> UPDATE_UI: mayor
Park s ljuljačkama, klackalicama i toboganima?
>>> UPDATE_UI: wheelie
DAAAAAAAAAAAAAA!!!
>>> UPDATE_UI: mayor
Bez prljavih automobila posvuda?
>>> UPDATE_UI: happy_tree
TAKO JEEEE!!!
>>> UPDATE_UI: mayor
U redu! Tako će i biti!
Nadam se da uživaš u svom novom parku!
Ćiribu ćiriba!
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
Plavko, misliš li da je ovaj park preeemali za igranje nogometa?
Trebamo organizirati prosvjed za veći park!
-> before_poster_designed

= before_poster_designed
>>> UPDATE_UI: solid_snejk
~ operation_better_park_started = 1
Čujem da parkoljupci imaju natjecanje u izradi postera za park.
>>> PAN_CAMERA_TO_POSITION: 3120 1216
Možda im možeš pomoći osmisliti poster?
>>> RESET_CAMERA
Također, trebali bismo reći svima da organiziramo prosvjed!
Možeš li prošetati gradom i svima reći da nam se pridruže?
U većem i ljepšem parku uživat ćemo svi!
-> DONE

= after_operation_better_park_started
// First check if the poster has been designed!
{poster_designed:
	- 0: -> before_poster_designed
}
Idemo vidjeti tko nam sve fali na prosvjedu...
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
Čini se da ima dovoljno ljudi za prosvjed!
Idemo promijeniti svijet na bolje!
>>> PLAY_CUTSCENE: outro
-> DONE

= show_rosalina
>>> PAN_CAMERA_TO_POSITION: 4048 1728
Što misliš da pozovemo iz Vilkove zgrade, onu koja obožava cvijeće?
Možda bi ona došla na prosvjed.
Mislim da se zove Ružica, pitaj ju bi li nam pomogla.
>>> RESET_CAMERA
-> DONE

= show_old_man
>>> PAN_CAMERA_TO_POSITION: 4048 1728
Ima onaj jedan stari gospodin u Vilkovok zgradi koji bi nam mogao pomoći.
Malo je mrgud ali je dobar u duši, pitaj bi li nam pomogao.
>>> RESET_CAMERA
-> DONE

= show_student
>>> PAN_CAMERA_TO_POSITION: 4048 1728
Mislim da u Vilkovoj zgradi živi i neki učenik.
Ne znam kako se zove jer je stalno doma i pokušava dovršiti domaću zadaću.
Pitaj ga bi li nam se pridružio!
>>> RESET_CAMERA
-> DONE

= show_blind_guy
>>> PAN_CAMERA_TO_POSITION: 2336 1888
Jedna slijepa osoba prolazi parkom svaki dan. Sigurno bi mu bilo drago da uredimo park.
Pozovi i njega!
>>> RESET_CAMERA
-> DONE

= show_helter_skelter
>>> PAN_CAMERA_TO_POSITION: 2464 3744
Znam da je Helter Skejter često huligan, ali...
Mislim da potajno i on želi ljepši park!
Odi ga pitaj!
>>> RESET_CAMERA
-> DONE

= show_love_interest
>>> PAN_CAMERA_TO_POSITION: 4048 1728
A tvoja simpatija? 
Mislim da će se ona rado odazvati tvom pozivu!
>>> RESET_CAMERA
-> DONE

= show_dog_trainer_club
>>> PAN_CAMERA_TO_POSITION: 3380 1728
Volonteri za školovanje terapijskih pasa žele više prirode u gradu.
Pitaj ih bi li nam i oni pomogli?
>>> RESET_CAMERA
-> DONE

= show_animal_protection_services
>>> PAN_CAMERA_TO_POSITION: 2736 1216
Lunja je udruga koja brine za životinje, oni bi sigurno željeli veći park.
Možda ih možeš zamoliti da dođu iako su vjerojatno jako zaposleni.
Možda će imati više vremena za nas ako im pomogneš u njihovom poslu.
>>> RESET_CAMERA
-> DONE

= show_roda_shop
>>> PAN_CAMERA_TO_POSITION: 2576 1216
Radnici iz dućana također žele bolji park! Zamoli i njih da se pojave na našoj park-revoluciji!
>>> RESET_CAMERA
-> DONE

= show_monsters_without_borders
>>> PAN_CAMERA_TO_POSITION: 2192 1216
Momci iz udruge za prava čudovišta uvijek traže priliku za pomoći našem kvartu.
Kad bi još i oni došli, imali bismo stvarno dovoljno ljudi!
>>> RESET_CAMERA
-> DONE

= outro
{solid_snejk_outro_completed:
	- 0: -> before_solid_snejk_outro_completed
	- 1: -> after_solid_snejk_outro_completed
}

= before_solid_snejk_outro_completed
~ solid_snejk_outro_completed = 1
Nevjerojatno koliko je park sad lijep.
I ti si u tome puno pomogao!
Prošetaj se i istraži! Svi su tu!
-> DONE

= after_solid_snejk_outro_completed
Još uvijek sam oduševljen s parkom!
Ostajem ovdje ali ti možeš ići i istraživati!
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
Želimo bolji park!
Dajte nam pravi nogometni teren da se možemo igrati u miru!
-> DONE

= outro
Toliko nogometnih lopti oko mene!
Ne znam koju prvu da šutnem...
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
Prikupljaš ljude za svoj prosvjed, je li?
Eh pa meni je baš lijepo živjeti u smeću!
Ali sretno ti bilo.
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
Ovaj park koji ste si izgradili je baš jedinstven!
Uopće se ne želim vratiti u svoju rodnu zemlju Prometiju!
-> DONE

= intro
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
+ [Osoba koja voli plastičnu bocu.] 
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
+ {operation_better_park_started}[Hoćeš li nam se pridružiti u prosvjedu za uređenje parka?]
	Prosvjed za uređenje vašeg parka?
	A zašto ja ne bih došao prosvjedovati za uređenje svog skejterskog parka?
	Doći ćemo i ja i moji skejter minioni!
	>>> FADE_TO_OPAQUE
	~ helter_skelter_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Hvala na pomoći!]
    Ispada da lijepe riječi otvaraju mnoga neobična vrata, pa čak i vrata do mojeg crnog skejterskog srca. 
    Tko bi rekao!
    -> DONE

= protesting
Želimo bolji skejterski park!
Dosta je bilo skejtanja po smeću!
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
Žalim, ne možeš povesti psa taksijem. Vrati se kad prošetaš tog predivnog psa.
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
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup" or used_item == "trash_paper": -> trash
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
Kad god poželiš u moju zgradu, slobodno!
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
Dosta je bilo gladnih kanti za smeće po putu do doma!
Dajte nam čisti park bez smeća posvuda!
-> DONE

= outro
Ovaj park je ludilo.
Uopće više nema smeća po putu.
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
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Zapravo, htio sam te pozvati na prosvjed za uređenje parka.]
	Ti znaš da bih ja učinila baš sve za tebe!
	Odmah idem na prosvjed!
	>>> FADE_TO_OPAQUE
	~ love_interest_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
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
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Zapravo, htio sam te pozvati na prosvjed za uređenje parka.]
	Ti znaš da bih ja učinila baš sve za tebe!
	Odmah idem na prosvjed!
	>>> FADE_TO_OPAQUE
	~ love_interest_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Da, vrati mi moju jaknu!]
	~ player_wearing_color = 0
	Naravno, izvoli!
	-> DONE
+ [Ne, sviđa mi se tvoja jakna!]
	Okej, nosi je koliko želiš!
	-> DONE

= protesting
Uredite nam park! 
Park park park!
{player_wearing_color:
	- 0: -> wearing_plain
	- 1: -> wearing_color
}

= outro
Sad kad smo gotovi s cijelom ovom pričom oko prosvjeda, možda...
Možda možemo uživati u parku skupa!
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
Vau vau!
Peso izgleda kao da želi vode?
Odvest ću ga do jezera pored Vilkove zgrade!
-> DONE

= visit_park
Vau vau!
Peso želi u park!
Idem ga odvesti u park kod crva zvanog Solid Snejk.
-> DONE

= go_back_home
Vau vau!
Peso izgleda umoran...
Vratit ću ga nazad u udrugu za školovanje terapijskih pasa.
-> DONE

= use_item
Peso pronjuška stvar iz inventara.
Ali tako je dobro školovan da ju uopće neće sažvakati!
-> DONE

== conv_dog_at_lake ===
// -- STATUS: READY FOR TRANSLATION
// Conversation that pops up when you arrive at the lake with the dog.
//-- RELEVANT VARIABLES:
// dog_visited_lake

Peso izgleda sretan što je na jezeru.
Malo ću ga prošetati pa vidjeti gdje želi dalje.
~ dog_visited_lake = 1
-> DONE

== conv_dog_at_park ===
// -- STATUS: READY FOR TRANSLATION
// Conversation that pops up when you arrive at the park with the dog.
//-- RELEVANT VARIABLES:
// dog_visited_park

Peso je presretan što vidi park!
Malo ću ga prošetati pa vidjeti gdje želi dalje.
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
Park je predivan!
I sada imam tako puno drveća za prijatelje!
Hvala ti na trudu!
-> DONE

= use_item
Ja sam samo drvo i meni takve stvari ne trebaju!
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
Sto mu smogova, nikad nećeš pobijediti moju smogastu smogovitost!
>>> RESET_CAMERA
-> DONE

= after_mr_smog_defeated
>>> UPDATE_UI: happy_tree
>>> PAN_CAMERA_TO_POSITION: 704 2720
Ajme, sav me smog napustio!
Sada sam ponovno sretno drvo!
Idem natrag u svoj rodni park!
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
Zemlja je rahla i savršena za biljke!
Nažalost, ništa tu ne raste?
-> DONE

= after_rose_seeds_planted
Ruže baš lijepo mirišu.
Pašu uz boju zgrade.
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
Hej, što ti to radiš!?
Sadnja cvijeća u tegle nije dozvoljena!
Cvijeće će biti posađeno kada sadnja cvijeća dođe na dnevni red u gradu!
+ [Dođe na dnevni red? Koliko dugo je ovako bez cvijeća?]
	Hmm... Mislim da su te tegle tu još od vremena dok nisam bio policajac.
	++ [Kad si postao policajac?]
		...
		Prije više od 10 godina...
		Dobro, moj čudovišni prijatelju, ako baš moraš posaditi ruže...
		Neću te spriječiti u tome.
		Možda je i vrijeme da netko napokon posadi nešto u te tegle.
		~ flower_copper_swayed = 1
		-> DONE
	++ [Pa ako su tako dugo tegle prazne, neka budu prazne još malo...]
		Tako je, tegle će kad tad doći na red.
		Ali ne danas.
		-> DONE
+ [Oprosti, pričekat ću dok to ne dođe na red u gradskoj birokraciji...]
	Tako je, poslušni građane! Birokracija je izmišljena s dobrim razlogom!
	-> DONE

= after_flower_copper_swayed
Čudovišne ruže iznimno brzo rastu u rahloj zemljici!
Ružica će biti presretna!
>>> REMOVE_ITEM: rose_seeds
~ rose_seeds_planted = 1
-> DONE

= default
Mislim da ne mogu to posaditi...
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
Ja samo pratim situaciju da ne bi netko napravio nešto ilegalno.
Imam te na oku!
-> DONE

= after_rose_seeds_planted
Kad vidim ovo divno cvijeće, pomislim kako je ponekad korisno zaobići birokraciju.
Možda kad bismo manje slušali pravila, a više slušali srce, svijet bi bio pun mirisnih ruža.
-> DONE

= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default 
}

= rose_seeds
Simpatične sjemenke.
Nemoj ih saditi bez dozvole od komunalne birokracije!
POGOTOVO ih nemoj saditi ovdje u ovu teglu.
Ta tegla je gradsko vlasništvo i ništa ne smiješ saditi u nju!
-> DONE

= default
Hvala, građane, ali meni ne treba ništa osim poštivanja zakona.
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
Pozdrav i dobrodošli u Školu pasa!
Mi školujemo terapijske pse.
Oni su iznimno važni za slijepe osobe i osobe s invaliditetom!
Ti si dobri čudovišni lik, hoćeš nam pomoći u obuci jednog psa?
+ [Zapravo, mislim da nemam vremena...]
	Šteta.
	Dođi ako ti se raspored raščisti!
	-> DONE
+ {operation_better_park_started}[Hoćete doći na prosvjed za uređenje parka?]
	Mogli bismo ali prvo moramo prošetati ovog terapijskog psa.
	Ako nam pomogneš, doći ćemo na prosvjed!
	-> before_dog_test_started
+ [Bila bi mi čast.]
	-> before_dog_test_started

= before_dog_test_started
Vidiš, pse se mora svakodnevno šetati po gradu da ga bolje zapamte.
No, prije toga, moramo provjeriti tvoje znanje o terapijskim psima!
Jesi li spreman položiti naš ispit za trenera terapijskih pasa?
-> after_dog_test_started

= before_dog_test_passed
Bok, hoćeš opet probati položiti naš ispit za trenera Terapijskih Pasa?
-> after_dog_test_started

= after_dog_test_started
++ [Da!!!]
	Pa krenimo!
	~ dog_test_started = 1
	-> start_dog_test
++ [Malo kasnije.]
	Može i kasnije.
	Dođi kad god poželiš!
	-> DONE

= start_dog_test
Prvo pitanje:
Što je volontiranje?
+ [Dobro plaćeni prekovremeni rad.]
	Krivo!
	-> wrong_answer
+ [Dobrovoljno ulaganje vremena, truda, znanja i vještina radi dobrobiti druge osobe ili zajednice, npr. volontiranje u udrugama, u skloništima za životinje, socijalizacija terapijskog psa i dr.]
	Tako je!
	-> second_question
+ [Neplaćeni prekovremeni rad.]
	Krivo!
	-> wrong_answer
+ [Nedobrovoljno ulaganje vremena, truda, znanja i vještina radi dobrobiti druge osobe ili zajednice.]
	Krivo!
	-> wrong_answer

= second_question
Drugo pitanje:
Što rade psi pomagači?
+ [Nose novine i potrepštine iz dućana.]
	Krivo.
	-> wrong_answer
+ [Pomažu djeci s teškoćama u razvoju, osobama koje se kreću pomoću invalidskih kolica i mogu biti psi vodiči slijepim osobama.]
	Točno!
	-> third_question
+ [Traže tartufe u šumi ili idu u lov s lovcima.]
	Krivo.
	-> wrong_answer

= third_question
Odgovorio si na sva pitanja točno što znači da si sada službeno...
Trener terapijskih pasa!!! Čestitam!
~ dog_test_passed = 1
-> after_dog_test_passed

= wrong_answer
Ne, to je krivo!
Morat ćemo zaustaviti ispitivanje odmah sada.
No, ne očajavaj - uvijek možeš probati ponovno položiti ispit.
-> DONE

= after_dog_test_passed
Sada nam možeš pomoći šetati ovog divnog psa.
~ dog_walking_started = 1
Zove se Lepa. Uživajte!
Ako ne znaš gdje ići, samo ju pitaj.
Možda ne može pričati ali psi imaju svoj način da nam pokažu gdje žele ići!
Vratite se ovdje kad se ona umori.
-> DONE

= before_dog_walking_completed
Lepa još nije umorna, šetajte još malo!
Pitaj ju gdje bi željela ako ne znaš kamo.
-> DONE

= after_dog_tired
~ dog_walking_completed = 1
Lepa se baš lijepo umorila od ove šetnjice.
Svaka čast! Malo treninga uvijek dobro dođe!
-> after_dog_walking_completed

= after_dog_walking_completed
Hvala što si nam prošetao Lepu!
Možda mi možemo tebi nekako pomoći?
+ {operation_better_park_started}[Možete li doći na prosvijed za uređenje parka?]
	Naravno da ćemo doći!
	Ljepši park znači više prirode u gradu za naše terapijske pse.
	~ dog_trainer_club_gone_protesting = 1
	-> DONE
+ [Ništa za sad.]
	Samo pitaj ako ti nešto zatreba.
	Ipak ti mi sada dugujemo uslugu!
	-> DONE

= protesting
O, bok.
Svi drugi su već otišli na prosvjed.
Ja sam samo tu da pazim na pse.
-> DONE

= outro
Svi psi su na mjestu ako te to zanima.
I jako su oduševljeni uređenjem parka!
Raznolikost drveća ih jako uveseljava!
-> DONE

= use_item
Ne treba nam to, hvala.
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
Mi smo parkoljupci!
Mi volimo naš park i jedva čekamo pokrenuti svoj parkoljubivi plan.
Ali još nije vrijeme. Ispričat ćemo ti sve o tome jednog dana.
-> DONE

= before_poster_designed
Mi smo parkoljupci!
Čujemo da si i ti parkoljubac.
Želimo osmisliti plakat koji bismo postavili posvuda po gradu.
Nažalost, treba nam dobar dizajner.
Bi li nam ti pomogao?
+ [Da! Ja sam stručnjak u izradi plakata.]
	Savršeno, evo ti prazan plakat!
	Javi kad si gotov s dizajnom!
	-> start_poster_minigame
+ [Mislim da ništa od moje pomoći ovaj put.]
	Ne brini, naći ćemo mi već nekoga.
	-> DONE

= after_poster_designed
Želiš li redizajnirati plakat?
+ [Da, imam ideju za bolji dizajn!]
	Super, jedva čekamo vidjeti i to.
	-> start_poster_minigame
+ [Ne treba mijenjati savršenstvo.]
	U redu, mi smo tu kao poželiš nešto mijenjati.
	-> DONE

= start_poster_minigame
>>> BEGIN_MINIGAME: poster_minigame
+ Izgleda ZAKON!
	Ovaj plakat ćemo kopirati i polijepiti po čitavom gradu!
	Ako ti se ne sviđa dizajn, uvijek ga možemo promijeniti - samo nas pitaj!
	~ poster_designed = 1
	>>> END_MINIGAME
	-> DONE

= outro
Hvala što si pomogao u obnovi parka.
No, park-revolucija nikad ne spava - sada imamo još veće planove za naš park!
-> DONE

= use_item
Ne treba nam to!
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
Vilko me pozvao u svoju zgradu!
Da uđem?
+ [Da, idem unutra!]
	{player_on_bike:
		- 1: -> on_bike
	}
	{dog_walking_started && not dog_walking_completed:
		- 1: -> with_dog
	}
	~ player_inside_appartment = 1
	>>> TELEPORT_TO_WAYPOINT: wheelie_elevator
	-> DONE
+ [Ne još.]
	Možda drugi put.
	-> DONE

= on_bike
Pa nisam ja divljak... Trebao bih prvo sići s bicikla prije nego uđem u tuđu kuću!
-> DONE

= with_dog
Neću s Lepom u kuću, ne bi bilo okej.
-> DONE

=== conv_wheelie_elevator
//-- STATUS: READY FOR TRANSLATION
// The elevator necessary to leave Wheelie's appartment again...

Da se spustim dizalom do dolje?
+ [Da, vrijeme je za izaći van.]
	~ player_inside_appartment = 0
	>>> TELEPORT_TO_WAYPOINT: wheelie_appartment
	-> DONE
+ [Ne, još ću malo ostati ovdje.]
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
Dobro došli u SUPER RODA dućan!
Sanjamo jednog dana otvoriti udrugu Roda za pomoć roditeljima i djeci!
Kako vam možemo pomoći?
+ {rosalina_requested_seeds}[Mogu li dobiti besplatne ružine sjemenke?]
	Naravno da možeš! Jedva čekamo pomoći napraviti grad življim i zelenijim.
	{roda_shop_gave_seeds:
		- 0: -> before_roda_shop_gave_seeds
		- 1: -> after_roda_shop_gave_seeds
	}
+ {old_man_requested_groceries && not roda_shop_gave_groceries}[Stariji gospodin iz Vilkove zgrade je rekao da imate namirnice za njega.]
	Tako je, sve je spremno za njega.
	Izvoli vrećicu s namirnicama i slobodno mu ih odnesi!
	>>> ADD_ITEM: grocery_bag
	~ roda_shop_gave_groceries = 1
	-> DONE
+ {operation_better_park_started && not roda_shop_gone_protesting}[Hoćete li doći na prosvjed za uređenje parka]
	To zvuči kao nešto od čega bi čitava zajednica mogla imati koristi.
	Odmah ćemo otići tamo!
	~ roda_shop_gone_protesting = 1
	-> DONE
+ [Ništa, samo šetam...]
	Nemoj se ustručavati pitati nas bilo što!
	-> DONE

= before_roda_shop_gave_seeds
Izvoli: besplatne sjemenke za uzgajanje čudovišnih ruža!
>>> ADD_ITEM: rose_seeds
~ roda_shop_gave_seeds = 1
-> DONE

= after_roda_shop_gave_seeds
Zapravo, već smo ti dali sjemenke za uzgajanje čudovišnih ruža.
Ne možemo ti dati više od jedne, moramo misliti i na druge.
-> DONE

= use_item
Hvala ali nama to ne treba!
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
Poštovano čudovište!
Hoćete li mi pomoći prijeći cestu?
Kao što možete vidjeti, ja sam slijep kao miš!
No, to me ne spriječava u mojoj želji da uživam u mirisima i zvukovima našeg divnog parka.
Kad bi samo ti brzi auti bili malo sporiji, ne bih se bojao prijeći cestu...
+ [Ja ću ti pomoći prijeći cestu!]
	Hvala vam najljepša!
	>>> PLAY_CUTSCENE: escort_blind_guy
	-> success
+ [Ne stignem sada, možda drugi put.]
	Dobro, ja ću pričekati još malo, možda promet prestane.
	-> DONE

= success
Hvala što ste mi pomogli preko ceste!
Ne znam ni sam koliko dugo bih tamo čekao da niste naišli!
Kako bih vam se mogao zahvaliti?
Ah, znam! Mogao bih ti pokazati kako se kaže "hvala" na Braillovom pismu!
~ blind_guy_helped = 1
-> show_braille

= after_blind_guy_helped
Njušim li ja to ono isto čudovišno biće koje mi je pomoglo prijeći cestu?
Želiš li da ti opet pokažem Brailleovo pismo?
+ {operation_better_park_started}[Organiziramo prosvjed za uređenje parka. Želiš li doći?]
	Veći park bi značilo da ne moram više prelaziti cestu da dođem do njega!
	Ne biste vjerovali koliko vremena dnevno odlazi na to čekanje na zebri...
	Rado ću pomoći!
	>>> FADE_TO_OPAQUE
	~ blind_guy_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Može!]
	-> show_braille
+ [Moram ići!]
	U redu, vrati se kad god poželiš!
	-> DONE

= show_braille
>>> BEGIN_MINIGAME: braille_minigame
Braille je pismo kojeg slijepe osobe poput mene koriste za pisanje i čitanje.
Čita se tako da prolaziš preko slova prstima i osjetiš znakove.
Recimo, idući puta kad budeš u dizalu, pogledaj tipke na dizalu!
Tipke u dizalu često imaju napisan broj i na brailleovom pismu.
Tako da i slijepe osobe mogu bez problema odabrati tipku za kat na koji žele ići!
Baš fora, zar ne?
>>> END_MINIGAME
-> DONE

= protesting
Dosta zvučnog zagađenja! Dosta smoga od automobila!
Izgradite nam veći park!
-> DONE

= outro
Možda ne mogu vidjeti novi park.
Ali definitivno mogu reći da se kvaliteta zraka jako popravila.
Također, nema više zvučnog zagađenja od silnih automobila kao nekad!
Svaka vam čast na inicijativi!
-> DONE

= use_item
Čekaj da napipam što mi to daješ...
{used_item == "trash_cup" || used_item == "trash_bottle" || used_item == "trash_bag":
	- 1: -> trash
	- 0: -> no_trash
}

= trash
Želiš se riješiti svojeg smeća tako da ga meni uvališ?
E pa neće ići!
-> DONE

= no_trash
To je simpatična stvarčica, ali meni ne treba.
Ipak, hvala!
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
Dobrodošli u udrugu Čudovišta Bez Granica!
Mi se borimo za prava svih čudovišta bila ona mala ili velika.
Kako vam možemo pomoći?
+ {operation_better_park_started}[Možete li nam doći na prosvjed za veći park?]
	{monsters_without_borders_joined:
		- 0: -> before_monsters_without_borders_joined
		- 1: -> after_monsters_without_borders_joined
	}
+ {not monsters_without_borders_joined}[Mogu li i ja biti vaš član?]
	Ne može svatko postati našim članom.
	Morat ćeš položiti ispit da postaneš naš član.
	Jesi li spreman?
	++ [Da, idemo!]
		Ok, samo da nađem formular...
		-> start_monsters_without_borders_test
	++ [Ne još.]
		Nema frke, dođi kad hoćeš.
		-> DONE
+ [Samo se šetam.]
	U redu, samo se vi šetajte!
	-> DONE

= start_monsters_without_borders_test
Prvo pitanje...
-> first_question

// TODO: Add some actual questions here!
= first_question
Što je participativnost?
+ [Kada građani i građanke ne sudjeluju u odlukama važnim za zajednicu u kojoj žive, npr. u odluci o uređenju parka ili opremanju sportskog igrališta.]
	Krivo.
	-> failure
+ [Kada građani i građanke aktivno sudjeluju u donošenju odluka važnih za svoju zajednicu, npr. u odluci o uređenju parka, opremanju sportskog igrališta, uređenju škole i sl.]
	Točno.
	-> second_question
+ [Kada građani i građanke sudjeluju u protestnim skupovima.]
	Krivo.
	-> failure

= second_question
Što je socijalna održivost ili socijalna kohezija?
+ [Kada društvo u kojemu živimo osigurava dobrobit samo nekim građanima i građankama.]
	Krivo.
	-> failure
+ [Kada je društvo u kojemu živimo sposobno osigurati dobrobit svih svojih članova i članica, npr. smanjujući nejednakosti i podjele među njima brigom o svim članovima i članicama društva]
	Točno!
	-> success
+ [Kada društvo u kojemu živimo nije sposobno osigurati dobrobit svih svojih članova i članica.]
	Krivo.
	-> failure
+ [Kada društvo potiče nejednakosti i podjele među građanima i građankama.]
	Krivo.
	-> failure

= success
Čudovišno dobro!
Bila bi nam čast da postaneš naš član!
Čestitamo, sada si i ti Čudovište Bez Granica!
~ monsters_without_borders_joined = 1
-> DONE

= failure
Možda drugi put!
-> DONE

= before_monsters_without_borders_joined
Jeste li član Čudovišta Bez Granica?
Niste?
Onda vam još ne možemo pomoći.
Srećom, lako je postati naš član.
-> DONE

= after_monsters_without_borders_joined
Naravno da ćemo ti pomoći! To je prava stvar za čudovišta u ovom kvartu!
Odmah šaljemo svoje članove tamo!
~ monsters_without_borders_gone_protesting = 1
-> DONE

= protesting
Svi su na prosvjedu za park.
Ja sam ostao jer nisam još platio članarinu.
-> DONE

= outro
Prava svakog čudovišta se moraju poštivati, pa i pravo na uređen park!
To nas veseli!
-> DONE

= use_item
Ne trebamo to.
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
Bilo koji cvijet je dobar!
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
	Dućani i cvjećarne imaju sjemenke različitog cvijeća, ali ja najviše volim crvene ruže!
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
	>>> FADE_TO_OPAQUE
	~ rosalina_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE
+ [Bilo mi je zadovoljstvo!]
	-> DONE

= protesting
Parkovi su pluća grada!
Neka cvate tisuću cvijetova!
-> DONE

// INTERACT - OUTRO //
= outro
Ovo cvijeće je prelijepo!
Drago mi je da imamo novi park.
Svatko treba više cvijeća u svojem životu!
-> DONE

// USE ITEM //
= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default
}

= rose_seeds
Pa to su ružine sjemenke, moje omiljene!
Možeš ih posaditi u zemlju ispred zgrade?
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
	Vrati se kad mi doneseš namirnice!
	Trebali su mi ih dostaviti iz SuperRoda dućana još prije sat vremena!
	~ old_man_requested_groceries = 1
	-> DONE
+ [Kriva vrata, ispričavam se.]
	U redu.
	-> DONE

= after_old_man_received_groceries
Još si tu?
Trebaš nešto od mene?
+ [Hoćete li doći na prosvjed za uređenje parka?]
	A tako... Ja na prosvjed?
	Pa, mislim da mladi danas zaslužuju puno bolji park od ovog rugla koje imaju sada.
	Da, doći ću na prosvjed!
	Vidimo se!
	~ old_man_gone_protesting = 1
	-> DONE
+ [Ne, vidimo se!]
	Uživaj u mladosti!
	-> DONE

= protesting
Kuc kuc...
Hm....
Nema nikog doma!
Možda je djed već otišao na prosvjed!
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
	- 0: -> DONE
	- 1: -> after_old_man_received_groceries
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
Kad sam ja bio mlad, ovo je sve bila samo zelena poljana.
Idemo nazad u bolje dane! Nazad u poljane!
-> DONE

= outro
Ovaj park sad izgleda još ljepše nego poljane mojeg djetinjstva!
-> DONE

= use_item
Pih, što li sve neće danas izmisliti...
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
	Uređenje parka je super ideja!
	Veći park znači više zelenih površina za naše životinje!
	Nažalost, imamo previše posla i ne stignemo...
	-> DONE
+ [Mogu li vam pomoći?]
	Ti bi volontirao za nas?
	Pa puno ti hvala, udrugama uvijek treba pomoći!
	Hmm, što bismo ti mogli dati kao zadatak...
	Ah, pa naravno... Treba nahraniti naše gradske vjeverice!
	Postavili smo kućice za vjeverice na drveće u gradu.
	Možeš im ostaviti žireve i lješnjake!
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	~ lunja_gave_nuts = 1
	-> DONE
+ [Sretno!]
	Zapamti: životinje i čudovišta su dio iste planete.
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
Mnogo životinja sada živi u ovom parku.
Mislim da vjeverice od sutra više neće trebati našu pomoć!
Tu je sve puno hrane!
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
Vrti mi se u glavi od svih ovih ispušnih plinova iz letećih automobila...
+ [Hoćeš da ti pomognem?]
	Joj, stvarno ti puno hvala!
	Ova zadaća me muči već satima.
	-> first_question
+ [Sretno ti...]
	Hvala, trebat će mi puno sreće...
-> DONE

// TODO : Add some actual questions here!
e
= first_question
Prvo pitanje: Što je solidarnost?
+ [Kada neki članovi naše zajednice brinu o svemu, a drugi ne rade ništa.]
	Mislim da to nije točno...
	-> first_question
+ [Kada činimo dobro i kada smo spremni pomoći onima kojima je naša pomoć potrebna npr.\npomoć učenicima u učenju, osobama starije životne dobi i dr.]
	Hvala ti puno, to je točno.
	Baš si genije, pomozi mi još s jednim pitanjem!
	-> second_question
+ [Kada brinemo samo o sebi jer zbog obaveza ne stignemo brinuti o drugima kojima je naša pomoć potrebna.]
	Mislim da to nije točno...
	-> first_question
+ [Kada previše brinemo o drugima pa nam ne ostaje vremena pobrinuti se za sebe.]
	Mislim da to nije točno...
	-> first_question

= second_question
Drugo pitanje: Što je inkluzija?
+ [Kada su svi građani i građanke jednaki.]
	Mislim da to nije točno...
	-> second_question
+ [Kada su svi građani i građanke bez obzira na rasu, boju kože, spol, jezik, vjeru, političko ili drugo uvjerenje, nacionalno ili socijalno podrijetlo, društveni  položaj, invaliditet, seksualnu orijentaciju i dob uključeni u društvene aktivnosti, npr. osobe s invaliditetom, Romi, LGBTIQ osobe i druge ranjive skupine društva.]
	Hvala ti puno, to je točno.
	Baš si genije, sve mi je sada jasno!
	Hvala do neba!
	~ student_homework_done = 1
	-> after_student_homework_done
+ [Kada građani i građanke zbog svoje rase, boje kože, spola, jezika, vjere, političkog ili drugog uvjerenje, nacionalnog ili socijalnog podrijetla, društvenog položaja, invaliditeta, seksualne orijentacije i dobi nisu uključeni u društvene aktivnosti.]
	Mislim da to nije točno...
	-> second_question
+ [Kada su svi građani i građanke različiti.]
	Mislim da to nije točno...
	-> second_question

= after_student_homework_done
Još jednom puno hvala na pomoći s domaćom zadaćom!
Ako ikad zatrebaš nešto od mene, tu sam!
+ [Nema frke, sretno u školi!]
	Također!
	-> DONE
+ {operation_better_park_started}[Bi li došao podržati naš prosvjed za uređenje parka?]
	Naravno! Taj park je presitan čak i za naš mali grad.
	Mi zaslužujemo puno veći park.
	Vidimo se tamo!
	>>> FADE_TO_OPAQUE
	~ student_gone_protesting = 1
	>>> FADE_TO_TRANSPARENT
	-> DONE

= protesting
Hoćemo veći park!
Nećemo aute!
Od plinova iz automobila vam se zavrti u glavi i ne možete riješiti zadaću!
-> DONE

= outro
Nema više groznih ispušnih plinova!
Sada svoju domaću zadaću mogu raditi vani u parku!
Već sam dovršio svu domaću zadaću do kraja godine!
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
Vjeverice u ovoj maloj kućici izgledaju sretno i zdravo!
Mislim da sada ima dovoljno hrane da vjeverice mogu preživjeti i bez pomoći udruge Lunja!
-> DONE

= use_item
{used_item:
	- "squirrel_nuts": -> interact
	- else: -> default
}

= default
Mislim da to nije dobra hrana za vjeverice.
-> DONE

=== conv_dog_people ===
// People from the Dog Trainer Club that are protesting...

Želimo veći park da i psi mogu uživati u prirodi!
-> DONE

=== conv_roda_people ===
// People from the RODA shop that are protesting...

Želimo više prirode za našu djecu!
Više igračaka u parku!
-> DONE

=== conv_rights_people ===
// People from the Monsters Without Borders that are protesting...

Ljudi žele veći park!
Grad mora poslušati naše želje!
-> DONE

=== conv_animal_people ===
// People from Lunja, the Animal Protection Services, that are protesting...

Dosta smoga i automobila! Više prostora za životinjice i prirodu!
-> DONE

=== conv_container ===
// A container in which you can throw trash!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
Ovo je kontejner za smeće!
-> DONE

= use_item
{is_correct_trash(interact_id, used_item):
	- 0: -> wrong_trash
	- 1: -> correct_trash
}

= wrong_trash
Mislim da to nije pravi otpad za tu kantu.
-> DONE

= correct_trash
Tako je, pravi otpad treba ići u pravu kantu.
>>> REMOVE_ITEM: {used_item}
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
Ova boca ima nešto malo soka, ali neću to piti!
Možda najbolje da je bacim u smeće.
-> DONE

=== conv_trash_paper ===
// Trash necessary to feed the cansters... or throw in the bin somewhere?
Netko je bacio papir na pod umjesto u smeće.
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
Ne mogu voziti bicikl dok šetam psa!
-> DONE

= inside_appartment
Ne mogu voziti bicikl u kući!
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
Moram odnijeti ovu vreću s namirnicama starijem gospodinu iz Vilkove zgrade!
-> DONE

= rose_seeds
Sigurno će se Ružici jako svidjeti kad posadim sjemenke u teglu pred njenom zgradom!
-> DONE

= squirrel_nuts
Ovi žirevi su hrana za vjeverica.
Moram naći drveće u kojima su vjeveričje kućice.
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