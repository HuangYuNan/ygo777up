--奇迹小镇-杏
function c1001003.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,1001003)
	e1:SetCondition(c1001003.atkcon)
	e1:SetOperation(c1001003.atkop)
	c:RegisterEffect(e1)
	--tohand or SPECIAL_SUMMON
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1001003,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,10010030)
	e1:SetCondition(c1001003.spcon)
	e1:SetTarget(c1001003.sptg)
	e1:SetOperation(c1001003.spop)
	c:RegisterEffect(e1)
end
function c1001003.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonLocation()==LOCATION_GRAVE
end
function c1001003.atktg(e,c)
	return c:IsSetCard(0x9204) 
end
function c1001003.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c1001003.atktg)
	e1:SetValue(500)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	Duel.RegisterEffect(e2,tp)
end
function c1001003.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_FUSION
end
function c1001003.filter(c,e,tp,ft)
	return c:IsSetCard(0x9204) and (c:IsAbleToHand() or (ft>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c1001003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c1001003.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c1001003.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1001003.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	local tc=g:GetFirst()
	if tc then
		if ft>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToHand() or Duel.SelectYesNo(tp,aux.Stringid(1001003,1))) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end

