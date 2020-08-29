VAR number_of_fences_fixed = 0
VAR found_bike = 0
VAR picked_up_fence_at_turbine = 0
VAR picked_up_fence_in_smog_town = 0
VAR got_fence_from_helter_skelter = 0
VAR got_fence_from_wheelie = 0

// SolidSnejk
VAR talked_to_solid_snejk = 0

// Lizzy
VAR talked_to_lizzy = 0

// Watto
VAR watto_question_solved = 0

// SolidSlug
VAR figured_out_issue_with_bike = 0
VAR gave_back_bike = 0

// BrokenBike
VAR fixed_bike = 0
LIST checked_components = tyres, pedals, horn_and_brakes, saddle, lights

// Taxi
VAR seat_belt_given_to_taxi = 0

// Helter Skelter
VAR talked_to_helter_skelter = 0

// SeatBeltCar
VAR seat_sorting_completed = 0

// Wind Turbine
VAR turbine_fixed = 0

// Mr. Smog
VAR smog_defeated = 0

// Canster
VAR received_pump_from_canster = 0

// Wheelie
VAR escorted_wheelie_to_house = 0
VAR escorted_wheelie_back_to_park = 0

VAR talked_to_wheelie_at_park = 0
VAR talked_to_wheelie_at_house = 0
VAR talked_to_wheelie_back_at_park = 0

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
Hej svi, idemo igrati nogomet!
>>> UPDATE_UI: solid_slug
Daaaaa! Dodaj mi loptu!
>>> PLAY_CUTSCENE: intro_play_ball
Dajte, dodajte i meni loptu!
...
>>> PLAY_CUTSCENE: show_smog
>>> UPDATE_UI: solid_snejk
Čekaj, što se događa?
Odakle sav ovaj smog?
>>> UPDATE_UI: mr_smog
AHAHAHAHA!
>>> PLAY_CUTSCENE: mr_smog_intro
Pozdravite se sa svojim slatkim parkom, djeco!
Mister Smog je došao pokvariti vašu zabavu!
>>> PLAY_CUTSCENE: mr_smog_destroy_park
AHAHAHAHA!!!
>>> PLAY_CUTSCENE: mr_smog_outro
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

{smog_defeated:
    - 1: -> second_ending
}

{number_of_fences_fixed:
    - 4: -> first_ending
}

{has_item("fence"):
	- true: -> fix_fence
}

{talked_to_solid_snejk:
	- 0: -> intro
	- else: -> main
}

= intro
Oh ne! Otpuhane su ograde u našem parku... #solid_snejk_intro_1
Idemo naći ograde i popraviti park da se možemo opet loptati! #solid_snejk_intro_2
~ talked_to_solid_snejk = 1
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
VAU, Ovo mjesto sad izgleda mnogo ljepše, zar ne?
Makar, čini mi se da je tu nekada bilo jedno drvo...
Pitam se što mu se dogodilo?
Možda možeš otkriti što se dogodilo s našim omiljenim drvetom!
Nakon toga se možemo nastaviti loptati!
-> DONE

= main
Hej, idemo popraviti ogradu zajedno! #solid_snejk_main_1
Ti mi donesi dijelove ograde i ja ću ju postaviti. #solid_snejk_main_2
Zločesti Mister Smog ih je otpuhao na sve strane svijeta... #solid_snejk_main_3
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
	- true : -> broken_bike
}

{has_item("bike"):
	- true: -> has_bike
	- false: -> intro
}

= intro

Vjetar ti je otpuhao ogradu od parka?
Ah, a ja sam zagubio svoj bicikl...
Ako mi pomogneš naći bicikl, ja ću ti pomoći naći jedan dio ograde!
-> DONE

= has_bike

Hvala što s mi našao bicikl!
~ gave_back_bike = 1
>>> REMOVE_ITEM: bike
>>> SHOW: ReturnedBike
-> broken_bike

= broken_bike

Ah, čini se da nešto ne valja s mojim biciklom...
Šteta... Možeš li mi pomoći otkriti što?
-> DONE

= issue_with_bike

Ah, znači guma je ispuhana?
Šteta...
Možeš li negdje od nekoga nabaviti pumpu za bicikle?
-> DONE

= has_pump

Ah, super, našao si pumpu za bicikle! Možeš li mi napumpati gumu, molim te?
-> DONE

= bike_was_fixed

Hvala što si popravio moj bicikl!
You can use my bike if you want!
Just take it and use it on yourself any time to ride the bicycle!
-> DONE

