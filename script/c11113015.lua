--战场女武神 觉醒极限
function c11113015.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,11113015)
	e1:SetTarget(c11113015.target)
	e1:SetOperation(c11113015.activate)
	c:RegisterEffect(e1)
	--Salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11113015,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,111130150)
	e2:SetCondition(c11113015.thcon)
	e2:SetCost(c11113015.thcost)
	e2:SetTarget(c11113015.thtg)
	e2:SetOperation(c11113015.thop)
	c:RegisterEffect(e2)
end
function c11113015.filter(c,e,tp,m1,m2)
	if not c:IsSetCard(0x15c) or bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m1:Filter(Card.IsCanBeRitualMaterial,c,c)
	mg:Merge(m2)
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
end
function c11113015.mfilter(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_MONSTER) and c:GetLevel()>0 and c:IsAbleToRemove()
end
function c11113015.cfilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA
end
function c11113015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg1=Duel.GetMatchingGroup(c11113015.mfilter,tp,LOCATION_HAND,0,nil)
		local mg2=Duel.GetMatchingGroup(c11113015.mfilter,tp,LOCATION_GRAVE,0,nil)
		local loc=LOCATION_HAND
		if Duel.IsExistingMatchingCard(c11113015.cfilter,tp,0,LOCATION_MZONE,1,nil) then
		    loc=loc+LOCATION_GRAVE
		end
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		    and Duel.IsExistingMatchingCard(c11113015.filter,tp,loc,0,1,nil,e,tp,mg1,mg2)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c11113015.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg1=Duel.GetMatchingGroup(c11113015.mfilter,tp,LOCATION_HAND,0,nil)
	local mg2=Duel.GetMatchingGroup(c11113015.mfilter,tp,LOCATION_GRAVE,0,nil)
	if Duel.IsExistingMatchingCard(c11113015.cfilter,tp,0,LOCATION_MZONE,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=Duel.SelectMatchingCard(tp,c11113015.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,mg1,mg2)
		local tc=tg:GetFirst()
		if tc and not tc:IsHasEffect(EFFECT_NECRO_VALLEY) then
			if tc:IsLocation(LOCATION_GRAVE) then Duel.HintSelection(tg) end
			local mg=mg1:Filter(Card.IsCanBeRitualMaterial,tc,tc)
			mg:Merge(mg2)
			if tc.mat_filter then
				mg=mg:Filter(tc.mat_filter,nil)
			end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
			tc:SetMaterial(mat)
			Duel.Remove(mat,POS_FACEUP,REASON_EFFECT)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
			tc:CompleteProcedure()
		end
	else
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=Duel.SelectMatchingCard(tp,c11113015.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg1,mg2)
		local tc=tg:GetFirst()
		if tc then
			local mg=mg1:Filter(Card.IsCanBeRitualMaterial,tc,tc)
			mg:Merge(mg2)
			if tc.mat_filter then
				mg=mg:Filter(tc.mat_filter,nil)
			end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
			tc:SetMaterial(mat)
			Duel.Remove(mat,POS_FACEUP,REASON_EFFECT)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
			tc:CompleteProcedure()
		end	
	end
end
function c11113015.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c11113015.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c11113015.thfilter(c)
	return c:IsSetCard(0x15c) and bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToHand()
end
function c11113015.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c11113015.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11113015.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c11113015.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c11113015.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,0,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end