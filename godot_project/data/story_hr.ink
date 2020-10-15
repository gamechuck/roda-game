VAR number_of_fences_fixed = 0
VAR found_bike = 0
VAR picked_up_fence_at_turbine = 0
VAR picked_up_fence_in_smog_town = 0
VAR got_fence_from_helter_skelter = 0
VAR got_fence_from_wheelie = 0

VAR player_answered_bike_question = 0

VAR player_wearing_color = 0

// SolidSnejk
VAR solid_snejk_intro_completed = 0

// Lizzy
VAR lizzy_intro_completed = 0

// Watto
VAR watto_question_solved = 0

// SolidSlug
VAR figured_out_issue_with_bike = 0
VAR gave_back_bike = 0
VAR take_bike_allowed = 0

// BrokenBike
VAR fixed_bike = 0
LIST checked_components = tyres, pedals, horn_and_brakes, saddle, lights

// Taxi
VAR taxi_received_seat_belt = 0

// HelterSkelter
VAR helter_skelter_intro_completed = 0

// SeatSortingCar
VAR seat_sorting_completed = 0

// WindTurbine
VAR turbine_fixed = 0

// MrSmog
VAR mr_smog_defeated = 0

// Canster
VAR canster_gave_pump = 0

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

=== conv_solid_snejk ===
// Solid Snejk tasks you with bringing back the fences to him.
// After bringing all 4 fences back to him, he tasks you with 
// restoring the park to its former glory.

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
// Solid slug is missing his bike... Mr. Smog blew it away.
// He asks you to find his bike somewhere and bring it back to him.
// Afterwards, when you fixed his bike, he tells you that you can use his bike.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{fixed_bike:
	- 1 : -> bike_was_fixed
}

{has_item("pump") && figured_out_issue_with_bike:
	- true: -> has_pump
}

{figured_out_issue_with_bike:
	- true: -> issue_with_bike
}

{gave_back_bike:
	- true : -> bike_is_broken
}

{has_item("broken_bike"):
	- true: -> has_broken_bike
	- false: -> intro
}

= intro

Vjetar ti je otpuhao ogradu daleko od parka?
A ja sam zagubio svoj bicikl...
Ako mi pomogneš naći bicikl, ja ću ti pomoći naći jedan dio ograde!
-> DONE

= has_broken_bike

Hvala što si mi našao bicikl!
~ gave_back_bike = 1
>>> REMOVE_ITEM: broken_bike
>>> SHOW: ReturnedBike
-> bike_is_broken

= bike_is_broken

Čini se da nešto ne valja s mojim biciklom...
Šteta... Možeš li mi pomoći otkriti što?
-> DONE

= issue_with_bike

Znači guma je ispuhana?
Šteta...
Možeš li negdje od nekoga nabaviti pumpu za bicikle?
-> DONE

= has_pump

Super, našao si pumpu za bicikle! Možeš li mi napumpati gumu, molim te?
-> DONE

= bike_was_fixed

