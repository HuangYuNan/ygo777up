--花符「幻想乡的开花」
function c23309009.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23309009,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c23309009.tgcon)
	e2:SetTarget(c23309009.tgtg)
	e2:SetOperation(c23309009.tgop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(23309009)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0x77,0)
	e3:SetTarget(c23309009.tg)
	c:RegisterEffect(e3)
	
	--draw
	-- local e2=Effect.CreateEffect(c)
	-- e2:SetDescription(aux.Stringid(23309009,0))
	-- e2:SetCategory(CATEGORY_DRAW)
	-- e2:SetType(EFFECT_TYPE_IGNITION)
	-- e2:SetRange(LOCATION_FZONE)
	-- e2:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_PLAYER_TARGET)
	-- e2:SetCountLimit(1)
	-- e2:SetTarget(c23309009.drtg)
	-- e2:SetOperation(c23309009.drop)
	-- c:RegisterEffect(e2)
	--search
	-- local e4=Effect.CreateEffect(c)
	-- e4:SetDescription(aux.Stringid(23309009,1))
	-- e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	-- e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	-- e4:SetCode(EVENT_TO_GRAVE)
	-- e4:SetCondition(c23309009.thcon)
	-- e4:SetTarget(c23309009.thtg)
	-- e4:SetOperation(c23309009.thop)
	-- c:RegisterEffect(e4)
end
function c23309009.tg(e,c)
	return c:IsSetCard(0x99a)
end
function c23309009.tgfilter(c,tp)
	return c:IsSetCard(0x99a) and c:IsControler(tp)
end
function c23309009.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23309009.tgfilter,1,nil,tp)
end
function c23309009.schfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsType(TYPE_MONSTER) and c:IsLevelAbove(7) and c:IsAbleToHand()
end
function c23309009.desfilter(c)
	return c:IsAbleToHand()
end
function c23309009.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local sel=0
		if Duel.IsExistingMatchingCard(c23309009.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then sel=sel+1 end
		if Duel.IsExistingMatchingCard(c23309009.schfilter,tp,LOCATION_DECK,0,1,nil) then sel=sel+2 end
		e:SetLabel(sel)
		return sel~=0
	end
	local sel=e:GetLabel()
	if sel==3 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23309009,0))
		sel=Duel.SelectOption(tp,aux.Stringid(23309009,1),aux.Stringid(23309009,2))+1
	elseif sel==1 then
		Duel.SelectOption(tp,aux.Stringid(23309009,1))
	else
		Duel.SelectOption(tp,aux.Stringid(23309009,2))
	end
	e:SetLabel(sel)
	if sel==1 then
		local g=Duel.GetMatchingGroup(c23309009.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK) end
end
function c23309009.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local sel=e:GetLabel()
	if sel==1 then
		local g=Duel.GetMatchingGroup(c23309009.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=g:Select(tp,1,1,nil)
			Duel.HintSelection(dg)
			Duel.SendtoHand(dg,nil,REASON_EFFECT)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c23309009.schfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
-- function c23309009.filter(c)
	-- return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x99a) and c:IsReleasableByEffect()
-- end
-- function c23309009.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	-- if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		-- and Duel.CheckReleaseGroupEx(tp,c23309009.filter,1,nil) end
	-- Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
-- end
-- function c23309009.drop(e,tp,eg,ep,ev,re,r,rp)
	-- if not Duel.IsPlayerCanDraw(tp) then return end
	-- local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	-- if ct==0 then ct=1 end
	-- if ct>2 then ct=2 end
	-- local g=Duel.SelectReleaseGroupEx(tp,c23309009.filter,1,ct,nil)
	-- if g:GetCount()>0 then
		-- Duel.HintSelection(g)
		-- local rct=Duel.Release(g,REASON_EFFECT)
		-- Duel.Draw(tp,rct,REASON_EFFECT)
	-- end
-- end
-- function c23309009.thcon(e,tp,eg,ep,ev,re,r,rp)
	-- return not e:GetHandler():IsReason(REASON_RETURN)
-- end
-- function c23309009.thfilter(c)
	-- return (c:IsCode(24094667) or c:IsCode(23309010)) and c:IsAbleToHand()
-- end
-- function c23309009.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	-- if chk==0 then return true end
	-- Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
-- end
-- function c23309009.thop(e,tp,eg,ep,ev,re,r,rp)
	-- Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	-- local g=Duel.SelectMatchingCard(tp,c23309009.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	-- if g:GetCount()>0 then
		-- Duel.SendtoHand(g,nil,REASON_EFFECT)
		-- Duel.ConfirmCards(1-tp,g)
	-- end
-- end