= use_item

{used_item:
	- "pump": -> pump
	- "bike": -> has_bike
	- "fence": -> fence
	- else: -> default
}

= pump
{figured_out_issue_with_bike:
	- true: -> has_pump
	- false: -> default
}
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

Tražiš bicikl!
Pokazat ću ti gdje sam ga našao ako mi odgovoriš na ovo pitanje:
- (start_question)
Ako nema pločnika, gdje se pješaci kreću?
+ [Defencesnom stranom prometnice] 
	Ha! Krivo!
	Tako ne vidiš aute koji dolaze i u većoj si opasnosti.
	Još ti moraš mnogo naučiti o ljudima i njihovim prometnim pravilima...
	-> start_question
+ [Lijevom stranom prometnice]
	Tako je!
	Lijevom stranom - kako bi lakše vidio promet koji nailazi prema tebi.
	~ watto_question_solved = 1
	-> show_bike_location
+ [Sredinom prometnice.]
	Ha! Krivo! Sredinom ceste će te najlakše pokupiti auto!
	-> start_question
+ [Skakuću s jedne strane prometnice na drugu.]
	KRIVO! KRIVO!
	-> start_question

= show_bike_location
Eno gdje stoji izgubljeni bicikl!
>>> PAN_CAMERA_TO_POSITION: 3560 3032
Sad ti je sigurno žao što nemaš moju leteću raketu?
Hehe, šteta zar ne...
>>> RESET_CAMERA
-> DONE

= ending
Vidim da si savladao šetanje po pločnicima i zebrama.
Ali tamo gdje ja idem, ne trebaju mi ceste!
-> DONE

= use_item

{used_item:
	- "bike": -> bike
	- "pump": -> pump
	- "fence": -> fence
	- else: -> default
}

= bike
Ah... Vidim da si otkrio kako prijeći zebre!
Svaka čast.
-> DONE

= pump
S tim napumpaj gumu na biciklu, meni za raketu to ne treba!
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

{talked_to_lizzy:
	- 0: -> intro
	- 1: -> main
}

= intro
Ja sam Veliki Lizijan! Čarobnjak iz daleke zemlje Prometije.
Došao sam tu na odmor, ali čini se da tu imate neke probleme.
Možda ti mogu pomoći? Imam moć s kojom ti mogu pokazati što tražiš!
Ali... prvo moraš odgovoriti na jednu od mojih zagonetki!
Žao mi je zbog toga, ali tako moje moći rade...
~ talked_to_lizzy = 1
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
	Krivo!
	To će samo zbuniti druge u prometu.
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Na vrijeme se zaustaviti, sići s bicikla i hodati preko zebre gurajući bicikl.] 
	TOČNO!
	Na zebrama nije dopušteno voziti se s biciklom, moraš ga gurati.
	-> dobroide
+ [Ostati na biciklu i ubrzati kako bismo što prije prešli cestu] 
	Krivo!!!
	Ubrzavanje će samo još više povećati šansu da te neki auto slučajno pokupi!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Pjevati i ne obazirati se na druge sudionike prometa.]
	To sigurno.
	Zapravo: To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle

// RIDDLE TWO
= second_riddle
- (start_riddle)
Zašto se prometni znakovi moraju poštivati?
+ [Zbog veselih boja.]
	Krivo!
	Razmisli malo bolje!
	-> start_riddle
+ [Zbog sigurnosti u prometu.] 
	TOČNO!
	Inače bismo svi bili u velikoj opasnosti!
	-> dobroide
+ [Zbog dosade kad sami hodamo.] 
	Krivo!!!
	Znakove se treba poštivati i kad nam je dosadno i kad nam je zabavno!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Zbog moguće kazne.]
	To sigurno.
	Zapravo: To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle

// RIDDLE THREE
= third_riddle
- (start_riddle)
Što može povećati pozornost pješaka u prometu?
+ [Pričanje s prijateljima.]
	Krivo!
	Samo ćete se zapričati i imati još manju pozornost!
	-> start_riddle
+ [Predviđanje i očekivanje opasnosti.] 
	TOČNO!
	Razmisli i probaj predvidjeti moguće opasnosti!
	-> dobroide
+ [Razgovor mobitelom.] 
	Krivo!!!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Pretrčavanje preko kolnika.]
	To sigurno.
	Zapravo: To sigurno NE!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle

