--传说之魔术师 库丘林
function c99991092.initial_effect(c)
	--synchro
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),aux.NonTuner(Card.IsRace,RACE_SPELLCASTER),1)
	c:EnableReviveLimit()
	--cannot target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99991092,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
    e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c99991092.destg)
	e2:SetOperation(c99991092.desop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c99991092.thcon)
	e3:SetTarget(c99991092.thtg)
	e3:SetOperation(c99991092.thop)
	c:RegisterEffect(e3)
end
function c99991092.filter(c)
	return c:IsAttackPos() and c:IsDestructable()
end
function c99991092.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c99991092.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c99991092.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*300)
end
function c99991092.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c99991092.filter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,ct*300,REASON_EFFECT)
	end
end
function c99991092.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c99991092.sfilter(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToHand()
end
function c99991092.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99991092.sfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c99991092.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	local  g=Duel.SelectMatchingCard(tp,c99991092.sfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tc)
end
end