--战场女武神 达哈尔
function c11113036.initial_effect(c)
	c:SetUniqueOnField(1,0,11113036)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x15c),aux.NonTuner(Card.IsType,TYPE_PENDULUM),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11113036,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c11113036.discon)
	e1:SetCost(c11113036.discost)
	e1:SetTarget(c11113036.distg)
	e1:SetOperation(c11113036.disop)
	c:RegisterEffect(e1)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113036,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCondition(c11113036.rtcon)
	e2:SetTarget(c11113036.rttg)
	e2:SetOperation(c11113036.rtop)
	c:RegisterEffect(e2)
end
function c11113036.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsAbleToDeckAsCost()
end
function c11113036.discon(e,tp,eg,ep,ev,re,r,rp)
   return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c11113036.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11113036.cfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c11113036.cfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.HintSelection(g)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c11113036.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToRemove() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c11113036.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
function c11113036.rtcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c11113036.rtfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x15c) and not c:IsCode(11113036)
end	
function c11113036.rttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c11113036.rtfilter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
	    and Duel.IsExistingTarget(c11113036.rtfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11113036,2))
	local g=Duel.SelectTarget(tp,c11113036.rtfilter,tp,LOCATION_REMOVED,0,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c11113036.rtop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 and Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)~=0 then
	    Duel.Draw(tp,1,REASON_EFFECT)
	end
end