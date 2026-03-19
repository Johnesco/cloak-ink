// Cloak of Darkness — An Ink Implementation
// A standard demonstration of interactive fiction systems
// Original specification by Roger Firth (1999)

VAR has_cloak = true
VAR cloak_on_hook = false
VAR cloak_score_given = false
VAR message_damage = 0
VAR score = 0

Hurrying through the rainswept November night, you're glad to see the bright lights of the Opera House. It's surprising that there aren't more people about but, hey, what do you expect in a cheap demo game...?

-> foyer

=== foyer ===
<b>Foyer of the Opera House</b>
You are standing in a spacious hall, splendidly decorated in red and gold, with glittering chandeliers overhead. The entrance from the street is to the north, and there are doorways south and west.

+ [Go north]
    You've only just arrived, and besides, the weather outside seems to be getting worse.
    -> foyer
+ [Go south] -> bar
+ [Go west] -> cloakroom
+ {has_cloak} [Examine your cloak]
    A handsome cloak, of velvet trimmed with satin, and slightly splattered with raindrops. Its blackness is so deep that it almost seems to suck light from the room.
    -> foyer

=== cloakroom ===
<b>Cloakroom</b>
The walls of this small room were clearly once lined with hooks, though now only one remains. The exit is a door to the east.
{cloak_on_hook:Your velvet cloak hangs on the small brass hook.}

+ [Go east] -> foyer
+ [Examine the hook]
    {cloak_on_hook:It's just a small brass hook, with a velvet cloak hanging on it.}
    {not cloak_on_hook:It's just a small brass hook, screwed to the wall.}
    -> cloakroom
+ {has_cloak} [Hang your cloak on the hook]
    ~ has_cloak = false
    ~ cloak_on_hook = true
    {not cloak_score_given:
        ~ cloak_score_given = true
        ~ score = score + 1
    }
    You hang the velvet cloak on the small brass hook.
    -> cloakroom
+ {cloak_on_hook} [Take your cloak back]
    ~ has_cloak = true
    ~ cloak_on_hook = false
    You take the velvet cloak from the hook and put it on.
    -> cloakroom
+ {has_cloak} [Examine your cloak]
    A handsome cloak, of velvet trimmed with satin, and slightly splattered with raindrops. Its blackness is so deep that it almost seems to suck light from the room.
    -> cloakroom

=== bar ===
{has_cloak: -> bar_dark}
-> bar_lit

=== bar_dark ===
<b>Foyer Bar</b>
It is pitch dark in here. You can barely see a thing.

+ [Stumble around in the dark]
    ~ message_damage = message_damage + 1
    In the dark? You could easily disturb something.
    -> bar_dark
+ [Feel around for something on the floor]
    ~ message_damage = message_damage + 1
    In the dark? You could easily disturb something.
    -> bar_dark
+ {has_cloak} [Drop your cloak here]
    This isn't the best place to leave a smart cloak lying around.
    -> bar_dark
+ [Go north] -> foyer

=== bar_lit ===
<b>Foyer Bar</b>
The bar, much rougher than you'd have guessed after the opulence of the foyer to the north, is completely empty. There seems to be some sort of message scrawled in the sawdust on the floor.

+ [Read the message in the sawdust] -> read_message
+ [Go north] -> foyer

=== read_message ===
{
    - message_damage < 2:
        ~ score = score + 1
        The message, neatly marked in the sawdust, reads...

        <b>*** You have won ***</b>

        Score: {score} out of 2
        -> END
    - else:
        The message has been carelessly trampled, making it difficult to read. You can just distinguish the words...

        <b>*** You have lost ***</b>

        Score: {score} out of 2
        -> END
}
