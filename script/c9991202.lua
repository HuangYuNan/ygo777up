--神天竜－トルネード
require "expansions/script/c9990000"
function c9991202.initial_effect(c)
	Dazz.GodraMainCommonEffect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,19991202)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.CheckReleaseGroup(tp,function(c) return c:IsRace(RACE_WYRM) end,1,nil) end
		local sg=Duel.SelectReleaseGroup(tp,function(c) return c:IsRace(RACE_WYRM) end,1,1,nil)
		Duel.Release(sg,REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9991202.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c9991202.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
			g:GetFirst():CompleteProcedure()
		end
	end)
	c:RegisterEffect(e1)
	--Fuck Spell & Trap
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(0xfe)
	e2:SetCountLimit(1,29991202)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg and eg:IsExists(function(c,mc)
			local mg=c:GetMaterial()
			return mg and mg:IsContains(mc) and Dazz.IsGodra(c) and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		end,1,nil,e:GetHandler())
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local sg=Duel.GetMatchingGroup(c9991202.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if chk==0 then return sg:GetCount()>=1 end
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(c9991202.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end)
	c:RegisterEffect(e2)
end
c9991202.Dazz_name_godra=true
function c9991202.filter(c,e,tp)
	return Dazz.IsGodra(c) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c9991202.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end