RunAnims (by crocokuo)

Adds running animations to the player and its followers, similar in functionality
the ones seen in Undertale Yellow.

To use, simply create a "run" folder directly in an actor's path. Place the run
sprites in there (left_1, left_2, left_3, etc).

NOTES:

--  If no "run" folder is provided for a certain character, the library will not
    effect on said character.

--  Creates a "RUN" state for the player and its followers, and a "WALK" state
    for said followers.

--  Creates the following variables for the player:

        self.running
        self.has_run
        self.old_xv
        self.old_yv
        self.stay_grace

--  Creates the following variables for the followers:

        self.running
        self.has_run