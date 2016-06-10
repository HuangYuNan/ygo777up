--百慕 窈窕名流·夏洛特
require "script/c37564765"
function c37564423.initial_effect(c)
	senya.bmdamchk(c,false)
	aux.AddXyzProcedure(c,senya.bmchkfilter,3,2)
	c:EnableReviveLimit()
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37564423,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,37564423)
	e2:SetCost(senya.rmovcost(1))
	e2:SetTarget(c37564423.tdtg)
	e2:SetOperation(c37564423.tdop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37564423,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,37564423)
	e3:SetCost(senya.rmovcost(1))
	e3:SetTarget(c37564423.sptg)
	e3:SetOperation(c37564423.spop)
	c:RegisterEffect(e3)
end
function c37564423.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0) end
end
function c37564423.tdop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetFieldGroupCount(tp,LOCATION_DECK,0) then return end
	Duel.ConfirmDecktop(tp,1)
	local ag=Duel.GetDecktopGroup(tp,1)
	local tc=ag:GetFirst()
	local val=tc:GetTextAttack()/2
		local t1=ag:FilterCount(Card.IsCode,nil,37564451)
		local t2=ag:FilterCount(Card.IsCode,nil,37564452)
		local t3=ag:FilterCount(Card.IsCode,nil,37564453)
		local t4=ag:FilterCount(Card.IsCode,nil,37564454)
		if t1>0 and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
			Duel.Hint(HINT_CARD,0,37564451)
			if Duel.SelectYesNo(tp,aux.Stringid(37564765,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,t1,nil)
				if g:GetCount()>0 then
					Duel.HintSelection(g)
					Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
				end
			end
		end
		if t2>0 then
			Duel.Hint(HINT_CARD,0,37564452)
			for i=1,t2 do
			   c:RegisterFlagEffect(37564498,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			end
		end
		if t3>0 then
			Duel.Hint(HINT_CARD,0,37564453)
			val=val+(t3*750)
		end
		if t4>0 then
			Duel.Hint(HINT_CARD,0,37564454)
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,t4*2,REASON_EFFECT)
		end
		if senya.bmchkfilter(tc) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and tc:IsLocation(LOCATION_DECK) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
				Duel.BreakEffect()
				Duel.Recover(tp,val,REASON_EFFECT)
				Duel.Damage(1-tp,val,REASON_EFFECT)
			end
		end
	Duel.ShuffleDeck(tp)
end
function c37564423.filter(c,e,tp)
	return senya.bmchkfilter(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==3 and Duel.GetFlagEffect(tp,c:GetCode())==0
end
function c37564423.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37564423.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c37564423.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37564423.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		tc:RegisterFlagEffect(37564499,RESET_EVENT+0x1fe0000,0,1)
		Duel.RegisterFlagEffect(tp,tc:GetCode(),RESET_PHASE+PHASE_END,0,1)
		Duel.SpecialSummonComplete()
	end
end