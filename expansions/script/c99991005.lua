--奥尔良人形
function c99991005.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52575195,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c99991005.tgcon1)
	e1:SetTarget(c99991005.tgtg)
	e1:SetOperation(c99991005.tgop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52575195,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c99991005.tgcon2)
	e2:SetTarget(c99991005.tgtg)
	e2:SetOperation(c99991005.tgop2)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetTarget(c99991005.attg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--cannot attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_ONFIELD)
	e4:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c99991005.aktg)
	c:RegisterEffect(e4)
	--ind
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(c99991005.targeta)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c99991005.tgcon1(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup()
		and tc:IsSetCard(0x2e6)
end
function c99991005.tgcon2(e,tp,eg,ep,ev,re,r,rp)
	if tp==Duel.GetTurnPlayer() then return false end
	local tc=Duel.GetAttackTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0x2e6)
end
function c99991005.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return   Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_HAND)
end
function c99991005.tgop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.ChangeTargetCard(ev,Group.FromCards(c))
		end
end
function c99991005.tgop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local a=Duel.GetAttacker()
		if a:IsOnField() and a:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetValue(1)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
			c:RegisterEffect(e1)
			Duel.CalculateDamage(a,c)
			end
end
end
function c99991005.attg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x2e6) and c:GetCode()~=99991005
end
function c99991005.aktg(e,c)
   local g=(4-e:GetHandler():GetSequence())
	return c:GetSequence()==g 
end
function c99991005.targeta(e,c)
    local g=(4-e:GetHandler():GetSequence())
	return c:IsFaceup() and c:IsSetCard(0x2e6) and  c:GetSequence()==g   and c:GetCode()~=99991005
end