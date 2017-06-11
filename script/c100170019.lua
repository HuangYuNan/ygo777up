--tiangoujingrui
function c100170019.initial_effect(c)
	aux.AddSynchroProcedure(c,c100170019.tfilter,aux.NonTuner(),2)
	c:EnableReviveLimit()
	--connot Remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(0,1)
	c:RegisterEffect(e1)
	--not Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c100170019.indtg)
	e2:SetValue(c100170019.indval)
	c:RegisterEffect(e2)
	--not att PLAYER
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e4)
end
function c100170019.indfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsSetCard(0x5cd)
end
function c100170019.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c100170019.indfilter,1,nil,tp) end
	return true
end
function c100170019.indval(e,c)
	return c100170019.indfilter(c,e:GetHandlerPlayer())
end
function c100170019.tfilter(c)
	return c:IsSetCard(0x5cd) and c:IsType(TYPE_SYNCHRO)
end