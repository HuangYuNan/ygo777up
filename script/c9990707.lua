LuaR  

             @ e   
@ @ e@  
@  @ e  
@ @ eΐ  
@  @ e  
@ @ e@ 
@      	   c9990707    initial_effect    filter1    filter1Sub    filter2    target 	   activate       &    6   F @ G@ΐ    ] ΐ Α@ @ Α AA @Α ΑA @ Β %  @@Β B ΑB@ Γ B AC@C   @ @ @@ΐ    Μ AFΑC D Mέ@ΜAFAD έ@ΜDFΑD E Mέ@Μ@EeA  έ@Μ Ce  έ@ΜC @ έ@        Effect    CreateEffect    SetCategory    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_ACTIVATE    SetCode    EVENT_FREE_CHAIN    SetCost 
   SetTarget 	   c9990707    target    SetOperation 	   activate    RegisterEffect    EFFECT_TYPE_SINGLE    EFFECT_TYPE_CONTINUOUS    EVENT_TO_HAND    SetProperty    EFFECT_FLAG_CANNOT_DISABLE    EFFECT_FLAG_UNCOPYABLE    SetCondition          	 "   L@ ] LBΐΑ  ]Xΐΐ@ C _ e  ΐ@A BAΐ  FA Γ  ΑΓ @      A Bΐ  AΓ Γ ΖCB B ΝB         GetHandler    GetFlagEffect    `FcA           Duel    IsExistingMatchingCard    LOCATION_HAND        @   DiscardHand    REASON_COST    REASON_DISCARD    
   
       L @ ] [   @ L@@ ] _          IsDiscardable    IsAbleToGraveAsCost            @$    
   
   
   
   
   
   
   
         c                    @$ "   	   	   	   	   	   	   	   	   	   
                                                                           
      e     "      tp     "      eg     "      ep     "      ev     "      re     "      r     "      rp     "      chk     "      fil 
   "         _ENV           @  FB@ Gΐ ΑΒ  ] ΑFB@ GBΑ] A  LΒAΖB ][  @LΒAΖBB ]@ CB  C _   
      GetHandler    Duel    GetFlagEffect    `FcA           GetCurrentPhase    PHASE_DRAW 	   IsReason    REASON_DRAW    REASON_RULE             @$                                                                                        	      e           tp           eg           ep           ev           re           r           rp           c             _ENV    $    .   @  FB@ Gΐ ΖΒ@ ΗΑC A έ]  [  ΐFΒA GΒ ] BΒB BΒΒC BBΓC ΓCFD CFCD CBD BΒDC FC MΓΓD MCD M Α B         GetHandler    Duel    SelectYesNo    aux 	   Stringid    `FcA           Effect    CreateEffect    SetType    EFFECT_TYPE_SINGLE    SetCode    EFFECT_PUBLIC 	   SetReset    RESET_EVENT      ΰA   RESET_PHASE 
   PHASE_END    RegisterEffect    RegisterFlagEffect       π?            @$ .                                                                                                        !   !   !   "   "   "   "   "   "   "   "   "   "   "   $   
      e     .      tp     .      eg     .      ep     .      ev     .      re     .      r     .      rp     .      c    .      e1    -         _ENV         @$ 6                                                                                                                                                   $      %   %   %   &         c     6      e1    6      e2    6         _ENV '   )        @ @@ΐ       ΐ @            	   c9990707    filter1Sub    IsImmuneToEffect             @$    (   (   (   (   (   (   (   (   (   (   (   )         c           e              _ENV *   ,       L @ ] [   L@@ Ζ@ ][   @ Lΐ@ ] _          IsCanBeFusionMaterial    IsType    TYPE_PENDULUM    IsAbleToRemove             @$    +   +   +   +   +   +   +   +   +   +   +   +   ,         c              _ENV -   2    !   ΐ ΜA@@  έAΜ@ FΒ@ έΫ      ΐ    έ Ϋ  @ΜA @ BA ΐ   C  έΫ   ΜA @   ΐέί         Clone    RemoveCard    IsType    TYPE_FUSION    IsCanBeSpecialSummoned    SUMMON_TYPE_FUSION    CheckFusionMaterial             @$ !   .   .   /   /   /   0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   2         c     !      e     !      tp     !      m     !      f     !      chkf     !      m1    !         _ENV 3   D   	 W    @FB@ Gΐ ΖΒ@ ]@ FA [B    @ B@ BAΖA ΗΒΑ  FB CB MΓ@ MB M  Δ   ΖB@ ΗΒΒA C@ B Α  D D    ΐ   D  έ ΫB  C@ C@  XΐC LD] ΐ    @  ΜCDέ D@ ΔBFA GΓ ΖB   AE   ΐ    @ ΐ ΐ ί FB@ GΔ  ΖΒD   AC  ΖB ]B                Duel    GetLocationCount    LOCATION_MZONE    PLAYER_NONE    GetMatchingGroup 	   c9990707    filter1Sub    LOCATION_EXTRA    LOCATION_HAND    LOCATION_GRAVE    IsExistingMatchingCard    filter2       π?   GetChainMaterial  
   GetTarget 	   GetValue    SetOperationInfo    CATEGORY_SPECIAL_SUMMON             @$ W   4   4   5   5   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   8   8   9   9   9   9   :   :   ;   ;   <   <   <   <   <   =   =   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   >   A   C   C   C   C   C   C   C   C   C   D         e     W      tp     W      eg     W      ep     W      ev     W      re     W      r     W      rp     W      chk     W      chkf    M      mg1    M      res +   M      ce 1   L      fgroup 5   L      mg2 :   L      mf <   L         _ENV E   o    λ   @ B@@ @   A B      F@ GBΑA ΒAΐ B FCB CF@ CFB CAΓ    ΐ  ]@ BAΖA ΗΒΒ  FB Γ  Δ     @ Δ    Δ F@ GΓ ] X@Γ Γ ΐ  @   έ ΐΜΓΓέ @ DAFA GΔΒ ΖB Ε  D    ΐ  @   D Y@X@C@D @CD    ΜD@ έCΖ@ ΗΓΔE @ DE έC ΜE@ Δ ΑΔ   έ Ζ LDΖΐ ]DLFΐ ][   X@C LFΐ ][  ΐF@ GΔΖ ΜΗέ ]  [D  @F@ GDΗ ΐ  D   ] G D@ ΔG	ΐH FEH E
