--Oblivion Sower
require "expansions/script/c9990000"
function c9991136.initial_effect(c)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,nil,function(e,tp)
		local g=Duel.GetDecktopGroup(1-tp,4)
		if g:FilterCount(Card.IsAbleToRemove,nil)==4 then
			Duel.DisableShuffleCheck()
			Duel.Remove(g,POS_FACEUP,REASON_RULE)
			local dc=g:FilterCount(function(c)
				return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsLocation(LOCATION_REMOVED)
			end,nil)
			if dc~=0 and Duel.IsPlayerCanDraw(tp) then Duel.Draw(tp,dc,REASON_RULE) end
		end
	end)
end