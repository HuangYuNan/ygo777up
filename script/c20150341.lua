--Ratatoskr·Fraxinus
function c20150341.initial_effect(c)
	c:SetUniqueOnField(1,0,20150341)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c20150341.sprcon)
	e2:SetOperation(c20150341.sprop)
	c:RegisterEffect(e2)  
	--reover
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(20150341,1))
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,201503411)
	e3:SetCondition(c20150341.recon)
	e3:SetTarget(c20150341.rectg)
	e3:SetOperation(c20150341.recop)
	c:RegisterEffect(e3)
	--reover
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20150341,2))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,201503411)
	e4:SetCondition(c20150341.recon)
	e4:SetTarget(c20150341.target2)
	e4:SetOperation(c20150341.activate2)
	c:RegisterEffect(e4)
	--reover
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(20150341,3))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,201503411)
	e5:SetCondition(c20150341.recon)
	e5:SetTarget(c20150341.ntarget)
	e5:SetOperation(c20150341.noperation)
	c:RegisterEffect(e5)
end
function c20150341.sprfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x9291) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c20150341.sprcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c20150341.sprfilter2,c:GetControler(),LOCATION_MZONE,0,3,nil)
end
function c20150341.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c20150341.sprfilter2,c:GetControler(),LOCATION_MZONE,0,3,3,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c20150341.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3291)
end
function c20150341.recon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20150341.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c20150341.recfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3291)
end
function c20150341.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c20150341.recfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ct*1000)
end
function c20150341.recop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c20150341.recfilter,p,LOCATION_MZONE,0,nil)
	if ct>0 then
		Duel.Recover(p,ct*1000,REASON_EFFECT)
	end
end
function c20150341.filter2(c)
	return c:IsFaceup() and (c:IsSetCard(0x3291) or c:IsSetCard(0x9291))
end
function c20150341.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED+LOCATION_GRAVE) and c20150341.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20150341.filter2,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20150341,0))
	local g=Duel.SelectTarget(tp,c20150341.filter2,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c20150341.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
function c20150341.nfilter(c,e,sp)
	return c:IsSetCard(0x3291) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c20150341.ntarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c20150341.nfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c20150341.noperation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c20150341.nfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end