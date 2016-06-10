--神之曲 探求者艾德
function c75000001.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75000001,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c75000001.drcon)
	e2:SetTarget(c75000001.drtg)
	e2:SetOperation(c75000001.drop)
	c:RegisterEffect(e2)
	--cannot pendulum summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c75000001.splimit)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(75000001,1))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,75000001)
	e4:SetTarget(c75000001.target)
	e4:SetOperation(c75000001.operation)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1,75000001)
	e7:SetCost(c75000001.cost)
	e7:SetTarget(c75000001.detg)
	e7:SetOperation(c75000001.deop)
	c:RegisterEffect(e7)  
end
function c75000001.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c75000001.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c75000001.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c75000001.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x0) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c75000001.filter2(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and not c:IsCode(75000001)
end
function c75000001.filter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and not c:IsCode(75000001) and c:IsAbleToHand() and c:IsLevelAbove(4)
end
function c75000001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000001.filter2,tp,LOCATION_DECK,0,1,nil)
		and (Duel.GetFieldCard(tp,LOCATION_SZONE,6)==nil or Duel.GetFieldCard(tp,LOCATION_SZONE,7)==nil) end
end
function c75000001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c75000001.filter2,tp,LOCATION_DECK,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c75000001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000001.cfilter,tp,LOCATION_SZONE,0,1,nil) end
	local tg=Duel.SelectMatchingCard(tp,c75000001.cfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Remove(tg,POS_FACEUP,REASON_COST)
end
function c75000001.cfilter(c)
	return c:IsSetCard(0x52f) and c:IsType(TYPE_PENDULUM) and c:IsAbleToRemoveAsCost()
end
function c75000001.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75000001.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75000001.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75000001.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end