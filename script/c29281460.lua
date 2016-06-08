--ゴーストリック・アルカード
function c29281460.initial_effect(c)
	aux.AddSynchroProcedure(c,c29281460.tfilter,aux.NonTuner(Card.IsSetCard,0x3da),2)
	c:EnableReviveLimit()
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281460,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,29281461)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c29281460.mtcon)
	e1:SetOperation(c29281460.mtop)
	c:RegisterEffect(e1)
	--sort
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,29281460)
	e2:SetCondition(c29281460.sdcon)
	e2:SetTarget(c29281460.sdtg)
	e2:SetOperation(c29281460.sdop)
	c:RegisterEffect(e2)
end
function c29281460.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
end
function c29281460.filter1(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER) 
end
function c29281460.mtop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	local ct=g:FilterCount(c29281450.filter1,nil)
	Duel.ShuffleDeck(tp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	e1:SetValue(ct-1)
	e:GetHandler():RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetCondition(c29281460.rdcon)
		e2:SetOperation(c29281460.rdop)
		e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e:GetHandler():RegisterEffect(e2)
end
function c29281460.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c29281460.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end
function c29281460.tfilter(c)
	return c:IsSetCard(0x3da)
end
function c29281460.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c29281460.sdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>3 end
end
function c29281460.sdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,4)
end