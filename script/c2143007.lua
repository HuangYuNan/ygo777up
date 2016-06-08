--月世界 翡翠
function c2143007.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c2143007.reptg)
	e2:SetValue(c2143007.repval)
	e2:SetOperation(c2143007.repop)
	c:RegisterEffect(e2)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetTarget(c2143007.tg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c2143007.rlevel)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2143007,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c2143007.shtg)
	e2:SetOperation(c2143007.shop)
	c:RegisterEffect(e2)
	--disable
	--local e1=Effect.CreateEffect(c)
	--e1:SetDescription(aux.Stringid(2143007,0))
	--e1:SetType(EFFECT_TYPE_QUICK_O)
	--e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	--e1:SetRange(LOCATION_MZONE)
	--e1:SetCost(c2143007.cost)
	--e1:SetOperation(c2143007.operation)
	--c:RegisterEffect(e1)
end
function c2143007.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsSetCard(0x213) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
function c2143007.tfilter(c)
	return c:IsSetCard(0x213) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:IsType(TYPE_PENDULUM) and not c:IsCode(2143007)
end
function c2143007.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2143007.tfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2143007.shop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2143007.tfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c2143007.tg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x213) and c:IsType(TYPE_RITUAL)
end
function c2143007.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsSetCard(0x213) and not c:IsReason(REASON_REPLACE)
end
function c2143007.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c2143007.filter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(2143007,1))
end
function c2143007.repval(e,c)
	return c2143007.filter(c,e:GetHandlerPlayer())
end
function c2143007.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
function c2143007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c2143007.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c2143007.atktg)
	e1:SetValue(c2143007.indval)
	e1:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e1,tp)
end
function c2143007.atktg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x213) and c:IsType(TYPE_SPELL)
end
function c2143007.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end