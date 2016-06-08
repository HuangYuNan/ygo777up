--罪恶王冠 楪祈
function c2330601.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2330601,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c2330601.tgcon)
	e1:SetTarget(c2330601.sptg)
	e1:SetOperation(c2330601.tgop)
	c:RegisterEffect(e1)
	--change battle target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2330601,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c2330601.cbcon)
	e2:SetTarget(c2330601.sptg)
	e2:SetOperation(c2330601.cbop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_PZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xf9))
	e3:SetValue(300)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
	--creat void
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(2330601,1))
	e5:SetCategory(CATEGORY_EQUIP)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_SINGLE)
	e5:SetCode(2330600)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c2330601.voidtg)
	e5:SetOperation(c2330601.voidop)
	c:RegisterEffect(e5)
	--pendulum set
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(4104,0))
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCost(c2330601.thcost)
	e6:SetTarget(c2330601.thtg)
	e6:SetOperation(c2330601.thop)
	c:RegisterEffect(e6)
end
function c2330601.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=eg:GetFirst()
	return  c~=tc and tc:IsFaceup() and tc:IsControler(tp)and tc:IsSetCard(0xf9) and tc:GetCode()~=2330601
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c2330601.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_PZONE)
end
function c2330601.cbop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)>0 then
		Duel.BreakEffect()
		Duel.ChangeAttackTarget(e:GetHandler())
	end
end
function c2330601.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	if tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsLocation(LOCATION_MZONE)or not tc:IsSetCard(0xf9)
	or tc:GetCode()==2330601 then return false end
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c2330601.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)>0 and c:IsFaceup() then
		Duel.BreakEffect()
		local g=Group.CreateGroup()
		g:AddCard(c)
		Duel.ChangeTargetCard(ev,g)
	end
end

function c2330601.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c2330601.penfilter(c,tp)
	return c:IsSetCard(0xf9) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c2330601.thtg(e,tp,eg,ep,ev,re,r,rp,chk)	
	local  a1=(Duel.GetFieldCard(tp,LOCATION_SZONE,6))
	local  a2=(Duel.GetFieldCard(tp,LOCATION_SZONE,7))
	if chk==0 then return Duel.IsExistingMatchingCard(c2330601.penfilter,tp,LOCATION_DECK,0,1,nil,tp) 
	and not (a1 and a2) end
end
function c2330601.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(2330601,2))
	local tc=Duel.SelectMatchingCard(tp,c2330601.penfilter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
		local fc2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
		if fc1 and fc2 then return end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c2330601.voidfilter(c)
	return c:IsSetCard(0xf9) and c:IsFaceup()
end
function c2330601.voidtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c2330601.voidfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and e:GetHandler():IsLocation(LOCATION_MZONE) and e:GetHandler():IsFaceup() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	Duel.Hint(8,tp,2330603)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	local g=Duel.SelectTarget(tp,c2330601.voidfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2330601.voidop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<1 or not c:IsRelateToEffect(e) then return end
	if not c:IsLocation(LOCATION_MZONE) or not c:IsFaceup() then return end
	local eqc=Duel.GetFirstTarget()
	if eqc:IsRelateToEffect(e) then
	c:RegisterFlagEffect(23306001,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(2330600,4))
	--back void
	-- local e7=Effect.CreateEffect(c)
	-- e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	-- e7:SetCode(23306001)
	-- e7:SetRange(LOCATION_MZONE)
	-- e7:SetTarget(c2330601.backtg)
	-- e7:SetOperation(c2330601.backop)
	-- e7:SetLabelObject(e1)
	-- c:RegisterEffect(e7)
	local os=require "os"
	math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
	local code = math.random(2330603,2330605)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
		local g=Group.FromCards(Duel.CreateToken(tp,code))
		local tc=g:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.BreakEffect()
		Duel.Equip(tp,tc,eqc,true)
		c:SetCardTarget(tc)
		--Destroy
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetOperation(c2330601.desop)
		c:RegisterEffect(e2,true)
		--Destroy2
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetCondition(c2330601.descon2)
		e3:SetOperation(c2330601.desop2)
		c:RegisterEffect(e3,true)
	end
end
-- function c2330601.backtg(e,tp,eg,ep,ev,re,r,rp,chk)
	-- local c=e:GetHandler()
	-- if chk==0 then return c:GetFlagEffect(23306001)~=0 and c:GetCardTargetCount()~=0 end
-- end
-- function c2330601.backop(e,tp,eg,ep,ev,re,r,rp)
	-- local c=e:GetHandler()
	-- e:GetLabelObject():Reset()
	-- Duel.Recover(0,3,REASON_EFFECT)
	-- c:ResetFlagEffect(23306001)
	-- local e1=Effect.CreateEffect(c)
	-- e1:SetDescription(aux.Stringid(2330600,5))
	-- e1:SetType(EFFECT_TYPE_FIELD)
	-- e1:SetRange(LOCATION_MZONE)
	-- e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
	-- e1:SetReset(RESET_EVENT+0x1fe0000)
	-- c:RegisterEffect(e1)
	-- e:Reset()
-- end
function c2330601.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_ONFIELD) then
		Duel.Destroy(tc,REASON_RULE)
	end
end
function c2330601.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc) and re and not re:GetHandler():IsSetCard(0xf9)
end
function c2330601.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_RULE)
end