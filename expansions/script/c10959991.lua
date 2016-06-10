--堕眠
function c10959991.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c10959991.cost)
	e1:SetTarget(c10959991.target)
	e1:SetOperation(c10959991.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(800)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_GRAVE,0)
	e3:SetTarget(c10959991.disable)
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10959991,0))
	e4:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c10959991.target)
	e4:SetOperation(c10959991.operation)
	c:RegisterEffect(e4)	
end
function c10959991.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,3,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,3,3,REASON_COST+REASON_DISCARD)
end
function c10959991.filter(c,e,tp)
	return c:IsLevelBelow(5) and c:IsSummonableCard() and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10959991.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c10959991.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c10959991.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if not Duel.IsPlayerCanSpecialSummon(tp) or not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	local g=Duel.GetMatchingGroup(c10959991.filter,tp,LOCATION_DECK,0,nil,e,tp)
	local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local seq=-1
	local tc=g:GetFirst()
	local spcard=nil
	while tc do
		if tc:GetSequence()>seq then 
			seq=tc:GetSequence()
			spcard=tc
		end
		tc=g:GetNext()
	end
	if seq==-1 then
		Duel.ConfirmDecktop(tp,dcount)
		Duel.ShuffleDeck(tp)
		return
	end
	Duel.ConfirmDecktop(tp,dcount-seq)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and spcard:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.DisableShuffleCheck()
		if dcount-seq==1 then Duel.SpecialSummon(spcard,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SpecialSummonStep(spcard,0,tp,tp,false,false,POS_FACEUP)
			Duel.DiscardDeck(tp,dcount-seq-1,REASON_EFFECT)
			Duel.SpecialSummonComplete()
		end
	else
		Duel.DiscardDeck(tp,dcount-seq,REASON_EFFECT)
	end
end
function c10959991.disable(e,c)
	return c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end