Hvala što si popravio moj bicikl!
Možeš voziti moj bicikl ako želiš!
Samo ga uzmi i klikni na mene kad god se poželiš voziti.
~ take_bike_allowed = 1
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
{figured_out_issue_with_bike:
	- true: -> has_pump
	- false: -> default
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

=== conv_watto ===
// Watto points out where the bike is and ...

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{found_bike:
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
>>> PAN_CAMERA_TO_POSITION: 3560 3032
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
// A wizard who has the power to show you the location of the fences!

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{lizzy_intro_completed:
	- 0: -> intro
	- 1: -> main
}

= intro
Ja sam Veliki Lizijan! Čarobnjak iz daleke zemlje Prometije.
Došao sam tu na odmor, ali čini se da tu imate neke probleme.
Možda ti mogu pomoći? Imam moć s kojom ti mogu pokazati što tražiš!
Ali... prvo moraš odgovoriti na jednu od mojih zagonetki!
Žao mi je zbog toga, ali tako moje moći rade...
~ lizzy_intro_completed = 1
-> main

= main
Želiš li riješiti zagonetku?
Pokazat ću ti što tvoje srce želi!
+ [Želim riješiti zagonetku!]
	-> pop_riddle
+ [Ne treba mi tvoja pomoć!]
	Dobro onda! Ja sam tu do kraja godine pa se samo vrati ako se predomisliš!
	-> DONE

// There should be at least ~ four (more is always kewl) riddles here, I'll make a switch to randomly choose one!
= pop_riddle
{shuffle:
	- -> first_riddle
	- -> second_riddle
	- -> third_riddle
	- -> fourth_riddle
}

// RIDDLE ONE // PIET MAKE A SWITCH!
= first_riddle
- (start_riddle)
Pri prelasku kolnika zebrom na biciklu trebamo:
+ [Naglo zakočiti prije prelaska.]
	pogrešno!
	To će samo zbuniti druge u prometu.
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Na vrijeme se zaustaviti, sići s bicikla i hodati preko zebre gurajući bicikl.] 
	TOČNO!
	Na zebrama nije dopušteno voziti bicikl, moraš ga gurati.
	-> dobroide
+ [Ostati na biciklu i ubrzati kako bismo što prije prešli cestu] 
	Pogrešno!!!
	Ubrzavanje će samo još više povećati opasnost da te neki auto slučajno pokupi!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Pjevati i ne obazirati se na druge sudionike u prometu.]
	To sigurno.
	Zapravo, To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle

// RIDDLE TWO
= second_riddle
- (start_riddle)
Zašto se prometni znakovi moraju poštivati?
+ [Zbog veselih boja.]
	Pogrešno!
	Razmisli malo bolje!
	-> start_riddle
+ [Zbog sigurnosti u prometu.] 
	TOČNO!
	Inače bismo svi bili u velikoj opasnosti!
	-> dobroide
+ [Zbog dosade kad sami hodamo.] 
	Pogrešno!!!
	Znakove treba poštovati i kad nam je dosadno i kad nam je zabavno!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Zbog moguće kazne.]
	To sigurno.
	Zapravo, To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle

// RIDDLE THREE
= third_riddle
- (start_riddle)
Što može povećati pozornost pješaka u prometu?
+ [Razgovaranje s prijateljima.]
	Pogrešno!
	Samo će se zapričati i imati još manju pozornost!
	-> start_riddle
+ [Predviđanje i očekivanje opasnosti.] 
	TOČNO!
	Razmisli i pokušaj predvidjeti moguće opasnosti!
	-> dobroide
+ [Razgovor mobitelom.] 
	Pogrešno!!!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Pretrčavanje preko kolnika.]
	To sigurno.
	Zapravo, To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle

// RIDDLE FOUR
= fourth_riddle
- (start_riddle)
Što je kolnik?
+ [Dio ceste kojim se kreću pješaci.]
	Pogrešno!
	To bi bio pločnik, a ne kolnik!
	-> start_riddle
+ [Dio ceste kojim se kreću vozila.] 
	TOČNO!
	-> dobroide
+ [Osoba koja voli Coca-colu.] 
	Pogrešno!!!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Slovenski atletičar koji je 1960. sudjelovao na Olimpijskim igrama.]
	Opa, još jedan obožavatelj lika i djela Mirka Kolnika!
	Zapravo, točan odgovor je: "Kolnik je dio ceste kojim se kreću vozila."
	Ali nagradit ću tvoje znanje regionalnih atletičara i smatrati ovo točnim.
	Čestitam!!!
	-> dobroide

= dobroide
Dobro ti ide odgovaranje na moje zagonetke!
{ picked_up_fence_in_smog_town && picked_up_fence_at_turbine && got_fence_from_wheelie && got_fence_from_helter_skelter:
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
- {got_fence_from_wheelie: 
	- 0: -> pan_to_house
	- else: -> choice_shuffle
	}
- {got_fence_from_helter_skelter: 
	- 0:-> pan_to_helter_skelter
	- else: -> choice_shuffle
	}
- {picked_up_fence_at_turbine: 
	- 0: -> pan_to_fence_at_turbine
	- else: -> choice_shuffle
	}
- {picked_up_fence_in_smog_town: 
	- 0: -> pan_to_fence_in_smog_town
	- else: -> choice_shuffle
	}
}
-> DONE

