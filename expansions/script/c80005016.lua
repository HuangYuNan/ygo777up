--圣灵之曦
function c80005016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,80005016+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c80005016.cost)
	e1:SetTarget(c80005016.target)
	e1:SetOperation(c80005016.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(80005016,ACTIVITY_SPSUMMON,c80005016.counterfilter)
end
function c80005016.counterfilter(c)
	return not c:IsLevelAbove(7)
end
function c80005016.filter(c)
	return c:IsAbleToHand() and c:GetAttack()==-2 and c:GetDefense()==-2 and c:IsRace(RACE_SPELLCASTER)
end
function c80005016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80005016.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80005016.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80005016.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c80005016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(80005016,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c80005016.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c80005016.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLevelAbove(7)
end