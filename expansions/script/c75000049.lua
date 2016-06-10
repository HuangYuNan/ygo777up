--神之曲 远古守护树
function c75000049.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000049,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c75000049.shcon)
	e2:SetTarget(c75000049.shtg)
	e2:SetOperation(c75000049.shop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c75000049.splimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetCountLimit(1,75000049)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c75000049.spcon)
	e4:SetOperation(c75000049.spop)
	c:RegisterEffect(e4)
end
function c75000049.shcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c75000049.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingTarget(c75000049.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c75000049.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c75000049.shop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c75000049.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAbleToRemove()
end
function c75000049.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x0) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c75000049.spfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToRemoveAsCost() and c:IsSetCard(0x52f)
end
function c75000049.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75000049.spfilter,tp,LOCATION_SZONE,0,1,c)
end
function c75000049.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c75000049.spfilter,tp,LOCATION_SZONE,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end