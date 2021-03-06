--Smothering Abomination
require "expansions/script/c9990000"
function c9991161.initial_effect(c)
	--Xyz
	c:EnableReviveLimit()
	Dazz.AddXyzProcedureEldrazi(c,4,2,nil,nil)
	--Devoid
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ex:SetRange(LOCATION_MZONE)
	ex:SetCode(EFFECT_ADD_ATTRIBUTE)
	ex:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(ex)
	--AD Change
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	end)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)>0 end
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local sg=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
		if sg:GetCount()==0 then return end
		local c=e:GetHandler()
		local sg=sg:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		local tc=sg:GetFirst()
		if tc:IsFacedown() then
			Duel.Remove(tc,POS_FACEUP,REASON_RULE)
		else
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(1500)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			e2:SetValue(-1500)
			tc:RegisterEffect(e2)
			if tc:GetDefense()==0 then
				if tc:IsAbleToRemove() then
					Duel.Remove(tc,POS_FACEUP,REASON_RULE)
				else
					Duel.SendtoGrave(tc,REASON_RULE)
				end
			end
		end
	end)
	c:RegisterEffect(e1)
end