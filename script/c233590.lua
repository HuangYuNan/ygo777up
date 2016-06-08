--战舰栖姬
function c233590.initial_effect(c)
    --synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WATER),1)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(233590,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c233590.tocon)
	e2:SetTarget(c233590.totg)
	e2:SetOperation(c233590.toop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(233590,1))
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetTarget(c233590.sptg)
	e3:SetOperation(c233590.spop)
	c:RegisterEffect(e3)
	--Announce
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(233590,2))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c233590.ancost)
	e4:SetOperation(c233590.anop)
	c:RegisterEffect(e4)
end
function c233590.tocon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end	
function c233590.tofilter(c)
	return c:IsType(0x6) and c:IsAbleToDeck()
end
function c233590.totg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c233590.tofilter,tp,0xc,0xc,1,nil) end
    local g=Duel.GetMatchingGroup(c233590.tofilter,tp,0xc,0xc,nil) 
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end	
function c233590.toop(e,tp,eg,ep,ev,re,r,rp)
     local g=Duel.GetMatchingGroup(c233590.tofilter,tp,0xc,0xc,nil) 
     if g:GetCount()>0 then
     Duel.SendtoDeck(g,nil,2,0x40) 
	end
end	
function c233590.filter(c)
	return c:IsAttribute(0x2) and c:IsAbleToDeckAsCost()
end
function c233590.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c233590.filter,tp,0x10,0,1,nil) end
	local g=Duel.GetMatchingGroup(c233590.filter,tp,0x10,0,nil) 
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c233590.spop(e,tp,eg,ep,ev,re,r,rp)
      local c=e:GetHandler()
	  local g=Duel.GetMatchingGroup(c233590.filter,tp,0x10,0,nil) 
	  if g:GetCount()==0 then return end
	  Duel.SendtoDeck(g,nil,2,0x40)
	  if c:IsRelateToEffect(e) then
      Duel.BreakEffect() 
	  Duel.SpecialSummon(c,0,tp,tp,false,false,0x5) 
	 end 
end	  
function c233590.ancost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetLabelObject() then e:GetLabelObject():Reset() end
end
function c233590.anop(e,tp,eg,ep,ev,re,r,rp)
       local c=e:GetHandler()
       local ct=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10) 
	   if c:IsFaceup() and c:IsRelateToEffect(e) then
	   local e1=Effect.CreateEffect(c)
	   e1:SetType(EFFECT_TYPE_SINGLE)
	   e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	   e1:SetRange(LOCATION_MZONE)
	   e1:SetLabel(ct) 
	   e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	   e1:SetReset(RESET_EVENT+0x1fe0000)
	   e1:SetValue(c233590.tgvalue)
	   e:SetLabelObject(e1)
	   c:RegisterEffect(e1)
	 end  
end  
function c233590.tgvalue(e,re,rp)
	return re:GetHandler():IsType(0x800000) and re:GetHandler():GetRank()==e:GetLabel() 
end