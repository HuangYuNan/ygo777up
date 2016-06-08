--hongfengsanluo
function c29281650.initial_effect(c)
	aux.AddSynchroProcedure(c,c29281650.tfilter,aux.NonTuner(Card.IsSetCard,0x3da),1)
	c:EnableReviveLimit()
	--To Grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29281650,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,29281650)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetTarget(c29281650.target2)
	e2:SetOperation(c29281650.mtop)
	c:RegisterEffect(e2)
	--[[multi attack
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(29281650,1))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetCountLimit(1,29281651)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTarget(c29281650.target2)
	e10:SetOperation(c29281650.mtop)
	c:RegisterEffect(e10)]]
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29281650,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,29281650)
	e1:SetTarget(c29281650.sptg)
	e1:SetOperation(c29281650.spop)
	c:RegisterEffect(e1)
end
function c29281650.tfilter(c)
	return c:IsSetCard(0x3da)
end
function c29281650.filter1(c)
	return c:IsSetCard(0x3da)
end
function c29281650.filter2(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281650.filter5(c)
	return c:IsAbleToGrave()
end
function c29281650.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	  and Duel.IsExistingMatchingCard(c29281650.filter5,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
end
function c29281650.sumfilter(c)
	return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281650.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,2) then return end
	Duel.ConfirmDecktop(tp,2)
	local g=Duel.GetDecktopGroup(tp,2):Filter(c29281650.filter2,nil)
	local g1=Duel.GetMatchingGroup(c29281650.filter5,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	   if g:GetCount()>1 then
	   Duel.SortDecktop(tp,tp,2)
	   for i=1,2 do
		   local mg=Duel.GetDecktopGroup(tp,1)
		   Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
	   end
	   Duel.SendtoGrave(g1,REASON_EFFECT)
	   else
	   Duel.SortDecktop(tp,tp,2)
	   for i=1,2 do
		   local mg=Duel.GetDecktopGroup(tp,1)
		   Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
	   end
	 end
end
function c29281650.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsPlayerCanDiscardDeck(tp,3) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29281650.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local back=Duel.GetDecktopGroup(tp,1)
	if not Duel.IsPlayerCanDiscardDeck(tp,3) then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3):Filter(c29281650.filter2,nil)
	   if g:GetCount()>2 then
	   Duel.SortDecktop(tp,tp,3)
	   for i=1,3 do
		   local mg=Duel.GetDecktopGroup(tp,1)
		   Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
	   end
	   if e:GetHandler():IsRelateToEffect(e) then
		  Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	   end
	   else
	   Duel.SortDecktop(tp,tp,3)
	   for i=1,3 do
		   local mg=Duel.GetDecktopGroup(tp,1)
		   Duel.MoveSequence(mg:GetFirst(),1)
		   Duel.RaiseSingleEvent(mg:GetFirst(),29281400,e,0,0,0,0)
	   end
	end
end