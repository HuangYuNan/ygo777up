--�ػ�Ů��  ��³¶��
function c1101117.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c1101117.spcon)
	c:RegisterEffect(e1)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(1101117,1))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCountLimit(1,1101117)
	e5:SetTarget(c1101117.thtg)
	e5:SetOperation(c1101117.thop)
	c:RegisterEffect(e5)
end
function c1101117.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1241) 
end
function c1101117.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c1101117.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c1101117.thfilter(c)
	return c:IsSetCard(0x1241) and c:GetCode()~=1101117 and c:IsAbleToHand()
end
function c1101117.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1101117.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c1101117.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1101117.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end