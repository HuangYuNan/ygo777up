--流星优势
function c10952425.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCost(c10952425.spcost)
	e1:SetTarget(c10952425.destg)
	e1:SetOperation(c10952425.desop)
	c:RegisterEffect(e1)	
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetDescription(aux.Stringid(10952425,0))
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c10952425.condtion)
	e4:SetCountLimit(1,10952425)
	e4:SetTarget(c10952425.target)
	e4:SetOperation(c10952425.operation)
	c:RegisterEffect(e4)	
end
function c10952425.costfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c10952425.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10952425.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c10952425.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c10952425.dfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x233) or c:IsSetCard(0x232))
end
function c10952425.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingMatchingCard(c10952425.dfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
		and Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c10952425.dfilter,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c10952425.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c10952425.condtion(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_DECK
end
function c10952425.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x233) and c:IsAbleToHand()
end
function c10952425.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10952425.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10952425.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10952425.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
