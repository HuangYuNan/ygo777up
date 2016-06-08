--深渊之血魔
function c23311007.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_PENDULUM),2)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23311007,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c23311007.con)
	e1:SetTarget(c23311007.mttg)
	e1:SetOperation(c23311007.mtop)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	-- battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c23311007.con)
	e2:SetValue(1)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	-- destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23311007,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c23311007.con)
	e3:SetCost(c23311007.descost)
	e3:SetTarget(c23311007.destg)
	e3:SetOperation(c23311007.desop)
	e3:SetLabel(2)
	c:RegisterEffect(e3)
	-- spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23311007,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCondition(c23311007.spcon)
	e4:SetCost(c23311007.spcost)
	e4:SetTarget(c23311007.sptg)
	e4:SetOperation(c23311007.spop)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e4)
end
function c23311007.con(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311001) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311002) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311003) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311004) then ct=ct+1 end
	return ct>e:GetLabel()
end
function c23311007.tgfilter(c)
	return c:IsType(TYPE_PENDULUM)
end
function c23311007.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return tp==Duel.GetTurnPlayer() 
		and Duel.IsExistingMatchingCard(c23311007.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c23311007.mtop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23311007,4))
	local g=Duel.SelectMatchingCard(tp,c23311007.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoExtraP(g,nil,REASON_EFFECT)
	end
end
function c23311007.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToGraveAsCost()
end
function c23311007.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23311007.cfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c23311007.cfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c23311007.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c23311007.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c23311007.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311001) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311002) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311003) then ct=ct+1 end
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,23311004) then ct=ct+1 end
	return ct>3
end
function c23311007.filter(c,e,tp)
	return c:GetLevel()>3 and Duel.IsExistingMatchingCard(c23311007.cfilter,tp,LOCATION_EXTRA,0,c:GetLevel()-3,nil)
		and c:IsType(TYPE_SYNCHRO) and e:GetHandler():IsAbleToGrave()
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c23311007.filter1(c,e,tp,i)
	return c:GetLevel()==i and e:GetHandler():IsAbleToGrave() and c:IsType(TYPE_SYNCHRO)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c23311007.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c23311007.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	local oc=Duel.GetMatchingGroupCount(c23311007.cfilter,tp,LOCATION_EXTRA,0,nil)
	local t={}
	local i=1
	local p=1
	for i=1,oc do 
		if Duel.IsExistingMatchingCard(c23311007.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,i+3) then t[p]=i p=p+1 end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23311007,3))
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
	local g=Duel.SelectMatchingCard(tp,c23311007.cfilter,tp,LOCATION_EXTRA,0,e:GetLabel(),e:GetLabel(),nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c23311007.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c23311007.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23311007.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.SendtoGrave(c,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23311007.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel()+3)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
end