// RIDDLE FOUR
= fourth_riddle
- (start_riddle)
Što je kolnik?
+ [Dio ceste kojom se kreću pješaci.]
	Krivo!
	To bi bio pločnik, a ne kolnik!
	-> start_riddle
+ [Dio ceste kojom se kreću vozila.] 
	TOČNO!
	-> dobroide
+ [Osoba koja voli koka kolu.] 
	Krivo!!!
	Bolje da ti ne pomažem ako si tako neodgovorno biće!
	-> start_riddle
+ [Slovenski atletičar koji je 1960-e sudjelovao na ljetnoj Olimpijadi.]
	Opa, još jedan obožavatelj lika i djela Mirka Kolnika!
	Zapravo, točan odgovor je "Kolnik je dio ceste kojom se kreću vozila."
	Ali nagradit ću tvoje znanje regionalnih atletičara i smatrati ovo točnim.
	Čestitam!!!
	-> dobroide

= dobroide
Dobro ti ide odgovaranje na moje zagonetke!
{ picked_up_fence_in_smog_town && picked_up_fence_at_turbine && got_fence_from_wheelie && got_fence_from_helter_skelter:
	- 0: -> show_missing_fence_locations
	- 1: -> pan_to_love_interest
}

// Here the lizard will show you (the camera will pan) to one of the locations of the fence.
// If there are no more fences, he'll pan the camera to your love interest.. because that is
// what you desire most! <3
= show_missing_fence_locations
Hmmm, vidim sada... Ti tragaš za ogradom, koju želiš popraviti da bude kao nekad!
Da vidimo...
{shuffle:
- {not got_fence_from_wheelie: -> pan_to_house }
- {not got_fence_from_helter_skelter: -> pan_to_helter_skelter }
- {not picked_up_fence_at_turbine: -> pan_to_fence_at_turbine }
- {not picked_up_fence_in_smog_town: -> pan_to_fence_in_smog_town }
}
-> DONE

= pan_to_house
// PAN TO HOUSE:
>>> PAN_CAMERA_TO_POSITION: 3870 1788
Opa! Čini se da je jedan dio ograde pao na krov ove zgrade!
Morat ćeš otkriti tko je vlasnik zgrade pa ti možda on može ući i popeti se na krov po taj dio ograde.
>>> RESET_CAMERA
-> DONE

= pan_to_helter_skelter
// PAN TO HELTER SKELTER:
>>> PAN_CAMERA_TO_POSITION: 2500 3738
Čini se da je neki ljutko sa skejtom našao ogradu i prisvojio je sebi.
Morat ćeš ga zamoliti da ti je vrati koristeći svoju karizmu i riječitost, čini se!
>>> RESET_CAMERA
-> DONE

= pan_to_fence_in_smog_town
// PAN TO SMOG ZONE:
>>> PAN_CAMERA_TO_POSITION: 1439 1768
Moj magični vid jedva može vidjeti kroz sav ovaj smog!
Ova regija se čini vrlo opasnom i mislim da ćeš u njoj morati nositi raznobojnu odjeću da te auti bolje vide!
I ne samo to...
Tamo je sve puno duhova!!!!!
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
Ja sam to zaboravio previše puta i sada sam vrlo usamljeni čarobnjak.
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

{figured_out_issue_with_bike:
	- false : -> check_bike
}

{has_item("pump"):
	- true: -> fix_bike_with_pump
}

Trebao bih okolo potražiti pumpu za bicikl...
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
	Čini se da su pedale dobro ušarafljene...
	I na pedalama je s prednje i stražnje strane po jedno mačje oko.
	Super!
	~ checked_components += pedals
	-> bike_repair
+ Svijetla?
	Prednje svjetlo bijele boje za osvjetljavanje ceste.
	Stražnje svjetlo crvene boje s mačjim okom.
	Super!
	~ checked_components += lights
	-> bike_repair
+ Zvonce?
	Zvonce je na upravljaču.
	TRUB TRUB!
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

= use_item

{used_item:
	- "pump": -> pump
	- else: -> default
}

= pump

{figured_out_issue_with_bike:
	- 1: -> fix_bike_with_pump
}

Trebam prvo otkriti što ne valja s bicilkom...
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
Hej, simpatično čudovište. Žalim slučaj, malo sam zauzet...
Ali čekaj malo, možda mi možeš pomoći!
Pokušavam posložiti sva ova čudovišta na prava mjesta ali ne znam koji pojas ide na koju dob.
Pomozi mi molim te!
+ [Kako da ne, meni sortiranje čudovišta po pojasevima dolazi skroz prirodno!]
	-> start_seat_sorting
