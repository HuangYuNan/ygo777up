--比企谷小町
function c20152711.initial_effect(c)
c:SetUniqueOnField(1,0,20152711)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(c20152711.xyzfilter),4,2)
	c:EnableReviveLimit()
		--解放
	local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(20152711,0))
	e2:SetCategory(CATEGORY_RELEASE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20152711.damcost)
	e2:SetTarget(c20152711.damtg)
	e2:SetOperation(c20152711.damop)
	c:RegisterEffect(e2)
		--handes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152711,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c20152711.hdcon)
	e3:SetCost(c20152711.hdcost)
	e3:SetTarget(c20152711.hdtg)
	e3:SetOperation(c20152711.hdop)
	c:RegisterEffect(e3)
end
function c20152711.xyzfilter(c)
	return c:IsSetCard(0xc290)
end

function c20152711.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c20152711.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c20152711.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c20152711.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c20152711.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and eg:IsExists(c20152711.cfilter,1,nil,1-tp)
end
function c20152711.hdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152711.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND)
end
function c20152711.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(tp,1)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
