--ヴォイド・アーチャー マドカ
require "expansions/script/c9990000"
function c9991000.initial_effect(c)
	Dazz.VoidPendulumCommonEffect(c,1)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Multiplied Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(function(e,c)
		return Duel.GetMatchingGroupCount(c9991000.pufilter,c:GetControler(),LOCATION_MZONE,0,nil)-1
	end)
	c:RegisterEffect(e1)
	--Synchro Limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(1)
	e2:SetTarget(function(e,syncard,f,minc,maxc)
		local c=e:GetHandler()
		local lv=syncard:GetLevel()-c:GetLevel()
		if lv<=0 then return false end
		local g=Duel.GetMatchingGroup(c9991000.synfilter,syncard:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
		return g:CheckWithSumEqual(Card.GetSynchroLevel,lv,minc,maxc,syncard)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp,syncard,f,minc,maxc)
		local c=e:GetHandler()
		local lv=syncard:GetLevel()-c:GetLevel()
		local g=Duel.GetMatchingGroup(c9991000.synfilter,tp,LOCATION_MZONE,LOCATION_MZONE,c,syncard,c,f)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local sg=g:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv,minc,maxc,syncard)
		Duel.SetSynchroMaterial(sg)
	end)
	c:RegisterEffect(e2)
	--Power Up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp)
			and c9991000.pufilter(chkc) and chkc~=e:GetHandler() end
		if chk==0 then return Duel.IsExistingTarget(c9991000.pufilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c9991000.pufilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsFaceup() and tc:IsControler(tp) and tc:IsRelateToEffect(e) then
			local val=tc:GetAttack()/2
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(val)
			e:GetHandler():RegisterEffect(e1)
		end
	end)
	c:RegisterEffect(e3)
end
c9991000.Dazz_name_void=1
c9991000.tuner_filter=Dazz.IsVoid
function c9991000.synfilter(c,syncard,tuner,f)
	return c:IsFaceup() and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard,tuner) and Dazz.IsVoid(c) and (not f or f(c))
end
function c9991000.pufilter(c)
	return c:IsFaceup() and Dazz.IsVoid(c)
end