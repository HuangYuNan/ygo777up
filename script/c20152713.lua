--雪之下阳乃
function c20152713.initial_effect(c)
c:SetUniqueOnField(1,0,20152713)
--synchro summon
aux.AddSynchroProcedure(c,aux.FilterBoolFunction(c20152713.synfilter1),aux.NonTuner(c20152713.synfilter2),1)
	c:EnableReviveLimit()
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152713,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20152713.tdcost)
	e2:SetTarget(c20152713.tdtarget)
	e2:SetOperation(c20152713.tdoperation)
	c:RegisterEffect(e2)
		--recover
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(c20152713.reccondition)
	e3:SetTarget(c20152713.rectarget)
	e3:SetOperation(c20152713.recoperation)
	c:RegisterEffect(e3)
end
function c20152713.synfilter1(c)
	return c:IsType(TYPE_TUNER)
and c:IsSetCard(0xc290)
end
function c20152713.synfilter2(c)
	return c:IsSetCard(0xc290)
end

function c20152713.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000) 
end
function c20152713.tdtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c20152713.tdoperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	if tc:IsSetCard(0xc290) and tc:IsType(TYPE_MONSTER) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local dg=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		Duel.SendtoDeck(dg,nil,2,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end
function c20152713.reccondition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c20152713.rectarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,ev)
end
function c20152713.recoperation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
