--神之曲 歌姬阿加提
function c75000073.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x52f),3,2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c75000073.cost)
	e1:SetTarget(c75000073.target)
	e1:SetOperation(c75000073.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c75000073.con)
	e2:SetTarget(c75000073.tg)
	e2:SetOperation(c75000073.op)
	c:RegisterEffect(e2)
end
function c75000073.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75000073.filter(c,e,tp)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_MONSTER)
end
function c75000073.filter2(c,e,tp)
	return c:IsSetCard(0x52f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(3)
end
function c75000073.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000073.filter,tp,LOCATION_REMOVED,0,1,nil) or (Duel.IsExistingMatchingCard(c75000073.filter2,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function c75000073.operation(e,tp,eg,ep,ev,re,r,rp)
	local off=1
	local ops={}
	local opval={}
	if Duel.IsExistingMatchingCard(c75000073.filter,tp,LOCATION_REMOVED,0,1,nil) then
		ops[off]=aux.Stringid(75000073,0)
		opval[off-1]=1
		off=off+1
	end
	if Duel.IsExistingMatchingCard(c75000073.filter2,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		ops[off]=aux.Stringid(75000073,1)
		opval[off-1]=2
		off=off+1
	end
	if off==1 then return end
	local op=Duel.SelectOption(tp,table.unpack(ops))
	if opval[op]==1 then
		local sh1=Duel.SelectMatchingCard(tp,c75000073.filter,tp,LOCATION_REMOVED,0,1,1,nil)
		if sh1:GetCount()>0 then
			Duel.SendtoHand(sh1,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sh1)
		end
	elseif opval[op]==2 then
		local sg1=Duel.SelectMatchingCard(tp,c75000073.filter2,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil,e,tp)
		if sg1:GetCount()>0 then
			Duel.SpecialSummon(sg1,nil,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c75000073.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp 
end
function c75000073.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingTarget(nil,tp,0,LOCATION_EXTRA,1,e:GetHandler()) end
end
function c75000073.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_EXTRA,nil)
	local sg=g:RandomSelect(tp,1)
	local c=e:GetHandler()
	if sg:GetCount()>0 then
		Duel.Overlay(c,sg)
	end
end