+ [Nemam vremena, imam ja i svoj zadatak za riješiti!]
	Ajoj! Ja neću moći poletjeti dok to ne razriješim.
	-> DONE

= start_seat_sorting
Okej, hvala ti puno!
>>> BEGIN_MINIGAME: seat_sorting
- (sorting_minigame_start)
Stavi pravo čudovište na pravo mjesto! I čini to često!
+ Ne, ne, ne, pa čak i ja vidim da to nije dobro...
	Probajmo opet.
	-> sorting_minigame_start
+ Wow! To je savršeno!
	Sada napokon neću više morati plaćati kazne!
	Da ne spominjem povećanu sigurnost!
	-> sorting_minigame_solved
= sorting_minigame_solved
>>> END_MINIGAME
Here take this pump as a reward for your help!
>>> ADD_ITEM: pump
~ seat_sorting_completed = 1
-> DONE

= after_solving_enigma
Thanks again!
Now we can finally go to the sea!
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

{talked_to_helter_skelter:
	- 1: -> try_again
}

?
Kako si prošao sve moje skejter minione???
Ja sam im eksplicitno rekao da nikoga ne puštaju!
Sigurno si došao po komadić ograde koji sam našao?!
E pa neću ga nikada dati nikome! Taj komadić ograde je sada MOJ!
Jer ja sam HELTER SKEJTER, Strah i Trepet skejtera od Smogograda do Oblak Planine!
~ talked_to_helter_skelter = true
-> choices

= choices
+ [Ne zafrkavaj ti mene, ja sam veliko i opasno Čudovište!]
	Nisi ni blizu velik i opasan kao ja!
	A sad briši dok te nisam ozlijedio!
	-> DONE
+ [Ako si ti strah i trepet, ja sam semafor!]
	Pa tako i izgledaš, kao mali plavi semafor!
	Ali hmm, semafori nisu plavi...
	Nema veze, makni mi se s očiju!
	-> DONE
+ [Molim te, gospodine Helter Skejter, možete li nam ipak dati komadić ograde, jako nam je to važno?]
	Što?!
	Je li to... Pristojnost!?
	U mojoj butigi?!?!?!
	To nisam čuo od...
	Od...
	Od kad sam išao svojoj dragoj bakici na kolače...
	Ah, kako je to bilo lijepo.
	Hvala što si me podsjetio na nevinije vrijeme mog djetinjstva dok nisam bio vođa bande skejtera.
	Evo, uzmi ovu ogradu.
	Zbogom, čudovište!
	>>> ADD_ITEM: fence
	A vi, skejteri, prestanite ga udarati!
	~ got_fence_from_helter_skelter = true
	-> DONE

= try_again

Opet ti, što hoćeš?
-> choices

= question_solved
Ispada da lijepe riječi otvaraju mnoga neobična vrata, pa čak i vrata do mojeg crnog skejterskog srca. Tko bi rekao!
-> DONE

= use_item

{used_item:
	- else: -> default
}

= default
Keep your junk to yourself!
-> DONE

=== conv_taxi_at_park ===
// The taxi at the park 

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{seat_belt_given_to_taxi:
	- 0: -> no_seat_belt
	- 1: -> taking_to_mountain
}

= no_seat_belt
Moj posao je voziti ljude do planine.
Nažalost, nemam više pojaseva za putnike tako da...
+ {has_item("seat_belt") == false}[Ma kaj me briga!]
	Okej, ali to je izuzetno opasno...
	Idemo!
	>>> PLAY_CUTSCENE: drop_player
	Ups! Ispao si!
	Trebao si nositi pojas!
	-> DONE
+ {has_item("seat_belt") == true}[Imam svoj pojas tako da - sve je okej!]
	Oh... okej!
	Čekaj da ga uglavim u vozilo...
	>>> REMOVE_ITEM: seat_belt
	~ seat_belt_given_to_taxi = 1
	-> taking_to_mountain
+ [To je preopasno! Neću!]
	Mudar izbor.
	Možda možeš naći pojas viška negdje...
	-> DONE

= taking_to_mountain
Možeš me odvesti do planine?
+ [Take me to the mountain!]
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
Fora pojas. Taman ono što trebam!
Sad ću napokon opet moći sigurno voziti ljude do planine!
Samo pričaj sa mnom kad god želiš do planine!
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

