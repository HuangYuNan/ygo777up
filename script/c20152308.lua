--田村麻奈实
function c20152308.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetTarget(c20152308.bttg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20152308,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,20152308)
	e3:SetCondition(c20152308.pcon)
	e3:SetTarget(c20152308.indtg)
	e3:SetOperation(c20152308.indop)
	c:RegisterEffect(e3)
	--splimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetTargetRange(1,0)
	e4:SetCondition(function(e) return not e:GetHandler():IsHasEffect(EFFECT_FORBIDDEN) end)
	e4:SetTarget(c20152308.splimit)
	c:RegisterEffect(e4)
	--scale
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_SINGLE)
	--e4:SetCode(EFFECT_CHANGE_LSCALE)
	--e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e4:SetRange(LOCATION_PZONE)
	--e4:SetCondition(c20152308.sccon)
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
	--buhuipohuai
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EFFECT_DESTROY_REPLACE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(2)
	e7:SetTarget(c20152308.indtg2)
	e7:SetValue(c20152308.indval2)
	c:RegisterEffect(e7)
end
function c20152308.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x5290)
end
function c20152308.pcon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return tc and tc:IsSetCard(0x5290)
end
--function c20152308.sccon(e)
	--local seq=e:GetHandler():GetSequence()
	--local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	--return not tc or not tc:IsSetCard(0x5290)
--end
function c20152308.cfilter(c)
return c:IsSetCard(0x5290) and c:IsType(TYPE_MONSTER)
end
function c20152308.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c20152308.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20152308.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c20152308.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c20152308.indop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c20152308.bttg(e,c)
	return c:IsSetCard(0x5290) and c~=e:GetHandler()
end
function c20152308.filter2(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_SZONE) and (c:GetSequence()==6 or c:GetSequence()==7)
		and c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp
end
function c20152308.indtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c20152308.filter2,1,nil,tp) end
	return true
end
function c20152308.indval2(e,c)
	return c20152308.filter2(c,e:GetHandlerPlayer())
end
