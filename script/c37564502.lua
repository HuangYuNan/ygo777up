--Harukoi
require "expansions/script/c37564765"
function c37564502.initial_effect(c)
	senya.nnhr(c)
	aux.AddSynchroProcedure2(c,nil,aux.FilterBoolFunction(Card.IsCode,37564765))
	c:EnableReviveLimit()
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c37564502.discon)
	e3:SetTarget(c37564502.distg)
	e3:SetOperation(c37564502.disop)
	c:RegisterEffect(e3)
end
function c37564502.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and ep~=tp
end
function c37564502.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local val=Duel.GetFlagEffect(tp,37564502)*100
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val+100)
	Duel.SetChainLimit(aux.FALSE)
end
function c37564502.disop(e,tp,eg,ep,ev,re,r,rp) 
	Duel.RegisterFlagEffect(tp,37564502,RESET_PHASE+PHASE_END,0,1)
	local val=Duel.GetFlagEffect(tp,37564502)*100
	Duel.Damage(1-tp,val,REASON_EFFECT)
	if val==100 then
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end	
	end
end