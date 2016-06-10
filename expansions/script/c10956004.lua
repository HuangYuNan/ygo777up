--必杀代号O·S·S
function c10956004.initial_effect(c)
	--attack up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10956004,0))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCountLimit(1,10956004)
	e2:SetCondition(c10956004.actcon)
	e2:SetTarget(c10956004.hdtg)
	e2:SetOperation(c10956004.op)
	c:RegisterEffect(e2)
	--revive 
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10956004,0))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c10956004.cost)
	e3:SetTarget(c10956004.tg2)
	e3:SetOperation(c10956004.op2)
	c:RegisterEffect(e3)	  
end
function c10956004.spfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_SYNCHRO)
end
function c10956004.actcon(e)
	return Duel.IsExistingMatchingCard(c10956004.spfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c10956004.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c10956004.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
end
function c10956004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c10956004.filter2(c)
	return c:IsCode(10956004) and c:IsAbleToHand()
end
function c10956004.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10956004.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10956004.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10956004.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
