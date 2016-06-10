--非统一魔法世界论
function c1000413.initial_effect(c)
	c:SetUniqueOnField(1,0,1000413)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1000413)
	c:RegisterEffect(e1)
	--adjust
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c1000413.adjustop)
	c:RegisterEffect(e2)
	--cannot activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(1,1)
	e3:SetLabel(0)
	e3:SetValue(c1000413.actlimit)
	c:RegisterEffect(e3)
	e2:SetLabelObject(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(aux.exccon)
	e4:SetCost(c1000413.thcost)
	e4:SetTarget(c1000413.thtg)
	e4:SetOperation(c1000413.thop)
	c:RegisterEffect(e4)
end
function c1000413.actlimit(e,te,tp)
	if not te:IsHasType(EFFECT_TYPE_ACTIVATE) or not te:IsActiveType(TYPE_SPELL) then return false end
	if tp==e:GetHandlerPlayer() then return e:GetLabel()==1
	else return e:GetLabel()==2 end
end
function c1000413.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c1000413.adjustop(e,tp,eg,ep,ev,re,r,rp)
	local b1=Duel.IsExistingMatchingCard(c1000413.filter,tp,LOCATION_MZONE,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(c1000413.filter,tp,0,LOCATION_MZONE,1,nil)
	local te=e:GetLabelObject()
	if not b1 then te:SetLabel(1)
	elseif b1 and not b2 then te:SetLabel(2)
	else te:SetLabel(0) end
end
function c1000413.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1000413.filter1(c)
	return c:IsSetCard(0xa201) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c1000413.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000413.filter1,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function c1000413.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1000413.filter1,tp,LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end