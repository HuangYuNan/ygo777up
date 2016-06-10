--源符「诹访清水」
function c1100706.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,1100706+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c1100706.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x3240))
	e2:SetValue(200)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(aux.exccon)
	e4:SetCost(c1100706.spcost)
	e4:SetTarget(c1100706.sptg)
	e4:SetOperation(c1100706.spop)
	c:RegisterEffect(e4) 
end
function c1100706.filter1(c)
	return c:IsSetCard(0x3240) and c:IsType(TYPE_MONSTER)  and c:IsAbleToHand()
end
function c1100706.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c1100706.filter1,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(1100706,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c1100706.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c1100706.filter(c,e,tp)
	local rk=c:GetRank()
	return c:IsType(TYPE_XYZ) and c:IsFaceup() and c:IsSetCard(0x3240) 
		and Duel.IsExistingMatchingCard(c1100706.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,rk)
end
function c1100706.spfilter(c,e,tp,rk)
	return c:IsType(TYPE_XYZ) and c:GetRank()==rk+1 and c:IsSetCard(0x3240) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1100706.chkfilter(c,tc)
	local rk=tc:GetRank()
	return c:IsFaceup() and c:GetRank()==rk-1
end
function c1100706.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c1100706.chkfilter(chkc,e:GetLabelObject()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c1100706.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(1100706,1))
	local g=Duel.SelectTarget(tp,c1100706.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	e:SetLabelObject(g:GetFirst())
end
function c1100706.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local rk=tc:GetRank()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1100706.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,rk)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,tc)
		Duel.SpecialSummon(g,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end