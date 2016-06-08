--Lost Christmas
function c2330622.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96029576,1))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c2330622.target)
	e1:SetOperation(c2330622.activate)
	e1:SetCountLimit(1,2330622+EFFECT_COUNT_CODE_DUEL)
	c:RegisterEffect(e1)
	dis1=0x1f001f
	local temp ={}
	for i = 0,1 do 
		temp[i] = {}
	end
	for j = 0,4 do
		temp[i][j] = nil
	end
end


function c2330622.desfilter(c)
	return c:IsFaceup() --and c:IsSetCard(0xf9) and c:GetLeftScale()>=4
end
function c2330622.desfilter2(c)
	return c:IsFaceup() --and c:IsSetCard(0xf9) and c:GetLeftScale()<=4
end
function c2330622.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c2330622.desfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c2330622.desfilter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c2330622.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g2=Duel.SelectTarget(tp,c2330622.desfilter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2330622.xfilter(c,tc2)
	return c:IsDestructable() and c~=tc2
end
function c2330622.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc1,tc2=Duel.GetFirstTarget()
	local sg=Duel.GetMatchingGroup(c2330622.xfilter,tp,LOCATION_MZONE,LOCATION_MZONE,tc1,tc2)
	Duel.Destroy(sg,REASON_EFFECT)
	Duel.BreakEffect()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)+Duel.GetLocationCount(1-tp,LOCATION_MZONE)==0 then return end
	--dis
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY,1)
	e1:SetOperation(c2330622.diso1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,23306220,0,0,1)
	Duel.RegisterFlagEffect(1-tp,23306221,0,0,1)
	--standby
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetOperation(c2330622.disop)
	e2:SetCountLimit(1)
	Duel.RegisterEffect(e2,tp)
end
function c2330622.diso1(e,tp)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)~=0 then
		local sg=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,nil)
		local s1=sg:GetFirst()
		while s1 do
			local seq=s1:GetSequence()
			seq=bit.lshift(0x1,seq)
			dis1=dis1-seq
			s1=sg:GetNext()
		end
		local sg2=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
		local s2=sg2:GetFirst()
		while s2 do
			local seq=s2:GetSequence()
			seq=seq+16
			seq=bit.lshift(0x1,seq)
			dis1=dis1-seq
			s2=sg2:GetNext()
		end
	end
	return dis1
end
function c2330622.diso2(e,tp)
	local dis=0
	local seq1=0
	local seq2=0
	while seq1<5 do
		if not Duel.CheckLocation(tp,LOCATION_MZONE,seq1) and not Duel.GetFieldCard(tp,LOCATION_MZONE,seq1) then
		temp[0][seq1]=e
		dis=dis+bit.lshift(0x1,seq1)
		seq1=seq1+1
	end
	while seq2<5 do
		if not Duel.CheckLocation(1-tp,LOCATION_MZONE,seq2) and not Duel.GetFieldCard(1-tp,LOCATION_MZONE,seq2) then
		temp[1][seq2]=e
		dis=dis+bit.lshift(0x1,seq2+16)
		seq2=seq2+1
	end
	return dis
end
function c2330622.disop(e,tp,eg,ep,ev,re,r,rp)
	if (Duel.GetFlagEffect(tp,23306220)==0 and Duel.GetFlagEffect(1-tp,23306221)==0)or dis1==0 then
		e:Reset()
		return 
	end
	--dis1
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
	e1:SetOperation(c2330622.diso2)
	Duel.RegisterEffect(e1,tp)
end

function c2330622.diso2(e,tp)
	local seq=0
	local flag=0
	local a=0
		if Duel.GetTurnPlayer()==tp and Duel.GetFlagEffect(tp,23306220)~=0 then
			while seq1<5 and a==0 do
				if not Duel.CheckLocation(tp,LOCATION_MZONE,seq1) and not Duel.GetFieldCard(tp,LOCATION_MZONE,seq1) then
					flag=bit.bor(flag,bit.lshift(0x1,seq1))
					--Duel.Recover(0,flag,REASON_EFFECT)
					a=1
				end
			end
		elseif Duel.GetTurnPlayer()==1-tp and Duel.GetFlagEffect(1-tp,23306221)~=0 then
			while seq2<5 and a==0 do
				if not Duel.CheckLocation(1-tp,LOCATION_MZONE,seq2) and not Duel.GetFieldCard(1-tp,LOCATION_MZONE,seq2) then
					flag=bit.bor(flag,bit.lshift(0x1,seq2+16))
					--Duel.Recover(0,flag,REASON_EFFECT)
					a=1
				end
			end
		
		else
			return dis1
		end
		if seq1==5 and Duel.GetFlagEffect(tp,23306220)~=0 then Duel.ResetFlagEffect(tp,23306220) end
		if seq2==5 and Duel.GetFlagEffect(1-tp,23306221)~=0 then Duel.ResetFlagEffect(1-tp,23306221) end
	while seq<5 do
		if not Duel.CheckLocation(tp,LOCATION_MZONE,seq) and not Duel.GetFieldCard(tp,LOCATION_MZONE,seq) then
			flag=bit.bor(flag,bit.lshift(0x1,seq))
			--Duel.Recover(0,flag,REASON_EFFECT)
			a=1
		end
		if not Duel.CheckLocation(1-tp,LOCATION_MZONE,seq) and not Duel.GetFieldCard(1-tp,LOCATION_MZONE,seq)==0 then
			flag=bit.bor(flag,bit.lshift(0x1,seq+16))
			a=1
		end
		seq=seq+1
	end
		local c=Duel.GetLocationCount(tp,LOCATION_MZONE)
			Duel.Recover(0,flag,REASON_EFFECT)
			Duel.Recover(0,c,REASON_EFFECT)
		dis1=bit.bxor(flag,0xff)
	-- local tp1=1
	-- if Duel.GetTurnPlayer()==tp and Duel.GetFlagEffect(tp,23306220)~=0 then
		-- while bit.band(tp1,dis1)==0 do
			-- if tp1 >16 then return dis1 end
			-- tp1=bit.lshift(tp1,0x1)
		-- end
	-- elseif Duel.GetTurnPlayer()==1-tp and Duel.GetFlagEffect(1-tp,23306221)~=0 then
		-- tp1=0x10000
		-- while bit.band(tp1,dis1)==0 do
			-- tp1=bit.lshift(tp1,0x1)
		-- end
	-- else
		-- return dis1
	-- end
	-- dis1=dis1-tp1
	-- if bit.band(0x00001f,dis1)==0 and Duel.GetFlagEffect(tp,23306220)~=0 then Duel.ResetFlagEffect(tp,23306220) end
	-- if bit.band(0x1f0000,dis1)==0 and Duel.GetFlagEffect(1-tp,23306221)~=0 then Duel.ResetFlagEffect(1-tp,23306221) end
	-- return dis1
end

