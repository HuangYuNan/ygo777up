--机械女仆 翡翠
function c99999012.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCode(EVENT_CHANGE_POS)
    e1:SetCountLimit(1,99999019+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c99999012.spcon)
	e1:SetTarget(c99999012.sptg)
	e1:SetOperation(c99999012.spop)
	c:RegisterEffect(e1)
	--xyz limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c99999012.limit)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_CHANGE_POS)
	e3:SetCondition(c99999012.drcon)
	e3:SetCountLimit(1,99999012+EFFECT_COUNT_CODE_OATH)
	e3:SetTarget(c99999012.drtg)
	e3:SetOperation(c99999012.drop)
	c:RegisterEffect(e3)
	--ind
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_NAGA+EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_TO_DECK)
	e4:SetCountLimit(1,99999012+EFFECT_COUNT_CODE_OATH)
	e4:SetCondition(c99999012.incon)
	e4:SetTarget(c99999012.intg)
	e4:SetOperation(c99999012.inop)
	c:RegisterEffect(e4)
end
function c99999012.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(tp) and ec:IsPreviousPosition(POS_FACEUP)
end
function c99999012.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c99999012.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
		c:CompleteProcedure()
	end
end
function c99999012.limit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x2e5) 
end
function c99999012.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c99999012.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c99999012.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c99999012.incon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c99999012.infilter(c)
	return c:IsFaceup() and  c:IsSetCard(0x2e5)
end
function c99999012.intg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c99999012.infilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99999012.infilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c99999012.infilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c99999012.inop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end