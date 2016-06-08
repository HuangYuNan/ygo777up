--ジャンク・フォアード
function c29281680.initial_effect(c)
	--special summon
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(29281680,0))
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_SPSUMMON_PROC)
	e11:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e11:SetRange(LOCATION_HAND)
	e11:SetCondition(c29281680.spcon)
	c:RegisterEffect(e11)
	--spsummon limit
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c29281680.limcon)
	e3:SetOperation(c29281680.limop)
	c:RegisterEffect(e3)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281680,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,29281680)
	e1:SetCost(c29281680.cost)
	e1:SetTarget(c29281680.target)
	e1:SetOperation(c29281680.operation)
	c:RegisterEffect(e1)
end
function c29281680.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0,nil)==0
end
function c29281680.limcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c29281680.limop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c29281680.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c29281680.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x3da)
end
function c29281680.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c29281680.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c29281680.tdfilter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c29281680.operation(e,tp,eg,ep,ev,re,r,rp)
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	if g:GetCount()>0 then
	Duel.MoveSequence(back:GetFirst(),1)
	local dg=Duel.GetMatchingGroup(c29281680.tdfilter,tp,LOCATION_GRAVE,0,nil)
	if dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(29281680,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local tg=dg:Select(tp,1,1,nil)
		Duel.HintSelection(tg)
		Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	end
	end
	local tg=g:GetFirst()
	Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)		
end