= pan_to_house
// PAN TO HOUSE:
>>> PAN_CAMERA_TO_POSITION: 3870 1788
Opa! Čini se da je jedan dio ograde pao na krov ove zgrade!
Morat ćeš otkriti tko je vlasnik zgrade pa ti možda on može spustiti taj dio ograde.
>>> RESET_CAMERA
-> DONE

= pan_to_helter_skelter
// PAN TO HELTER SKELTER:
>>> PAN_CAMERA_TO_POSITION: 2500 3738
Čini se da je neki ljutko sa skejtom našao ogradu i prisvojio je sebi.
Morat ćeš ga zamoliti da ti je vrati koristeći svojom karizmom i rječitošću, čini se!
>>> RESET_CAMERA
-> DONE

= pan_to_fence_in_smog_town
// PAN TO SMOG ZONE:
>>> PAN_CAMERA_TO_POSITION: 1439 1768
Moj magični vid jedva može vidjeti kroz sav ovaj smog!
Ova regija čini se vrlo opasnom i mislim da ćeš u njoj morati nositi raznobojnu odjeću da te auti bolje vide!
I ne samo to...
Tamo je sve puno duhova!!!
>>> RESET_CAMERA
-> DONE

= pan_to_fence_at_turbine
// PAN TO WIND TURBINE:
>>> PAN_CAMERA_TO_POSITION: 1047 700
Hmm... komad ograde pao je blizu stare zračne turbine na vrhu planine...
To je prilično daleko... Ali mislim da će ti neko motorno vozilo pomoći da dođeš do gore.
Mlad si i pametan, otkrit ćeš već put do gore!
>>> RESET_CAMERA
-> DONE

= pan_to_love_interest
// PAN TO LOVE INTEREST
>>> PAN_CAMERA_TO_POSITION: 2300 2871
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

=== conv_returned_bike ===
// A broken bike which has to be fixed using the tyre pump.
// This bike first has to be found and carried to solid slug.
// After the bike is fixed and you talked to sold slug, you can pick it up.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{fixed_bike:
	- 1: -> tyr_taking_fixed_bike
}

{figured_out_issue_with_bike:
	- false : -> check_bike
}

{has_item("pump"):
	- true: -> fix_bike_with_pump
}

Trebao bih naokolo potražiti pumpu za bicikl...
Tko bi mi mogao pomoći?
-> DONE

= check_bike
>>> BEGIN_MINIGAME: bike_repair
- (bike_repair)
{checked_components == LIST_ALL(checked_components):
	- true: -> after_checking_bike
}
{figured_out_issue_with_bike:
	- true: Trebao bih provjeriti jesu li drugi dijelovi bicikla dobri...
	- false: Trebao bih provjeriti je li sve kako treba na biciklu...
}
+ Guma?
	Oh, ne! Jedna guma je ispuhana!
	~ figured_out_issue_with_bike = 1
	~ checked_components += tyres
	-> bike_repair
+ Pedale?
	Čini se da su pedale dobro smontirane...
	I na pedalama je s prednje i stražnje strane po jedno mačje oko.
	Super!
	~ checked_components += pedals
	-> bike_repair
+ Svjetla?
	Prednje svjetlo bijele boje za osvjetljavanje ceste.
	Stražnje svjetlo crvene boje s mačjim okom.
	Super!
	~ checked_components += lights
	-> bike_repair
+ Zvonce?
	Zvonce je na upravljaču.
	TRUB, TRUB!
	Čini se da radi!
	I jedna kočnica za svaki kotač - dobro!
	~ checked_components += horn_and_brakes
	-> bike_repair
