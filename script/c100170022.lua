--baoshejituan--
function c100170022.initial_effect(c)
	c:SetUniqueOnField(1,0,100170022)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--net
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_FIELD)
	--e2:SetCode(EFFECT_IMMUNE_EFFECT)
	--e2:SetRange(LOCATION_SZONE)
	--e2:SetTargetRange(LOCATION_ONFIELD,0)
	--e2:SetTarget(c100170022.netg)
	--e2:SetValue(1)
	--c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1)
	e3:SetCondition(c100170022.thcon)
	e3:SetTarget(c100170022.thtg)
	e3:SetOperation(c100170022.thop)
	c:RegisterEffect(e3)
end
--function c100170022.netg(e,c)
	--return c~=e:GetHandler() and c:IsSetCard(0x5cd) and c:IsType(TYPE_SPELL+TYPE_TRAP)
--end
function c100170022.thcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and tg~=e:GetHandler() and tg:IsSetCard(0x5cd) and ( tg:GetSummonType()==SUMMON_TYPE_SYNCHRO or tg:GetSummonType()==SUMMON_TYPE_FUSION or tg:GetSummonType()==SUMMON_TYPE_XYZ)
end
function c100170022.thfilter(c)
	return c:IsSetCard(0x5cd) and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)) and c:IsAbleToHand()
end
function c100170022.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100170022.thfilter,tp,LOCATION_GRAVE,0,1,nil)  and e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c100170022.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c100170022.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end