--星之女神  星野梦美
function c1103910.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1103910,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c1103910.eqtg)
	e1:SetOperation(c1103910.eqop)
	c:RegisterEffect(e1)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1103910,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c1103910.shcon)
	e3:SetTarget(c1103910.shtg)
	e3:SetOperation(c1103910.shop)
	c:RegisterEffect(e3)
	--add type
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetValue(TYPE_TUNER)
	c:RegisterEffect(e2) 
end
function c1103910.filter(c)
	return c:IsSetCard(0x1240) and c:IsType(TYPE_MONSTER)
end
function c1103910.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c1103910.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c1103910.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,c1103910.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and not tc:IsHasEffect(EFFECT_NECRO_VALLEY) then
		if not Duel.Equip(tp,tc,c,true) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c1103910.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c1103910.eqlimit(e,c)
	return e:GetOwner()==c
end
function c1103910.cfilter(c,ec,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c:GetEquipTarget()==ec
end
function c1103910.shcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1103910.cfilter,1,nil,e:GetHandler(),tp)
end
function c1103910.tgfilter(c)
	return c:IsSetCard(0x1240) and c:GetCode()~=1103910 and c:IsAbleToHand()
end
function c1103910.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup()
		and Duel.IsExistingMatchingCard(c1103910.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1103910.shop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1103910.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
