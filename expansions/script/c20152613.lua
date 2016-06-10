--SAO•莉兹贝特
function c20152613.initial_effect(c)
	c:SetUniqueOnField(1,1,20152613)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,c20152613.ovfilter,aux.Stringid(20152613,7),3,nil)
	c:EnableReviveLimit()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152613,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c20152613.condition2)
	e1:SetCost(c20152613.cost2)
	e1:SetTarget(c20152613.target2)
	e1:SetOperation(c20152613.operation2)
	c:RegisterEffect(e1)
	--disable attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152613,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCost(c20152613.atkcost)
	e2:SetOperation(c20152613.atkop)
	c:RegisterEffect(e2)
end
function c20152613.ovfilter(c)
	return c:IsCode(20152605) and c:IsFaceup()
end
function c20152613.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,20152605)
end
function c20152613.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e2,true)
end
function c20152613.filter2(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end
function c20152613.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20152613.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20152613.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20152613.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c20152613.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152613.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
