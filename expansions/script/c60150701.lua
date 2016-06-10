--学徒型橄榄石
function c60150701.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	 
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60150701,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,6015701)
	e2:SetCondition(c60150701.descon)
	e2:SetTarget(c60150701.destg)
	e2:SetOperation(c60150701.desop)
	c:RegisterEffect(e2)
	--splimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c60150701.splimit)
	e3:SetCondition(c60150701.splimcon)
	c:RegisterEffect(e3)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60150701,1))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c60150701.ntcon)
	e1:SetOperation(c60150701.ntop)
	c:RegisterEffect(e1)
	--poh 
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(60150701,2))
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,60150701)
	e4:SetTarget(c60150701.thtg)
	e4:SetOperation(c60150701.thop)
	c:RegisterEffect(e4)
end
function c60150701.cfilter(c,tp)
	return c:IsControler(tp) and ((c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY)) or c:IsSetCard(0x3b22)) and c:GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c60150701.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c60150701.cfilter,1,nil,tp)
end
function c60150701.thfilter(c)
	return c:IsSetCard(0xb22) and c:IsAbleToHand()
end
function c60150701.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150701.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60150701.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60150701.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	local c=e:GetHandler()
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		if Duel.SelectYesNo(tp,aux.Stringid(60150701,3)) then
			Duel.BreakEffect()
			Duel.Destroy(c,REASON_EFFECT)
		end
	end
end
function c60150701.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb22) or (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FAIRY)) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c60150701.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c60150701.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c60150701.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1900)
	c:RegisterEffect(e1)
end
function c60150701.filter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c60150701.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60150701.filter2,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c60150701.filter2,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c60150701.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c60150701.filter2,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end