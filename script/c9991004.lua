--ヴォイド・マスケッティーア マミ
require "expansions/script/c9990000"
function c9991004.initial_effect(c)
	Dazz.VoidPendulumCommonEffect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Procedure
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(function(e,c)
		if c==nil then return true end
		return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(function(c)
				return c:IsFaceup() and Dazz.IsVoid(c) end,c:GetControler(),LOCATION_MZONE,0,2,nil)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local ex=Effect.CreateEffect(c)
		ex:SetType(EFFECT_TYPE_FIELD)
		ex:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		ex:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		ex:SetTargetRange(1,0)
		ex:SetTarget(function(e,c,sump,sumtype,sumpos,targetp,sumtp)
			return c:IsLocation(LOCATION_HAND) and sumtype~=SUMMON_TYPE_PENDULUM
		end)
		ex:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(ex,tp)
	end)
	c:RegisterEffect(e1)
	--Position Change
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(function(e,tp)
		return Duel.IsExistingMatchingCard(function(c)
			return c:IsFaceup() and Dazz.IsVoid(c) and (c:GetSequence()==6 or c:GetSequence()==7)
		end,tp,LOCATION_SZONE,0,1,nil)
	end)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return Duel.IsExistingMatchingCard(aux.TURE,tp,0,LOCATION_MZONE,1,nil) and e:GetHandler():IsDestructable() end
		local sg=Duel.GetMatchingGroup(aux.TURE,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetMatchingGroup(aux.TURE,tp,0,LOCATION_MZONE,nil) local c=e:GetHandler()
		if not c:IsRelateToEffect(e) or sg:GetCount()==0 then return end
		if Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)~=0 then
			Duel.BreakEffect()
			Duel.Destroy(c,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e2)
end
c9991004.Dazz_name_void=1