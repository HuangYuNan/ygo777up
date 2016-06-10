--冰洁之仪式怪
function c23456752.initial_effect(c)
	c:EnableReviveLimit()
	--召唤限制
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--额外怪兽破坏
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23456752,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,23456752)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c23456752.exdescon)
	e2:SetTarget(c23456752.exdestg)
	e2:SetOperation(c23456752.exdesop)
	c:RegisterEffect(e2) 
	--Immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c23456752.tgvalue)
	c:RegisterEffect(e3) 
	--检索
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,23456752)
	e4:SetCondition(c23456752.thcon)
	e4:SetTarget(c23456752.thtg)
	e4:SetOperation(c23456752.thop)
	c:RegisterEffect(e4)
end
function c23456752.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
-----检索-----------------------------------------------------------
function c23456752.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c23456752.thfilter(c)
	return c:IsSetCard(0x531) and not c:IsCode(23456752) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c23456752.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456752.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c23456752.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c23456752.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
-------额外破坏-------------------------------------------------------
function c23456752.exdescon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c23456752.exdesfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0 and c:IsDestructable() and c:GetSummonLocation()==LOCATION_EXTRA
end
function c23456752.exdestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23456752.exdesfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c23456752.exdesfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c23456752.exdesop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c23456752.exdesfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end