--Avacyn, the Purifier
require "expansions/script/c9990000"
function c9990326.initial_effect(c)
	Dazz.DFCBacksideCommonEffect(c)
	c:EnableReviveLimit()
	--Destroy All
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c9990326.destg)
	e1:SetOperation(c9990326.desop)
	c:RegisterEffect(e1)
end
function c9990326.filter(c,lab)
	if c:IsFacedown() then return true end
	return c:GetRealFieldID()~=lab and c:IsDefenseBelow(3200)
end
function c9990326.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local lab=c:GetRealFieldID()
	local g=Duel.GetMatchingGroup(c9990326.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lab)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
	e:SetLabel(lab)
end
function c9990326.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c9990326.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end