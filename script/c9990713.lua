--Westvale Abbey
require "expansions/script/c9990000"
function c9990713.initial_effect(c)
	Dazz.DFCFrontsideCommonEffect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9990713,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,9990713)
	e2:SetTarget(c9990713.target)
	e2:SetOperation(c9990713.operation)
	c:RegisterEffect(e2)
	--Transform
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(9990713,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,9990713)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetOriginalCode()==9990713 and Duel.GetTurnCount()>4
	end)
	e3:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.CheckReleaseGroup(tp,nil,5,nil) end
		local rg=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
		Duel.Release(rg,REASON_COST)
	end)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Dazz.DFCTransformable(c,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Dazz.DFCTransformable(c,tp) then
			Duel.SendtoGrave(c,REASON_RULE)
			return
		end
		local token=Dazz.DFCTransformExecute(c)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end)
	c:RegisterEffect(e3)
end
function c9990713.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,9990715,0,0x4011,500,500,1,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c9990713.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,9990715,0,0x4011,500,500,1,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,9990715)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end