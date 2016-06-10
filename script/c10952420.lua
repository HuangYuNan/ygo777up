--星象盘
function c10952420.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10952420+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c10952420.topcon)
	e1:SetTarget(c10952420.target)
	e1:SetOperation(c10952420.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c10952420.negcon)
	e4:SetTarget(c10952420.reptg)
	e4:SetValue(c10952420.repval)
	e4:SetOperation(c10952420.repop)
	c:RegisterEffect(e4)
end
function c10952420.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c10952420.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x233)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c10952420.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c10952420.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(10952420,1))
end
function c10952420.repval(e,c)
	return c10952420.repfilter(c,e:GetHandlerPlayer())
end
function c10952420.repop(e,tp,eg,ep,ev,re,r,rp)
	return Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
function c10952420.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x233)
end
function c10952420.topcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10952420.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c10952420.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_DECK,0,1,nil,TYPE_MONSTER) end
end
function c10952420.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10952420,3))
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_MONSTER)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(tp,1)
	end
end