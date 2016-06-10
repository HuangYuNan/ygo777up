--罗星 摩羯座
function c10952422.initial_effect(c)
	c:EnableReviveLimit()
	c:SetSPSummonOnce(10952422)
	--cannot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c10952422.spcon)
	e0:SetOperation(c10952422.spop2)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10952422,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c10952422.cost)
	e1:SetTarget(c10952422.target)
	e1:SetOperation(c10952422.operation)
	c:RegisterEffect(e1)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
end
function c10952422.spfilter(c)
	return c:IsSetCard(0x233) and c:IsLevelBelow(2) and c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c10952422.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x232)
end
function c10952422.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()   
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 
	and Duel.IsExistingMatchingCard(c10952422.spfilter2,tp,LOCATION_MZONE,0,1,nil) then return Duel.IsExistingMatchingCard(c10952422.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) 
end
end
function c10952422.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10952422.spfilter,c:GetControler(),LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST) 
end
function c10952422.filter(c)
	return c:IsSetCard(0x233) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_FUSION) and c:IsAbleToDeckAsCost()
end
function c10952422.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10952422.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c10952422.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c10952422.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10952422.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
