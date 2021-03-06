--Ulamog, the Ceaseless Hunger
require "expansions/script/c9990000"
function c9991150.initial_effect(c)
	c:SetUniqueOnField(1,0,9991150,LOCATION_MZONE)
	--Synchro
	c:EnableReviveLimit()
	Dazz.AddSynchroProcedureEldrazi(c,1,10,function(e,tp)
		local tg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		if tg:GetCount()==0 then return end
		if tg:GetCount()>2 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			tg=tg:Select(tp,2,2,nil)
		end
		Duel.HintSelection(tg)
		local et={}
		tg:ForEach(function(tc)
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(LOCATION_REMOVED)
			tc:RegisterEffect(e1,true)
			table.insert(et,e1)
		end)
		Duel.SendtoGrave(tg,REASON_RULE+REASON_DESTROY)
		for i,rde in pairs(et) do
			rde:Reset()
		end
	end)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,20,1-tp,LOCATION_DECK)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetDecktopGroup(1-tp,20)
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end)
	c:RegisterEffect(e1)
end