--命运扑克魔术 梦色爱丽丝
function c66612325.initial_effect(c)
	aux.AddFusionProcFun2(c,c66612325.filter1,c66612325.filter2,false)
	c:SetUniqueOnField(1,0,66612325)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c66612325.filter)
	e1:SetValue(c66612325.tgval)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c66612325.splimit)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ADD_CODE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(19910004)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c66612325.excon)
	e4:SetTarget(c66612325.extg)
	e4:SetOperation(c66612325.exop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c66612325.postg)
	e5:SetOperation(c66612325.posop)
	c:RegisterEffect(e5)
end
function c66612325.filter1(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_FUSION)
end
function c66612325.filter2(c)
	return c:IsSetCard(0x666) and (c:IsType(TYPE_XYZ) or c:IsType(TYPE_SYNCHRO))
end
function c66612325.filter(c)
	return c:IsSetCard(0x660) and c:IsSetCard(0x666)
end
function c66612325.tgval(e,re,rp)
	local tp=e:GetHandler():GetControler()
	return tp~=rp and aux.tgval(e,re,rp)
end

function c66612325.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c66612325.excon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp
end
function c66612325.extg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.disfilter1,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c66612325.exop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.disfilter1,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c66612325.posfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c66612325.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(c66612325.posfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c66612325.posfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c66612325.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end