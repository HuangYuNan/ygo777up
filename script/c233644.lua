--幻想光
function c233644.initial_effect(c)
    c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
    --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c233644.spcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(233644,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1,233644+EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c233644.sumcon)
	e2:SetTarget(c233644.sumtg)
	e2:SetOperation(c233644.sumop)
	c:RegisterEffect(e2)
	--turn set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(233644,1))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c233644.postg)
	e3:SetOperation(c233644.posop)
	c:RegisterEffect(e3)
	--flip
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,233644+EFFECT_COUNT_CODE_SINGLE)
	e4:SetTarget(c233644.target)
	e4:SetOperation(c233644.operation)
	c:RegisterEffect(e4)
end
function c233644.cfilter(c)
	return not c:IsAttribute(0x10) 
end	
function c233644.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),0x4)<=0 then return false end
	return not Duel.IsExistingMatchingCard(c233644.cfilter,c:GetControler(),0x10,0,1,nil) and Duel.GetFieldGroupCount(c:GetControler(),0x10,0)>0
end	
function c233644.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(233644)==0 end
	c:RegisterFlagEffect(233644,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c233644.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c233644.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return  bit.band(r,0x41)==0x41  and e:GetHandler():GetReasonPlayer()~=tp
end
function c233644.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c233644.sumop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c233644.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=2 end
end
function c233644.hfilter(c,e,tp)
	return c:IsAttribute(0x10) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c233644.operation(e,tp,eg,ep,ev,re,r,rp)
     Duel.ConfirmDecktop(tp,2)
     local g=Duel.GetDecktopGroup(tp,2)
	 local hg=g:Filter(c233644.hfilter,nil,e,tp)
	   g:Sub(hg)
	   if hg:GetCount()~=0 then
	   Duel.SpecialSummon(hg,0,tp,tp,false,false,0x8) 
    end
	   if g:GetCount()~=0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,0x8000040)
	end
end	