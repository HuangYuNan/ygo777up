--hongfengsanluo
function c29281540.initial_effect(c)
    aux.AddSynchroProcedure(c,c29281540.tfilter,aux.NonTuner(Card.IsSetCard,0x3da),1)
    c:EnableReviveLimit()
    --activate limit
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCondition(c29281540.discon)
    e2:SetOperation(c29281540.actlimit)
    c:RegisterEffect(e2)
    --multi attack
    local e10=Effect.CreateEffect(c)
    e10:SetDescription(aux.Stringid(29281540,0))
    e10:SetType(EFFECT_TYPE_IGNITION)
    e10:SetCountLimit(2,29281540)
    e10:SetRange(LOCATION_MZONE)
    e10:SetTarget(c29281540.target2)
    e10:SetOperation(c29281540.mtop)
    c:RegisterEffect(e10)
end
function c29281540.tfilter(c)
    return c:IsSetCard(0x3da)
end
function c29281540.discon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c29281540.actlimit(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(0,1)
    e1:SetValue(c29281540.elimit)
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
end
function c29281540.elimit(e,te,tp)
    return te:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c29281540.filter1(c)
    return c:IsSetCard(0x3da)
end
function c29281540.filter2(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281540.target2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) 
	  and Duel.IsExistingMatchingCard(c29281540.filter2,tp,LOCATION_MZONE,0,1,nil) end
end
function c29281540.sumfilter(c)
    return c:IsSetCard(0x3da) and c:IsType(TYPE_MONSTER)
end
function c29281540.mtop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local back=Duel.GetDecktopGroup(tp,1)
    if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
    Duel.ConfirmDecktop(tp,1)
    local g=Duel.GetDecktopGroup(tp,1):Filter(c29281540.filter1,nil)
       if g:GetCount()>0 then
	   	    Duel.MoveSequence(back:GetFirst(),1)
        local g=Duel.GetMatchingGroup(c29281540.filter2,tp,LOCATION_MZONE,0,nil)
		local g1=Duel.SelectMatchingCard(tp,c29281540.sumfilter,tp,LOCATION_MZONE,0,1,1,nil)
        local tc=g1:GetFirst()
        local opt=0    
		if tc:GetLevel()==2  then
 	        opt=Duel.SelectOption(tp,aux.Stringid(29281540,1))
 	    else	
		    opt=Duel.SelectOption(tp,aux.Stringid(29281540,1),aux.Stringid(29281540,2))
		end
        while tc do
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_LEVEL)
            if opt==0 then
			e1:SetValue(2)
	    	else 
			e1:SetValue(-2) 
	    	end
            e1:SetReset(RESET_EVENT+0x1fe0000)
            tc:RegisterEffect(e1)
            tc=g1:GetNext()
        end
	        local tg=g:GetFirst()
		    Duel.RaiseSingleEvent(tg,29281400,e,0,0,0,0)
		else
			Duel.MoveSequence(back:GetFirst(),1)
	   end
end