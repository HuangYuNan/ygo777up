--罪恶王冠 守墓人
function c2330650.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsSetCard,0xf9),aux.FilterBoolFunction(Card.IsSetCard,0xf5),true)
	--spsummon condition
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetCode(EFFECT_SPSUMMON_CONDITION)
	e11:SetValue(c2330650.splimit2)
	c:RegisterEffect(e11)
	--special summon rule
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_SPSUMMON_PROC)
	e22:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e22:SetRange(LOCATION_EXTRA)
	e22:SetCondition(c2330650.sprcon)
	e22:SetOperation(c2330650.sprop)
	c:RegisterEffect(e22)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--effect gain
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_ADJUST)
	e0:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e0:SetRange(LOCATION_MZONE)
	e0:SetLabelObject(g)
	e0:SetCondition(c2330650.spcon)
	e0:SetOperation(c2330650.adjustop)
	c:RegisterEffect(e0)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c2330650.effcon)
	e1:SetLabel(1)
	e1:SetLabelObject(e0)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2330650,3))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetLabel(2)
	e2:SetLabelObject(e0)
	e2:SetCountLimit(1)
	e2:SetCondition(c2330650.effcon)
	e2:SetCost(c2330650.cost2)
	e2:SetTarget(c2330650.drtg)
	e2:SetOperation(c2330650.drop)
	c:RegisterEffect(e2)
	--disable field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2330650,4))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(3)
	e3:SetCountLimit(1)
	e3:SetLabelObject(e0)
	e3:SetCondition(c2330650.effcon)
	e3:SetOperation(c2330650.disop1)
	c:RegisterEffect(e3)
	--activate limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(4)
	e3:SetLabelObject(e0)
	e3:SetCondition(c2330650.effcon)
	e3:SetOperation(c2330650.aclimit1)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_CHAIN_NEGATED)
	e4:SetRange(LOCATION_MZONE)
	e4:SetLabel(4)
	e4:SetLabelObject(e0)
	e4:SetCondition(c2330650.effcon)
	e4:SetOperation(c2330650.aclimit2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,1)
	e5:SetCondition(c2330650.econ)
	e5:SetValue(c2330650.elimit)
	c:RegisterEffect(e5)
	--creat void
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(2330650,1))
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_SINGLE)
	e6:SetCode(2330600)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTarget(c2330650.voidtg)
	e6:SetOperation(c2330650.voidop)
	c:RegisterEffect(e6)
	local e33=Effect.CreateEffect(c)
	e33:SetType(EFFECT_TYPE_FIELD)
	e33:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e33:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e33:SetRange(LOCATION_MZONE)
	e33:SetTargetRange(1,0)
	e33:SetTarget(c2330650.splimit)
	c:RegisterEffect(e33)
end
function c2330650.splimit2(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c2330650.spfilter1(c,tp)
	return c:IsSetCard(0xf9) and c:IsCanBeFusionMaterial()
		and (Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,0,1,c,0xf5)
		or Duel.IsExistingMatchingCard(c2330650.spfilter3,tp,LOCATION_SZONE,0,1,c,tp))
end
function c2330650.spfilter3(c,tp)
	return c:IsSetCard(0xf5) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
end
function c2330650.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c2330650.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c2330650.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c2330650.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then
		g2=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_SZONE,0,1,1,g1:GetFirst(),0xf5)
	else
		g2=Duel.SelectMatchingCard(tp,c2330650.spfilter3,tp,LOCATION_ONFIELD,0,1,1,g1:GetFirst(),tp)
	end
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c2330650.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()<4 --re:GetCode()==2330600 --and not e:GetHandler():IsStatus(STATUS_CHAINING) 
end
function c2330650.adjustfilter(c,g,fid)
	return c:IsFaceup() and not g:IsContains(c) and c:GetFieldID()>fid and c:IsSetCard(0xf5)
end
function c2330650.adjustop(e,tp,eg,ep,ev,re,r,rp)
	local fid=e:GetHandler():GetFieldID()
	local preg=e:GetLabelObject()
	local g=Duel.GetMatchingGroup(c2330650.adjustfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,preg,fid)
	local tc=g:GetFirst()
	while tc do
		c2330650.spop(e,tp,eg,ep,ev,re,r,rp)
		preg:AddCard(tc)
		tc=g:GetNext()
	end
	local tc=preg:GetFirst()
	while tc do
		if not tc:IsOnField() or tc:IsFacedown() or tc:GetFieldID()<fid then
			preg:RemoveCard(tc)
		end
		tc=preg:GetNext()
	end
	if g:GetCount()>0 then
		Duel.Readjust()
	end
end
function c2330650.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	e:SetLabel(e:GetLabel()+1)
	if e:GetLabel()>4 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2330650,e:GetLabel() + 1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	Duel.Hint(10,0,e:GetHandler():GetCode())
end

function c2330650.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()>=e:GetLabel()
end
function c2330650.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,e:GetHandler(),0xf9) end
	local sg=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,e:GetHandler(),0xf9)
	Duel.Release(sg,REASON_COST)
end
function c2330650.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c2330650.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c2330650.disop1(e,tp)
	local ct=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ct==0 then return end
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_DISABLE_FIELD)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e3:SetOperation(c2330650.disop)
	c:RegisterEffect(e3,tp)
end
function c2330650.disop(e,tp)
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	return dis1
end

function c2330650.aclimit1(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not re:IsActiveType(TYPE_MONSTER) then return end
	e:GetHandler():RegisterFlagEffect(23306501,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
end
function c2330650.aclimit2(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not re:IsActiveType(TYPE_MONSTER) then return end
	e:GetHandler():ResetFlagEffect(23306501)
end
function c2330650.econ(e)
	return e:GetHandler():GetFlagEffect(23306501)~=0
end
function c2330650.elimit(e,te,tp)
	return te:IsActiveType(TYPE_MONSTER)
end

function c2330650.voidfilter(c)
	return c:IsSetCard(0xf9) and c:IsFaceup()
end
function c2330650.voidtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c2330650.voidfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and e:GetHandler():IsLocation(LOCATION_MZONE) and e:GetHandler():IsFaceup() end
	Duel.Hint(8,tp,2330652)
	local g=Duel.SelectTarget(tp,c2330650.voidfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2330650.voidop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<1 or not c:IsRelateToEffect(e) then return end
	if not c:IsLocation(LOCATION_MZONE) or not c:IsFaceup() then return end
	local eqc=Duel.GetFirstTarget()
	if eqc:IsRelateToEffect(e) then
		c:RegisterFlagEffect(23306001,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(2330600,4))
		local os=require "os"
		math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
		local code = math.random(2330652,2330653)
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
		e2:SetOperation(c2330650.desop)
		c:RegisterEffect(e2,true)
		--Destroy2
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetCondition(c2330650.descon2)
		e3:SetOperation(c2330650.desop2)
		c:RegisterEffect(e3,true)
	end
end
function c2330650.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_ONFIELD) then
		Duel.Destroy(tc,REASON_RULE)
	end
end
function c2330650.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc) and re and not re:GetHandler():IsSetCard(0xf9)
end
function c2330650.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_RULE)
end
function c2330650.splimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_EXTRA) and c:IsCode(2330650)
end