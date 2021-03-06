--Matter Reshaper
function c9991117.initial_effect(c)
	--Search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return not e:GetHandler():IsReason(REASON_RETURN)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetDecktopGroup(tp,4)
		if g:GetCount()<=0 then return end
		Duel.ConfirmCards(tp,g)
		local g1=g:Filter(Card.IsAbleToGrave,nil)
		local g2=g:Filter(function(c,e,tp)
			return c:IsLevelBelow(4) and c:IsRace(RACE_REPTILE)
				and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		end,nil,e,tp)
		local v1,v2=
			g1:GetCount()>0,
			g2:GetCount()>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)>=2
				and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		local sel=2
		if v1 and not v2 then
			sel=0
		elseif v2 and not v1 then
			sel=1
		elseif v1 and v2 then
			if Duel.SelectYesNo(tp,aux.Stringid(9991117,0)) then
				sel=1
			else
				sel=0
			end
		end
		if sel==0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g1=g1:Select(tp,1,1,nil)
			Duel.SendtoGrave(g1,REASON_EFFECT)
		elseif sel==1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g2=g2:Select(tp,1,1,nil)
			Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.ShuffleDeck(tp)
	end)
	c:RegisterEffect(e1)
end