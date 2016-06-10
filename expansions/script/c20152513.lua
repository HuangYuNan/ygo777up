--鼓舞の国际象棋
function c20152513.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,20152513)
	e1:SetTarget(c20152513.target)
	e1:SetOperation(c20152513.activate)
	c:RegisterEffect(e1)
		--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,20152513)
	e2:SetTarget(c20152513.reptg)
	e2:SetValue(c20152513.repval)
	e2:SetOperation(c20152513.repop)
	c:RegisterEffect(e2)
end
function c20152513.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x6290) and c:IsType(TYPE_MONSTER)
end
function c20152513.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c20152513.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152513.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c20152513.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c20152513.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(c20152513.val)
		tc:RegisterEffect(e1)
	end
end
function c20152513.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)*1000
end
function c20152513.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x6290)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c20152513.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c20152513.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(20152513,0))
end
function c20152513.repval(e,c)
	return c20152513.repfilter(c,e:GetHandlerPlayer())
end
function c20152513.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
