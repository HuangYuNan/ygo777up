--神之曲 风之精灵帕特拉
function c75000015.initial_effect(c)
	 --pendulum summon
	aux.EnablePendulumAttribute(c,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000015,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c75000015.decon)
	e2:SetTarget(c75000015.detg)
	e2:SetOperation(c75000015.deop)
	c:RegisterEffect(e2)
	--cannot pendulum summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c75000015.splimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCountLimit(1,75000015)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetTarget(c75000015.target)
	e4:SetOperation(c75000015.operation)
	c:RegisterEffect(e4)
	--local e6=e4:Clone()
	--e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	--c:RegisterEffect(e6)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetDescription(aux.Stringid(75000015,1))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetCondition(c75000015.drcon)
	e5:SetTarget(c75000015.drtg)
	e5:SetOperation(c75000015.drop)
	c:RegisterEffect(e5)
end
function c75000015.decon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c75000015.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000015.defilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,LOCATION_ONFIELD)
end
function c75000015.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c75000015.defilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c75000015.defilter(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c75000015.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x0) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c75000015.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_SPELL+TYPE_TRAP) 
end
function c75000015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000015.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75000015.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75000015.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c75000015.drcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_BATTLE) 
end
function c75000015.filter2(c)
	return c:GetLevel()==3 and c:IsSetCard(0x52f)
end
function c75000015.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000015.filter2,tp,LOCATION_DECK,0,1,nil) end
end
function c75000015.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75000015.filter2,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0  then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,tp,REASON_EFFECT)
	end
end