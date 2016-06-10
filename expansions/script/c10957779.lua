--Miracle·Honest
function c10957779.initial_effect(c)
	c:SetSPSummonOnce(10957779)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(1160)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCondition(c10957779.condition)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(10957779,0))
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c10957779.condtion2)
	e1:SetTarget(c10957779.target)
	e1:SetOperation(c10957779.operation)
	c:RegisterEffect(e1) 
	--sp	
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10957779,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,10957779)
	e2:SetCost(c10957779.cost)
	e2:SetCondition(c10957779.spcon)
	e2:SetTarget(c10957779.tg)
	e2:SetOperation(c10957779.op)
	c:RegisterEffect(e2)
	--xyzlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetValue(c10957779.xyzlimit)
	c:RegisterEffect(e3)
	--redirect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetCondition(c10957779.recon)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)  
	--special summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10957779,0))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_PZONE)
	e6:SetCountLimit(1,10957779)
	e6:SetTarget(c10957779.sptg2)
	e6:SetOperation(c10957779.spop2)
	c:RegisterEffect(e6)	   
end
function c10957779.cfilter(c)
	return c:IsSetCard(0x239) and c:IsType(TYPE_PENDULUM)
end
function c10957779.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10957779.cfilter,0,LOCATION_EXTRA,0,2,nil)
end
function c10957779.condtion2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10957779.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10957779.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c10957779.xyzlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_FAIRY)
end
function c10957779.recon(e)
	return e:GetHandler():IsLocation(LOCATION_PZONE)
end
function c10957779.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTORY,nil,1,tp,LOCATION_DECK)
end
function c10957779.spop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.Destroy(g,REASON_EFFECT)
end
function c10957779.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c10957779.spcon(e)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c10957779.spfilter(c,e,tp)
	return c:IsSetCard(0x239) and c:IsAttackBelow(2000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10957779.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c10957779.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c10957779.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10957779.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
