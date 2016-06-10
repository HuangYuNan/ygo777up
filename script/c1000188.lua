--原色骑士-光谱
function c1000188.initial_effect(c)
  --①卡组检索
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,1000188)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCost(c1000188.spcost)
	e1:SetTarget(c1000188.target)
	e1:SetOperation(c1000188.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
  --②解放发动
	--local e2=Effect.CreateEffect(c)
	--e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	--e2:SetType(EFFECT_TYPE_IGNITION)
	--e2:SetRange(LOCATION_MZONE)
	--e2:SetCountLimit(1,1000188)
	--e2:SetCost(c1000188.spcost)
	--e2:SetTarget(c1000188.sptg)
	--e2:SetOperation(c1000188.spop)
	--c:RegisterEffect(e2)
  --③回到卡组发动
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1,1000188)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(c1000188.necon)
	e3:SetCost(c1000188.necost)
	e3:SetTarget(c1000188.netarget)
	e3:SetOperation(c1000188.neoperation)
	c:RegisterEffect(e3)  
end
function c1000188.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1000188.filter(c)
	return c:IsSetCard(0x200) and c:IsAbleToHand()
end
function c1000188.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000188.filter,tp,LOCATION_DECK,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end 
function c1000188.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x200)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())
		local sg1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg1:GetFirst():GetCode())
		sg:Merge(sg1)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleDeck(tp)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local tg=sg:Select(1-tp,1,1,nil)
		local tc=tg:GetFirst()
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			sg:RemoveCard(tc)
		end
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
--function c1000188.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return e:GetHandler():IsReleasable() end
	--Duel.Release(e:GetHandler(),REASON_COST)
--end
--function c1000188.cfilter(c,e,tp)
	--return c:IsSetCard(0x200) and c:IsCanBeSpecialSummoned(e,0,tp,--false,false)
--end
--function c1000188.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		--and Duel.IsExistingMatchingCard(c1000188.cfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	--Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
--end
--function c1000188.spop(e,tp,eg,ep,ev,re,r,rp)
	--local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectMatchingCard(tp,c1000188.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	--local tc=g:GetFirst()
	--if g:GetCount()~=0 then
	--Duel.BreakEffect()
	--Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	--local e1=Effect.CreateEffect(e:GetHandler())
	--e1:SetType(EFFECT_TYPE_SINGLE)
	--e1:SetCode(EFFECT_DISABLE)
	--e1:SetReset(RESET_EVENT+0x1fe0000)
	--tc:RegisterEffect(e1,true)
	--local e2=Effect.CreateEffect(e:GetHandler())
	--e2:SetType(EFFECT_TYPE_SINGLE)
	--e2:SetCode(EFFECT_DISABLE_EFFECT)
	--e2:SetReset(RESET_EVENT+0x1fe0000)
	--tc:RegisterEffect(e2,true)
	--Duel.SpecialSummonComplete()
	--Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD,nil)  
	--end
--end
function c1000188.necon(e)
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c1000188.necost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),c,nil,2,REASON_COST)
end
function c1000188.nefilter(c)
	return c:IsSetCard(0x200) and c:IsAbleToHand() 
end
function c1000188.anfilter(c)
	return c:IsSetCard(0x200) and c:IsType(TYPE_SPELL) and c:IsFaceup()
end
function c1000188.netarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1000188.anfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c1000188.nefilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1000188.neoperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1000188.nefilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end