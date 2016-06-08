--森羅の水先 リーフ
function c29281400.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281400,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,29281400)
	e1:SetTarget(c29281400.target)
	e1:SetOperation(c29281400.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c29281400.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
--[[
function c29281400.filter1(c,e,tp)
	return c:IsSetCard(0x3da) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
]]
function c29281400.operation(e,tp,eg,ep,ev,re,r,rp)
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsSetCard(0x3da) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.DisableShuffleCheck()
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	else
		Duel.MoveSequence(back:GetFirst(),1)
	if tc:IsSetCard(0x3da) then
		Duel.RaiseSingleEvent(tc,29281400,e,0,0,0,0)
	end
	end
end