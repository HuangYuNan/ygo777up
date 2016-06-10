--帕拉诺尼亚 280
function c37564307.initial_effect(c)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),5,4,c37564307.ovfilter,aux.Stringid(37564307,0))
	c:EnableReviveLimit()   
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c37564307.aclimit)
	e2:SetCondition(c37564307.actcon)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564307,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(c37564307.atkcon)
	e3:SetCost(c37564307.atkcost)
	e3:SetOperation(c37564307.atkop)
	c:RegisterEffect(e3)


--publics
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c37564307.immcon)
	e5:SetValue(c37564307.immfilter)
	c:RegisterEffect(e5)
end
function c37564307.immcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
--changes
function c37564307.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x776) and c:GetAttack()==0 and c:GetDefense()==2800
end
function c37564307.immfilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner() and te:GetHandler():GetAttack()<2800
end
--effects


function c37564307.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c37564307.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c37564307.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil and e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_MONSTER)
end
function c37564307.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(37564307)==0 end
	c:RegisterFlagEffect(37564307,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c37564307.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=c:GetOverlayGroup()
	if c:IsRelateToEffect(e) and c:IsFaceup() and og:IsExists(Card.IsType,1,nil,TYPE_MONSTER) then
		local g=og:FilterSelect(tp,Card.IsType,1,1,nil,TYPE_MONSTER)
		local val=g:GetFirst():GetTextDefense()*2
		if val<0 then val=0 end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(val)
		c:RegisterEffect(e1)
	end
end
