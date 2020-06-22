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
LIST checked_components = tyres, pedals, horn, saddle

VAR used_item = "Bush"
VAR conv_type = 0

EXTERNAL has_item(item_id)
=== function has_item(item_id) ===
~ return true 

=== conv_solid_snejk ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{number_of_fences_fixed:
    - 4: -> ending
}

{has_item("Fence"):
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
>>> REMOVE_ITEM: Fence
{number_of_fences_fixed:
    - 4: -> ending
	- else: -> END
}

= ending
VAU, Ovo mjesto sad izgleda mnogo ljepše, zar ne?
Idemo se sad napokon loptati!
-> END

= main
Hej, idemo popraviti ogradu zajedno!
Ti mi donesi dijelove ograde i ja ću ju postaviti.
Moraju biti tu negdje oko nas...
-> END

= use_item

{used_item:
	- "Bike": -> bike
	- "Pump": -> pump
	- "Fence": -> fix_fence
	- else: -> default
}

= bike
Fora bicikl, frende!
-> END

= pump
Pumpa za bicikl? Isprobaj je na biciklu!
A ne na meni!
-> END

= default
Ne želim to uzeti...
-> END

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
-> END

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
	Da ideš desnom stranom bi auti išli u smjeru prema tebi i pokupili te...
	Još ti moraš mnogo naučiti o ljudima i njihovim prometnim pravilima...
	-> start_question
+ [Lijevom stranom prometnice]
	Tako je!
	Lijevom stranom je u smjeru kretanja autiju pa će te lakše vidjeti!
+ [Sredinom prometnice.]
	Ha! Krivo! Sredinom ceste će te najlakše pokupiti auto!
	-> start_question
+ [Skakuću s jedne strane prometnice na drugu.]
	KRIVO!
	-> start_question
-
>>> ADD_ITEM: Fence
~ watto_question_solved = 1
-> END

= ending

Tamo gdje ja idem, ne trebaju nam ceste!
-> END

= use_item

{used_item:
	- "Bike": -> bike
	- "Pump": -> pump
	- "Bike": -> fence
	- else: -> default
}

= bike
Ah... Vidim da si groknuo kako prijeći zebre!
Svaka čast.
-> END

= pump
PUMP UP THE JAM!
PUMP IT UP!
-> END

= fence
Ne treba mi ta ograda.
-> END

= default
Ne treba mi ta stvar.
-> END

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

Sinko, ne znam ja ništa o nikakvim ogradama...
{picked_up_fence:
	- false: -> show_fence
}
Ali ako ikad zatrebaš neki magični artefakt, slobodno dođi!
-> END

= show_fence
>>> PAN_CAMERA: Fence
Ali vidio sam da je nešto palo tamo negdje u onom smjeru...
Možda da odeš provjeriti?
>>> PAN_CAMERA: Player
-> END

= need_pump

{lizzy_riddle_solved:
	- 0: -> pop_riddle
	- 1: -> ending
}

= pop_riddle

Trebaš pumpu za gume za bicikl, sinko?
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
	Na zebrama nije dopušteno voziti se s biciklom, moraš ga vući.
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
Evo ti magična super pumpa za bicikle, sinko.
>>> ADD_ITEM: Pump
~ lizzy_riddle_solved = 1
-> END

= ending

Nadam se da ti je moja magična super pumpa za bicikle korisna, sinko!
-> END

= use_item

{used_item:
	- "Bike": -> bike
	- "Pump": -> ending
	- "Fence": -> fence
	- else: -> default
}

= bike
Ah, vidim, našao si bicikl.
Zapamti: 
Uvijek, nosi biciklističku kacigu kada voziš bicikl!
-> END

= fence
Kako divna ograda!
Da je bar mogu ponijeti doma sa sobom...
Ali to bi bilo otimanje javnog vlasništva!
-> END

= default
Makni mi to s očiju, sinko!
-> END

=== conv_solid_slug ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{fixed_bike:
	- 1 : -> bike_was_fixed
}

{has_item("Pump") && figured_out_issue_with_bike:
	- true: -> has_pump
}

{figured_out_issue_with_bike:
	- true: -> issue_with_bike
}

{gave_back_bike:
	- true : -> broken_bike
}

{has_item("Bike"):
	- true: -> has_bike
	- false: -> intro
}

= intro

Otpuhala ti se ograda od parka?
Ah, a ja sam zagubio svoj bicikl...
Ako mi pomogneš naći bicikl, ja ću ti pomoći naći jednu ogradu!
-> END

= has_bike

Hvala što s mi našao bicikl.
Evo komada ograde kojeg sam našao u međuvremenu...
~ gave_back_bike = 1
>>> REMOVE_ITEM: Bike
>>> ADD_ITEM: Fence
>>> SHOW: BrokenBike
-> broken_bike

= broken_bike

Ah, čini se da nešto ne valja s mojim biciklom...
Šteta... Možeš li mi pomoći otkriti što?
-> END

= issue_with_bike

Ah, znači guma je ispuhana?
Šteta...
Možeš li negdje od nekoga nabaviti pumpu za gume za bicikle?
-> END

= has_pump

Ah, super, našao si pumpu za gume za bicikle! Možeš li mi napumpati bicikl, molim te?
-> END

= bike_was_fixed

Hvala što si popravio moj bicikl!
{got_second_fence_from_solid_slug:
	- 1 : -> END
}
Evo, ja sam našao još jedan komad otpuhane ograde!
>>> ADD_ITEM: Fence
~ got_second_fence_from_solid_slug = 1
-> END

= use_item

{used_item:
	- "Pump": -> pump
	- "Bike": -> has_bike
	- "Fence": -> fence
	- else: -> default
}

= pump
{figured_out_issue_with_bike:
	- true: -> has_pump
	- false: -> default
}
-> END

= fence
Kladim se da bi crv zvan Solid Snejk znao što napraviti s tom ogradom...
-> END

= default
Ne treba mi to, hvala...
-> END

=== conv_bike ===

Mogu ponijeti ovaj bicikl sa sobom!
~ found_bike = true
-> END

=== conv_fence ===

Trebao bih dati ovu ogradu crvu zvanom Solid Snejk.
~ picked_up_fence = true
-> END


=== conv_broken_bike ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

{figured_out_issue_with_bike:
	- false : -> check_bike
}

{has_item("Pump"):
	- true: -> fix_bike_with_pump
}

Trebao bih okolo potražiti pumpu za bicikl...
Možda pitati nekoga?
-> END

= check_bike
>>> BEGIN_MINIGAME: bike_repair
- (bike_repair)
{checked_components == LIST_ALL(checked_components):
	- true: -> after_checking_bike
}
{figured_out_issue_with_bike:
	- true: Trebao bih provjeriti jesu li drugi dijelovi bicikla dobro...
	- false: Trebao bih provjeriti radi li sve kako treba na biciklu...
}
+ Guma?
	Oh, ne! Jedna guma je ispuhana!
	~ figured_out_issue_with_bike = 1
	~ checked_components += tyres
	-> bike_repair
+ Pedale?
	Čini se da su pedale dobro ušarafljene...
	~ checked_components += pedals
	-> bike_repair
+ Truba?
	HONK!
	Čini se da truba radi!
	~ checked_components += horn
	-> bike_repair
+ Sjedalica?
	Čini se da je sjedalica čvrsto uglavljena.
	~ checked_components += saddle
	-> bike_repair
= after_checking_bike
Čini se da je problem u ispuhanoj gumi...
Trebamo to popraviti!
>>> END_MINIGAME: bike_repair
-> END

= use_item

{used_item:
	- "Pump": -> pump
	- else: -> default
}

= pump

{figured_out_issue_with_bike:
	- 1: -> fix_bike_with_pump
}

Trebam prvo otkriti što ne valja s bicilkom...
-> END

= fix_bike_with_pump

Vrijeme za napumpati ispražnjelu gumu!
\*PUMP*
\*PUMP PUMP*
\*PUMP PUMP PUMP*
...
...?
Eto, kao nova!
~ fixed_bike = 1
-> END

= default
Ne treba to biciklu...
-> END

=== conv_debug ===

Što hoćeš?
+ [Daj ogradu]
	>>> ADD_ITEM : Fence
+ [Daj bicikl]
	>>> ADD_ITEM : Bike
+ [Daj pumpu]
	>>> ADD_ITEM : Pump
-
Evo, sinko!
-> END