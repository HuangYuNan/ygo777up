LuaR  

             @ e   
@ @ e@  
@  @ e  
@ @ eÀ  
@      	   c9990102    initial_effect    filter    sumtg    sumop           ,   F @ G@À    ] À Á@ @ Á AA FA A@ÀÁ B FAB A@Â ÁB @ Ã A A @ ÀÃ D AD@Ä D ÁD@ E   @@Å  ÌBFE Ý@Ì E @ Ý@        Effect    CreateEffect    SetCategory    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_SINGLE    EFFECT_TYPE_TRIGGER_O    SetProperty    EFFECT_FLAG_CARD_TARGET    EFFECT_FLAG_DAMAGE_STEP    SetCode    EVENT_SUMMON_SUCCESS    SetCountLimit       ð?   ÀúcA
   SetTarget 	   c9990102    sumtg    SetOperation    sumop    RegisterEffect    Clone    EVENT_SPSUMMON_SUCCESS             @$ ,                                                               	   	   	   	   
   
   
   
                                                         c     ,      e1    ,      e2 %   ,         _ENV        
   Ì @ FA@ ÝÛ   Ì@ @ Á  À   C  Ýß          IsType    TYPE_PENDULUM    IsCanBeSpecialSummoned                     @$                                                    c           e           tp              _ENV       
 K   [   ÀC@   À    @Â@ AÀ   @   @AÀA ÂAÆÂ@ ÇÁ  FC@ C Á   @      A BBÀ B Y  B    A ÂBÆC   FCC B A CÀ Ã@ A@ C@ ÁC  A   À    ÆA ÇÂÃC FD  Á D AD ÝB        IsLocation    LOCATION_GRAVE    IsControler 	   c9990102    filter            Duel    IsExistingTarget       ð?   GetLocationCount    LOCATION_MZONE    Hint    HINT_SELECTMSG    HINTMSG_SPSUMMON    SelectTarget    SetOperationInfo    CATEGORY_SPECIAL_SUMMON             @$ K                                                                                                                                                                                                                                          e     K      tp     K      eg     K      ep     K      ev     K      re     K      r     K      rp     K      chk     K      chkc     K      g A   K         _ENV           @ B@   L@À  ][  @F@ GÂÀ Á   @   Ã  DA ]B         Duel    GetFirstTarget    IsRelateToEffect    SpecialSummon            POS_FACEUP             @$                                                                   	      e           tp           eg           ep           ev           re           r           rp           tc             _ENV        @$                                                     _ENV 