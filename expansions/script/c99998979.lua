--封印指定执行者 巴泽特
function c99998979.initial_effect(c)
	c:SetUniqueOnField(1,0,99998979)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_PENDULUM),7,2,c99998979.ovfilter,aux.Stringid(99991098,12),2,c99998979.xyzop)
	c:EnableReviveLimit()
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCondition(c99998979.con)
	e1:SetTarget(c99998979.tg)
	e1:SetOperation(c99998979.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99991095,6))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1e0)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(c99998979.cost)
	e2:SetTarget(c99998979.tg)
	e2:SetOperation(c99998979.op)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(c99998979.ind)
	c:RegisterEffect(e3)
	--negate
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(99991095,7))
	e5:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e5:SetCode(EVENT_CHAINING)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetCountLimit(1)
	e5:SetCondition(c99998979.negcon)
	e5:SetCost(c99998979.negcost)
	e5:SetTarget(c99998979.negtg)
	e5:SetOperation(c99998979.negop)
	c:RegisterEffect(e5)
	--pierce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e6)
	--add setcode
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetCode(EFFECT_ADD_SETCODE)
	e7:SetValue(0x213)
	c:RegisterEffect(e7)
end
function c99998979.disfilter(c)
    return  c:IsType(TYPE_SPELL) and c:IsType(TYPE_EQUIP) and c:IsDiscardable()
end
function c99998979.ovfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x2e0) or c:IsSetCard(0x2e1))
	and c:IsRace(RACE_WARRIOR) and c:IsType(TYPE_SYNCHRO)
end
function c99998979.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99998979.disfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c99998979.disfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c99998979.con(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c99998979.filter(c)
	return  c:IsCode(99998978) and (c:IsAbleToHand() or c:IsAbleToDeck())
end
function c99998979.tg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c99998979.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
end
function c99998979.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c99998979.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if (not tc:IsAbleToDeck() or Duel.SelectYesNo(tp,aux.Stringid(999999,2))) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
		end
	end
end
function c99998979.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c99998979.ind(e,re,tp)
	return  re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and  e:GetHandlerPlayer()==1-tp
end
function c99998979.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:GetHandler():IsControler(1-tp)
		and (re:IsActiveType(TYPE_EUIP) or re:GetActiveType()==TYPE_SPELL+TYPE_CONTINUOUS or (re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsSummonableCard())) and Duel.IsChainNegatable(ev)
end
function c99998979.cfilter(c)
	return c:IsCode(99998978) and c:IsAbleToGraveAsCost()
end
function c99998979.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingMatchingCard(c99998979.cfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,0,1,nil)  end
	local g=Duel.SelectMatchingCard(tp,c99998979.cfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c99998979.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToRemove() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
	Duel.SetChainLimit(c99998979.chlimit)
end
function c99998979.chlimit(e,ep,tp)
	return tp==ep
end
function c99998979.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SelectOption(tp,aux.Stringid(99991095,7))
	Duel.SelectOption(1-tp,aux.Stringid(99991095,7))
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e:GetHandler():RegisterEffect(e1)
	end
end