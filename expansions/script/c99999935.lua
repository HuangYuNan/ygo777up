--传说之狂战士 赫拉克勒斯
function c99999935.initial_effect(c)
    c:EnableCounterPermit(0x1111)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(c99999935.synfilter),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	 --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11112003,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCountLimit(1,99999935+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c99999935.sptg)
	e1:SetOperation(c99999935.spop)
	c:RegisterEffect(e1)
    --must attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_EP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCondition(c99999935.becon)
	c:RegisterEffect(e3)
  --[[  --negate
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c99999935.discon)
	e4:SetCost(c99999935.discost)
	e4:SetTarget(c99999935.distg)
	e4:SetOperation(c99999935.disop)
	c:RegisterEffect(e4)]]--
	--only 1 can exists
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	e5:SetCondition(c99999935.excon)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e7)
	--[[--destroy replace
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_DESTROY_REPLACE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTarget(c99999935.reptg)
	c:RegisterEffect(e8)--]]
end
function c99999935.synfilter(c)
	return  c:IsSetCard(0x2e0) or c:IsSetCard(0x2e1)
end
function c99999935.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c99999935.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then 
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
--[[function c99999935.setg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99999935.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c99999935.seop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c99999935.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and tc:IsSSetable()
			and (not tc:IsAbleToHand() or Duel.SelectYesNo(tp,aux.Stringid(999997,7))) then
			Duel.SSet(tp,tc)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
end
     c:AddCounter(0x1111,11)
end]]--
function c99999935.becon(e)
	return e:GetHandler():IsAttackable()
end
--[[function c99999935.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(c) and Duel.IsChainNegatable(ev)
end
function c99999935.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1111,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1111,1,REASON_COST)
end
function c99999935.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c99999935.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end]]--
function c99999935.exfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x92e0)  and c:IsType(TYPE_SYNCHRO)
end
function c99999935.excon(e)
	return Duel.IsExistingMatchingCard(c99999935.exfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
--[[function c99999935.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCounter(tp,LOCATION_ONFIELD,0,0x1111)>0  and not e:GetHandler():IsReason(REASON_RULE) end
	if Duel.SelectYesNo(tp,aux.Stringid(999997,6)) then
		Duel.RemoveCounter(tp,LOCATION_ONFIELD,0,0x1111,1,REASON_EFFECT)
		return true
	else return false end
end]]--