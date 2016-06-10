--绝剑•优纪
function c20152637.initial_effect(c)
c:SetUniqueOnField(1,1,20152637)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),8,5,c20152637.ovfilter,aux.Stringid(20152637,0),5,nil)
	c:EnableReviveLimit()
		--Atk update
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c20152637.condition)
	e1:SetValue(c20152637.atkval)
	c:RegisterEffect(e1)
			--activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,20152637+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c20152637.condition)
	e2:SetCost(c20152637.cost2)
	e2:SetTarget(c20152637.tg)
	e2:SetOperation(c20152637.op)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c) e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1) e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c20152637.negcon)
	e3:SetCost(c20152637.negcost)
	e3:SetTarget(c20152637.negtg)
	e3:SetOperation(c20152637.negop)
	c:RegisterEffect(e3)
	--return
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20152637,0))
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c20152637.condition)
	e4:SetCost(c20152637.reccost)
	e4:SetTarget(c20152637.rectg)
	e4:SetOperation(c20152637.recop)
	c:RegisterEffect(e4)
	--immune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetCondition(c20152637.condition)
	e5:SetValue(c20152637.efilter)
	c:RegisterEffect(e5)
end
function c20152637.ovfilter(c)
	return (c:IsCode(20152612) or c:IsCode(20152607)) and c:IsFaceup()
end
function c20152637.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c20152637.condition(e,c)
	local tp=e:GetHandler():GetControler()
	return Duel.GetLP(tp)<=1000
end
function c20152637.atkval(e,c)
	local cont=c:GetControler()
	if Duel.GetLP(cont)>=Duel.GetLP(1-cont) then
	return Duel.GetLP(cont)-Duel.GetLP(1-cont) else return Duel.GetLP(1-cont)-Duel.GetLP(cont)
	end 
end
function c20152637.negcon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandler():GetControler()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and Duel.GetLP(tp)<=1000
end
function c20152637.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20152637.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
end
end
function c20152637.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
function c20152637.filter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xa290) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20152637.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)>100 end
	Duel.PayLPCost(tp,Duel.GetLP(tp)-100)
end
function c20152637.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c20152637.filter2,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c20152637.op(e,tp,eg,ep,ev,re,r,rp)
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20152637.filter2,tp,LOCATION_REMOVED,0,ft1,ft1,nil,e,tp)
	if g:GetCount()>0 then
		local fid=e:GetHandler():GetFieldID()
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(20152637,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
		g:KeepAlive()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCountLimit(1)
		e2:SetLabel(fid)
		e2:SetLabelObject(g)
		e2:SetCondition(c20152637.rmcon)
		e2:SetOperation(c20152637.rmop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c20152637.rmfilter2(c,fid)
	return c:GetFlagEffectLabel(20152637)==fid
end
function c20152637.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c20152637.rmfilter2,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c20152637.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c20152637.rmfilter2,nil,e:GetLabel())
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
end
function c20152637.reccost(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end 
function c20152637.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c20152637.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
