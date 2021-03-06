--第七小队的相绊
function c11113023.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
    --to pzone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113023,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,11113023)
	e2:SetCost(c11113023.cost)
	e2:SetTarget(c11113023.target)
	e2:SetOperation(c11113023.operation)
	c:RegisterEffect(e2)
end
function c11113023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c11113023.mvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsType(TYPE_PENDULUM)
end
function c11113023.spfilter(c,e,tp)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11113023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=(Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) and Duel.IsExistingMatchingCard(c11113023.mvfilter,tp,LOCATION_EXTRA+LOCATION_REMOVED,0,1,nil)
	local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c11113023.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(11113023,1),aux.Stringid(11113023,2))
	elseif b1 then op=Duel.SelectOption(tp,aux.Stringid(11113023,1))
	else op=Duel.SelectOption(tp,aux.Stringid(11113023,2))+1 end
	e:SetLabel(op)
	if opt==0 then
		e:SetProperty(0)
	else
        e:SetCategory(CATEGORY_SPECIAL_SUMMON)		
    end
end
function c11113023.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetLabel()==0 then
	    if not (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then return end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11113023,3))
		local g=Duel.SelectMatchingCard(tp,c11113023.mvfilter,tp,LOCATION_REMOVED+LOCATION_EXTRA,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	else
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c11113023.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end