--藏书屋 森近霖之助
function c6000003.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c6000003.splimit)
	c:RegisterEffect(e2)
	--to extra
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6000003,1))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,6000003)
	e3:SetRange(LOCATION_PZONE)
	e3:SetTarget(c6000003.tetg)
	e3:SetOperation(c6000003.teop)
	c:RegisterEffect(e3)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6000003,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCost(c6000003.cost)
	e4:SetCountLimit(1,6000003)
	e4:SetTarget(c6000003.target1)
	e4:SetOperation(c6000003.operation1)
	c:RegisterEffect(e4)
	--synchro limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c6000003.limit)
	c:RegisterEffect(e6)
	--xyz limit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetValue(c6000003.limit)
	c:RegisterEffect(e7)
end
function c6000003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c6000003.filter1(c)
	return c:IsSetCard(0x300) and c:IsType(TYPE_TRAP) and not c:IsCode(6000003) and c:IsAbleToHand()
end
function c6000003.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6000003.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6000003.operation1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6000003.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c6000003.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c6000003.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0x300) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c6000003.limit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x300)
end
function c6000003.filter(c)
	return c:IsSetCard(0x300) and c:IsType(TYPE_PENDULUM) and c:IsAbleToExtra()
end
function c6000003.tetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6000003.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c6000003.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c6000003.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,nil,g,1,0,0)
end
function c6000003.teop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoExtraP(tc,nil,REASON_EFFECT)
	end
end