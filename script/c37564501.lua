--Dokkin
if not senya then local io=require('io') local chk=io.open("expansions/script/c37564765.lua","r") if chk then chk:close() require "expansions/script/c37564765" else require "script/c37564765" end end
function c37564501.initial_effect(c)
	senya.nnhr(c)
	aux.AddXyzProcedure(c,c37564501.mfilter,7,3)
	c:EnableReviveLimit()
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c37564501.discon)
	e3:SetTarget(c37564501.distg)
	e3:SetOperation(c37564501.disop)
	c:RegisterEffect(e3)
end
function c37564501.mfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c37564501.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and ep~=tp
end
function c37564501.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,100)
	Duel.SetChainLimit(aux.FALSE)
end
function c37564501.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,100,REASON_EFFECT)
	if Duel.GetFlagEffect(tp,37564501)==0 and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		Duel.NegateActivation(ev)
		if re:GetHandler():IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
		Duel.RegisterFlagEffect(tp,37564501,RESET_PHASE+PHASE_END,0,1)
	end
end