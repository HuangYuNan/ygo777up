--百慕 当心睡过头！克尔克
require "script/c37564765"
function c37564413.initial_effect(c)
	aux.AddXyzProcedure(c,nil,5,3,c37564413.ovfilter,aux.Stringid(37564413,0),3,c37564413.xyzop)
	c:EnableReviveLimit()
	senya.bmdamchk(c,true)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564411,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(3)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCost(c37564413.cost)
	e3:SetCondition(senya.bmdamchkcon)
	e3:SetOperation(senya.bmdamchkop)
	c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c37564413.con)
	e2:SetOperation(c37564413.op)
	c:RegisterEffect(e2)
end
function c37564413.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and c:GetFlagEffect(37564413)==0 end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
	c:RegisterFlagEffect(37564413,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c37564413.ovfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and senya.bmchkfilter(c) and c:GetOverlayCount()==0
end
function c37564413.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(senya.bmrmcostfilter,tp,LOCATION_EXTRA,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,senya.bmrmcostfilter,tp,LOCATION_EXTRA,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c37564413.con(e)
	return (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
	and e:GetHandler():GetBattleTarget()
end
function c37564413.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e2)
end