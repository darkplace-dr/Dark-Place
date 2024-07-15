return {
    pre_pick = function(cutscene, event)
		cutscene:showNametag("Jamm", {top = false})
		cutscene:text("* Alright, so here's what you need to know.", "neutral", "jamm")
		cutscene:text("* The number under your head shows your card points.", "neutral", "jamm")
		cutscene:text("* You need card points to play cards in this game...", "neutral", "jamm")
		cutscene:text("* ...as indicated by the small number on your cards.", "neutral", "jamm")
		cutscene:text("* The big number represents a card's value, and...", "neutral", "jamm")
		cutscene:text("* ...a sword or a shield shows if it's for attack or defense.", "neutral", "jamm")
		cutscene:text("* Which, by the way, there are separate turns for that.", "neutral", "jamm")
		cutscene:text("* And if you see a card with both, it can be used for either one.", "neutral", "jamm")
		cutscene:text("* Alright, that's it!\n* Let the match begin!", "neutral", "jamm")
		Game.card_game:setState("CARDSELECT")
		cutscene:hideNametag()
	end,
}