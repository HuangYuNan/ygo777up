--效果樱
function c37564105.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564105,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c37564105.con)
	e2:SetCost(c37564105.cost)
	e2:SetTarget(c37564105.target)
	e2:SetOperation(c37564105.operation)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1,37564105)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c37564105.discon)
	e3:SetTarget(c37564105.distg)
	e3:SetOperation(c37564105.disop)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564105,1))
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c37564105.condition)
	e4:SetTarget(c37564105.thtg)
	e4:SetOperation(c37564105.thop)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c37564105.spcon)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c37564105.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x772) and c:IsType(TYPE_MONSTER)
end
function c37564105.con(e,c)
	return Duel.IsExistingMatchingCard(c37564105.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c37564105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeckAsCost() end
	Duel.SendtoDeck(c,nil,2,REASON_COST)
end
function c37564105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c37564105.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c37564105.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:GetCode()==SUMMON_TYPE_ADVANCE and Duel.IsChainNegatable(ev)
end
function c37564105.filter(c,e,tp)
	return c:IsSetCard(0x772) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c37564105.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c37564105.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37564105.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
	local g=Duel.SelectTarget(tp,c37564105.filter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	end
end
function c37564105.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local tc=Duel.GetFirstTarget()
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
function c37564105.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c37564105.tfilter(c,e,tp)
	return c:IsCode(37564101)
end
function c37564105.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingMatchingCard(c37564105.tfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37564105.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.Destroy(c,REASON_EFFECT)==0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564105.tfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
	   Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	   tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	end
end
function c37564105.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(37564105)>0
end