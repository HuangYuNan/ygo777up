--DRRR!! 情报贩
function c80003036.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x2da),9,3,c80003036.ovfilter,aux.Stringid(80003036,0),3,c80003036.xyzop)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,80003036)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)	
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2da))
	c:RegisterEffect(e2)
	--cannot disable summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2da))
	c:RegisterEffect(e3) 
	--cannot disable spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e4:SetRange(LOCATION_PZONE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2da))
	c:RegisterEffect(e4) 
	--pendulum
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCondition(c80003036.pencon)
	e5:SetOperation(c80003036.penop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e7)
	--material
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(80003036,2))
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e8:SetRange(LOCATION_MZONE)
	e8:SetHintTiming(TIMING_DAMAGE_STEP)
	e8:SetCountLimit(1)
	e8:SetCondition(c80003036.condition)
	e8:SetTarget(c80003036.target)
	e8:SetOperation(c80003036.operation)
	c:RegisterEffect(e8)
	--negate
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(80003036,3))
	e9:SetCategory(CATEGORY_NEGATE+CATEGORY_TOGRAVE)
	e9:SetType(EFFECT_TYPE_QUICK_O)
	e9:SetCode(EVENT_CHAINING)
	e9:SetCountLimit(1)
	e9:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCondition(c80003036.discon)
	e9:SetCost(c80003036.discost)
	e9:SetTarget(c80003036.distg)
	e9:SetOperation(c80003036.disop)
	c:RegisterEffect(e9)
end
c80003036.pendulum_level=9
function c80003036.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c80003036.cfilter(c)
	return c:IsCode(80003034) and c:IsDiscardable()
end
function c80003036.ovfilter(c)
	return c:IsFaceup() and c:IsCode(80003020)
end
function c80003036.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80003036.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c80003036.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c80003036.pencon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c80003036.penop(e,tp,eg,ep,ev,re,r,rp)
	if  e:GetHandler():IsRelateToEffect(e) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c80003036.filter(c,tp)
	return  c:IsControler(tp) or c:IsAbleToChangeControler()
end
function c80003036.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c80003036.filter(chkc,tp) and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingTarget(c80003036.filter,tp,0,LOCATION_GRAVE,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c80003036.filter,tp,0,LOCATION_GRAVE,1,1,e:GetHandler(),tp)
end
function c80003036.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
function c80003036.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,80003034)
end
function c80003036.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c80003036.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,eg,1,0,0)
	end
end
function c80003036.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SendtoGrave(eg,REASON_EFFECT)
	end
end