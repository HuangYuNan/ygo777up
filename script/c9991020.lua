--虚望の隕星（ヴォイド・フォーリング）
require "expansions/script/c9990000"
function c9991020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCountLimit(1,9991020+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg:IsExists(function(c,tp) return Dazz.IsVoid(c,Card.GetPreviousCodeOnField) and c:IsPreviousPosition(POS_FACEUP)
			and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp end,1,nil,tp)
	end)
	e1:SetTarget(c9991020.target)
	e1:SetOperation(c9991020.activate)
	c:RegisterEffect(e1)
end
c9991020.Dazz_name_void=1
function c9991020.filter(c)
	return Dazz.IsVoid(c) and c:IsAbleToHand() and (c:IsLocation(LOCATION_GRAVE) or not c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ))
end
function c9991020.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c9991020.filter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c9991020.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c9991020.filter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()~=0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():IsRelateToEffect(e) then
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end