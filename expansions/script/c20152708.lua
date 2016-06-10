--户部翔
function c20152708.initial_effect(c)
c:SetUniqueOnField(1,0,20152708) 
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20152708.tg)
	e1:SetOperation(c20152708.op)
	c:RegisterEffect(e1)
		--Pendulum Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c20152708.spcon)
	e2:SetTarget(c20152708.sptg)
	e2:SetOperation(c20152708.spop)
	c:RegisterEffect(e2)
		--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_PIERCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
		e3:SetCondition(c20152708.condition)
	e3:SetTarget(c20152708.cfilter)
	c:RegisterEffect(e3)
end
function c20152708.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,800)
end
function c20152708.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c20152708.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK+LOCATION_HAND) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c:IsSetCard(0xc290)
end
function c20152708.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20152708.filter,1,nil,tp) and e:GetHandler():IsStatus(STATUS_ACTIVATED)
end
function c20152708.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c20152708.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP) end
end
function c20152708.cfilter(c)
	return c:IsSetCard(0xc290)
end
function c20152708.xfilter(c)
	return c:IsFaceup() and c:IsCode(20152707)
end
function c20152708.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_BATTLE and Duel.IsExistingMatchingCard(c20152708.xfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
