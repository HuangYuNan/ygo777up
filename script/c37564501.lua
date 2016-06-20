--Dokkin
require "expansions/script/c37564765"
function c37564501.initial_effect(c)
	senya.nnhr(c)
	aux.AddXyzProcedure(c,c37564501.mfilter,7,2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83986578,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCountLimit(1,37560501)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c37564501.condition)
	e1:SetTarget(c37564501.target)
	e1:SetOperation(c37564501.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564501,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,37561501)
	e2:SetTarget(c37564501.xmtg)
	e2:SetOperation(c37564501.xmop)
	c:RegisterEffect(e2)
end
function c37564501.mfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c37564501.cfilter(c)
	return c:IsFaceup() and c:GetFlagEffect(37564501)==0 and not c:IsType(TYPE_TOKEN)
end
function c37564501.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c37564501.cfilter,1,nil) and not eg:IsContains(e:GetHandler())
end
function c37564501.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ) end
	local g=eg:Filter(c37564501.cfilter,nil)
	Duel.SetTargetCard(eg)
end
function c37564501.filter(c,e)
	return c:IsFaceup() and c:GetFlagEffect(37564501)==0 and c:IsRelateToEffect(e)
end
function c37564501.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c37564501.filter,nil,e)
	if g:GetFirst():GetOverlayCount()>0 then Duel.SendtoGrave(g:GetFirst():GetOverlayGroup(),REASON_RULE) end
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c37564501.ssfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,true) and c:GetOwner()==1-tp
end
function c37564501.xmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():GetOverlayGroup():IsExists(c37564501.ssfilter,1,nil,e,tp) and e:GetHandler():IsType(TYPE_XYZ) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_MZONE)
end
function c37564501.xmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local gg=c:GetOverlayGroup()
	if not (c:IsRelateToEffect(e) and gg:IsExists(c37564501.ssfilter,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0) then return end
	local sg=gg:FilterSelect(tp,c37564501.ssfilter,1,1,nil,e,tp):GetFirst()
	if sg and Duel.SpecialSummonStep(sg,0,tp,tp,true,true,POS_FACEUP) then
		sg:RegisterFlagEffect(37564501,RESET_EVENT+0x1fe0000,0,1)
		Duel.SpecialSummonComplete()
	end
end