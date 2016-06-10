--反轉精靈·鳶一折紙
function c20150337.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x3291),11,2)
	c:EnableReviveLimit()
	--change name
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(20150309)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c20150337.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20150337,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,20150337)
	e3:SetOperation(c20150337.imop)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20150337,1))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,20150337)
	e4:SetCost(c20150337.discost)
	e4:SetTarget(c20150337.distg)
	e4:SetOperation(c20150337.disop)
	c:RegisterEffect(e4)
	--remove
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(20150337,2))
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetCountLimit(1,20150337)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c20150337.rmcost)
	e5:SetTarget(c20150337.rmtg)
	e5:SetOperation(c20150337.rmop)
	c:RegisterEffect(e5)
end
function c20150337.indcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c20150337.imop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetValue(c20150337.imfilter)
		e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e3)
	end
end
function c20150337.imfilter(e,re)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c20150337.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20150337.tgfilter(c)
	return c:IsFaceup() and c:IsAbleToRemove() and c:GetAttack()>=2600
end
function c20150337.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20150337.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150337.tgfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c20150337.tgfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c20150337.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c20150337.disfilter(c)
	return c:IsFaceup() and c:GetDefense()<=1900
end
function c20150337.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20150337.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20150337.disfilter,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c20150337.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20150337.disfilter,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	if not tc then return end
	local c=e:GetHandler()
	while tc do
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DISABLE)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e4)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3)
		end
		tc=g:GetNext()
	end
end
