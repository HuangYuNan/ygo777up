--厄灵 暗影骨龙
require "script/c20329999"
function c20321007.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_ZOMBIE),aux.NonTuner(c20321007.synfilter),1)
	c:EnableReviveLimit()
	--td1
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20321007,0))
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c20321007.tdcon1)
	e4:SetTarget(c20321007.tdtg1)
	e4:SetOperation(c20321007.tdop1)
	c:RegisterEffect(e4)
	--cannot summon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_SUMMON)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c20321007.effcon)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e7)
	--td2
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60800381,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c20321007.con)
	e1:SetOperation(c20321007.op)
	c:RegisterEffect(e1)
end
function c20321007.synfilter(c)
	return c:GetDefence()==0
end
function c20321007.tdcon1(e,tp,eg,ep,ev,re,r,rp)
	local tgp=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_CONTROLER)
	return tgp~=tp and re:IsActiveType(TYPE_MONSTER) and loc==LOCATION_MZONE
end
function c20321007.tdtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,0,0)
end
function c20321007.tdop1(e,tp,eg,ep,ev,re,r,rp)
	Mfrog.elmtd(e,tp,1,LOCATION_DECK)
end
function c20321007.effcon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandler():GetControler()
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	return tc:IsSetCard(0x281) and tc:GetControler()==1-tc:GetOwner()
end
function c20321007.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c20321007.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Mfrog.elmtdfilter,tp,LOCATION_GRAVE,0,nil)
	local num=g:GetCount()
	if num<1 then return end
	local c=g:GetFirst()
	local num=g:GetCount()
	for i=1,num,1 do
		Duel.SendtoDeck(c,1-tp,2,REASON_EFFECT)
		c:ReverseInDeck()
		c=g:GetNext()
	end
	Duel.ShuffleDeck(1-tp)
end