+ Sjedalica?
	Sjedalo je dobro učvršćeno! Super!
	~ checked_components += saddle
	-> bike_repair
= after_checking_bike
Čini se da je problem samo u ispuhanoj gumi...
Trebamo to popraviti!
>>> END_MINIGAME
-> DONE

= tyr_taking_fixed_bike
Mogao bi uzeti bicikl!
{take_bike_allowed:
	- 0: -> first_ask_nicely
	- else: -> take_fixed_bike
}

= first_ask_nicely
Bolje da pitam Solid Slug-a prije nego što ga uzmem...
-> DONE

= take_fixed_bike
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

{figured_out_issue_with_bike:
	- 1: -> fix_bike_with_pump
}

Trebam prvo otkriti što ne valja s biciklom...
-> DONE

= fix_bike_with_pump

Vrijeme za napumpati praznu gumu!
\*PUMP*
\*PUMP PUMP*
\*PUMP PUMP PUMP*
...
...?
Eto, kao nova!
~ fixed_bike = 1
-> DONE

= default
Ne treba to biciklu...
-> DONE

=== conv_seat_sorting_car ===
// This car has some problems with arranging it's passengers... when you correctly arrange everyone
// the driver gives you a seat belt.

{seat_sorting_completed:
	- 0: -> before_solving_enigma
	- 1: -> after_solving_enigma
}

= before_solving_enigma
Hej, simpatično čudovište! Žalim slučaj, malo sam zauzet...
Ali čekaj malo, možda mi možeš pomoći!
Pokušavam posložiti sva ta čudovišta na prava mjesta, ali ne znam koji pojas ide za koju dob.
Pomozi mi, molim te!
+ [Kako da ne, ja sam za sortiranje čudovišta prema pojasevima prirodno nadaren!]
	-> start_seat_sorting
+ [Nemam vremena, imam ja i svoj zadatak koji trebam riješiti!]
	Ajoj! Ja neću moći poletjeti dok to ne razriješim.
	-> DONE

= start_seat_sorting
Okej, hvala ti puno!
>>> BEGIN_MINIGAME: seat_sorting
- (sorting_minigame_start)
Stavi pravo čudovište na pravo mjesto!
+ Ne, ne, ne, pa čak i ja vidim da to nije dobro...
    Pokušajmo opet.
    -> sorting_minigame_start
+ Vau! To je savršeno!
    Sve si napravio točno!
    -> sorting_minigame_solved
= sorting_minigame_solved
Prije vožnje svi moraju vezati pojaseve!
Ja svoj već imam, ali molim te provjeri za druge!
- (belting_start)
Podsjeti sva čudovišta da vežu pojaseve!
+ Mislim da ipak netko još nema pojas!
    Provjeri ponovno!
    -> belting_start
+ Bravo! Sada su svi vezani pojasevima!
    Sada napokon neću više morati plaćati kazne!
    Da ne spominjem povećanu sigurnost!
    -> belting_end
= belting_end
>>> END_MINIGAME
Uzmi ovaj sigurnosni pojas kao nagradu za pomoć!
>>> ADD_ITEM: seat_belt
~ seat_sorting_completed = 1
-> DONE

= after_solving_enigma
Hvala još jednom!
Sad napokon možemo na more!
-> DONE

=== conv_skater ===
// Regular skater who runs into you and bumps you back to a safe zone.

{Makni se, luzeru! | Haha, prespor si! Odi doma mamici!} 
>>> RESPAWN_PLAYER
-> DONE

=== conv_helter_skelter ===
// The boss of the skaters gives you some questions and if you answer correctly he gives you a piece of the fence.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{got_fence_from_helter_skelter:
	- 1: -> question_solved
}

{helter_skelter_intro_completed:
	- 1: -> try_again
}

?
Kako si prošao sve moje skejter minione???
Ja sam im jasno i glasno rekao da nikoga ne puštaju!
Sigurno si došao po komadić ograde koji sam našao?!
E, pa neću ga nikada dati nikome! Taj komadić ograde je sada MOJ!
Jer ja sam HELTER SKEJTER, Strah i Trepet skejtera od Smogograda do Oblak planine!
~ helter_skelter_intro_completed = true
-> choices

