LuaR  

             @ e   
@ @ e@  
@  @ e  
@ @ eΐ  
@  @ e  
@ @ e@ 
@  @ e 
@ @ eΐ 
@   	   	   c9990752    initial_effect    cost    filter1    filter2    target 	   activate    target2    operation2           E   F @ G@ΐ    ] ΐ Α@ @ Α AA @Α ΑA @ Β AB @Β ΑB C@@Γ ΑB C@ΐΓ ΑB D@@D   @ @ @@ΐ    Μ@FD έ@Μ AFΑD έ@Μ EFAE έ@ΜEAΑ F έ@ ΜBFΑB GΓέ@ΜFFΑF GΗέ@Μ@CFΑB GAΗέ@ΜΐCFΑB GΗέ@Μ@D @ έ@        Effect    CreateEffect    SetCategory    CATEGORY_SPECIAL_SUMMON    SetType    EFFECT_TYPE_ACTIVATE    SetCode    EVENT_FREE_CHAIN    SetProperty    EFFECT_FLAG_CARD_TARGET    SetCost 	   c9990752    cost 
   SetTarget    target    SetOperation 	   activate    RegisterEffect    CATEGORY_TOHAND    EFFECT_TYPE_IGNITION 	   SetRange    LOCATION_GRAVE    SetCountLimit       π?   EFFECT_COUNT_CODE_DUEL     LcA   SetCondition    aux    exccon    target2    operation2             @$ E                                                   	   	   	   	   
   
   
   
                                                                                                                                                c     E      e1    E      e2 #   E         _ENV    "   	 5    @ FB@ Gΐ ΑΒ    AΓ  A ^ _  FB@ GBΑA @ΐ ΓA A    ΐ Δ  FA ]Β Xΐ@ B@ BBΖB   AΓ B Γ  AΓ  Γ  Δ   @ B@ BCΐB Γ ΒC  AΓ  Γ  ΖA B                 Duel    CheckRemoveOverlayCard       π?   REASON_COST    GetMatchingGroup    Card    LOCATION_MZONE 	   GetCount    Hint    HINT_SELECTMSG       @   Select    HintSelection 	   GetFirst    RemoveOverlayCard             @$ 5                                                                                                                                       !   !   !   !   !   !   !   !   "   
      e     5      tp     5      eg     5      ep     5      ev     5      re     5      r     5      rp     5      chk     5      sg    5         _ENV #   %        Μ @ έ ΐΐΜ@ έ Ϋ   @Ζΐ@ Η ΑAA A@ ΑA ΑA   D  @  ΜBB έ B  @  ΐ  έ@ Γ@  Γ  ί          GetRank         	   IsFaceup    Duel    IsExistingMatchingCard 	   c9990752    filter2    LOCATION_EXTRA       π?   GetRace    GetCode             @$     $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   $   %         c            e            tp               _ENV &   *    ,   Μ@ AB  έΫ  ΐ Xΐ@ Γ  ί ΜΑ@@   έ ΫA  @ Γ  ί ΜA έ BΑ  @ΜA @ έΫ  ΜΑA FB έΫ  @ΜAB @ B ΐ  C  έ@ ΓA  Γ ί         IsCode     &WA   Pτ\A   IsCanBeXyzMaterial    GetRank       π?   IsRace    IsAttribute    ATTRIBUTE_LIGHT    IsCanBeSpecialSummoned    SUMMON_TYPE_XYZ             @$ ,   '   '   '   '   '   '   '   '   '   (   (   (   (   (   (   (   (   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   *         c     ,      rk     ,      rc     ,      code     ,      e     ,      tp     ,      mc     ,         _ENV +   1   
 J   [   ΐ    Bΐ@   @Β@ Aΐ   @   @AA ΒAΐ @  A BBΖΒ@ ΗΑ  F@ C Α   @   @ B    A ΒBΖC   FCC B A Cΐ Γ@ A@ @ ΑC  A   ΐ    ΖA ΗΒΓC FD   Α   FDD έB        IsControler    IsLocation    LOCATION_MZONE 	   c9990752    filter1            Duel    GetLocationCount       πΏ   IsExistingTarget       π?   Hint    HINT_SELECTMSG    HINTMSG_TARGET    SelectTarget    SetOperationInfo    CATEGORY_SPECIAL_SUMMON    LOCATION_EXTRA             @$ J   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   .   .   .   .   .   .   /   /   /   /   /   /   /   /   /   /   /   /   /   /   0   0   0   0   0   0   0   0   0   1         e     J      tp     J      eg     J      ep     J      ev     J      re     J      r     J      rp     J      chk     J      chkc     J      g @   J         _ENV 2   ;    x   @ B@ L@ ]    Β@ B   
A     ΐBAC B  ΒA   B  @Α      @ BΖBB ΗΒ  FΓB  Α   LDC] C ΜΔCέ    @  B      @ DΖBD   FD B @ ΒDΐ CB B@ ΓB Α  A   ΜDCέ C LΕC]   ΐ   E ΜBEέ Ε X C @ ΓE@ CFCF Fΐ  C  @ ΓE@ CF Fΐ  C  @ ΓF@ G ΐ   C    ΖDG C GC         Duel    GetFirstTarget    GetHandler    IsFacedown    IsRelateToEffect    IsControler       π?   IsImmuneToEffect    IsExistingMatchingCard 	   c9990752    filter2    LOCATION_EXTRA            GetRank    GetRace    GetCode    Hint    HINT_SELECTMSG    HINTMSG_SPSUMMON    SelectMatchingCard 	   GetFirst    GetOverlayGroup 	   GetCount    Overlay    SetMaterial    Group 
   FromCards    SpecialSummon    SUMMON_TYPE_XYZ    POS_FACEUP    CompleteProcedure             @$ x   3   3   3   3   3   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   7   8   8   8   8   8   8   8   8   8   8   8   9   9   9   9   9   9   9   9   9   9   9   9   9   9   :   :   :   :   :   :   :   :   :   :   :   :   ;         e     x      tp     x      eg     x      ep     x      ev     x      re     x      r     x      rp     x      tc    x      c    x      sc R   x      mg T   x         _ENV <   ?   	     @ LB@ ] Lΐ^ _  FΒ@ GΑ  ΖBA C@  A   Α  ]B                GetHandler    IsAbleToHand    Duel    SetOperationInfo    CATEGORY_TOHAND       π?            @$    =   =   =   =   =   =   =   >   >   >   >   >   >   >   >   >   >   ?   	      e           tp           eg           ep           ev           re           r           rp           chk              _ENV @   C       @  LB@ΐ  ][  F@ GΒΐ Δ  A ]B F@ GBΑB ΐ ]B        GetHandler    IsRelateToEffect    Duel    SendtoHand    REASON_EFFECT    ConfirmCards       π?            @$    A   A   B   B   B   B   B   B   B   B   B   B   B   B   B   B   B   B   C   	      e           tp           eg           ep           ev           re           r           rp           c             _ENV        @$                "      #   %   #   &   *   &   +   1   +   2   ;   2   <   ?   <   @   C   @   C             _ENV 