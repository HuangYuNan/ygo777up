--元素精灵·崔缇伦
function c37564023.initial_effect(c)
--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564023,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,37564023)
	e1:SetCondition(c37564023.drcon)
	e1:SetTarget(c37564023.drtg)
	e1:SetOperation(c37564023.drop)
	c:RegisterEffect(e1)
--xm
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,37564023)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c37564023.cost)
	e2:SetTarget(c37564023.target)
	e2:SetOperation(c37564023.operation)
	c:RegisterEffect(e2)
end
function c37564023.drfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x770) and c:IsType(TYPE_MONSTER) and (not c:IsCode(37564023))
end
function c37564023.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c37564023.drfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil) and e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,REASON_DISCARD)~=0
end
function c37564023.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c37564023.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c37564023.costfilter(c)
	return c:IsSetCard(0x770) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and (not c:IsCode(37564023))
end
function c37564023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37564023.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c37564023.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37564023.filter1(c)
	return c:IsFaceup() and c:GetRank()==4 and c:IsType(TYPE_XYZ)
end
function c37564023.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c37564023.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37564023.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c37564023.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c37564023.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
