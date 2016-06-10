--冬之花 风见幽香
function c23309003.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23309003,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,23309003)
	e1:SetCost(c23309003.cost)
	e1:SetTarget(c23309003.target)
	e1:SetOperation(c23309003.operation)
	c:RegisterEffect(e1)
	--tohand
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(23309003,1))
	e8:SetCategory(CATEGORY_DESTROY)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_RELEASE)
	e8:SetCountLimit(1,23309003)
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e8:SetTarget(c23309003.thtg)
	e8:SetOperation(c23309003.thop)
	c:RegisterEffect(e8)
	if not YuukaGlobal then
		YuukaGlobal={}
		YuukaGlobal["Effects"]={}
	end
	YuukaGlobal["Effects"]["c23309003"]=e8
end
function c23309003.costfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsReleasable()
end
function c23309003.refilter(c)
	return c:IsSetCard(0x99a) and c:IsAbleToRemoveAsCost()
end
function c23309003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg1=Duel.GetMatchingGroup(c23309003.costfilter,tp,LOCATION_MZONE,0,nil)
	local mg2=Duel.GetMatchingGroup(c23309003.refilter,tp,LOCATION_GRAVE,0,nil)
	if e:GetHandler():IsHasEffect(23309009) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then mg1:Merge(mg2) end
	if chk==0 then return mg1:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=mg1:Select(tp,1,1,nil)
	if g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	else
		Duel.Release(g,REASON_COST)
	end
end
function c23309003.spfilter(c,e,tp)
	return c:IsCode(23309007) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c23309003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c23309003.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23309003.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstMatchingCard(c23309003.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3,true)
	end
end
function c23309003.desfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsFaceup()
end
function c23309003.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c23309003.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23309003.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c23309003.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
	if g:GetFirst():IsControler(1-tp) and g:GetFirst():IsControlerCanBeChanged() then
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	end
end
function c23309003.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if tc:IsControler(1-tp) and tc:IsControlerCanBeChanged() then
			if not Duel.GetControl(tc,tp) then
				if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
					Duel.Destroy(tc,REASON_EFFECT)
				end
			end
		end
	end
end
