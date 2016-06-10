--京都人形
function c99991004.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99991004,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_SZONE)
	e1:SetCode(99991003)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,99991004)
	e1:SetCost(c99991004.spcost)
	e1:SetTarget(c99991004.sptg)
	e1:SetOperation(c99991004.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(99991004,ACTIVITY_SPSUMMON,c99991004.counterfilter)
    --draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99991004,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(99991003)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,99991011)
	e2:SetTarget(c99991004.drtg)
	e2:SetOperation(c99991004.drop)
	c:RegisterEffect(e2)
end
function c99991004.counterfilter(c)
	return c:IsSetCard(0x2e6)
end
function c99991004.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(99991004,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c99991004.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c99991004.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x2e6)
end
function c99991004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c99991004.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
		if c:GetPreviousLocation()==LOCATION_SZONE then 
		Duel.RaiseEvent(e:GetHandler(),99991003,e,0,tp,0,0)
	end
end
end
function c99991004.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c99991004.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
