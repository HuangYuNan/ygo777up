LuaR  

             @ e   
@ @ e@  
@      	   c9991185    initial_effect    filter1           $   F @ G@ΐ    ] ΐ Α@ FA A@@Α A @ΐΑ B @@Β %  @Β %A  @ΐΒ %  @ C   @@Γ  ΜΐAFC έ@Μ C @ έ@        Effect    CreateEffect    SetCategory    CATEGORY_DISABLE_SUMMON    CATEGORY_REMOVE    SetType    EFFECT_TYPE_ACTIVATE    SetCode    EVENT_SUMMON    SetCondition 
   SetTarget    SetOperation    RegisterEffect    Clone    EVENT_SPSUMMON       
       @ B@@   ΖΒ@    @ A X@  B            Duel    GetFieldGroupCount            LOCATION_REMOVED    GetCurrentChain             @$    	   	   	   	   	   	   	   	   	   	   	   	   	   	   	   	   
         e           tp           eg           ep           ev           re           r           rp              _ENV       	 $   L@ΖB@ Ηΐ  @ ]ΐ@Α ΐ@  B    BA AΑΒ  ΓA @Α ΑΓ  Δ  BBA AΑΒ  B @Α ΑΓ  Δ  B  	      Filter 	   c9991185    filter1         	   GetCount    Duel    SetOperationInfo    CATEGORY_DISABLE_SUMMON    CATEGORY_REMOVE             @$ $                                                                                                               
      e     $      tp     $      eg     $      ep     $      ev     $      re     $      r     $      rp     $      chk     $      rg    $         _ENV           @B@ @Δ    FΒ@ GΑ ]B FΒ@ GBΑ ΖA ΓA ]B         Filter 	   c9991185    filter1    Duel    NegateSummon    Remove    POS_FACEUP    REASON_EFFECT             @$                                                       	      e           tp           eg           ep           ev           re           r           rp           rg             _ENV         @$ $                                                   
                                                                  c     $      e1    $      e2    $         _ENV            @  X@  @@ @Μΐ@ έ A    Z@A  @              GetSummonPlayer    math    max    GetOriginalLevel    GetOriginalRank       @            @$                                                             c           tp              _ENV        @$                                   _ENV 