--露西亚人形
function c99991007.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99991007,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(99991001)
	e1:SetCountLimit(1,99991007)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c99991007.setg)
	e1:SetOperation(c99991007.seop)
	c:RegisterEffect(e1)
	--freeze
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(0,LOCATION_SZONE)
	e2:SetTarget(c99991007.frtg)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	e3:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e3)
end
function c99991007.sefilter(c)
	return  c:IsSetCard(0x2e6) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c99991007.setg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c99991007.sefilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c99991007.seop(e,tp,eg,ep,ev,re,r,rp)
 if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c99991007.sefilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c99991007.frtg(e,c)
   local g=(4-e:GetHandler():GetSequence())
	return c:GetSequence()==g and c:IsFacedown()
end
