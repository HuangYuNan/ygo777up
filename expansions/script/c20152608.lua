--结衣
function c20152608.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20152608,1))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,20152608)
	e1:SetTarget(c20152608.target)
	e1:SetOperation(c20152608.activate)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20152608,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,20152608)
	e2:SetCost(c20152608.thcost)
	e2:SetTarget(c20152608.thtg)
	e2:SetOperation(c20152608.thop)
	c:RegisterEffect(e2)
end
function c20152608.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0xa290) and c:GetOverlayCount()==0
end
function c20152608.filter2(c)
	return c:IsSetCard(0xa290) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c20152608.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c20152608.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c20152608.filter2,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20152608,1))
	local g1=Duel.SelectTarget(tp,c20152608.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20152608,2))
	local g2=Duel.SelectTarget(tp,c20152608.filter2,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g2,2,0,0)
end
function c20152608.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFacedown() then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,tc,e)
	if g:GetCount()>0 then
		Duel.Overlay(tc,g)
	end
end
function c20152608.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c20152608.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c20152608.filter(c,e,tp)
	return c:IsSetCard(0xa290) and not c:IsCode(20152608) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c20152608.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardDeck(tp,1,REASON_EFFECT)==1 then
		local g=Duel.GetOperatedGroup()
		if g:GetFirst():IsSetCard(0xa290) then
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c20152608.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		  end
		end
	end
end

