--农业之神  神奈子
function c1100058.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c1100058.reg)
	c:RegisterEffect(e1)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_PZONE)
	e5:SetDescription(aux.Stringid(1100058,1))
	e5:SetCountLimit(1,1100058)
	e5:SetCondition(c1100058.thcon)
	e5:SetTarget(c1100058.thtg)
	e5:SetOperation(c1100058.thop)
	c:RegisterEffect(e5)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetCondition(function(e) return not e:GetHandler():IsHasEffect(EFFECT_FORBIDDEN) end)
	e2:SetTarget(c1100058.splimit)
	c:RegisterEffect(e2)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1100058,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c1100058.spcon)
	e2:SetTarget(c1100058.sptg)
	e2:SetOperation(c1100058.spop)
	c:RegisterEffect(e2)
end
function c1100058.reg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(1100058,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c1100058.splimit(e,c)
	return not c:IsSetCard(0x5240)
end
function c1100058.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(1100058)~=0
end
function c1100058.thfilter(c)
	return c:GetLevel()==3 and c:IsSetCard(0x5240) and c:IsAbleToHand()
end
function c1100058.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1100058.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1100058.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1100058.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c1100058.cfilter(c,tp)
	return c:IsSetCard(0x5240) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c1100058.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1100058.cfilter,1,nil,tp)
end
function c1100058.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c1100058.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end