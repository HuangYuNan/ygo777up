--冰洁之舞者
function c23456751.initial_effect(c)
	--添加灵摆属性
	aux.EnablePendulumAttribute(c)
	--抽卡特招
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23456751,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,23456751)
	e1:SetCost(c23456751.thcost)
	e1:SetTarget(c23456751.sptg)
	e1:SetOperation(c23456751.spop)
	c:RegisterEffect(e1)
	--进入额外抽卡效果-------------------------------------------------------------
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetDescription(aux.Stringid(23456751,1))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,23456751)
	e2:SetCondition(c23456751.thcon)
	e2:SetTarget(c23456751.drtarget)
	e2:SetOperation(c23456751.dractivate)
	c:RegisterEffect(e2)
	--除外效果
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23456751,3))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_RELEASE)
	e3:SetCountLimit(1,234567511)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetTarget(c23456751.removetg)
	e3:SetOperation(c23456751.removeop)
	c:RegisterEffect(e3)
	--double
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(23456751,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetCountLimit(1,234567511)
	e4:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e4:SetCost(c23456751.doucost)
	e4:SetTarget(c23456751.doutarget)
	e4:SetOperation(c23456751.douoperation)
	c:RegisterEffect(e4)
	--解放代替
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_RITUAL_LEVEL)
	e5:SetValue(c23456751.rlevel)
	c:RegisterEffect(e5)
end
----解放代替--------------------------------------------------------
function c23456751.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsSetCard(0x531) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
----Double-----------------------------------------------------------
function c23456751.doucost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c23456751.doutarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a=d end
	if chk==0 then return d and a:IsSetCard(0x531)  end
	e:SetLabelObject(a)
end
function c23456751.douoperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local atk=tc:GetBaseAttack()
		local def=tc:GetBaseDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc:RegisterEffect(e1)
	end
end
-----解放除外-----------------------------------------------------------
function c23456751.removetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c23456751.removeop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
-----进入额外抽卡-------------------------------------------------------------
function c23456751.thfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_EXTRA) and c:IsSetCard(0x531)
		and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c23456751.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23456751.thfilter,1,nil,tp)
end
function c23456751.drtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c23456751.dractivate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
-----抽卡特招-------------------------------------------------------------
function c23456751.cfilter(c)
	return c:IsDiscardable()
end
function c23456751.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456751.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c23456751.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c23456751.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c23456751.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23456751.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	if tc:IsSetCard(0x531) and tc:IsType(TYPE_MONSTER) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		local g=Duel.GetMatchingGroup(c23456751.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23456751,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sc=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		Duel.BreakEffect()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_DISCARD)
	end
	Duel.ShuffleHand(tp)
end