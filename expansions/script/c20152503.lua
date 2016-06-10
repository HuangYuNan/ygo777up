--史蒂芬妮
function c20152503.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152503,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,201520)
	e1:SetTarget(c20152503.eqat)
	e1:SetOperation(c20152503.eqop)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152503,0))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1,201520)
	e3:SetCondition(c20152503.eqcon2)
	e3:SetTarget(c20152503.eqat)
	e3:SetOperation(c20152503.eqop)
	c:RegisterEffect(e3)
	--summon success
	--local e2=Effect.CreateEffect(c)
	--e2:SetDescription(aux.Stringid(20152503,1))
	--e2:SetCategory(CATEGORY_TOHAND)
	--e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e2:SetType(EFFECT_TYPE_IGNITION)
	--e2:SetRange(LOCATION_GRAVE)
	--e2:SetCountLimit(2,20152503)
	--e2:SetTarget(c20152503.target2)
	--e2:SetOperation(c20152503.operation2)
	--c:RegisterEffect(e2)
	--tohand
	--local e4=Effect.CreateEffect(c)
	--e4:SetCategory(CATEGORY_TOHAND)
	--e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e4:SetRange(LOCATION_GRAVE)
	--e4:SetCode(EVENT_SUMMON_SUCCESS)
	--e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	--e4:SetCountLimit(1,201520)
	--e4:SetCondition(c20152503.thcon)
	--e4:SetOperation(c20152503.thop)
	--c:RegisterEffect(e4)
end
function c20152503.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsControler(tp) and at:IsFaceup() and at:IsSetCard(0x6290)
end
function c20152503.eqat(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return chkc==at end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and at:IsControler(1-tp) and at:IsRelateToBattle() and at:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(at)
end
function c20152503.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
	else
		Duel.Equip(tp,c,tc,true)
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		--Add Equip limit
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c20152503.eqlimit)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_CANNOT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_ONFIELD)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1,true)
		--cannot change position
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_EQUIP)
		e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
	end
end
function c20152503.eqlimit(e,c)
	return e:GetOwner()==c
end
--function c20152503.filter2(c)
	--return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand() and c:IsFaceup()
--end
--function c20152503.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	--if chk==0 then return Duel.IsExistingTarget(c20152503.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	--Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	--local g=Duel.SelectTarget(tp,c20152503.filter2,tp,LOCATION_ONFIELD,-LOCATION_ONFIELD,1,1,nil)
	--Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
--end
--function c20152503.operation2(e,tp,eg,ep,ev,re,r,rp)
	--local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	--if g:GetCount()>0 then
		--Duel.SendtoHand(g,nil,REASON_EFFECT)
	--end
--end
--function c20152503.thcon(e,tp,eg,ep,ev,re,r,rp)
	--local ec=eg:GetFirst()
	--return ec:IsControler(tp) and ec:IsSetCard(0x6290)
--end
--function c20152503.thop(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	--if c:IsRelateToEffect(e) then
		--Duel.SendtoHand(c,nil,REASON_EFFECT)
	--end
--end