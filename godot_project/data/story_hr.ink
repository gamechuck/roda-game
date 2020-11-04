VAR number_of_fences_fixed = 0

VAR turbine_fence_received = 0
VAR smog_fence_received = 0
VAR helter_skelter_fence_received = 0
VAR wheelie_fence_received = 0

// Additional variable added here to trigger an update of the smog blockade.
VAR player_wearing_color = 0

// SolidSnejk
VAR solid_snejk_intro_completed = 0
VAR operation_better_park_started = 0

// Lizzy
VAR lizzy_intro_completed = 0

// Watto
VAR watto_question_solved = 0

// SolidSlug
VAR bike_quest_completed = 0
VAR checkup_quest_completed = 0
VAR permission_quest_completed = 0

// BrokenBike
VAR fix_quest_completed = 0
VAR found_issue_with_bike = 0
LIST checked_components = tyres, pedals, horn_and_brakes, saddle, lights

// Taxi
VAR belt_quest_completed = 0

// HelterSkelter
VAR helter_skelter_intro_completed = 0
VAR helter_skelter_gone_protesting = 0

// SeatSortingCar
VAR car_quest_completed = 0

// WindTurbine
VAR battery_quest_completed = 0

// MrSmog
VAR mr_smog_defeated = 0

// FlowerBox
VAR rose_seeds_planted = 0

// Loveinterest
VAR love_interest_gone_protesting = 0

// Old Man
VAR grocery_quest_completed = 0
VAR old_man_gone_protesting = 0

// Student
VAR homework_quest_completed = 0
VAR student_gone_protesting = 0

// Animal Protection Services
VAR feeding_quest_started = 0
VAR feeding_quest_completed = 0
VAR lunja_gone_protesting = 0

// Canster
VAR pump_received = 0

// Rosalina
VAR flower_quest_started = 0
VAR flower_quest_completed = 0
VAR rosalina_gone_protesting = 0

// Dog Trainer Club
VAR test_quest_started = 0
VAR test_quest_completed = 0
VAR dog_quest_started = 0
VAR dog_quest_completed = 0
VAR dog_trainer_club_gone_protesting = 0

// Monsters Without Borders
VAR monsters_without_borders_quest_completed = 0

// Wheelie
VAR wheelie_escorted_to_house = 0
VAR wheelie_escorted_back_to_park = 0

VAR wheelie_intro_at_park_completed = 0
VAR wheelie_intro_before_park_fixed_completed = 0
VAR wheelie_intro_after_park_fixed_completed = 0
VAR wheelie_intro_back_at_park_completed = 0

VAR used_item = "bush"
VAR interact_id = "player"

VAR conv_type = 0

EXTERNAL has_item(item_id)
=== function has_item(item_id) ===
~ return true

EXTERNAL get_state_property(entity_id, property)
=== function get_state_property(entity_id, property) ===
~ return 0

//--
// CUTSCENES
//--
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

// Outro cutscene?
=== conv_outro ===
What is going on here?
WE WANT A BETTER PARK!!!
You people all want to have a bigger and better park?
WE DO!
A park with swings, slides and seesaws?
YEEEEEEAAHHHHH!!!
No more dirty cars everywhere?
YEEEEEEAAHHHHH!!!
Okay!
It shall be done!
Simsalabimbom!
>>> PLAY_CUTSCENE: outro
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
// - ...

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{mr_smog_defeated:
    - 1: -> second_ending
}

{number_of_fences_fixed:
    - 4: -> first_ending
}

{has_item("fence"):
	- true: -> fix_fence
}

{solid_snejk_intro_completed:
	- 0: -> intro
	- else: -> main
}

= intro
Oh ne! Otpuhane su ograde u našem parku... #solid_snejk_intro_1
Idemo naći dijelove ograde i popraviti je da se možemo opet loptati! #solid_snejk_intro_2
~ solid_snejk_intro_completed = 1
-> main

= fix_fence
Super! Našao si komad ograde!
Idem ga postaviti!
~ number_of_fences_fixed += 1
>>> REMOVE_ITEM: fence
{number_of_fences_fixed:
    - 4: -> first_ending
	- else: -> DONE
}

= second_ending
Ne mogu vjerovati da je Mister Smog zapravo bio naše izgubljeno drvo!
Sada se napokon možemo igrati u miru!
Vrijeme je za nogomet!
-> DONE

= first_ending
Vau! Ovo mjesto sad izgleda mnogo ljepše, zar ne?
Iako, čini mi se da je tu nekada bilo jedno drvo...
Pitam se što mu se dogodilo?
Možda možeš otkriti što se dogodilo s našim omiljenim drvetom?
Nakon toga se možemo nastaviti loptati.
-> DONE

