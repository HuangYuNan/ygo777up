--阿库娅：你是笨蛋么？
function c74010012.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetTarget(c74010012.target)
	e1:SetOperation(c74010012.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c74010012.handcon)
	c:RegisterEffect(e2)
	--DRAW
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74010012,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(c74010012.thcon)
	e3:SetTarget(c74010012.thtg)
	e3:SetOperation(c74010012.thop)
	c:RegisterEffect(e3)
end
function c74010012.filter2(c)
	return c:IsSetCard(0x3740)
end
function c74010012.filter(c)
	return c:IsAbleToGrave() and c:IsSetCard(0x3740)
end
function c74010012.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) end
	if chk==0 then return Duel.IsExistingTarget(c74010012.filter2,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74010012,1))
	local g=Duel.SelectTarget(tp,c74010012.filter2,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c74010012.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
		local mg=Duel.GetMatchingGroup(c74010012.filter,tp,LOCATION_DECK,0,nil)
		if mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(74010012,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local sg=mg:Select(tp,1,1,nil)
			Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
end
function c74010012.hdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x3740)
end
function c74010012.handcon(e)
	return not Duel.IsExistingMatchingCard(c74010012.hdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c74010012.thcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetDrawCount(tp)>0
end
function c74010012.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c74010012.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	_replace_count=_replace_count+1
	if _replace_count<=_replace_max and c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end