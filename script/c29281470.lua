--森羅の水先 リーフ
function c29281470.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281470,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,29281470)
	e1:SetTarget(c29281470.target)
	e1:SetOperation(c29281470.operation)
	c:RegisterEffect(e1)
	local e12=e1:Clone()
	e12:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e12)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,29281471)
	e2:SetCondition(c29281470.condition)
	e2:SetCost(c29281470.atkcost)
	e2:SetTarget(c29281470.atktg)
	e2:SetOperation(c29281470.atkop)
	c:RegisterEffect(e2)
end
function c29281470.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c29281470.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	and Duel.IsExistingMatchingCard(c29281470.filter12,tp,LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c29281470.filter1(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281470.sumfilter(c,e,tp)
	return c:IsSetCard(0x3da) and c:IsLevelBelow(6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29281470.operation(e,tp,eg,ep,ev,re,r,rp)
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1):Filter(c29281470.filter1,nil)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		 and Duel.IsExistingMatchingCard(c29281470.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then
		 Duel.BreakEffect()
		 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		 local g=Duel.SelectMatchingCard(tp,c29281470.sumfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		 Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.MoveSequence(back:GetFirst(),1)
	Duel.RaiseSingleEvent(back:GetFirst(),29281400,e,0,0,0,0)
end
function c29281470.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c29281470.filter12(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281470.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29281470.atkop(e,tp,eg,ep,ev,re,r,rp)
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsSetCard(0x3da) and tc:IsType(TYPE_MONSTER) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		local at=Duel.GetAttacker()
		local atk=Duel.GetAttacker():GetBaseAttack()
		if at:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(atk/2)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			at:RegisterEffect(e1)
		end
	else
		Duel.MoveSequence(back:GetFirst(),1)	 
	end
end