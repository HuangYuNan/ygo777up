--Syura
function c20320017.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE) 
	e2:SetLabel(0)
	e2:SetCost(c20320017.cost)
	e2:SetTarget(c20320017.thtg)
	e2:SetOperation(c20320017.thop)
	c:RegisterEffect(e2)
end
function c20320017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c20320017.cfilter(c,e,tp)
	local lv=c:GetLevel()
	return c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_NORMAL) and lv>0 and Duel.IsExistingMatchingCard(c20320017.spfilter,tp,LOCATION_EXTRA,0,1,nil,lv-1,e,tp)
end
function c20320017.spfilter(c,lv,e,tp)
	return c:GetLevel()==lv and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsFaceup()
end
function c20320017.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.CheckReleaseGroup(tp,c20320017.cfilter,1,nil,e,tp)
	end
	local rg=Duel.SelectReleaseGroup(tp,c20320017.cfilter,1,1,nil,e,tp)
	e:SetLabel(rg:GetFirst():GetLevel())
	Duel.Release(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c20320017.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local lv=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c20320017.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,lv-1,e,tp)
	g:AddCard(c)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end