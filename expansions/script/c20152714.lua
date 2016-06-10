--平冢静
function c20152714.initial_effect(c)
c:SetUniqueOnField(1,0,20152714)
--synchro summon
aux.AddSynchroProcedure(c,aux.FilterBoolFunction(c20152714.synfilter1),aux.NonTuner(c20152714.synfilter2),1)
	c:EnableReviveLimit()

	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152714,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c20152714.eqcost)
	e2:SetTarget(c20152714.eqtg)
	e2:SetOperation(c20152714.eqop)
	c:RegisterEffect(e2)
			--Pos Change
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetDescription(aux.Stringid(20152714,1))
e3:SetType(EFFECT_TYPE_IGNITION)		e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c20152714.poscost)
	e3:SetTarget(c20152714.postg)
	e3:SetOperation(c20152714.posop)
	c:RegisterEffect(e3)
end
function c20152714.synfilter1(c)
	return c:IsType(TYPE_TUNER)
and c:IsSetCard(0xc290)
end
function c20152714.synfilter2(c)
	return c:IsSetCard(0xc290)
end
function c20152714.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsDirectAttacked() end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c20152714.eqfilter(c)
	return c:IsFaceup() and c:IsAbleToChangeControler()
end
function c20152714.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c20152714.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c20152714.eqfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c20152714.eqfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c20152714.eqlimit(e,c)
	return e:GetOwner()==c and not c:IsDisabled()
end
function c20152714.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local atk=tc:GetTextAttack()/2
			if atk<0 then atk=0 end
			if not Duel.Equip(tp,tc,c,false) then return end
			--Add Equip limit
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c20152714.eqlimit)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(atk)
			tc:RegisterEffect(e2)
			tc:RegisterFlagEffect(20152714,RESET_EVENT+0x1fe0000,0,1)
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
function c20152714.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c20152714.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDefensePos,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c20152714.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,0,0,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
end
