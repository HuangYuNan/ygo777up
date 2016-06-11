--Lahm Loving
if not senya then local io=require('io') local chk=io.open("expansions/script/c37564765.lua","r") if chk then chk:close() require "expansions/script/c37564765" else require "script/c37564765" end end
function c37564513.initial_effect(c)
	senya.nntr(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37564513,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,37564513+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c37564513.decon(0))
	e1:SetTarget(c37564513.target)
	e1:SetOperation(c37564513.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564513,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,37564513+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c37564513.decon(1))
	e2:SetTarget(c37564513.tdtg)
	e2:SetOperation(c37564513.tdop)
	c:RegisterEffect(e2)
end
function c37564513.filter(c,n)
	if not c:IsFaceup() then return false end
	return (n==0 and c:IsCode(37564765)) or (n==1 and c:GetOriginalCode()==37564765)
end
function c37564513.decon(n)
	return function(e,tp,eg,ep,ev,re,r,rp)
		return Duel.IsExistingMatchingCard(c37564513.filter,tp,LOCATION_MZONE,0,1,nil,n)
	end
end
function c37564513.defilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDestructable()
end
function c37564513.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and c37564513.defilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c37564513.defilter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c37564513.defilter,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c37564513.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c37564513.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c37564513.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
		Duel.Remove(sg,POS_FACEUP,REASON_RULE)
end