--紫电轰雷
function c23400012.initial_effect(c)
	c:EnableCounterPermit(0x1530,LOCATION_SZONE)
	c:SetCounterLimit(0x1530,3)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c23400012.ctcon)
	e2:SetOperation(c23400012.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--inactivatable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_INACTIVATE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetValue(c23400012.efilter)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetDescription(aux.Stringid(23400012,0))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCost(c23400012.drcost)
	e5:SetTarget(c23400012.drtg)
	e5:SetOperation(c23400012.drop)
	c:RegisterEffect(e5)
end
function c23400012.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	local ct=e:GetHandler():GetCounter(0x1530)
	e:SetLabel(ct)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c23400012.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetCounter(0x1530)>0 and Duel.IsPlayerCanDraw(tp,c:GetCounter(0x1530)) end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c23400012.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

--
function c23400012.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23400012.ctfilter,1,nil,tp)
end
function c23400012.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x1530,1)
end
function c23400012.ctfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x530) and c:IsControler(tp)
end
function c23400012.efilter(e,ct)
	local te=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT)
	local tc=te:GetHandler()
	return te:IsActiveType(TYPE_MONSTER) and tc:IsSetCard(0x530)
end