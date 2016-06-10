--帕拉诺尼亚 250
function c37564306.initial_effect(c)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),5,4,c37564306.ovfilter,aux.Stringid(37564306,0))
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564306,1))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c37564306.con)
	e1:SetCost(c37564306.cost)
	e1:SetTarget(c37564306.tg)
	e1:SetOperation(c37564306.op)
	c:RegisterEffect(e1)

	
--publics
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c37564306.immcon)
	e5:SetValue(c37564306.immfilter)
	c:RegisterEffect(e5)
end
function c37564306.immcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
--changes
function c37564306.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x776) and c:GetAttack()==0 and c:GetDefense()==2500
end
function c37564306.immfilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner() and te:GetHandler():GetAttack()<2500
end
--effects
function c37564306.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:GetAttack()<e:GetHandler():GetAttack()
end
function c37564306.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	local atk=tc:GetAttack()
	if chk==0 then return true end
	if tc and tc:IsReleasable() then
	Duel.Release(tc,REASON_COST)
	end
	e:SetLabel(atk/2)
end
function c37564306.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,e:GetHandler(),0,tp,e:GetLabel())
end
function c37564306.op(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			e1:SetValue(e:GetLabel())
			c:RegisterEffect(e1)
		end
end
