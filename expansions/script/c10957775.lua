--Miracle·Politeness
function c10957775.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(1160)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCondition(c10957775.condition)
	c:RegisterEffect(e0)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10957775,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c10957775.ntcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10957775,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCost(c10957775.setcost)
	e2:SetCountLimit(1,10957775)
	e2:SetTarget(c10957775.sptg)
	e2:SetOperation(c10957775.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3) 
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetDescription(aux.Stringid(10957775,0))
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c10957775.condtion)
	e4:SetTarget(c10957775.target2)
	e4:SetOperation(c10957775.operation2)
	c:RegisterEffect(e4)  
	--redirect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetCondition(c10957775.recon)
	e5:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e5)  
	--special summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10957775,0))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_PZONE)
	e6:SetCountLimit(1,10957775)
	e6:SetCost(c10957775.thcost)
	e6:SetTarget(c10957775.sptg2)
	e6:SetOperation(c10957775.spop2)
	c:RegisterEffect(e6)   
end
function c10957775.cfilter(c)
	return c:IsSetCard(0x239) and c:IsType(TYPE_PENDULUM)
end
function c10957775.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10957775.cfilter,0,LOCATION_EXTRA,0,3,nil)
end
function c10957775.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c10957775.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,0,REASON_COST)
end
function c10957775.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTORY,nil,1,tp,LOCATION_DECK)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10957775.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c10957775.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10957775.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c10957775.operation2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c10957775.recon(e)
	return e:GetHandler():IsLocation(LOCATION_PZONE)
end
function c10957775.dfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x239)
end
function c10957775.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957775.dfilter,tp,LOCATION_EXTRA,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10957775.dfilter,tp,LOCATION_EXTRA,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c10957775.tgfilter(c)
	return c:IsSetCard(0x239) and c:IsDestructable()
end
function c10957775.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c10957775.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(c10957775.tgfilter,tp,LOCATION_DECK,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10957775.spop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c10957775.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
