--世界之树之叶
function c20150342.initial_effect(c)
	c:SetUniqueOnField(1,0,20150342)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x3291))
	c:RegisterEffect(e2)
	--trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c20150342.check)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetDescription(aux.Stringid(20150342,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_EVENT_PLAYER)
	e3:SetCode(20150342)
	e3:SetTarget(c20150342.target)
	e3:SetOperation(c20150342.operation)
	c:RegisterEffect(e3)
end
function c20150342.check(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=eg:GetFirst()
	while tc do
		if tc:IsPreviousLocation(LOCATION_MZONE) and tc:IsReason(REASON_DESTROY)
			and tc:IsSetCard(0x3291) and tc:GetLevel()~=0 and tc:IsPreviousPosition(POS_FACEUP) then
			Duel.RaiseSingleEvent(c,20150342,e,r,rp,tc:GetControler(),tc:GetLevel())
		end
		tc=eg:GetNext()
	end
end
function c20150342.filter(c,lv)
	return c:IsSetCard(0x3291) and c:IsAbleToHand()
end
function c20150342.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c20150342.filter,tp,LOCATION_DECK,0,1,nil,ev) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c20150342.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c20150342.filter,tp,LOCATION_DECK,0,1,1,nil,ev)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end