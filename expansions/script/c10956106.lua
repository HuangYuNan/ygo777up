--星占之巫女·忆·夜
function c10956106.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),aux.NonTuner(c10956106.sfilter),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10956106,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c10956106.drcon)
	e1:SetTarget(c10956106.sptg)
	e1:SetOperation(c10956106.spop)
	c:RegisterEffect(e1)
	--activate cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ACTIVATE_COST)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCost(c10956106.costchk)
	e2:SetOperation(c10956106.costop)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c10956106.distg)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,1)
	e4:SetValue(c10956106.aclimit)
	c:RegisterEffect(e4)  
end
function c10956106.cfilter(c,tp)
	local np=c:GetPosition()
	local pp=c:GetPreviousPosition()
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsControler(tp) and ((pp==0x1 and np==0x4) or (pp==0x4 and np==0x1))
end
function c10956106.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10956106.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10956102.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c10956106.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10956102.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c10956106.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10956106.cfilter,1,nil,tp)
end
function c10956106.sfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_SYNCHRO)
end
function c10956106.costchk(e,te_or_c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c10956106.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
function c10956106.distg(e,c)
	return c:GetSummonLocation()==LOCATION_GRAVE
end
function c10956106.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return loc==LOCATION_GRAVE and re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsImmuneToEffect(e)
end
