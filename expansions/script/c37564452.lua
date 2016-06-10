--百慕 神秘微笑·亚拉璐
require "script/c37564765"
function c37564452.initial_effect(c)
	senya.bm(c)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564452,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(senya.bmsscon)
	e3:SetTarget(c37564452.target)
	e3:SetOperation(c37564452.operation)
	c:RegisterEffect(e3)
end
function c37564452.filter(c,e,tp)
	return senya.bmchkfilter(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37564452.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c37564452.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c37564452.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) and e:GetHandler():IsAbleToDeck() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c37564452.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c37564452.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 and e:GetHandler():IsRelateToEffect(e) then
			Duel.ShuffleDeck(tp)
			Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
		end
	end
end