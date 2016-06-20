--AIW·觉醒的疯帽子
function c66619909.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x666),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11958188,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c66619909.descon)
	e1:SetCost(c66619909.descost)
	e1:SetTarget(c66619909.destg)
	e1:SetOperation(c66619909.desop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1)
	e2:SetCondition(c66619909.drwcon)
	e2:SetCost(c66619909.darwcost)
	e2:SetTarget(c66619909.drtg)
	e2:SetOperation(c66619909.drop)
	c:RegisterEffect(e2)
end
function c66619909.cfilter(c,tp)
	return c:IsSetCard(0x666) and c:IsControler(tp) and c:GetPreviousControler()==tp
		and c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE)
end
function c66619909.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c66619909.cfilter,nil,tp)
	e:SetLabelObject(g:GetFirst())
	return g:GetCount()>0
end
function c66619909.cfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_CONTINUOUS) and c:IsAbleToGraveAsCost()
end
function c66619909.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66619909.cfilter1,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c66619909.cfilter1,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c66619909.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject():GetReasonCard()
	if chk==0 then return tc:IsRelateToBattle() and tc:IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c66619909.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject():GetReasonCard()
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c66619909.gfilter(c,tp)
	return c:IsSetCard(0x666) and c:IsControler(tp)
end
function c66619909.drwcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66619909.gfilter,1,nil)
end
function c66619909.darwfilter(c)
	return c:IsFaceup() and c:IsCode(66619916) and c:IsAbleToDeckAsCost()
end
function c66619909.darwcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c66619909.darwfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c66619909.darwfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c66619909.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c66619909.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end