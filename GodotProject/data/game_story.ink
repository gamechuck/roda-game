VAR number_of_fences_fixed = 0
VAR found_bike = 0

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
Too bad the fence to our beautiful park got blown away!
~ talked_with_solid_snjek = 1
-> main

= fix_fence
Oh great, you have a piece of the fence!
let me put it up!
~ number_of_fences_fixed += 1
>>> REMOVE_ITEM: Fence
-> END

= ending
Wow, this place looks much nicer now doesn't it!?
Let's play ball now, finally!
-> END

= main
Hey, let's fix the fence together!
You bring me the fence pieces and I'll fix them.
They must be around somewhere!
-> END

= use_item

{used_item:
	- "Bike": -> bike
	- "Pump": -> pump
	- "Fence": -> fix_fence
	- else: -> default
}

= bike
Sick ride, brah!
-> END

= pump
A tyre pump should be used on tyres!
Not on me!
-> END

= default
I don't want this item!
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
Look, there's a bike right down there
Don't you wish you had my flying jetpack?
Oh well!
>>> PAN_CAMERA: Player
-> END

= has_bike

{watto_question_solved:
	- 0: -> pop_question
	- 1: -> ending
}

= pop_question

I found a piece of the park fence! 
I'll give it to you if you answer me this question:
- (start_question)
If the traffic light is GREEN as you are crossing it but then it turns RED! What do you do?
+ [RUN BACK!!!] 
	WRONG! WRONG!
	There's no going back in life or in traffic! 
	You have much to learn about the human condition!
	-> start_question
+ [RUN RUN RUN!!!]
	Ha! Wrong! Running on the street is never smart!
	-> start_question
+ [Walk a bit faster to the other side.]
	This is true! Istina! Here, have this fence.
-
>>> ADD_ITEM: Fence
~ watto_question_solved = 1
-> END

= ending

Where I'm going, I don't need roads.
-> END

= use_item

{used_item:
	- "Bike": -> bike
	- "Pump": -> pump
	- "Bike": -> fence
	- else: -> default
}

= bike
Ah... I see you conquered the zebras!
Good job!
-> END

= pump
PUMP UP THE JAM!
PUMP IT UP!
-> END

= fence
I have no need for a fence!
-> END

= default
I don't want this item!
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

I don't know about any fences...
but if you ever need a magical item, just talk to me!
-> END

= need_pump

{lizzy_riddle_solved:
	- 0: -> pop_riddle
	- 1: -> ending
}

= pop_riddle

It's a tyre pump you seek, boy? 
I'll give you a MAGICAL tyre pump but first answer my riddle!
- (start_riddle)
What direction do you look in FIRST before crossing the road?
+ [LEFT]
	CORRECT! 
	The cars closest to the road are always flying in from left to right?
+ [RIGHT] 
	Ha! Wrong! 
	The cars will approach you first from the left so you should check that side first!
	-> start_riddle
+ [UP] 
	Ha! Wrong! 
	If you keep your head in the skies you will be blue all over due to all the cars that hit you!
	-> start_riddle
-
>>> ADD_ITEM: Pump
~ lizzy_riddle_solved = 1
-> END

= ending

I hope my magical tyre pump is useful!
-> END

= use_item

{used_item:
	- "Bike": -> bike
	- "Pump": -> ending
	- "Fence": -> fence
	- else: -> default
}

= bike
Ah...
I see you found a bike...
-> END

= fence
This fence is nice and soft to the touch
I wish I could take it home with me...
But that would be theft of public property!
-> END

= default
I don't want this item!
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

You lost your fence? 
I lost my bike...
If you help me find it, I'll help you find your missing fence!
-> END

= has_bike

Oh, thanks so much for finding my bike! 
Here's a piece of the fence I found!
~ gave_back_bike = 1
>>> REMOVE_ITEM: Bike
>>> ADD_ITEM: Fence
>>> SHOW: BrokenBike
-> broken_bike

= broken_bike

Oh, it seems something is wrong with my bike! 
Too bad... Can you help me find out what?
-> END

= issue_with_bike

Oh, so I have a flat tyre? 
Too bad... 
Can you find a tyre pump so we can fix it?
-> END

= has_pump

Oh I see you have a tyre pump! Can you please use it on the bike?
-> END

= bike_was_fixed

Thanks for fixing my bike!
{got_second_fence_from_solid_slug:
	1 : -> END
}
Here's another piece of the fence I found!
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
I bet Solid Snejk would know what to do with this!
-> END

= default
I don't want this item!
-> END

=== conv_bike ===

I can take this bike with me!
~ found_bike = true
-> END

=== conv_broken_bike ===

{conv_type:
	- 0: -> interact
	- 1: -> use_item
}

= interact

>>> BEGIN_MINIGAME: bike_repair
- (bike_repair)
I should check to find out what's wrong with the bike!
+ Oh no! The tyres are flat!
+ It seems that the brakes work!
	-> bike_repair
+ HONK! - It seems that the horn works!
	-> bike_repair
+ It seems the seat is tight!
	-> bike_repair
-
~ figured_out_issue_with_bike = 1
>>> END_MINIGAME: bike_repair
-> END

= use_item

{used_item:
	- "Pump": -> pump
	- else: -> default
}

= pump
Let's fix this!
PUMP!
PUMP!
PUMP!
It's fixed!
~ fixed_bike = 1
-> END

= default
I can't use this item on the bike!
-> END

=== conv_debug ===

What ya want?
+ [Give me a Fence]
	>>> ADD_ITEM : Fence
+ [Give me a Bike]
	>>> ADD_ITEM : Bike
+ [Give me a Pump]
	>>> ADD_ITEM : Pump
-
Here you go buddy! 
-> END