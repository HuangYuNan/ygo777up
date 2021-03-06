--神天竜－ダークネッス
require "expansions/script/c9990000"
function c9991216.initial_effect(c)
	Dazz.GodraExtraCommonEffect(c,19991216)
	--Fusion
	aux.AddFusionProcFun2(c,function(c) return Dazz.IsGodra(c,Card.GetFusionCode) end,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),true)
	c:EnableReviveLimit()
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9991216,1))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,29991216)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c9991216.ccost)
	e1:SetTarget(c9991216.ctg)
	e1:SetOperation(c9991216.cop)
	c:RegisterEffect(e1)
end
c9991216.Dazz_name_godra=true
function c9991216.ccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,2) end
	Duel.DiscardDeck(tp,2,REASON_COST)
end
function c9991216.ctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
end
function c9991216.cop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,3,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end