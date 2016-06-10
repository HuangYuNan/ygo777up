--引诱契约的淫兽  丘比
function c1000800.initial_effect(c)
	--negate 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1000800,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,1000800)
	e1:SetCondition(c1000800.negcon)
	e1:SetCost(c1000800.cost)
	e1:SetTarget(c1000800.negtg)
	e1:SetOperation(c1000800.negop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1000800,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1,1000800)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c1000800.tgcon)
	e2:SetCost(c1000800.cost)
	e2:SetTarget(c1000800.tgtg)
	e2:SetOperation(c1000800.tgop)  
	c:RegisterEffect(e2)
end
function c1000800.cfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsControler(tp) and 
	(c:IsSetCard(0x3204) or c:IsSetCard(0xa204) or c:IsSetCard(0x120) or c:IsSetCard(0x200) or c:IsSetCard(0xc204) or c:IsSetCard(0x72c))
end
function c1000800.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	if not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c1000800.cfilter,1,nil,tp) and Duel.IsChainNegatable(ev)
end
function c1000800.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c1000800.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c1000800.negop(e,tp,eg,ep,ev,re,r,rp)
	 if e:GetHandler():IsRelateToEffect(e)  and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)~=0 then
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
end
function c1000800.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if tp==Duel.GetTurnPlayer() then return false end
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsFaceup() and tc:IsControler(tp) and (tc:IsSetCard(0xa204) or
	tc:IsSetCard(0x3204) or tc:IsSetCard(0x120) or tc:IsSetCard(0x200) or tc:IsSetCard(0xc204) or c:IsSetCard(0x72c))
end
function c1000800.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local g=Duel.GetAttacker()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tg,0)
end
function c1000800.tgop(e,tp,eg,ep,ev,re,r,rp)
	 local g=Duel.GetAttacker()
	 if e:GetHandler():IsRelateToEffect(e)  and g
	 and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)~=0 and 
	 Duel.Destroy(g,REASON_EFFECT)>0 then
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
end