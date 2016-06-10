--Miracle·Silent Lake
function c10957781.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10957781.thcost)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10957781,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1)
	e2:SetCondition(c10957781.drcon)
	e2:SetTarget(c10957781.drtg)
	e2:SetOperation(c10957781.drop)
	c:RegisterEffect(e2)
	--cannot activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c10957781.actcon)
	e3:SetValue(c10957781.actlimit)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_HANDES)
	e4:SetDescription(aux.Stringid(10957781,0))
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c10957781.condtion)
	e4:SetCountLimit(1,10957781)
	e4:SetTarget(c10957781.target2)
	e4:SetOperation(c10957781.operation)
	c:RegisterEffect(e4)	   
end
function c10957781.dfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x239)
end
function c10957781.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957781.dfilter,tp,LOCATION_EXTRA,0,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10957781.dfilter,tp,LOCATION_EXTRA,0,2,2,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c10957781.spfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c10957781.actcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c10957781.spfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c10957781.spfilter,tp,LOCATION_MZONE,1,nil)
end
function c10957781.actlimit(e,te,tp)
	return te:IsActiveType(TYPE_TRAP)
end
function c10957781.cfilter(c,tp)
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_DECK) and c:GetPreviousControler()==tp
end
function c10957781.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10957781.cfilter,1,nil,tp)
end
function c10957781.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10957781.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c10957781.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10957781.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c10957781.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
