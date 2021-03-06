--フロスト・ウオーム
function c9990312.initial_effect(c)
	--Synchro & Pendulum
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	aux.EnablePendulumAttribute(c,false)
	--Summon Activation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9990312,1))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,19990312)
	e1:SetTarget(c9990312.target1)
	e1:SetOperation(c9990312.operation1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(9990312,0))
	e2:SetCountLimit(2,19990312)
	e2:SetTarget(c9990312.target2)
	e2:SetOperation(c9990312.operation2)
	c:RegisterEffect(e2)
	--To Pendulum Zone
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,39990312)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c9990312.target3)
	e3:SetOperation(c9990312.operation3)
	c:RegisterEffect(e3)
end
function c9990312.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(Card.IsPreviousLocation,1,nil,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE) end
	local tg=eg:Filter(Card.IsPreviousLocation,nil,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
	Duel.SetTargetCard(tg)
end
function c9990312.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==0 then return end
	if tg:GetCount()>1 then tg=tg:Select(tp,1,1,nil) end
	Duel.HintSelection(tg)
	Duel.SendtoGrave(tg,REASON_EFFECT)
end
function c9990312.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:GetCount()==1 and tc:GetSummonType()==SUMMON_TYPE_XYZ and tc:GetOverlayCount()~=0 end
	Duel.SetTargetCard(eg)
	Duel.HintSelection(eg)
end
function c9990312.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==0 then return end
	og=tg:GetFirst():GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_EFFECT)
end
function c9990312.spfilter(c,e,tp)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9990312.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c9990312.spfilter(chkc,e,tp) end
	if chk==0 then return bit.band(e:GetHandler():GetOriginalType(),TYPE_PENDULUM)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c9990312.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c9990312.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c9990312.operation3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 or not e:GetHandler():IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	if not (Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7)) then return end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end