--战争前奏
function c23310017.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23310017+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c23310017.cost)
	e1:SetTarget(c23310017.target)
	e1:SetOperation(c23310017.activate)
	c:RegisterEffect(e1)
end
function c23310017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,23310017)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c23310017.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c23310017.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
function c23310017.tgfilter1(c)
	return c:IsType(TYPE_MONSTER) and not Duel.IsExistingMatchingCard(c23310017.tgfilter2,tp,LOCATION_GRAVE,0,1,c,c:GetAttribute())
end
function c23310017.tgfilter2(c,att)
	return c:IsType(TYPE_MONSTER) and not c:IsAttribute(att)
end
function c23310017.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsLevelAbove(5)
end
function c23310017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23310017.tgfilter1,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingMatchingCard(c23310017.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c23310017.spfilter(c,e,tp,code,rac)
	return c:IsRace(rac) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(code)
end
function c23310017.tofilter(c,e,tp,code,rac)
	return c:IsRace(rac) and c:IsAbleToGrave() and not c:IsCode(code)
end
function c23310017.thfilter(c,e,tp,code,rac)
	return c:IsRace(rac) and c:IsAbleToHand() and not c:IsCode(code)
end
function c23310017.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c23310017.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local tc=g:GetFirst()
		local rac=tc:GetRace()
		if tc:IsLevelAbove(5) and tc:IsLevelBelow(6) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c23310017.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,tc:GetCode(),rac) and Duel.SelectYesNo(tp,aux.Stringid(23310017,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=Duel.SelectMatchingCard(tp,c23310017.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetCode(),rac)
			if sg:GetCount()>0 then
				Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			end
		end
		if tc:IsLevelAbove(7) and tc:IsLevelBelow(8) and Duel.IsExistingMatchingCard(c23310017.tofilter,tp,LOCATION_HAND,0,1,nil,e,tp,tc:GetCode(),rac) and Duel.SelectYesNo(tp,aux.Stringid(23310017,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local tg=Duel.SelectMatchingCard(tp,c23310017.tofilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc:GetCode(),rac)
			if tg:GetCount()>0 then
				Duel.SendtoGrave(tg,REASON_EFFECT)
			end
		end
		if tc:IsLevelAbove(9) and Duel.IsExistingMatchingCard(c23310017.thfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tc:GetCode(),rac) and Duel.SelectYesNo(tp,aux.Stringid(23310017,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
			local hg=Duel.SelectMatchingCard(tp,c23310017.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,tc:GetCode(),rac)
			if hg:GetCount()>0 then
				Duel.SendtoHand(hg,nil,REASON_EFFECT)
			end
		end
	end
end