Želiš nazad u park?
+ [Da!]
	>>> TELEPORT_PLAYER: taxi_at_park
	OK! Idemo!
	Zabavi se!
	-> DONE
+ [Ne!]
	OK! Čekam te ovdje!
	-> DONE

= use_item

{used_item:
	- else: -> default
}

= default
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
>>> PLAY_CUTSCENE: chew_on_player
!!?
Nisi smeće! Bah!
>>> RESPAWN_PLAYER
-> DONE

= use_item

{
	- used_item == "trash_sock" or used_item == "trash_bag" or used_item == "trash_cup": -> appease_canster
	- else: -> interact
}

= appease_canster

>>> REMOVE_ITEM: {used_item}
>>> SET_STATE_PROPERTY: {interact_id} is_appeased 1
{received_pump_from_canster:
	- 1: -> thanks_for_trash
	- 0: -> give_a_pump
}

= thanks_for_trash
YUM YUM!
Ja volim smeće!
-> DONE

= give_a_pump
Njam njam, hvala na smeću!
Zauzvrat, evo tebi nešto što je netko bacio, a uopće nije smeće!
Zapravo je korisna pumpa za bicikl!
>>> ADD_ITEM: pump
~ received_pump_from_canster = 1
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
	- used_item == "trash_sock" or used_item == "trash_bag" or used_item == "trash_cup": -> canster_cant_even
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

{escorted_wheelie_back_to_park:
	- 1: -> back_at_park 
}

{escorted_wheelie_to_house:
	- 0: -> intro
	- 1: -> at_house
}

{talked_to_wheelie_at_park:
	- 0: -> intro
	- 1: -> main_at_park
}

= intro
Sad kad nema ograde, ne možemo igrati nogomet...
Dok se stvari ne riješe, idem ja doma.
No na putu do mene doma je hrpa gladnih kanti za smeće!
Možeš ih molim te nahraniti smećem? Inače krenu jesti nas čudovišta!
~ talked_to_wheelie_at_park = 1
-> main_at_park

= main_at_park
Hej, jesi li nahranio sve kante za smeće?
+ [Da, sad je put siguran!]
	Super, idemo!
	// You escort wheelie to his house/park! 
	-> DONE
+ [Ne još, možda kasnije.]
	Okej, samo mi javi kad pročistiš put do mene doma!
	-> DONE

= at_house
// WHEELIE AT HOUSE!

{talked_to_wheelie_at_house:
	- 0: -> just_arrived_at_house
	- 1: -> main_before_fixing_park
}

= just_arrived_at_house

Hvala na praćenju do kuće!
Idem vidjeti što mi rade mama i tata doma dok mene nema!
// Goes in and checks with his mom.
Hej, čini se da je na krovu ostao otpuhan dio ograde.
Slobodno ga uzmi, pa možda popraviš ogradu!
>> ADD_ITEM: fence
~ talked_to_wheelie_at_house = 1
-> DONE

= main_before_fixing_park

{number_of_fences_fixed:
    - 4: -> after_park_fixed
}

Hvala što si me otpratio.
Mislim da ću ostati ovjde dok se ne popravi ograda u parku.
Dođi po mene kad je popravite! Bok bok!
-> DONE

= after_park_fixed

{talked_to_wheelie_at_house:
    - 1: -> main_at_house
}

Vau, popravio si park!
Želio bih opet ići igrati nogomet s vama ali...
Opet su kante za smeće postale gladne!
Možeš ih opet nahraniti smećem molim te?
Jako ih se plašim!
~ talked_to_wheelie_at_house = 1
-> DONE

= main_at_house
Jesu li sve kante nahranjene?
+ [Da, sad je sigurno!]
	Super! Idemo!
	// You escort wheelie back to the park! 
	-> DONE
+ [Ne još, još radim na tome!]
	Okej, samo mi javi! Znaš kakve te kante znaju biti kad su gladne!
	-> DONE

= back_at_park
// WHEELIE BACK AT PARK!

{talked_to_wheelie_back_at_park:
	- 0: -> just_arrived_back_at_park
	- 1: -> main_back_at_park
}

= just_arrived_back_at_park
Hvala što si me otpratio do našeg predivnog parka!
Mislim da ću ostati ovdje i uživati u parku zauvijek!
Evo, možeš uzeti moju bateriju. Ne treba mi više!
>> ADD_ITEM: battery
~ talked_to_wheelie_back_at_park = 1
-> DONE

