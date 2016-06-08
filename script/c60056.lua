--藏书屋·蓬莱山辉夜
function c60056.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x300),aux.NonTuner(Card.IsSetCard,0x300),1)
	c:EnableReviveLimit()
	--set
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(60056,0))
	e4:SetType(EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c60056.setcon)
	e4:SetTarget(c60056.settg)
	e4:SetOperation(c60056.setop)
	c:RegisterEffect(e4)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_TO_GRAVE+EVENT_REMOVE)
	e6:SetOperation(c60056.spr)
	c:RegisterEffect(e6)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(60056,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_GRAVE+EVENT_REMOVE)
	e5:SetCountLimit(1)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetCondition(c60056.spcon)
	e5:SetTarget(c60056.sptg)
	e5:SetOperation(c60056.spop)
	c:RegisterEffect(e5)
end
function c60056.setcon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsOnField() and (re:IsActiveType(TYPE_MONSTER)
		or (re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c60056.filter(c)
	return c:IsSetCard(0x300) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function c60056.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c60056.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c60056.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c60056.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
	end
end
function c60056.spr(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if bit.band(r,0x41)~=0x41 or c:IsPreviousLocation(LOCATION_SZONE) then return end
	c:RegisterFlagEffect(60056,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY,0,1)
end
function c60056.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetTurnID()~=Duel.GetTurnCount() and c:GetFlagEffect(60056)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60056.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60056.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
	end
end