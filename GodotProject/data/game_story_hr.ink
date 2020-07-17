VAR number_of_fences_fixed = 0
VAR found_bike = 0

VAR picked_up_fence = 0

// SolidSnejk
VAR talked_with_solid_snjek = 0

// Lizzy
VAR lizzy_riddle_solved = 0

// Watto
VAR watto_question_solved = 0

// SolidSlug
VAR figured_out_issue_with_bike = 0
VAR got_second_fence_from_solid_slug = 0
VAR gave_back_bike = 0

// BrokenBike
VAR fixed_bike = 0
LIST checked_components = tyres, pedals, horn_and_brakes, saddle, lights

VAR used_item = "bush"
VAR conv_type = 0

EXTERNAL has_item(item_id)
=== function has_item(item_id) ===
~ return true 

EXTERNAL get_state()
=== function get_state() ===
~ return 0

=== conv_solid_snejk ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{number_of_fences_fixed:
    - 4: -> ending
}

{has_item("fence"):
	- true: -> fix_fence
}

{talked_with_solid_snjek:
	- 0: -> intro
	- else: -> main
}

= intro
Oh ne! Otpuhane su ograde u našem parku...
Idemo naći ograde i popraviti park da se možemo opet loptati!
~ talked_with_solid_snjek = 1
-> main

= fix_fence
Super! Našao si komad ograde!
Idem ga postaviti!
~ number_of_fences_fixed += 1
>>> REMOVE_ITEM: fence
{number_of_fences_fixed:
    - 4: -> ending
	- else: -> DONE
}

= ending
VAU, Ovo mjesto sad izgleda mnogo ljepše, zar ne?
Idemo se sad napokon loptati!
-> DONE

= main
Hej, idemo popraviti ogradu zajedno!
Ti mi donesi dijelove ograde i ja ću ju postaviti.
Moraju biti tu negdje oko nas...
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

=== conv_watto ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{found_bike:
	- 0: -> intro
	- 1: -> has_bike
}

= intro
>>> PAN_CAMERA: Bike
Pogledaj, dolje je bicikl!
Sad ti je sigurno žao što nemaš moju leteću raketu?
Hehe, šteta zar ne...
>>> PAN_CAMERA: Player
-> DONE

= has_bike

{watto_question_solved:
	- 0: -> pop_question
	- 1: -> ending
}

= pop_question

Našao sam komadić ograde od parka!
Dat ću ti komad ako mi odgovoriš na ovo pitanje:
- (start_question)
Ako nema pločnika, gdje se pješaci kreću?
+ [Desnom stranom prometnice] 
	Ha! Krivo!
	Tako ne vidiš aute koji dolaze i u većoj si opasnosti.
	Još ti moraš mnogo naučiti o ljudima i njihovim prometnim pravilima...
	-> start_question
+ [Lijevom stranom prometnice]
	Tako je!
	Lijevom stranom - kako bi lakše vidio promet koji nailazi prema tebi.
+ [Sredinom prometnice.]
	Ha! Krivo! Sredinom ceste će te najlakše pokupiti auto!
	-> start_question
+ [Skakuću s jedne strane prometnice na drugu.]
	KRIVO! KRIVO!
	-> start_question
-
>>> ADD_ITEM: fence
~ watto_question_solved = 1
-> DONE

= ending

Tamo gdje ja idem, ne trebaju nam ceste!
-> DONE

= use_item

{used_item:
	- "bike": -> bike
	- "pump": -> pump
	- "bike": -> fence
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

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{figured_out_issue_with_bike:
	- 0: -> intro
	- 1: -> need_pump
}

= intro

Ne znam ja ništa o nikakvim ogradama...
{picked_up_fence:
	- false: -> show_fence
}
Ali ako ikad zatrebaš nešto magično i korisno, slobodno me pitaj!
-> DONE

= show_fence
>>> PAN_CAMERA: Fence
Ali vidio sam da je nešto palo tamo negdje u onom smjeru...
Možda da odeš provjeriti?
>>> PAN_CAMERA: Player
-> DONE

= need_pump

{lizzy_riddle_solved:
	- 0: -> pop_riddle
	- 1: -> ending
}

= pop_riddle

Trebaš pumpu za bicikl?
Imam super MAGIČNU pumpu ali prvo odgovori na moju zagonetku:
- (start_riddle)
Pri prelasku kolnika zebrom na biciklu trebamo:
+ [Naglo zakočiti prije prelaska.]
	Krivo!
	To će samo zbuniti druge u prometu.
	Bolje da ti ne dam pumpu ako si tako neodgovorno biće!
	-> start_riddle
+ [Na vrijeme se zaustaviti, sići s bicikla i hodati preko zebre gurajući bicikl.] 
	TOČNO!
	Na zebrama nije dopušteno voziti se s biciklom, moraš ga gurati.
+ [Ostati na biciklu i ubrzati kako bismo što prije prešli cestu] 
	Krivo!!!
	Ubrzavanje će samo još više povećati šansu da te neki auto slučajno pokupi!
	Bolje da ti ne dam pumpu ako si tako neodgovorno biće!
	-> start_riddle
+ [Pjevati i ne obazirati se na druge sudionike prometa.]
	To sigurno.
	Zapravo: To sigurno NE!
	Bolje da ti ne dam pumpu ako si tako neodgovorno biće!
	-> start_riddle
-
Evo ti magična super pumpa za bicikle.
>>> ADD_ITEM: pump
~ lizzy_riddle_solved = 1
-> DONE

= ending

Nadam se da ti je moja magična super pumpa za bicikle korisna!
-> DONE

= use_item

{used_item:
	- "bike": -> bike
	- "pump": -> ending
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

=== conv_solid_slug ===

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

Hvala što s mi našao bicikl.
Evo komada ograde kojeg sam našao u međuvremenu...
~ gave_back_bike = 1
>>> REMOVE_ITEM: bike
>>> ADD_ITEM: fence
>>> SHOW: BrokenBike
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
{got_second_fence_from_solid_slug:
	1 : -> DONE
}
Evo, ja sam našao još jedan komad otpuhane ograde!
>>> ADD_ITEM: fence
~ got_second_fence_from_solid_slug = 1
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

=== conv_bike ===

Mogu ponijeti ovaj bicikl sa sobom!
~ found_bike = true
-> DONE

=== conv_fence ===

Trebao bih dati ovu ogradu crvu zvanom Solid Snejk.
~ picked_up_fence = true
-> DONE


=== conv_broken_bike ===

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
>>> END_MINIGAME: bike_repair
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

=== conv_debug ===

TESTNI RAZGOVOR: Što hoćeš?
+ [Daj mi ogradu!]
	>>> ADD_ITEM : fence
+ [Daj mi bicikl!]
	>>> ADD_ITEM : bike
+ [Daj mi pumpu!]
	>>> ADD_ITEM : pump
-
Evo!
-> DONE

=== conv_taxi ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

This is a taxi
-> DONE

= use_item

{used_item:
	- "trash_sock": -> trash_sock
	- "trash_bag": -> trash_bag
	- "trash_cup": -> trash_cup
	- else: -> default
}

= trash_sock

It's a sock
-> DONE

= trash_bag

It's a bag
-> DONE

= trash_cup

It's a cup
-> DONE

= default

NO
-> DONE

=== conv_trash_sock ===

A filthy sock!
-> DONE

=== conv_canster ===

{get_state():
	- 0: -> conv_canster_angry
	- 1: -> conv_canster_appeased
}

=== conv_canster_angry ===

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
YUM YUM!
Ja volim smeće!
>>> SET_STATE: 1
-> DONE

=== conv_canster_appeased ===

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