= choices
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
	~ got_fence_from_helter_skelter = true
	-> DONE

= try_again

Opet ti, što hoćeš?
-> choices

= question_solved
Ispada da lijepe riječi otvaraju mnoga neobična vrata, pa čak i vrata do mojeg crnog skejterskog srca. 
Tko bi rekao!
-> DONE

= use_item

{used_item:
	- else: -> default
}

= default
Zadrži si te gluposti!
-> DONE

=== conv_taxi_at_park ===
// The taxi at the park 

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{taxi_received_seat_belt:
	- 0: -> no_seat_belt
	- 1: -> taking_to_mountain
}

= no_seat_belt
Moj posao je voziti ljude do planine.
Nažalost, nemam više pojaseva za putnike tako da...
+ {has_item("seat_belt") == false}[Ma baš me briga!]
	Okej, ali to je izuzetno opasno...
	Idemo!
	>>> PLAY_CUTSCENE: drop_player
	Ups! Ispao si!
	Trebao si koristiti pojas!
	-> DONE
+ {has_item("seat_belt") == true}[Imam svoj pojas tako da - sve je okej!]
	Oh... okej!
	Čekaj da ga uglavim u vozilo...
	>>> REMOVE_ITEM: seat_belt
	~ taxi_received_seat_belt = 1
	-> taking_to_mountain
+ [To je preopasno! Neću!]
	Mudar izbor.
	Možda možeš naći pojas viška negdje...
	-> DONE

= taking_to_mountain
Mogu te odvesti do planine!
+ [Odvedi me u planinu.]
	>>> TELEPORT_PLAYER: taxi_at_mountain
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
// This taxi waits for you at the mountain and can take you back to the parking.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

Želiš nazad u grad?
+ [Da!]
	>>> TELEPORT_PLAYER: taxi_at_park
	OK! Idemo!
	Zabavi se!
	-> DONE
+ [Ne!]
	OK! Čekam te ovdje!
	-> DONE

= use_item

Ne treba mi to.
-> DONE

=== conv_canster ===
// This trashbin eats you if it isn't appeased with some trash tribute!

{get_state_property(interact_id, "is_appeased"):
	- 0: -> conv_canster_angry
	- 1: -> conv_canster_appeased
}

=== conv_canster_angry ===
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
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup": -> appease_canster
	- else: -> interact
}

= appease_canster

>>> REMOVE_ITEM: {used_item}
>>> SET_STATE_PROPERTY: {interact_id} is_appeased 1
{canster_gave_pump:
	- 1: -> thank_for_trash
	- 0: -> give_pump
}

= thank_for_trash
Njam njam!
Ja volim smeće!
-> DONE

= give_pump
Njam njam, hvala na smeću!
Zauzvrat, evo tebi nešto što je netko bacio, a uopće nije smeće!
Zapravo je korisna pumpa za bicikl!
>>> ADD_ITEM: pump
~ canster_gave_pump = 1
-> DONE

=== conv_canster_appeased ===
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
	- used_item == "trash_bottle" or used_item == "trash_bag" or used_item == "trash_cup": -> canster_cant_even
	- else: -> default
}

= canster_cant_even
Oprosti, puna sam...
Ali možda negdje postoji još jedna kanta za smeće?
-> DONE

= default
Nisi smeće! Bah!
-> DONE

=== conv_wheelie ===
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
~ got_fence_from_wheelie = 1
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
	>>> SET_STATE_PROPERTY: wheelie going_back_to_park 1
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
// The wind turbine can be powered by a battery you get from Wheelie and
// removes the smog from the smoggy part of twon.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{turbine_fixed:
	- 0: -> not_fixed
	- 1: -> fixed
}

