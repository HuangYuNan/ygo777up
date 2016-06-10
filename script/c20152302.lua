--高坂桐乃
function c20152302.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetCondition(c20152302.pcon)
	e2:SetTarget(c20152302.tgtg)
	e2:SetValue(c20152302.tgval)
	c:RegisterEffect(e2)
	--pos
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152302,0))
	e3:SetCategory(CATEGORY_POSITION)   
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c20152302.target)
	e3:SetOperation(c20152302.operation)
	c:RegisterEffect(e3)
	--splimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetTargetRange(1,0)
	e4:SetCondition(function(e) return not e:GetHandler():IsHasEffect(EFFECT_FORBIDDEN) end)
	e4:SetTarget(c20152302.splimit)
	c:RegisterEffect(e3)
			--scale
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetCode(EFFECT_CHANGE_LSCALE)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e4:SetRange(LOCATION_PZONE)
	--e4:SetCondition(c20152302.sccon)
	--e4:SetValue(4)
	--c:RegisterEffect(e4)
	--local e5=e4:Clone()
	--e5:SetCode(EFFECT_CHANGE_RSCALE)
	--c:RegisterEffect(e5)
	--cannot disable
	--local e6=Effect.CreateEffect(c)
	--e6:SetType(EFFECT_TYPE_SINGLE)
	--e6:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)  
	--e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--c:RegisterEffect(e6)
end
function c20152302.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x5290)
end
function c20152302.pcon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return tc and tc:IsSetCard(0x5290)
end
--function c20152302.sccon(e)
	--local seq=e:GetHandler():GetSequence()
	--local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	--return not tc or not tc:IsSetCard(0x5290)
--end
function c20152302.tgtg(e,c)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x5290) and c:IsOnField()
end
function c20152302.tgval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c20152302.filter(c,e,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==1-tp and (not e or c:IsRelateToEffect(e))
end
function c20152302.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c20152302.filter,1,nil,nil,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,eg,eg:GetCount(),0,0)
end
function c20152302.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c20152302.filter,nil,e,tp)
	Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
end