FH E
D@ ΔH	D @ I	ΐ EI @  Γ    FI D  F@ GDΗ ΐ  D   ] ΔΙ ΐ 	 @   ΐ  έD LJ]D  @ CJΐ DB F@ DAΔ   Ζ@ ΗCΚ  FB Δ  έ D  ΚΔJ K	ΑΔ     @ DK@     @ K@ Δ D  @@ LND D@ LNDD@ DL@ D   2      Duel    GetLocationCount    LOCATION_MZONE            PLAYER_NONE    GetMatchingGroup 	   c9990707    filter1    LOCATION_EXTRA    LOCATION_HAND    LOCATION_GRAVE    filter2    GetChainMaterial  
   GetTarget 	   GetValue 	   GetCount    Clone    Merge    Hint    HINT_SELECTMSG    HINTMSG_SPSUMMON    Select       π?	   GetFirst    RemoveCard    IsContains    SelectYesNo    GetDescription    SelectFusionMaterial    SetMaterial    Remove    REASON_EFFECT    REASON_MATERIAL    REASON_FUSION    BreakEffect    SpecialSummon    SUMMON_TYPE_FUSION    POS_FACEUP    GetOperation    CompleteProcedure    GetFieldGroup 	   IsExists    Card    IsFacedown    IsPlayerCanSpecialSummon    IsPlayerAffectedByEffect     ͺMzA   ConfirmCards    ShuffleHand             @$ λ   F   F   F   F   F   F   F   F   F   F   F   G   G   G   G   G   G   G   G   G   G   G   G   G   G   G   G   H   H   H   H   H   H   H   H   H   H   H   H   H   H   I   K   K   K   K   L   L   M   M   N   N   N   N   N   N   O   O   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   R   R   R   R   R   R   R   R   R   R   S   S   T   T   T   T   T   U   U   U   U   U   U   V   V   V   V   V   V   W   W   X   X   X   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   [   [   [   \   \   \   \   \   \   \   \   \   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   `   `   `   `   `   `   `   `   a   a   b   b   b   b   b   b   b   d   d   d   f   f   f   f   f   f   f   f   g   g   g   g   g   g   h   h   h   h   h   h   h   h   h   h   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   j   j   j   j   j   k   k   k   k   k   l   l   l   l   o         e     λ      tp     λ      eg     λ      ep     λ      ev     λ      re     λ      r     λ      rp     λ      chkf    λ      mg1    λ      sg1 )   λ      mg2 *   λ      sg2 *   λ      ce .   λ      fgroup 2   I      mf :   I      sg U   ΄      tg f   ΄      tc h   ΄      mat1           mat2 ©   ²      fop «   ²      cg1 ½   κ      cg2 Γ   κ         _ENV        @$       &      '   )   '   *   ,   *   -   2   -   3   D   3   E   o   E   o             _ENV 