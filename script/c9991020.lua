LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@   	      require    script/c9990000 	   c9991020    initial_effect    Dazz_name_void       π?   filter    target 	   activate           (   F @ G@ΐ    ] ΐ Α@ FA A@@Α A @ΐΑ B FAB A@Β ΑB @ Γ A FC MA@  Δ %  @@Δ D ΑD@ Ε D AE@E   @        Effect    CreateEffect    SetCategory    CATEGORY_TOHAND    CATEGORY_DRAW    SetType    EFFECT_TYPE_ACTIVATE    SetProperty    EFFECT_FLAG_DELAY    EFFECT_FLAG_DAMAGE_STEP    SetCode    EVENT_DESTROYED    SetCountLimit       π?   EFFECT_COUNT_CODE_OATH    mcA   SetCondition 
   SetTarget 	   c9991020    target    SetOperation 	   activate    RegisterEffect              @₯  ΑB    @         	   IsExists       π?              @ @@ΐ   @ Α@   ΐ A AA    A ΑA    @ B  X@   @        	      Dazz    IsVoid    Card    GetPreviousCodeOnField    IsPreviousPosition    POS_FACEUP    IsPreviousLocation    LOCATION_ONFIELD    GetPreviousControler             @$                                                                                        c           tp              _ENV         @$                                  e           tp           eg           ep           ev           re           r           rp              _ENV         @$ (                                                      	   	   	   
   
   
   
   
                                                      c     (      e1    (         _ENV           F @ G@ΐ    ] [    L@ ] [    Lΐ@ Ζ A ][@  ΐL@A ΖA ΑA Ν B Ν ]T  _    	      Dazz    IsVoid    IsAbleToHand    IsLocation    LOCATION_GRAVE    IsType    TYPE_FUSION    TYPE_SYNCHRO 	   TYPE_XYZ             @$                                                                                     c              _ENV       
 "    @ΐB@ @ΖΒ@ ΗΑ  FCA A M  ΑΓ      B@ Bΐ Γ  B@ BBΑ  B D  Γ ΐ DA FA DB                Duel    IsExistingMatchingCard 	   c9991020    filter    LOCATION_EXTRA    LOCATION_GRAVE       π?   IsPlayerCanDraw    SetOperationInfo    CATEGORY_TOHAND             @$ "                                                                                                         
      e     "      tp     "      eg     "      ep     "      ev     "      re     "      r     "      rp     "      chk     "      chkc     "         _ENV    &    D   @ B@F@  ΖΒ@ B @ A@ BA Aΐ ΓA FB CAC  Α   LΒB] X@ΒΐLC] LBΓΖC ][B   F@ GΒΓ Δ  D ]B F@ GBΔB ΐ ]BF@ GΔ Α D ]B LΒD ΖE ][  @LBE ] LΕΐ  ][  F@ GΒΕBE  ΖF D ]B         Duel    Hint    HINT_SELECTMSG    HINTMSG_ATOHAND    SelectMatchingCard 	   c9991020    filter    LOCATION_EXTRA    LOCATION_GRAVE               π?	   GetCount 	   GetFirst    IsHasEffect    EFFECT_NECRO_VALLEY    SendtoHand    REASON_EFFECT    ConfirmCards    Draw 
   IsHasType    EFFECT_TYPE_ACTIVATE    GetHandler    IsRelateToEffect    Remove    POS_FACEUP             @$ D                                                                                                                                      !   !   !   !   !   !   #   #   #   #   #   #   #   #   #   #   #   #   $   $   $   $   $   $   $   &   	      e     D      tp     D      eg     D      ep     D      ev     D      re     D      r     D      rp     D      g    D         _ENV        @$                                                 &      &             _ENV 