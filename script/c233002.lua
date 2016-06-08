--失乐的天使 莉莉丝
function c233002.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(233002,2))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c233002.xyzcon)
	e1:SetOperation(c233002.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(233002,3))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c233002.sumcon)
	e3:SetTarget(c233002.destg)
	e3:SetOperation(c233002.desop)
	e3:SetLabel(3)
	c:RegisterEffect(e3)
	--set LP 
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(17132130,1))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c233002.sumcon)
	e4:SetOperation(c233002.lpcop)
	e4:SetLabel(4)
	c:RegisterEffect(e4)
	--immune
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetCondition(c233002.sumcon)
	e6:SetOperation(c233002.immune)
	e6:SetLabel(6)
	c:RegisterEffect(e6)
end
function c233002.spfilter1(c,tp,ft)
	if c:GetLevel()==4 and c:IsFaceup() and not c:IsHasEffect(EFFECT_CANNOT_BE_XYZ_MATERIAL) then
		if ft>0 or (c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() )
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 then
			return Duel.IsExistingMatchingCard(c233002.spfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,tp)
		else
			return Duel.IsExistingMatchingCard(c233002.spfilter2,tp,LOCATION_MZONE,0,2,c,tp)
		end
	else return false end
end
function c233002.spfilter2(c,tp)
	return c:GetLevel()==4 and c:IsFaceup() and not c:IsHasEffect(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	--and c:IsCanBeXyzMaterial(true) and c:IsControler(tp)
end
function c233002.splimit(c)
	return c:GetLevel()==4 and c:IsFaceup() and not c:IsHasEffect(EFFECT_CANNOT_BE_XYZ_MATERIAL)
end
function c233002.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	--local tp=e:GetHandlerPlayer()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
	and Duel.IsExistingMatchingCard(c233002.splimit,tp,0,LOCATION_MZONE,1,nil) then
		return Duel.IsExistingMatchingCard(c233002.spfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp,ft)
	else 
		return Duel.IsExistingMatchingCard(c233002.spfilter1,tp,LOCATION_MZONE,0,2,nil,tp,ft)
	end
end
function c233002.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(233002,0))
	if Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)~=0 then
		g1=Duel.SelectMatchingCard(tp,c233002.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp,ft)
		tc=g1:GetFirst()
		g=Duel.GetMatchingGroup(c233002.spfilter2,tp,LOCATION_MZONE,0,tc,tp)
	else 
		g1=Duel.SelectMatchingCard(tp,c233002.spfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp,ft)
		tc=g1:GetFirst()
		g=Duel.GetMatchingGroup(c233002.spfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,tc,tp)
	end
	local g2=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(233002,1))
	if ft>0 or (tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE)and tc:IsFaceup() ) then
		g2=g:Select(tp,1,10,nil)
	else
		g2=g:FilterSelect(tp,Card.IsControler,1,1,nil,tp)
		if g:GetCount()>1 and Duel.SelectYesNo(tp,210) then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(233002,0))
			local g3=g:Select(tp,1,9,g2:GetFirst())
			g2:Merge(g3)
		end
	end
	g1:Merge(g2)
	local tm=g1:GetFirst()
	while tm do
		Duel.Overlay(c,tm)
		tm=g1:GetNext()
	end
end
function c233002.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ and e:GetHandler():GetOverlayCount()>=e:GetLabel()
end
function c233002.desfilter(c)
	return c:IsFacedown() and c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c233002.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c233002.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c233002.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c233002.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c233002.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c233002.lpcop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)/2)
end
function c233002.immune(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--immune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end