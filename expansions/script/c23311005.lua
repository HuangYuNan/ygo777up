--星空之神明
function c23311005.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,3,nil,nil,5)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23311005,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c23311005.con)
	e1:SetTarget(c23311005.mttg)
	e1:SetOperation(c23311005.mtop)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c23311005.con)
	e2:SetValue(aux.tgoval)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23311005,1))
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,0x1c0)
	e3:SetCountLimit(1)
	e3:SetCondition(c23311005.con)
	e3:SetCost(c23311005.cost)
	e3:SetTarget(c23311005.target)
	e3:SetOperation(c23311005.operation)
	e3:SetLabel(2)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23311005,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCondition(c23311005.spcon)
	e4:SetCost(c23311005.spcost)
	e4:SetTarget(c23311005.sptg)
	e4:SetOperation(c23311005.spop)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e4)
end
function c23311005.con(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311001) then ct=ct+1 end
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311002) then ct=ct+1 end
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311003) then ct=ct+1 end
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311004) then ct=ct+1 end
	return ct>e:GetLabel()
end
function c23311005.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return tp==Duel.GetTurnPlayer() 
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_DECK,0,1,nil,TYPE_PENDULUM) end
end
function c23311005.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_PENDULUM)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c23311005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c23311005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and aux.disfilter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.disfilter1,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,aux.disfilter1,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c23311005.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if ((tc:IsFaceup() and not tc:IsDisabled()) or tc:IsType(TYPE_TRAPMONSTER)) and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
		end
	end
end
function c23311005.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311001) then ct=ct+1 end
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311002) then ct=ct+1 end
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311003) then ct=ct+1 end
	if e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,23311004) then ct=ct+1 end
	return ct>3
end
function c23311005.filter(c,e,tp)
	return c:GetRank()>3 and e:GetHandler():CheckRemoveOverlayCard(tp,c:GetRank()-3,REASON_COST) and e:GetHandler():IsCanBeXyzMaterial(c)	and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c23311005.filter1(c,e,tp,i)
	return c:GetRank()==i and e:GetHandler():IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c23311005.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c23311005.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	local oc=c:GetOverlayCount()
	local t={}
	local i=1
	local p=1
	for i=1,oc do 
		if Duel.IsExistingMatchingCard(c23311005.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,i+3) then t[p]=i p=p+1 end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23311005,3))
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
	e:GetHandler():RemoveOverlayCard(tp,e:GetLabel(),e:GetLabel(),REASON_COST)
end
function c23311005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c23311005.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23311005.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23311005.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel()+3)
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end