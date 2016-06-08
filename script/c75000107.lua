--神之曲 启示之章
function c75000107.initial_effect(c)
	c:SetUniqueOnField(1,0,75000107)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000107,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c75000107.cost)
	e2:SetTarget(c75000107.target)
	e2:SetOperation(c75000107.operation)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75000107,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c75000107.cost2)
	e3:SetOperation(c75000107.operation2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetCondition(c75000107.indcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c75000107.cfilter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c75000107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000107.cfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil) end
	local tg=Duel.SelectMatchingCard(tp,c75000107.cfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(tg,POS_FACEUP,REASON_COST)
end
function c75000107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c75000107.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c75000107.cfilter2(c,e,tp)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_XYZ) and c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(c75000107.sfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetRank())
end
function c75000107.sfilter(c,e,tp,m)
	return c:GetLevel()==m and c:IsSetCard(0x52f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75000107.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000107.cfilter2,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	local tg=Duel.SelectMatchingCard(tp,c75000107.cfilter2,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tc=tg:GetFirst()
	e:SetLabel(tc:GetRank())
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
end
function c75000107.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.SelectMatchingCard(tp,c75000107.sfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,e:GetLabel())
	if tc:GetCount()>0 then 
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c75000107.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x52f) and c:IsType(TYPE_SYNCHRO+TYPE_XYZ)
end
function c75000107.indcon(e)
	return Duel.IsExistingMatchingCard(c75000107.filter2,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end