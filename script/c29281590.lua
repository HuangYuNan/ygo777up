--ダンディライオン
function c29281590.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281590,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_NAGA+EFFECT_FLAG_DELAY)
	e1:SetCode(29281400)
	e1:SetCountLimit(1,29281590)
	e1:SetTarget(c29281590.target)
	e1:SetOperation(c29281590.operation)
	c:RegisterEffect(e1)
	--multi attack
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29281590,1))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetCountLimit(1,29281591)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c29281590.target2)
	e10:SetOperation(c29281590.mtop)
	c:RegisterEffect(e10)
end
function c29281590.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29281590.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c29281590.filter1(c)
	return c:IsSetCard(0x3da)
end
function c29281590.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281590.sumfilter(c,e,tp)
	return c:GetCode()==29281590 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29281590.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29281590.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281480.filter1,nil)
	if g:GetCount()>0 then
		Duel.MoveSequence(back:GetFirst(),1)
		Duel.Damage(1-tp,600,REASON_EFFECT)
		local tg=g:GetFirst()
		Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
	else
		Duel.MoveSequence(back:GetFirst(),1)
	end
end