= main
Hej, popravimo ogradu zajedno! #solid_snejk_main_1
Ti mi donesi dijelove ograde, a ja ću ih postaviti. #solid_snejk_main_2
Mister Smog ih je otpuhao na sve strane svijeta... #solid_snejk_main_3
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

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{operation_better_park_started:
	- 0: 
	{fix_quest_completed:
		- 0:
		{checkup_quest_completed:
			- 0: 
			{bike_quest_completed:
				- 0: 
				{has_item("broken_bike"):
					- 0: -> intro
					- 1: -> has_broken_bike
				}
				- 1: -> after_bike_quest_completed
			}
			{has_item("pump"):
				- 0: -> after_checkup_quest_completed
				- 1: -> has_pump
			}
		}
		- 1: -> after_fix_quest_completed
	}
	- 1: -> after_operation_better_park_started
}

= intro
Vjetar ti je otpuhao ogradu daleko od parka?
A ja sam zagubio svoj bicikl...
Ako mi pomogneš naći bicikl, ja ću ti pomoći naći jedan dio ograde!
-> DONE

= has_broken_bike
Hvala što si mi našao bicikl!
~ bike_quest_completed = 1
>>> REMOVE_ITEM: broken_bike
>>> SHOW: ReturnedBike
-> after_bike_quest_completed

= after_bike_quest_completed
Čini se da nešto ne valja s mojim biciklom...
Šteta... Možeš li mi pomoći otkriti što?
-> DONE

= after_checkup_quest_completed
Znači guma je ispuhana?
Šteta...
Možeš li negdje od nekoga nabaviti pumpu za bicikle?
-> DONE

= has_pump
Super, našao si pumpu za bicikle! Možeš li mi napumpati gumu, molim te?
-> DONE

= after_fix_quest_completed
Hvala što si popravio moj bicikl!
Možeš voziti moj bicikl ako želiš!
Samo ga uzmi i klikni na mene kad god se poželiš voziti.
~ permission_quest_completed = 1
-> DONE

