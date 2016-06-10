--战场女武神 瓦尔基里枪盾
function c11113001.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,11113001)
	e1:SetTarget(c11113001.target)
	e1:SetOperation(c11113001.activate)
	c:RegisterEffect(e1)
	--Salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113001,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,111130010)
	e2:SetCondition(c11113001.thcon)
	e2:SetCost(c11113001.thcost)
	e2:SetTarget(c11113001.thtg)
	e2:SetOperation(c11113001.thop)
	c:RegisterEffect(e2)
end
function c11113001.filter(c,e,tp,m1,m2,m3)
	if not c:IsSetCard(0x15c) or bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m1:Filter(Card.IsCanBeRitualMaterial,c,c)
	mg:Merge(m2)
	mg:Merge(m3)
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end
function c11113001.mfilter1(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_MONSTER) and c:GetLevel()>0 and c:IsAbleToRemove()
end
function c11113001.mfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x15c) and c:IsType(TYPE_MONSTER) and c:GetLevel()>0 and c:IsAbleToDeck()
end
function c11113001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg1=Duel.GetMatchingGroup(c11113001.mfilter1,tp,LOCATION_HAND,0,nil)
		local mg2=Duel.GetMatchingGroup(c11113001.mfilter1,tp,LOCATION_GRAVE,0,nil)
		local mg3=Duel.GetMatchingGroup(c11113001.mfilter2,tp,LOCATION_REMOVED,0,nil)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		    and Duel.IsExistingMatchingCard(c11113001.filter,tp,LOCATION_HAND,0,1,nil,e,tp,mg1,mg2,mg3)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c11113001.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg1=Duel.GetMatchingGroup(c11113001.mfilter1,tp,LOCATION_HAND,0,nil)
	local mg2=Duel.GetMatchingGroup(c11113001.mfilter1,tp,LOCATION_GRAVE,0,nil)
	local mg3=Duel.GetMatchingGroup(c11113001.mfilter2,tp,LOCATION_REMOVED,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c11113001.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg1,mg2,mg3)
	local tc=tg:GetFirst()
	if tc then
		local mg=mg1:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		mg:Merge(mg2)
		mg:Merge(mg3)
		if tc.mat_filter then
			mg=mg:Filter(tc.mat_filter,nil)
		end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11113001,1))
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
		Duel.HintSelection(mat)
		tc:SetMaterial(mat)
		local mgt=mat:GetFirst()
		while mgt do
			if mgt:IsLocation(LOCATION_REMOVED) then
				Duel.SendtoDeck(mgt,nil,2,REASON_EFFECT)
			else
                Duel.Remove(mgt,POS_FACEUP,REASON_EFFECT)
			end
			mgt=mat:GetNext()
		end
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c11113001.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c11113001.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c11113001.thfilter(c)
	return c:IsSetCard(0x15c) and bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToHand()
end
function c11113001.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c11113001.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11113001.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c11113001.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c11113001.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,0,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end