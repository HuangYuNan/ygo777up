--jiandunshouhu
function c100170015.initial_effect(c)
	aux.AddSynchroProcedure(c,c100170015.tfilter,aux.NonTuner(Card.IsSetCard,0x5cd),1)
	c:EnableReviveLimit()
	--battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
end
function c100170015.tfilter(c)
	return c:IsSetCard(0x5cd)
end
