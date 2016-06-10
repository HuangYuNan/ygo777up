--虹之转变
function c1000073.initial_effect(c)
	c:SetUniqueOnField(1,0,1000073)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c1000073.target1)
	e1:SetOperation(c1000073.operation)
	c:RegisterEffect(e1)
	--加上虹纹1次通常召唤，这个方法成功给指示物
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1000073,3))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,10000731)
	e2:SetCost(c1000073.cost)
	e2:SetTarget(c1000073.target3)
	e2:SetOperation(c1000073.operation3)
	c:RegisterEffect(e2)
	--②：检索加入手卡或特招
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1000073,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMING_END_PHASE)
	e3:SetCountLimit(1,10000732)
	e3:SetCost(c1000073.cost2)
	e3:SetTarget(c1000073.target2)
	e3:SetOperation(c1000073.operation)
	e3:SetLabel(1)
	c:RegisterEffect(e3)
end
function c1000073.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.GetFlagEffect(tp,1000073)==0 end
	Duel.RegisterFlagEffect(tp,1000073,RESET_PHASE+PHASE_END,0,1)
	Duel.PayLPCost(tp,1000)
end
function c1000073.filter(c,e,sp)
	return c:IsSetCard(0x200) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c1000073.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1000073.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c1000073.operation3(e,tp,eg,ep,ev,re,r,rp)
	--if e:GetHandler():GetFlagEffect(1000073)==0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1000073.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,SUMMON_TYPE_NORMAL,tp,tp,false,false,POS_FACEUP)
	end
end
function c1000073.afilter(c)
	return c:IsSetCard(0x3200) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c1000073.dfilter(c)
	return not c:IsFaceup() or not c:IsType(TYPE_MONSTER) or not c:IsSetCard(0x200)
end
function c1000073.cfilter(c)
	return c:IsSetCard(0x200) and c:IsType(TYPE_MONSTER) and (c:IsLocation(LOCATION_HAND+LOCATION_MZONE) or c:IsFaceup()) and c:IsAbleToRemoveAsCost() 
end
function c1000073.cost2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000073.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) and e:GetHandler():IsAbleToGraveAsCost() and Duel.GetFlagEffect(tp,1000073)==0 end
	Duel.RegisterFlagEffect(tp,1000073,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c1000073.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	if g:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g)
	end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.Remove(g,POS_FACEUP,nil,2,REASON_COST)
end
function c1000073.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000073.afilter,tp,LOCATION_DECK,0,1,nil) and Duel.GetMatchingGroupCount(c1000073.dfilter,tp,LOCATION_MZONE,0,nil)==0 and e:GetHandler():IsAbleToGraveAsCost() and Duel.GetFlagEffect(tp,1000073)==0 end
	if Duel.IsExistingMatchingCard(c1000073.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)
	and Duel.SelectYesNo(tp,aux.Stringid(1000073,2)) then
	Duel.RegisterFlagEffect(tp,1000073,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c1000073.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	if g:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g)
	end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.Remove(g,POS_FACEUP,nil,2,REASON_COST)
	e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e:SetLabel(1)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	else
	e:SetCategory(0)
	e:SetLabel(0)
	end
end
function c1000073.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000073.afilter,tp,LOCATION_DECK,0,1,nil) and Duel.GetMatchingGroupCount(c1000073.dfilter,tp,LOCATION_MZONE,0,nil)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1000073.operation(e,tp,eg,ep,ev,re,r,rp)
	--if not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetLabel()==0 then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1000073.afilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ft)
	local tc=g:GetFirst()
	if tc then
		if ft>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToHand() or Duel.SelectYesNo(tp,aux.Stringid(1000073,0))) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			--unsynchroable
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetValue(c1000073.splimit)
			tc:RegisterEffect(e1)
			--xyzlimit
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e2:SetValue(c1000073.splimit)
			tc:RegisterEffect(e2)
			Duel.SpecialSummonComplete()
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
function c1000073.splimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x200)
end