--扑克魔术 悠然的甜美
function c66612307.initial_effect(c)
	aux.AddFusionProcFun2(c,c66612307.filter1,c66612307.filter2,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c66612307.sprcon)
	e1:SetOperation(c66612307.sprop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(TIMING_BATTLE_PHASE,0x1c0+TIMING_BATTLE_PHASE)
	e2:SetTarget(c66612307.target)
	e2:SetOperation(c66612307.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c66612307.splimit)
	c:RegisterEffect(e3)
end
function c66612307.filter1(c)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab)
end
function c66612307.filter2(c)
	return (c:GetLevel()==1 or c:GetLevel()==5) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab)
end
function c66612307.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x3660)
end
function c66612307.spfilter1(c,tp,fc)
	return c:IsSetCard(0x660) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab) and c:IsFaceup() and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial(fc)
		and Duel.IsExistingMatchingCard(c66612307.spfilter2,tp,LOCATION_MZONE,0,1,c,fc)
end
function c66612307.spfilter2(c,fc)
	return (c:GetLevel()==1 or c:GetLevel()==5) and c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x16ab) and c:IsFaceup() and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c66612307.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c66612307.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function c66612307.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectMatchingCard(tp,c66612307.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp,c)
	local g2=Duel.SelectMatchingCard(tp,c66612307.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),c)
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	c:SetMaterial(g1)
	Duel.Remove(g1,nil,2,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c66612307.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c66612307.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c66612307.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c66612307.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c66612307.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end