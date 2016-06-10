--777-绽放之时的色彩
function c66677708.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,66677708+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c66677708.activate)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(66677708)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	c:RegisterEffect(e3)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66677708,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,66677718)
	e2:SetCondition(c66677708.drcon)
	e2:SetTarget(c66677708.drtg)
	e2:SetOperation(c66677708.drop)
	c:RegisterEffect(e2) 
end
function c66677708.tdfilter(c)
	return c:IsSetCard(0x777) and c:IsAbleToHand() and c:GetLevel()==7
end
function c66677708.spfilter(c,e,tp)
	return c:IsCode(66677705) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66677708.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=Duel.GetMatchingGroup(c66677708.tdfilter,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(c66677708.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local gc1=(g1:GetCount()>0)
	local gc2=(g2:GetCount()>0)
	local ch1=false
	local ch2=false
	if gc1 and not gc2 then ch1=(Duel.SelectYesNo(tp,aux.Stringid(66677708,0))) end
	if gc2 and not gc1 then ch1=(Duel.SelectYesNo(tp,aux.Stringid(66677708,1))) end
	if gc1 and gc2 then
		local sel=Duel.SelectOption(tp,aux.Stringid(37564777,1),aux.Stringid(37564777,0))
		if sel==0 then ch1=true end
		if sel==1 then ch2=true end
	end
	if ch1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.SendtoHand(sg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
		elseif ch2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg2,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c66677708.cfilter(c,tp)
	return c:IsSetCard(0x777) and c:IsControler(tp)
end
function c66677708.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66677708.cfilter,1,nil,tp)
end
function c66677708.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c66677708.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
