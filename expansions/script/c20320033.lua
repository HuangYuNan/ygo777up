function c20320033.initial_effect(c)
	--Activate
local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c20320033.cost)
	e1:SetTarget(c20320033.target)
	e1:SetOperation(c20320033.activate)
	c:RegisterEffect(e1)
end
function c20320033.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1500) end
	Duel.PayLPCost(tp,1500)
end
function c20320033.spfilter1(c,e,tp)
	return c:IsSetCard(0x280) and c:IsType(TYPE_DUAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20320033.spfilter2(c,e,tp)
	return c:IsSetCard(0x280) and c:IsType(TYPE_FLIP) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20320033.thfilter(c)
	return c:IsSetCard(0x280) and c:GetLevel()>0 and c:GetLevel()<7 and c:IsAbleToHand()
end
function c20320033.thdfilter(c,d)
	return c:IsSetCard(0x280) and c:GetLevel()==d and c:IsAbleToHand()
end
function c20320033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local sel=0
		if Duel.IsExistingMatchingCard(c20320033.spfilter1,tp,LOCATION_DECK,0,1,nil,e,tp) then sel=sel+1 end
		if Duel.IsExistingMatchingCard(c20320033.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp) then sel=sel+2 end
		e:SetLabel(sel)
		return sel~=0
	end
	local sel=e:GetLabel()
	if sel==3 then
		sel=Duel.SelectOption(tp,aux.Stringid(20320033,1),aux.Stringid(20320033,2))+1
	elseif sel==1 then
		Duel.SelectOption(tp,aux.Stringid(20320033,1))
	elseif sel==2 then
		Duel.SelectOption(tp,aux.Stringid(20320033,2))
	end
	e:SetLabel(sel)
	if sel==1 then
		local g=Duel.GetMatchingGroup(c20320033.spfilter1,tp,0,LOCATION_DECK,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	elseif sel==2 then
		local g=Duel.GetMatchingGroup(c20320033.spfilter2,tp,0,LOCATION_DECK,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
end
function c20320033.activate(e,tp,eg,ep,ev,re,r,rp)
	local sel=e:GetLabel()
	if sel==1 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c20320033.spfilter1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			local tc=g:GetFirst()
			tc:EnableDualState()
		end
	elseif sel==2 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c20320033.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
			local tc=g:GetFirst()
			Duel.BreakEffect()
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		end
	end
end