= main_back_at_park
Predivan dan!
Jedino što fali je ono veliko drvo koje je nekad tu bilo posađeno.
Pitam se što se dogodilo s tim drvom...
-> DONE

= use_item

{used_item:
	- "battery": -> battery
	- else: -> default
}

= battery
Keep the battery! I don't need it anymore!
-> DONE

= default
I don't need that stuff!
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
Možda kad bih imao neku bateriju sa sobom, mogao bih pokrenuti ovu vjetrenjaču.
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
Ali ja jako kasnim za voznim redom, čak 23 sata.
Ali nema veze - ako još sat vremena pričekam ovdje, taman ću biti na vrijeme!
E da, pazi na aute!
Ne mogu te vidjeti kad prelaziš zebru jer je moj bus tu parkiran!
Probaj prijeći cestu sa zebrom s druge strane ceste!
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
Hej ti! Kako ti se sviđa moja nova jakna! Baš je šarena, zar ne?
Mislim da bi ti dobro stajala!
Hoćeš da se mijenjamo za jakne?
+ [Da, mijenjajmo se!]
	>>> SET_STATE_PROPERTY: player wearing_color 1
	>>> SET_STATE_PROPERTY: love_interest wearing_color 0
	Super! Samo mi javi kad se zaželiš svoje stare jakne!
	-> DONE
+ [Ne, volim svoju jaknu]
	Okej!
	-> DONE

= switch_to_plain
Hej! Hoćeš se opet mijenjati za jakne?
+ [Da, vrati mi moju jaknu!]
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
Vrati se kad imaš nešto svijetlije na sebi!
Zapamti: kad si u mračnim ulicama, moraš biti vidljiv autima!
-> DONE

= colorful
Pozdrav, čudovište. Čini se da imaš jako šarenu jaknu na sebi.
Smiješ ući u Smogograd dok god nosiš tako nešto vidljivo!
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
Zašto mi to daješ? Želiš me podmititi?!
Zar ne znaš da je policija najčasnija služba u javnom sektoru!?
Čak dajemo novce za udruge koje uče djecu prometnim pravilima!
-> DONE

=== conv_happy_tree ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

I was possessed by evil smog!
But now I am a happy tree again!
Thank you for your help!
-> DONE

= use_item

{used_item:
	- else: -> default
}

= default
Thank you for your gift!
>>> REMOVE_ITEM: {used_item}
-> DONE

=== conv_broken_bike ===
// The broken bike of Solid Slug

I think this is the bike of Solid Slug!
Wow, it got blown all the way out here!
I better bring it back to him!
~ found_bike = true
-> DONE

=== conv_trash_bag ===
// Trash necessary to feed the cansters...

Netko se jako potrudio da stavi hrpu raznog smeća u torbu...
Ali onda su je zaboravili baciti u smeće!
-> DONE

=== conv_trash_cup ===
// Trash necessary to feed the cansters...

Netko je ostavio ovu polu-praznu čašu na podu!
Ili polu-punu?
U svakom slučaju, trebao bih je baciti u kantu za smeće!
-> DONE

=== conv_trash_bottle ===
// Trash necessary to feed the cansters...

Ova boca ima nešto malo kole, ali uopće više nije gazirana!
Možda najbolje da je bacim u smeće.
-> DONE

=== conv_fence_at_turbine ===
// A fence piece lying next to the wind farm.

Wow! This fence piece flew all the way over here.
Better get it back to the park!
~ picked_up_fence_at_turbine = true
-> DONE

=== conv_fence_in_smog_town ===
// A fence piece lying in the smoggy part of town.

Komadić ograde! Gotovo da mi je izvakao u ovom smogu!
Najbolje da ga odnesem Solid Snejku!
~ picked_up_fence_in_smog_town = true
-> DONE

=== conv_player ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact
This should not be reachable!
-> DONE

= use_item

{used_item:
	- "bike": -> bike
	- else: -> default
}

= bike
{get_state_property("player", "on_bike"):
	- 0: -> hop_on_bike
	- 1: -> step_off_bike
}

= step_off_bike
>>> SET_STATE_PROPERTY: player on_bike 0
Off the bike I go!
-> DONE

= hop_on_bike
>>> SET_STATE_PROPERTY: player on_bike 1
Let's start using that bike!
-> DONE

= default
{used_item}
I should think really hard about what to with this item!
-> DONE