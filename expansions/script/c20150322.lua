--蚀时之城
function c20150322.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c20150322.cost)
	e1:SetTarget(c20150322.target)
	e1:SetOperation(c20150322.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20150322,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c20150322.thcon)
	e2:SetTarget(c20150322.mattg)
	e2:SetOperation(c20150322.matop)
	c:RegisterEffect(e2)
end
function c20150322.filter(c)
	return (c:IsSetCard(0x3291) or c:IsSetCard(0x5291)) and c:IsDiscardable()
end
function c20150322.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20150322.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c20150322.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c20150322.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c20150322.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c20150322.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetPreviousPosition(),POS_FACEUP)~=0
		and bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_ONFIELD)~=0
end
function c20150322.xyzfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsCode(20150323)
		and Duel.IsExistingMatchingCard(c20150322.matfilter,tp,LOCATION_GRAVE,0,1,c)
end
function c20150322.matfilter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsSetCard(0x3291) or c:IsSetCard(0x5291) and c:IsType(TYPE_MONSTER)
end
function c20150322.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c20150322.xyzfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c20150322.xyzfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c20150322.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c20150322.matop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g=Duel.SelectMatchingCard(tp,c20150322.matfilter,tp,LOCATION_GRAVE,0,1,1,tc)
		if g:GetCount()>0 then
			local mg=g:GetFirst():GetOverlayGroup()
			if mg:GetCount()>0 then
				Duel.SendtoGrave(mg,REASON_RULE)
			end
			Duel.Overlay(tc,g)
		end
	end
end
