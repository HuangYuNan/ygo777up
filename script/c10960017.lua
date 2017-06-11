--星薙音姬·初耀
function c10960017.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x357),2,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c10960017.efilter)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c10960017.ctcon)
	e2:SetOperation(c10960017.posop)
	c:RegisterEffect(e2)   
	--todeck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10960017,0))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,0x1e0)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c10960017.attg)
	e4:SetOperation(c10960017.atop)
	c:RegisterEffect(e4)	   
end
function c10960017.efilter(e,te)
	return te:IsActiveType(TYPE_CONTINUOUS)
end
function c10960017.cfilter(c)
	return c:IsSetCard(0x357) and c:IsType(TYPE_MONSTER) 
end
function c10960017.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10960017.cfilter,1,nil)
end
function c10960017.pfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x357)
end
function c10960017.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10960017.pfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end
function c10960017.filter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c10960017.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c10960017.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10960017.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c10960017.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c10960017.atop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)==0 then return end
	local cp=tc:GetOwner()
	if Duel.GetLocationCount(cp,LOCATION_MZONE)==0 then return Duel.SendtoGrave(tc,REASON_EFFECT) end
	Duel.MoveToField(tc,cp,cp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
end
