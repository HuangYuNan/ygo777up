LuaR  

             @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@@ e@ 
@         require    script/c9990000 	   c9992010    initial_effect    Dazz_name_Azorius 	   spfilter    sumtg    sumop    drtg    drop           ?   F @ G@ΐ    ] ΐ Α  @ Α A @Α Α @ Β A A @ ΐΒ  @@Γ C ΑC@ Δ C AD@D   @ @ @@ΐ    Μ@AΑ έ@Μ AAA έ@ΜΐBA έ@Μ BAA A έ@ ΜAA έ@Μ@CFC GΑΕέ@Μ DFC GΖέ@ΜD @ έ@        Effect    CreateEffect    SetCategory      @@   SetType       `@   SetCode      0@   SetCountLimit       π?    άsA   SetProperty      π@
   SetTarget 	   c9992010    sumtg    SetOperation    sumop    RegisterEffect      π@     τ@    D|A     8@   drtg    drop             @$ ?                                          	   	   	   	   
   
   
                                                                                                                                          c     ?      e1    ?      e2 #   ?         _ENV        
   Ζ @ Η@ΐ   έ Ϋ   Μ@ @ Α  ΐ   C  έί          Dazz 
   IsAzorius    IsCanBeSpecialSummoned                     @$                                                       c           e           tp              _ENV    )   
 Z   [  @     @@B@ @ΖΒ@ ΗΑ  AC   Α ΔA      ΐB@ @ΖB ΗBΒ  A   Α   @    B@ ΒBΑ   AC B B@ Cΐ Γ@ A@ C Α   A ΔA    ΖB@ ΗΒΒ @ Γ έB ΖB@ ΗΓ  FB GCΒ Α   A  Δ     @ έC@ DA  C ΐ  A    CC@ DA   ΐ A    C                Duel    IsExistingTarget    Card    IsAbleToHand       @      π?   GetHandler 	   c9992010 	   spfilter       0@   Hint       @     @   SelectTarget      Π@   SetOperationInfo        @      @            @$ Z                                                                         !   !   !   !   !   !   !   !   !   !   !   !   !   #   #   #   #   #   #   $   $   $   $   $   $   $   $   $   $   $   $   $   %   %   %   %   %   %   &   &   &   &   &   &   &   &   &   &   &   &   &   &   '   '   '   '   '   '   '   '   '   (   (   (   (   (   (   (   (   (   )         e     Z      tp     Z      eg     Z      ep     Z      ev     Z      re     Z      r     Z      rp     Z      chk     Z      chkc     Z      g1 3   Z      g2 G   Z         _ENV *   /    3   @ B@A  Β  Β@ B@Α   ΒCΑ A    @ ΓA@  Α  X@CΑ CB C      CΑ A    @@ ΓB@  ΐ   C    Α C         Duel    GetOperationInfo                @      @	   GetFirst    IsRelateToEffect    SendtoHand       P@   IsLocation      P@   SpecialSummon       @            @$ 3   +   +   +   +   +   ,   ,   ,   ,   ,   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   /         e     3      tp     3      eg     3      ep     3      ev     3      re     3      r     3      rp     3      ex    3      g1    3      ex 
   3      g2 
   3         _ENV 0   8   
 O   @  [  @ΜBΐA  έΫ  ΐΜΒΐέ Ϋ  ΐXΐ ΜΑ@ έ@ ΓB  Γ ί @A@ΖA ΗΒΑ  A έΫ  @ΖA ΗBΒB Γ@@   ΑC  @ έί ΖA ΗΒΒ @ C έB ΖA ΗΓ  FB GΓΐ Α  D A  ΐ έA ΓCAC  ΐ AD D CA ΓCAC C Δ  D @  C        GetHandler    IsLocation       @   IsAbleToHand    IsControler            Duel    IsPlayerCanDraw       π?   IsExistingTarget    Card    Hint       @     @   SelectTarget    SetOperationInfo        @      π@            @$ O   1   1   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   7   7   7   7   7   7   7   7   7   8         e     O      tp     O      eg     O      ep     O      ev     O      re     O      r     O      rp     O      chk     O      chkc     O      c    O      g <   O         _ENV 9   >       @ B@   ΐL@ΐ  ][  F@ GΒΐ Δ   ] X@ΑLAΑΒ ][  @F@ GΒ ΑB  ]B   
      Duel    GetFirstTarget    IsRelateToEffect    SendtoHand       P@           IsLocation      P@   Draw       π?            @$    :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   <   <   >   	      e           tp           eg           ep           ev           re           r           rp           tc             _ENV        @$                                        )      *   /   *   0   8   0   9   >   9   >             _ENV 