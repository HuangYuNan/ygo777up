--忘却之海·君临
function c66678915.initial_effect(c)
	c:SetUniqueOnField(1,1,66678915,LOCATION_MZONE)
	--Xyz
	aux.AddXyzProcedure(c,nil,11,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(function(e,c)
		return c:GetOverlayCount()*300
	end)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():GetOverlayCount()>0
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(function(e,te)
			return e:GetHandlerPlayer()~=te:GetHandlerPlayer()
		end)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		e:GetHandler():RegisterEffect(e1)
	end)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local bc=c:GetBattleTarget()
		return bc and c:GetControler()~=bc:GetControler() and bc:IsStatus(STATUS_BATTLE_DESTROYED)
			and not c:IsStatus(STATUS_BATTLE_DESTROYED)
	end)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return Duel.IsExistingMatchingCard(c66678915.schfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
		Duel.SetTargetCard(e:GetHandler():GetBattleTarget())
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	end)
	e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local bc=c:GetBattleTarget()
		if not c:IsRelateToEffect(e) or not c:IsLocation(LOCATION_MZONE)
			or not bc:IsRelateToEffect(e) or bc:IsImmuneToEffect(e) or not bc:IsAbleToChangeControler() then return end
		bc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
		Duel.SendtoGrave(bc:GetOverlayGroup(),REASON_RULE)
		Duel.Overlay(c,bc)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c66678915.schfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return bit.band(e:GetHandler():GetPreviousPosition(),POS_FACEUP)~=0
			and bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_ONFIELD)~=0
	end)
	e4:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
		local g=Duel.GetMatchingGroup(c66678915.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if chk==0 then return g:GetCount()~=0 end
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetMatchingGroup(c66678915.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if g:GetCount()>0 then
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end)
	c:RegisterEffect(e4)
end
function c66678915.tgfilter(c)
	return c:IsAbleToGrave() and (c:IsFacedown() or c:IsAttribute(ATTRIBUTE_WATER))
end
function c66678915.schfilter(c)
	return c:IsSetCard(0x665) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end