= not_fixed
Obično vjetrenjače pretvaraju vjetar u energiju, ali ova je drugačija!
Ova vjetrenjača pretvara energiju u vjetar!
Tu je velika rupa, i ima simbol za bateriju.
Možda bih, kad bih imao neku bateriju sa sobom, mogao pokrenuti tu vjetrenjaču.
-> DONE

= fixed
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
~ turbine_fixed = 1
>>> SET_STATE_PROPERTY: wind_turbine is_powered 1
>>> REMOVE_ITEM: battery
-> fixed

= default
To neće pomoći, ovdje trebam staviti neki izvor napajanja.
-> DONE

=== conv_bus ===
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
// The love interest trades you her colorful jacket in exchange for your plain one.
// You need this jacket to get into the smoggy part of town.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{get_state_property("player", "wearing_color"):
	- 0: -> switch_to_colorful
	- 1: -> switch_to_plain
}

= switch_to_colorful
Hej, ti! Kako ti se sviđa moja nova jakna? Baš je šarena, zar ne?
Mislim da bi ti dobro stajala!
Hoćeš da se mijenjamo za jakne?
+ [Da, mijenjajmo se!]
	~ player_wearing_color = 1
	>>> SET_STATE_PROPERTY: player wearing_color 1
	>>> SET_STATE_PROPERTY: love_interest wearing_color 0
	Super! Samo mi javi kad se zaželiš svoje stare jakne!
	-> DONE
+ [Ne, volim svoju jaknu.]
	Okej!
	-> DONE

= switch_to_plain
Hej! Hoćeš se opet mijenjati za jakne?
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
// The copper blocks you from entering the smoggy part of town until you are wearing something colorful.
// He also tells you about the windmill as a tip.

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{turbine_fixed:
	- true: -> smog_is_gone
}

{get_state_property("player", "wearing_color"):
	- 0: -> plain
	- 1: -> colorful
}

= plain
STANI!
Ne možeš tako ući u Smogograd!
Zar ne vidiš kakav je unutra smog?! Nitko te neće vidjeti s takvom odjećom!
Vrati se kad budeš imao nešto svjetlije na sebi!
Zapamti: kad si u mračnim ulicama, moraš biti vidljiv autima!
-> DONE

= colorful
Pozdrav, čudovište! Čini se da imaš jako šarenu jaknu na sebi.
Smiješ ući u Smogograd dokle god nosiš nešto tako vidljivo!
Zapamti: kad si u mračnim ulicama, moraš biti vidljiv autima!
-> DONE

= smog_is_gone
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
>>> PAN_CAMERA_TO_POSITION: 736 2782
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
>>> PAN_CAMERA_TO_POSITION: 736 2782
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

=== conv_broken_bike ===
// The broken bike of Solid Slug

Ovo je Slagačev bicikl!
Vau, otpuhan je skroz do tu...
Bolje da mu ga odnesem.
~ found_bike = true
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
~ picked_up_fence_at_turbine = true
-> DONE

=== conv_fence_in_smog_town ===
// A fence piece lying in the smoggy part of town.

Komadić ograde! Gotovo da mi je izmaknuo u ovom smogu!
Najbolje da ga odnesem Solid Snejku!
~ picked_up_fence_in_smog_town = true
-> DONE

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
	- "trash_bag": -> trash_talk
	- "trash_cup": -> trash_talk
	- "trash_bottle": -> trash_talk
	- "pump": -> pump
	- else: -> default
}

= bike
{get_state_property("player", "on_bike"):
	- 0: -> hop_on_bike
	- 1: -> step_off_bike
}

= step_off_bike
>>> SET_STATE_PROPERTY: player on_bike 0
Dosta je bilo bicikla za sada.
-> DONE

= hop_on_bike
{player_answered_bike_question:
	- 0:  -> pop_bike_question
}
>>> SET_STATE_PROPERTY: player on_bike 1
Vrijeme je za malo bicikliranja!
-> DONE

= pop_bike_question
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
	~ player_answered_bike_question = 1
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

= trash_talk
Trebao bih naći kantu za smeće u koju ću ovo baciti!
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