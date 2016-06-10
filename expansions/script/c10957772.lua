--Miracle·Fair
function c10957772.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10957772,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,10957772+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c10957772.spcon)
	c:RegisterEffect(e1)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10957772,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetTarget(c10957772.destg)
	e3:SetOperation(c10957772.desop)
	c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--redirect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetCondition(c10957772.recon)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)	
end
function c10957772.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c10957772.recon(e)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c10957772.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c10957772.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end