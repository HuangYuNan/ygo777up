--神天竜－サンダー
require "expansions/script/c9990000"
function c9991204.initial_effect(c)
	Dazz.GodraMainCommonEffect(c)
	--Special Summon From Removed
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,19991204)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9991204.spfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,e,tp) end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c9991204.spfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
			g:GetFirst():CompleteProcedure()
		end
	end)
	c:RegisterEffect(e1)
	--Fuck Monster
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(0xfe)
	e2:SetCountLimit(1,29991204)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg and eg:IsExists(function(c,mc)
			local mg=c:GetMaterial()
			return mg and mg:IsContains(mc) and Dazz.IsGodra(c) and bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		end,1,nil,e:GetHandler())
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetMatchingGroupCount(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)~=0 end
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		if sg and sg:GetCount()~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local rg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(rg)
			Duel.Destroy(rg,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e2)
end
c9991204.Dazz_name_godra=true
function c9991204.spfilter(c,e,tp)
	return c:IsFaceup() and Dazz.IsGodra(c) and not c:IsCode(9991204) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end