--传说的华光之二重·内克塔里娅
if not senya then local io=require('io') local chk=io.open("expansions/script/c37564765.lua","r") if chk then chk:close() require "expansions/script/c37564765" else require "script/c37564765" end end
function c37564400.initial_effect(c)
	senya.rxyz1(c,3,c37564400.mfilter)
--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c37564400.atkval)
	c:RegisterEffect(e2)
--tar
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(aux.tgval)
	e3:SetCondition(c37564400.indcon)
	c:RegisterEffect(e3)
--reg
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(37564400,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCost(c37564400.rm)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	end)
	e4:SetTarget(c37564400.drtg)
	e4:SetOperation(c37564400.drop)
	c:RegisterEffect(e4)
--th
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(37564400,1))
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1)
	e5:SetCondition(c37564400.descon)
	e5:SetTarget(c37564400.destg)
	e5:SetOperation(c37564400.desop)
	c:RegisterEffect(e5)
	--neg
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(37564400,2))
	e6:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_CHAINING)
	e6:SetCountLimit(1)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c37564400.discon)
	e6:SetCost(c37564400.discost)
	e6:SetTarget(c37564400.distg)
	e6:SetOperation(c37564400.disop)
	c:RegisterEffect(e6)
end
function c37564400.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(37564400)>0
end
function c37564400.mfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsRace(RACE_SEASERPENT)
end
function c37564400.atkval(e,c)
	return c:GetOverlayCount()*500
end
function c37564400.indcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>=3 and e:GetHandler():GetFlagEffect(37564400)>0
end
function c37564400.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function c37564400.drop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(37564400,RESET_EVENT+0x1fe0000,0,1)
end
function c37564400.costfilter(c)
	return c:IsCode(37564400) and c:IsAbleToRemoveAsCost()
end
function c37564400.rm(e,tp,eg,ep,ev,re,r,rp,chk)
	local rmc=2
	if e:GetHandler():GetOverlayCount()>=3 then rmc=1 end 
	if chk==0 then return Duel.IsExistingMatchingCard(c37564400.costfilter,tp,LOCATION_EXTRA,0,rmc,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c37564400.costfilter,tp,LOCATION_EXTRA,0,rmc,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37564400.drfilter(c,e)
	return not c:IsType(TYPE_TOKEN) and (c:IsControler(tp) or c:IsAbleToChangeControler()) and not c:IsImmuneToEffect(e)
end
function c37564400.desfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToHand() and c:IsRace(RACE_SEASERPENT) and c:IsFaceup()
end
function c37564400.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(37564400)>0
end
function c37564400.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c37564400.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37564400.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) and e:GetHandler():IsType(TYPE_XYZ) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c37564400.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c37564400.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 then
		if Duel.IsExistingMatchingCard(c37564400.drfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,e) and c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
			local g=Duel.SelectMatchingCard(tp,c37564400.drfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c,e)
			if g:GetCount()>0 then
				Duel.HintSelection(g)
				local dc=g:GetFirst()
				local og=dc:GetOverlayGroup()
				if og:GetCount()>0 then
					Duel.SendtoGrave(og,REASON_RULE)
				end
				if dc:IsType(TYPE_SPELL+TYPE_TRAP) then
					dc:CancelToGrave()
				end
				Duel.Overlay(c,Group.FromCards(dc))
			end
		end
	end
end
function c37564400.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and c:GetFlagEffect(37564400)>0 and rc~=c
end
function c37564400.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c37564400.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c37564400.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end