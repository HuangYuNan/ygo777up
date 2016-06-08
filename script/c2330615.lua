--void-枪
function c2330615.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--void token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2330615,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,23306151)
	e2:SetTarget(c2330615.attg)
	e2:SetOperation(c2330615.atop)
	c:RegisterEffect(e2)
	--void
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(2330600,3))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1,23306152)
	e5:SetTarget(c2330615.target)
	e5:SetOperation(c2330615.activate)
	c:RegisterEffect(e5)
end
function c2330615.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,277617,0xf5,0x4011,1000,1000,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c2330615.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<1 or not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,277617,0xf5,0x4011,1000,1000,1,RACE_FIEND,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,277617)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP)
		tc:SetCardTarget(token)
		Duel.SpecialSummonComplete()
		local e1=Effect.CreateEffect(tc)
		e1:SetDescription(aux.Stringid(2330600,4))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_MZONE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(23306001,RESET_EVENT+0x1fe0000,0,1)
		--Destroy
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetOperation(c2330615.desop)
		tc:RegisterEffect(e2,true)
		--Destroy2
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetCondition(c2330615.descon2)
		e3:SetOperation(c2330615.desop2)
		tc:RegisterEffect(e3,true)
	end
end
function c2330615.desfilter(c,rc)
	return rc:IsHasCardTarget(c)
end
function c2330615.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c2330615.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetHandler())
	Duel.Destroy(g,REASON_RULE)
end
function c2330615.dfilter(c,sg)
	return sg:IsContains(c)
end
function c2330615.descon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()==0 then return false end
	return c:GetCardTarget():IsExists(c2330615.dfilter,1,nil,eg)
end
function c2330615.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)
end

function c2330615.vfilter(c,e,tp)
	return (c:IsCode(2330603) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1)
	or ((c:IsSetCard(0xf9)and c:GetCode()~=2330603 and c:GetCode()~=2330600) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0) 
	and c:GetFlagEffect(23306001)==0 and c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c2330615.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c2330615.vfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c2330615.vfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2330615.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if (tc:IsCode(2330603) and Duel.GetLocationCount(tp,LOCATION_MZONE)<2)
	or ((tc:IsSetCard(0xf9)and tc:GetCode()~=2330603 and tc:GetCode()~=2330600) and Duel.GetLocationCount(tp,LOCATION_SZONE)<1) then return false end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.RaiseSingleEvent(tc,2330600,e,0,0,0,0)
		local e1=Effect.CreateEffect(tc)
		e1:SetDescription(aux.Stringid(2330600,4))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_MZONE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(23306001,RESET_EVENT+0x1fe0000,0,1)
	end
end