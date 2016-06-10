--百慕 学院的绮罗星·奥莉维亚
require "script/c37564765"
function c37564414.initial_effect(c)
	aux.AddXyzProcedure(c,senya.bmchkfilter,3,2,nil,nil,5)
	c:EnableReviveLimit()
	senya.bmdamchk(c,true)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564414,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCost(c37564414.cost)
	e3:SetCondition(senya.bmdamchkcon)
	e3:SetOperation(senya.bmdamchkop)
	c:RegisterEffect(e3)
end
function c37564414.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and c:GetFlagEffect(37564414)==0 end
	c:RemoveOverlayCard(tp,1,99,REASON_COST)
	local ct=Duel.GetOperatedGroup():GetCount()
	e:SetLabel(ct)
	c:RegisterFlagEffect(37564414,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end