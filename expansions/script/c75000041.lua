--神之曲 乐天鬼缉戏
function c75000041.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000041,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c75000041.thcon)
	e2:SetTarget(c75000041.thtg)
	e2:SetOperation(c75000041.thop)
	c:RegisterEffect(e2)
	--cannot pendulum summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c75000041.splimit)
	c:RegisterEffect(e3)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOGRAVE)
	e5:SetDescription(aux.Stringid(75000041,1))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetCountLimit(1,75000041)
	e5:SetCondition(c75000041.sgcon)
	e5:SetTarget(c75000041.sgtg)
	e5:SetOperation(c75000041.sgop)
	c:RegisterEffect(e5)
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(75000041,2))
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e9:SetCode(EVENT_REMOVE)
	e9:SetCondition(c75000041.rmcon)
	e9:SetTarget(c75000041.rmtg)
	e9:SetOperation(c75000041.rmop)
	c:RegisterEffect(e9)
end
function c75000041.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c75000041.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000041.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75000041.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75000041.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75000041.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x0) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c75000041.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand() and c:IsLevelBelow(3) and not c:IsCode(75000041)
end
function c75000041.filter2(c,e,tp)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==3
end
function c75000041.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c75000041.filter2,tp,LOCATION_DECK,0,1,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c75000041.filter2,tp,LOCATION_DECK,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),tp,LOCATION_DECK)
end
function c75000041.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c75000041.sgcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_BATTLE) 
end
function c75000041.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c75000041.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
function c75000041.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_DECK)
end
function c75000041.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,1-tp,LOCATION_DECK)
end
function c75000041.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)==0 then return end
	local g=Duel.GetDecktopGroup(1-tp,5)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end