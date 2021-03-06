--枯萎牧体
require "expansions/script/c9990000"
function c9991163.initial_effect(c)
	--Xyz
	c:EnableReviveLimit()
	Dazz.AddXyzProcedureEldrazi(c,4,2,nil,function(e,tp)
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
		if not Dazz.IsCanCreateEldraziScion(tp) then return end
		local exg=Duel.GetFieldGroup(tp,0,LOCATION_REMOVED)
		if exg:GetCount()<=1 or not Duel.SelectYesNo(tp,aux.Stringid(9991163,0)) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		exg=exg:Select(tp,2,2,nil)
		Duel.HintSelection(exg)
		Duel.SendtoGrave(exg,REASON_RETURN+REASON_RULE)
		local g=Group.CreateGroup()
		for i=1,2 do
			local token=Dazz.CreateEldraziScion(e,tp)
			g:AddCard(token)
		end
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end)
end