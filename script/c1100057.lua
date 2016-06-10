--山丘湖泊的化身  神奈子
function c1100057.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(1100057,3))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCountLimit(1,11000570)
	e5:SetTarget(c1100057.tgtg)
	e5:SetOperation(c1100057.tgop)
	c:RegisterEffect(e5)  
end
function c1100057.tgfilter(c)
	return c:IsSetCard(0x5240) and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)) and c:IsSSetable(true) and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
end
function c1100057.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_DECK+LOCATION_GRAVE) and c1100057.tgfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c1100057.tgfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c1100057.tgfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp)
end
function c1100057.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
	end
end