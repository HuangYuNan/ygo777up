--希洛库玛
function c10950004.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c10950004.spcon)
	c:RegisterEffect(e1)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10950004,0))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,10950004)
	e3:SetOperation(c10950004.addc)
	c:RegisterEffect(e3)
	--spsummon limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e5:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetTarget(c10950004.sumlimit)
	c:RegisterEffect(e5)
end
function c10950004.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x231)
end
function c10950004.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		local ct=Duel.GetMatchingGroupCount(c10950004.cfilter,tp,LOCATION_MZONE,0,nil)
		e:GetHandler():AddCounter(0x13ac,ct)
	end
end
function c10950004.spfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x231) and c:IsType(TYPE_MONSTER)
end
function c10950004.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10950004.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c10950004.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLevelAbove(6) and not (c:IsSetCard(0x231) or c:IsSetCard(0xabb))
end