= after_operation_better_park_started
We want a better park!
Better park now!
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
{checkup_quest_completed:
	- 1: -> pump
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

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{fix_quest_completed:
	- 0:
	{checkup_quest_completed:
		- 0: -> before_checkup_quest_completed
		- 1: -> before_fix_quest_completed
	}
	- 1: 
	{has_item("pump"):
		0: -> after_fix_quest_completed
		1: -> pump_after_checkup
	}
}

= before_fix_quest_completed
Trebao bih naokolo potražiti pumpu za bicikl...
Tko bi mi mogao pomoći?
-> DONE

= before_checkup_quest_completed
>>> BEGIN_MINIGAME: bike_minigame
- (bike_minigame)
{checked_components == LIST_ALL(checked_components):
	- 1: -> after_checkup_quest_completed
}
{found_issue_with_bike:
	- 1: Trebao bih provjeriti jesu li drugi dijelovi bicikla dobri...
	- 0: Trebao bih provjeriti je li sve kako treba na biciklu...
}
+ Guma?
	Oh, ne! Jedna guma je ispuhana!
	~ found_issue_with_bike = 1
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
= after_checkup_quest_completed
Čini se da je problem samo u ispuhanoj gumi...
Trebamo to popraviti!
>>> END_MINIGAME
-> DONE

= after_fix_quest_completed
Mogao bi uzeti bicikl!
{permission_quest_completed:
	- 0: -> before_permission_quest_completed
	- 1: -> after_permission_quest_completed
}

= before_permission_quest_completed
Bolje da pitam Solid Slug-a prije nego što ga uzmem...
-> DONE

= after_permission_quest_completed
Solid Slug je rekao da to mogu podnijeti!
>>> HIDE: ReturnedBike
>>> ADD_ITEM: bike
-> DONE

= use_item
{used_item:
	- "pump": -> pump
	- else: -> default
}

= pump
{checkup_quest_completed:
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
~ fix_quest_completed = 1
-> DONE

= default
Ne treba to biciklu...
-> DONE

=== conv_watto ===
//-- STATUS : 
// Watto shows you where the bike is and is useless afterwards.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{bike_quest_completed:
	- 0: -> no_bike
	- 1: -> ending
}

= no_bike

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

= ending
Vidim da si savladao šetanje po pločnicima i zebrama.
Ali onamo kamo ja idem, ne trebaju mi ceste!
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
// After you get all the fences, he shows you the love interest instead.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{lizzy_intro_completed:
	- 0: -> intro
	- 1: -> after_lizzy_intro_completed
}

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
{ smog_fence_received && turbine_fence_received && wheelie_fence_received && helter_skelter_fence_received:
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
- {wheelie_fence_received: 
	- 0: -> pan_to_wheelie_fence
	- else: -> choice_shuffle
	}
- {helter_skelter_fence_received: 
	- 0:-> pan_to_helter_skelter_fence
	- else: -> choice_shuffle
	}
- {turbine_fence_received: 
	- 0: -> pan_to_turbine_fence
	- else: -> choice_shuffle
	}
- {smog_fence_received: 
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
// This car has some problems with arranging it's passengers... when you correctly arrange everyone
// the driver gives you a seat belt.

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
// After starting operation better park, you can recruit him to come and protest.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{helter_skelter_gone_protesting:
	- 0:
	{helter_skelter_fence_received:
		- 0: 
		{helter_skelter_intro_completed:
			- 0: -> intro
			- 1: -> after_helter_skelter_intro_completed
		}
		- 1: -> after_helter_skelter_fence_received
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
~ helter_skelter_intro_completed = true
-> before_helter_skelter_fence_received

= before_helter_skelter_fence_received
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
	~ helter_skelter_fence_received = true
	>>> HIDE: SkaterLoop
	>>> HIDE: SkaterLoop2
	>>> HIDE: SkaterLoop3
	-> DONE

= after_helter_skelter_intro_completed
Opet ti, što hoćeš?
-> before_helter_skelter_fence_received

= after_helter_skelter_fence_received
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
{belt_quest_completed:
	- 0: -> before_belt_quest_completed
	- 1: -> after_belt_quest_completed
}

= before_belt_quest_completed
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
	~ belt_quest_completed = 1
	-> after_belt_quest_completed
+ [To je preopasno! Neću!]
	Mudar izbor.
	Možda možeš naći pojas viška negdje...
	-> DONE

= after_belt_quest_completed
Mogu te odvesti do planine!
+ [Odvedi me u planinu.]
	>>> TELEPORT_TO_WAYPOINT: taxi_at_mountain
	OK!
	Zabavi se!
	-> DONE
+ [Ništa sada, možda poslije...]
	OK!
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

{get_state_property(interact_id, "has_trash"):
	- 0: -> conv_canster_has_no_trash
	- 1: -> conv_canster_has_trash
}

=== conv_canster_has_no_trash ===
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
>>> SET_STATE_PROPERTY: {interact_id} has_trash 1
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

=== conv_canster_has_trash ===
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
//-- STATUS: 
// Wheelie is a kid in a wheelchair who wants to go home.
// You have to escort him and make sure he doesn't get scared away by cansters.
// You'll have to escort him twice... one time to his house and afterwards back to the park.
// When arriving at his house, he goes and comes back out with a fence.
// Afterwards, when getting back to the park he gives you the battery 
{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{get_state_property("wheelie", "arrived_safely"):
	- 1: -> process_arrival
}

{wheelie_escorted_back_to_park:
	- 1: -> back_at_park 
}

{wheelie_escorted_to_house:
	- 1: -> at_house
}

{wheelie_intro_at_park_completed:
	- 0: -> intro_at_park
	- 1: -> main_at_park
}

= intro_at_park
Sad kad nema ograde, ne možemo igrati nogomet...
Dok se stvari ne riješe, idem ja doma.
No na putu do moja kuće je hrpa gladnih kanti za smeće!
Možeš li ih, molim te, nahraniti smećem? Inače krenu jesti nas čudovišta!
~ wheelie_intro_at_park_completed = 1
-> main_at_park

= main_at_park
Hej, jesi li nahranio sve kante za smeće?
+ [Da, sad je put siguran!]
	Super, idemo!
	>>> SET_STATE_PROPERTY: wheelie going_to_house 1
	-> DONE
+ [Ne još, možda kasnije.]
	Okej, samo mi javi kad pročistiš put do mene doma!
	-> DONE

= at_house
// WHEELIE AT HOUSE!
{number_of_fences_fixed:
    - 4: -> after_park_fixed
	- else: -> before_park_fixed
}

= before_park_fixed
{wheelie_intro_before_park_fixed_completed:
	- 0: -> intro_at_house_before_park_fixed
	- 1: -> main_at_house_before_park_fixed
}

= intro_at_house_before_park_fixed
Hvala na praćenju do kuće!
Idem vidjeti što mi rade mama i tata doma dok mene nema!
// Goes in and checks with his mom.
>>> PLAY_CUTSCENE: fade_to_black_and_back
Hej, čini se da je na krovu ostao otpuhan dio ograde.
Slobodno ga uzmi pa možda popraviš ogradu!
>>> ADD_ITEM: fence
~ wheelie_fence_received = 1
~ wheelie_intro_before_park_fixed_completed = 1
-> main_at_house_before_park_fixed

= main_at_house_before_park_fixed
Hvala što si me dopratio.
Mislim da ću ostati ovdje dok se ne popravi ograda u parku.
Dođi po mene kad je popravite! Bok, bok!
-> DONE

= after_park_fixed
{wheelie_intro_after_park_fixed_completed:
	- 0: -> intro_at_house_after_park_fixed
	- 1: -> main_at_house_after_park_fixed
}

= intro_at_house_after_park_fixed
>>> SET_STATE_PROPERTY: canster_left is_appeased 0
>>> SET_STATE_PROPERTY: canster_middle is_appeased 0
>>> SET_STATE_PROPERTY: canster_right is_appeased 0
Vau, popravio si ograde!
Želio bih opet ići igrati nogomet s vama, ali...
Opet su kante za smeće postale gladne!
Možeš li ih opet nahraniti smećem molim te?
Jako ih se bojim!
~ wheelie_intro_after_park_fixed_completed = 1
-> main_at_house_after_park_fixed

= main_at_house_after_park_fixed
Jesu li sve kante nahranjene?
+ [Da, sad je sigurno!]
	Super! Idemo!
	>>> SET_STATE_PROPERTY: wheelie going_to_park 1
	// You escort wheelie back to the park! 
	-> DONE
+ [Ne još, radim na tome!]
	Okej, samo mi javi! Znaš kakve te kante znaju biti kad su gladne!
	-> DONE

= back_at_park
// WHEELIE BACK AT PARK!
{wheelie_intro_back_at_park_completed:
	- 0: -> intro_back_at_park
	- 1: -> main_back_at_park
}

= intro_back_at_park
Hvala što si me otpratio do našeg predivnog parka!
Mislim da ću ostati ovdje i uživati u parku zauvijek!
Evo, možeš uzeti moju bateriju. Ne treba mi više!
>>> ADD_ITEM: battery
~ wheelie_intro_back_at_park_completed = 1
-> main_back_at_park

= main_back_at_park
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

= process_arrival

{wheelie_escorted_to_house:
	- 0: ~ wheelie_escorted_to_house = 1
	- 1: ~ wheelie_escorted_back_to_park = 1
}
>>> SET_STATE_PROPERTY: wheelie arrived_safely 0
-> interact

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

-> DONE

=== conv_wind_turbine ===
//-- STATUS: COMPLETED!
// The wind turbine can be powered by a battery you get from Wheelie and
// removes the smog from the smoggy part of town.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{battery_quest_completed:
	- 0: -> before_battery_quest_completed
	- 1: -> after_battery_quest_completed
}

= before_battery_quest_completed
Obično vjetrenjače pretvaraju vjetar u energiju, ali ova je drugačija!
Ova vjetrenjača pretvara energiju u vjetar!
Tu je velika rupa, i ima simbol za bateriju.
Možda bih, kad bih imao neku bateriju sa sobom, mogao pokrenuti tu vjetrenjaču.
-> DONE

= after_battery_quest_completed
Vau, stvorilo se toliko vjetra da je sav smog u gradu otpuhan!
Ljudi će napokon moći disati!
-> DONE

= use_item

{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
Vau, sad radi!
~ battery_quest_completed = 1
>>> SET_STATE_PROPERTY: wind_turbine has_battery 1
>>> REMOVE_ITEM: battery
-> after_battery_quest_completed

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
// After 

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{love_interest_gone_protesting:
	- 1: Give us a better park now!
}

{get_state_property("player", "wearing_color"):
	- 0: -> wearing_plain
	- 1: -> wearing_color
}

= wearing_plain
Hej, ti! Kako ti se sviđa moja nova jakna? Baš je šarena, zar ne?
Mislim da bi ti dobro stajala!
Hoćeš da se mijenjamo za jakne?
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Hey, would you join me in a protest to get a better park?]
	Anything for you!
	I'll start protesting immediately!
	~ love_interest_gone_protesting = 1
	-> DONE
+ [Da, mijenjajmo se!]
	~ player_wearing_color = 1
	>>> SET_STATE_PROPERTY: player wearing_color 1
	>>> SET_STATE_PROPERTY: love_interest wearing_color 0
	Super! Samo mi javi kad se zaželiš svoje stare jakne!
	-> DONE
+ [Ne, volim svoju jaknu.]
	Okej!
	-> DONE

= wearing_color
Hej! Hoćeš se opet mijenjati za jakne?
+ {operation_better_park_started && love_interest_gone_protesting == 0}[Hey, would you join me in a protest to get a better park?]
	Anything for you!
	I'll start protesting immediately!
	-> DONE
	~ love_interest_gone_protesting = 1
+ [Da, vrati mi moju jaknu!]
	~ player_wearing_color = 0
	>>> SET_STATE_PROPERTY: player wearing_color 0
	>>> SET_STATE_PROPERTY: love_interest wearing_color 1
	Naravno, izvoli!
	-> DONE
+ [Ne, sviđa mi se tvoja jakna!]
	Okej, nosi je koliko želiš!
	-> DONE

= use_item
Hvala, ali sve što trebam od tebe je tvoja ljubav!
-> DONE

=== conv_copper ===
//-- STATUS: 
// The copper blocks you from entering the smoggy part of town until you are wearing something colorful.
// He also tells you about the windmill as a tip.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{battery_quest_completed:
	- 0:
	{get_state_property("player", "wearing_color"):
		- 0: -> wearing_plain
		- 1: -> wearing_color
	}
	- 1: -> after_battery_quest_completed
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

= after_battery_quest_completed
Opa! Čini se da je netko upalio vjetrenjaču na planini!
Sav smog je nestao i sad možeš nositi što god želiš!
-> DONE

= use_item
{used_item:
	- else: -> default
}

= default
Ne treba mi to, hvala! Ja samo pazim na sigurnost u prometu.
-> DONE

=== conv_happy_tree ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

Opsjeo me zli smog!
Ali sad sam opet sretno drvo!
Hvala vam na pomoći!
-> DONE

= use_item
Zahvaljujem na poklonu!
>>> REMOVE_ITEM: {used_item}
-> DONE

=== conv_mr_smog ===

{get_state_property("mr_smog", "is_defeated"):
	- 0: -> angry_mr_smog
	- 1: -> happy_mr_smog
}

= angry_mr_smog
>>> PAN_CAMERA_TO_POSITION: 672 2720
MUHUHAHAHA
Sto mu smogova, nikad nećeš pobijediti moju smogastu smogovitost!
>>> RESET_CAMERA
-> DONE

= happy_mr_smog
{mr_smog_defeated:
	- 0: -> intro
	- else: -> main
}

= intro
~ mr_smog_defeated = 1
>>> UPDATE_UI: happy_tree
>>> PAN_CAMERA_TO_POSITION: 672 2720
Ajme, sav me smog napustio!
Sada sam ponovno sretno drvo!
Idem natrag u svoj rodni park!
>>> SHOW: HappyTree
>>> RESET_CAMERA
-> DONE

= main
>>> UPDATE_UI: happy_tree
Sam ponovno sretno drvo!
-> DONE

//--
// PICKUPS
//--
=== conv_broken_bike ===
// The broken bike of Solid Slug
Ovo je Slagačev bicikl!
Vau, otpuhan je skroz do tu...
Bolje da mu ga odnesem.
~ bike_quest_completed = 1
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
Vau, ovaj komad ograde otpuhan je skroz do tu...
Bolje da ga odnesem nazad do parka.
~ turbine_fence_received = true
-> DONE

=== conv_fence_at_smog ===
// A fence piece lying in the smoggy part of town.
Komadić ograde! Gotovo da mi je izmaknuo u ovom smogu!
Najbolje da ga odnesem Solid Snejku!
~ smog_fence_received = true
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
{get_state_property("player", "entered_bike"):
	- 0: -> first_time_bike
	- 1: 
	{get_state_property("player", "on_bike"):
		- 0: -> hop_on_bike
		- 1: -> step_off_bike
	}
}

= step_off_bike
>>> SET_STATE_PROPERTY: player on_bike 0
Dosta je bilo bicikla za sada.
-> DONE

= hop_on_bike
>>> SET_STATE_PROPERTY: player on_bike 1
Vrijeme je za malo bicikliranja!
-> DONE

= first_time_bike
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
	>>> SET_STATE_PROPERTY: player entered_bike 1
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

=== conv_first_time_gummy ===
Uhuhuh, što je ovo posvuda na podu?!
Ljepljive žvakaće gume? Fuj!
Morat ću usporiti dok se tu šetam...
Možda bi bilo lakše biciklom.
-> DONE

=== conv_first_time_zebra ===
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
	-> DONE
+ [Pogledati desno, pa lijevo pa opet desno i onda prijeći!] 
	Ne, nije dobro, mislim da sam pogriješio smjer...
	-> multiple_choice

=== conv_first_time_traffic_lights ===

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
	-> DONE
+ [Čekati da na semaforu za aute bude zeleno i onda prijeći.] 
	Ne bi li to značilo da će me auti pregaziti jer je njima zeleno?
	Moram bolje promisliti.
	-> multiple_choice

=== conv_flower_box ===
//-- STATUS:
// Here you can plant the rose seeds you get from the shop and this pleases Rosalina.
// The police officer will appear here and disagree with your actions, but won't interfere.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_state_property(interact_id, "has_rose_seeds"):
	- 0: -> has_no_rose_seeds
	- 1: -> has_rose_seeds
}

= has_rose_seeds
The roses smell nice and look good!
A fine addition to the building's facade!
-> DONE

= has_no_rose_seeds
The fertile soil yearns to be used!
-> DONE

= use_item

{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default
}

= rose_seeds
The monster roses grow immediately in the fertile soil.
>>> SET_STATE_PROPERTY: flower_box has_rose_seeds 1
>>> REMOVE_ITEM: rose_seeds
~ flower_quest_completed = 1
-> DONE

= default
I don't think this is plantable?
-> DONE

=== conv_dog_trainer_club ===
//-- STATUS:
// These guys ask you questions about training dogs and then ask you to walk a dog for them.
// Afterwards you can ask her to join you in the park protests.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{dog_trainer_club_gone_protesting:
	- 0:
		{test_quest_started:
			- 0: -> intro
			- 1:
				{test_quest_completed:
					- 0: -> before_test_quest_completed
					- 1:
						{dog_quest_started:
							- 0: -> after_test_quest_completed
							- 1:
								{dog_quest_completed:
									- 0: -> before_dog_quest_completed
									- 1: -> after_dog_quest_completed
								}
						}
				}
		}
	- 1: -> protesting
}

= intro
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
	-> before_test_quest_started
+ [It would be my honor.]
	-> before_test_quest_started

= before_test_quest_started
See these dogs need to be walked daily and you look like just the person to do it!
But before that... we'll need to make sure you know what you are doing!
We have a few questions that will test your dog knowledge to the limits.
Are you ready to become a certified junior dog trainer?
-> after_test_quest_started

= before_test_quest_completed
Welcome again! Would you like to try the test again?
-> after_test_quest_started

= after_test_quest_started
++ [Bring it on!]
	Okay, lets go through the test together.
	~ test_quest_started = 1
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
	~ test_quest_completed = 1
	-> after_test_quest_completed
+ [C]
	-> wrong_answer

= wrong_answer
That's completely wrong!
I'm afraid I'll have to stop the test here.
Don't worry though: you can try to take the test again anytime!
-> DONE

= after_test_quest_completed
-> DONE

= before_dog_quest_completed
-> DONE

= after_dog_quest_completed
-> DONE

= protesting
Hello? Ah it's you!
Everyone has gone protesting!
I'm just making sure the dogs are okay.
-> DONE

= use_item
We don't have any need for that!
-> DONE

=== conv_park_lovers ===
//-- STATUS:
// The park crowd wants you to design a poster for them.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
We love the park!
We are searching for aspiring designers to make a poster for our campaign!
Would you be interested in designing a poster for us?
+ [Yes! I'm an expert at making posters]
	Perfect! Here's a blank canvas!
	Tell me when you are done with the design!
	-> start_poster_minigame
+ [No, I'll pass on this opportunity!]
	Oh... well someone else will come along then!
	-> DONE

= start_poster_minigame
	>>> BEGIN_MINIGAME: poster_minigame
	Tell me when you are done with the design!
	+ That looks like awesome!
		-> end_poster_minigame

= end_poster_minigame
>>> END_MINIGAME
-> DONE

= use_item
use_item
-> DONE

=== conv_wheelie_appartment ===
//-- STATUS:
// ??

{get_state_property(interact_id, "is_open"):
	- 0: -> DONE
	- 1: -> is_open
}

= is_open
Vilko invited me into his appartment!
Do I enter?
+ [Da]
	>>> TELEPORT_TO_WAYPOINT: wheelie_appartment
	-> DONE
+ [Ne]
	Yeah, I better stay outside.
	-> DONE
-> DONE

=== conv_roda_shop ===
//-- STATUS:
// RODA's shop is where you can get the old man's groceries and the rose seeds.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
We are RODA, an amazing organisation that helps families with their domestic issues.
// Some more stuff explaining about what RODA is?
Is there anything we might be able to help you with today?
+ [Yeah, the old man from the appartment building told me to get his groceries here?]
-> DONE

= use_item
Thanks, but we don't need this!
-> DONE

=== conv_blind_guy ===
//-- STATUS:
// Blind guy who wants to cross the street but can't because see the traffic lights.
// You help him cross the street and he joins you in protests for a better park.

= interact
interact
-> DONE

= use_item
use_item
-> DONE

=== conv_monsters_without_borders ===
//-- STATUS:
// Monsters without Borders protects the civil rights of monsters big and small!
// They ask you some questions about monster rights?

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{monsters_without_borders_quest_completed:
	- 0: -> intro
	- 1: -> intro
}

= intro
Welcome to Monsters Without Borders!
We guard the safety of every monster big or small.
-> DONE

// Add some questions here!

= use_item
We don't need that!
-> DONE

=== conv_rosalina ===
//-- STATUS : READY FOR TRANSLATION
// Rosalina wants to plant roses in front of the building, but she's afraid of authority.
// Afterwards you can ask her to join you in the park protests.
//-- RELEVANT VARIABLES:
// rosalina_gone_protesting
// flower_quest_started
// flower_quest_completed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{rosalina_gone_protesting:
	- 0:
		{flower_quest_started:
			- 0: -> intro
			- 1:
			{flower_quest_completed:
				- 0: -> before_flower_quest_completed
				- 1: -> after_flower_quest_completed
			}
		}
	- 1: -> protesting
}

= intro
Hello! My name is Rosalina and I love flowers!
Did you see that flower box in front of the building?
I can't believe they forgot to plant any flowers in them!
Could you do me a favor?
Would it be possible to get some flower seeds from the flower store?
Any type of flower is good!
+ {mr_smog_defeated == 0}[Sorry, I'm on an epic quest to save my park from Mr. Smog]
	Oh...
	Well if you change your mind, I'll always be here...
	-> DONE
+ {operation_better_park_started}[Sorry, I'm trying to recruit people to protest for a better park!]
	That sounds interesting! Parks have lots of flowers!
	But first I would like to fix the problems with my own building.
	Like that issue with the empty flower box...
	-> DONE
+ [Sure! I'll stop by the flower store and get some seeds!]
	My hero!
	I think you can get some rose seeds in the "Super Roda" store.
	This building will look much more beautiful with some flowers in that box.
	~ flower_quest_started = 1
	-> DONE

= before_flower_quest_completed
You can find some rose seeds in the "Super Roda"!
I think they were giving them away for free if I remember correctly?
Please get them quickly before supply runs out!
-> DONE

= after_flower_quest_completed
A thousand times thanks!
You can't believe how happy this makes me!
+ {operation_better_park_started}[Would you be willing to come and protest for a better park?]
	Oh my! I would be delighted to!
	I will explicitly demand that they add flowers to the park!
	Becuase this is my only personality trait!
	See you in the park!
	~ rosalina_gone_protesting = 1
	-> DONE
+ [It was my pleasure!]
	-> DONE

= protesting
Give us roses! Give us tulips!
Give us all the flowers!
-> DONE

= use_item
{used_item:
	- "rose_seeds": -> rose_seeds
	- else: -> default
}

= rose_seeds
Oh! Rose seeds! I love those!
Could you go and plant them in the flower box?
I would do it, but I'm scared of the policija...
-> DONE

= default
I'm flattered, but I can't accept that.
-> DONE

=== conv_bell_old_man ===
//-- STATUS : READY FOR TRANSLATION
// The old man wants his groceries so you deliver them?
// Afterwards you can ask him to join you in the park protests.
//-- RELEVANT VARIABLES:
// old_man_gone_protesting
// grocery_quest_completed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{old_man_gone_protesting:
	- 0:
		{grocery_quest_completed:
			- 0: -> intro
			- 1: -> after_grocery_quest_completed
		}
	- 1: -> protesting
}

= intro
HELLO?
Are you here to deliver my groceries?
+ {has_item("grocery_bag")}[Here are your groceries, sir!]
	~ grocery_quest_completed = 1
	-> grocery_bag
+ [No, I'm just your friendly neighborhood monster.]
	Come back when you get me my groceries!
	They were to be delivered almost an hour ago!
	You can get them at the "Super Roda" in the shopping square!
	'click'
	-> DONE
+ [Quietly walk away...]
	HELLO? IS ANYONE THERE?
	...
	'click'
	-> DONE

= after_grocery_quest_completed
Are you still standing here?
Do you need something from me, young monster?
+ [Actually, I'm searching for some protesters to demand for a better park.]
	Ah... and you want me to come and protest with you?
	I do think that we deserve a much better park than the tiny one we got!
	I'll be there to protest with you!
	See you there!
	~ old_man_gone_protesting = 1
	-> DONE
+ [Nope, I'll be running along now!]
	Okay! Have fun doing your kid stuff!
	-> DONE

= protesting
...
....
'click'
I don't think there's anyone home?
Didn't he say he was going to join the protests?
-> DONE

= use_item

{used_item:
	- "grocery_bag": -> grocery_bag
	- else: -> default
}

= grocery_bag
Hey! Those are my groceries!
>>> REMOVE_ITEM: grocery_bag
Did you go all the way and bring them from the "Super Roda"?
It seems chivalry isn't dead just yet! Thanks!
If you ever need a favor in return, be sure to ask!
{operation_better_park_started:
	0: -> DONE
	1: -> after_grocery_quest_completed
}

= default
Those aren't my groceries!
-> DONE

=== conv_animal_protection_services ===
//-- STATUS : READY FOR TRANSLATION
// These guys ask you to go and feed  all of the squirrel houses scattered across the map.
// Afterwards you can ask them to join you in the park protests.
//-- RELEVANT VARIABLES:
// lunja_gone_protesting
// feeding_quest_started
// feeding_quest_completed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{lunja_gone_protesting:
	- 0:
		{feeding_quest_started:
			- 0: -> intro
			- 1:
			{feeding_quest_completed:
				- 0: -> before_feeding_quest_completed
				- 1: -> after_feeding_quest_completed
			}
		}
	- 1: -> protesting
}

= intro
Hello! We are Lunja, the animal protection services.
Wherever there is an animal in need, we are there to help them!
Currently we are swamped with work! Soo many animals to protect and so little time!
+ {operation_better_park_started}[Would you be willing to help me protest for a better park?]
	Oh! That sounds like an awesome idea!
	A bigger park means more space for animals in our midst!
	But... unfortunately we are drowning in work lately...
	Maybe next time?
	-> DONE
+ [Can I help the animal cause?]
	That would be amazing!
	Yes, we are always looking for more people to help us protect the animals.
	Let's see what kind of task I can give you...
	Ah! The squirrels haven't been fed yet!
	All around the city we placed squirrel houses onto trees.
	Please go around and feed the squirrels some of deez nuts.
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	>>> ADD_ITEM: squirrel_nuts
	~ feeding_quest_started = 1
	-> DONE
+ [I'll leave you to it then!]
	Remember: Animals are our friends!
	-> DONE

= before_feeding_quest_completed
Hello! Thanks again for helping us out with the squirrels!
{has_item("squirrel_nuts"):
	- 0: -> after_feeding_quest_completed
	- 1: -> feeding_in_progress
}

= feeding_in_progress
Seems like you still have some squirrels left to feed...
Quickly now, before those poor creatures starve!
-> DONE

= after_feeding_quest_completed
All the squirrels have been fed!
You have no idea how much this helps our cause!
~ feeding_quest_completed = 1
+ {operation_better_park_started}[Would you be willing to help me protest for a better park?]
	Oh! That sounds like an awesome idea!
	A bigger park means more space for animals in our very midst!
	And I see here that we are done with today's tasks!
	Let's do some protesting!
	~ lunja_gone_protesting = 1
	-> DONE
+ [Glad to have been of service to cause]
	Remember: animals are our friends!
	-> DONE

= protesting
The store is empty...
I guess the Lunja volunteers went protesting in the park?
-> DONE

= use_item
We don't need that!
-> DONE

=== conv_student ===
//-- STATUS : READY FOR TRANSLATION
// A student monster who has serious issues with his homework. 
// Afterwards you can ask him to join you in the park protests.
//-- RELEVANT VARIABLES:
// student_gone_protesting
// homework_quest_completed

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{student_gone_protesting:
	- 0:
		{homework_quest_completed:
			- 0: -> intro
			- 1: -> after_homework_quest_completed
		}
	- 1: -> protesting
}

= intro
Sorry! I don't have time to come and play outside...
I have to finish my homework, but I can't concentrate!
And my head is woozy from all the fumes those cars make!
+ [I can help you if you want?]
	Really? Yeah, that would be awesome!
	This homework has been tormenting me for hours now!
	-> first_question
+ [I'll leave you to it then...]
	Yes, let me concentrate in peace!
-> DONE

// TODO : Add some actual questions here!

= first_question
Ok, so the first question is ...
+ [A]
	-> first_question
+ [B]
	Let's see...
	Yes! That checks out! You are a genius!
	Onto the next question... this one is even harder!
	-> second_question
+ [C]
	-> first_question

= second_question
Ok, so the second question is ...
+ [A]
	-> second_question
+ [B]
	Let's see...
	Yes! That checks out! You are a genius!
	Onto the next question... this one is even harder!
	-> third_question
+ [C]
	-> second_question

= third_question
Ok, so the third question is ...
+ [A]
	-> third_question
+ [B]
	Let's see...
	Yes! That checks out! You are a genius!
	That's all of the questions!
	I'm finally done!
	~ homework_quest_completed = 1
	-> after_homework_quest_completed
+ [C]
	-> third_question

= after_homework_quest_completed
Thanks so much for helping me with my homework!
If you ever need a favor from me, just tell me!
+ [Thank you!]
	No problem!
	-> DONE
+ {operation_better_park_started}[Actually... would you be willing to protest together with me for a better park?]
	Certainly! That park is way too small!
	We, the people, deserve something much bigger and majestic!
	I'll be there to demand a bigger park!
	~ student_gone_protesting = 1
	-> DONE

= protesting
We demand a better park now!
Remove all the cars! 
Their fumes make our heads all woozy and stop me from doing my homework! 
-> DONE

= use_item
I don't need this!
-> DONE

=== conv_squirrel_tree ===
//-- STATUS : READY FOR TRANSLATION
// Squirrel trees scattered around the map with squirrels that can be fed with nuts.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
{get_state_property(interact_id, "has_squirrel_nuts"):
	- 0: -> squirrel_hungry
	- 1: -> squirrel_satiated
}

= squirrel_hungry
This tree has a squirrel's house!
I can vaguely see some squirrels huddled inside, but I can't reach.
These creatures look like they are starving.
{has_item("squirrel_nuts"):
	- 0: -> has_no_nuts
	- 1: -> has_nuts
}

= has_no_nuts
If only I had some food to give to these poor animals...
-> DONE

= has_nuts
Luckily, the Animal Protection Services gave me some nuts!
Let's feed these poor animals.
>>> REMOVE_ITEM: squirrel_nuts
>>> SET_STATE_PROPERTY: {interact_id} has_squirrel_nuts 1
A hungry squirrel came out and ate my nuts!
That's one squirrel that won't go hungry today!
-> DONE

= squirrel_satiated
The squirrels in the squirrel's house look satiated and happy.
Giving these animals any more nuts will just make them fat and lazy.
{has_item("squirrel_nuts"):
	- 1: -> find_other_squirrel_tree
}
-> DONE

= find_other_squirrel_tree
I'll have to find another tree with squirrels that haven't been fed yet.
-> DONE

= use_item

{used_item:
	- "squirrel_nuts": -> interact
	- else: -> default
}

= default
I don't think I can feed this to the squirrels!
-> DONE