LuaR  

         !    @ A@  @ @ e   
@@ 
@A@ e@  
@ @ e  
@@ eΐ  
@ @ e  
@@ e@ 
@ @ e 
@@ eΐ 
@ @ e  
@        require    script/c9990000 	   c9992112    initial_effect    Dazz_name_Azorius    splimit    aclimit    actcon    thcon    filter 	   thfilter    thtg    thop 	      5    t   L @ ]@ F@@ Gΐ    ε   A@ Α@FA GAΑ C ]@FΐA G Β    ] @Β  @ΐΒ  @@Γ  @ΐΓ D AD@D   @ΐA  Bΐ    Μ@BAΑ έ@Μ@CA έ@Μ@EA έ@ΜΐEeA  έ@ΜD @ έ@ΖΐA Η Β   έ AΒ AΑΒA AAΓ AAΕ AΑΖ Α A ΑΓD AGAΗD ΑGAD AΑA B@   LABΑ ]ALΑBΑA ]ALHΑΑ ]ALACΑ	 ]ALGΖD ΗAΙ]ALIΖD ΗΑΙ]ALΑEΖD ΗΚ]ALD ΐ ]A  )      EnableReviveLimit    aux    AddFusionProcFun2    FilterBoolFunction    Card    IsAttribute       0@   Effect    CreateEffect    SetType       π?   SetProperty      A   SetCode       >@	   SetValue 	   c9992112    splimit    RegisterEffect       @     Ό@	   SetRange       @   SetOperation        @       @      @   SetTargetRange            aclimit    SetCondition    actcon      @      τ@   SetCategory        @     Έ@   thcon 
   SetTarget    thtg    thop              F @ G@ΐ    Ζ@ Ηΐΐ^ _           Dazz 
   IsAzorius    Card    GetFusionCode             @$                                  c              _ENV       	 0   F@ GBΐ] @ @   @ΜΒ@ έ ΜΑέ ΫB      ΖBA ΗΑΓ@  έ  ΓΑ CCΒ CΓΒ CCΓΓ C  ΓΓΓ C Δ LCCΜCέ ]C  LΓCΐ  ]C         Duel    GetAttacker    GetAttackTarget    GetHandler    IsRelateToBattle    Effect    CreateEffect    SetType       π?   SetCode      Y@	   SetReset      ΠA	   SetValue    GetDefense    RegisterEffect    Clone             @$ 0                                                                                                                                                         e     0      tp     0      eg     0      ep     0      ev     0      re     0      r     0      rp     0      chk     0      a    0      d    0      e1    0      e2 '   0         _ENV         @$ t                                                                  	   	   	   
   
   
                                                                                    "   "   "   "   #   #   #   $   $   $   %   %   %   &   &   &   '   '   '   '   (   (   (   (   )   )   )   )   *   *   *   ,   ,   ,   ,   -   -   -   .   .   .   /   /   /   0   0   0   1   1   1   1   2   2   2   2   3   3   3   3   4   4   4   5         c     t      e1    t      e2 &   t      e3 9   t      e4 X   t         _ENV 7   <       @  A@    @Α@ A@A X@A  A              GetHandler    IsLocation       P@   bit    band      ΐΠA            @$    8   8   8   8   8   8   8   9   9   9   9   9   9   9   9   9   9   ;   ;   <         e           se           sp           st              _ENV =   ?       Μ ΐ έ Μ@ΐ@  έΤ ί          GetHandler    IsImmuneToEffect            @$    >   >   >   >   >   >   >   ?         e           re           tp            @   D    $   L @ ] L@ΐ ] @ ΐ@ Ζ@ Η Αέ  @ΐAA A@     ΑA A   AA A@    ΑΑ          GetHandler    GetControler    Duel    GetAttacker    GetAttackTarget    Dazz 
   IsAzorius    IsControler             @$ $   A   A   A   A   B   B   B   B   B   B   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   D         e     $      p    $      a 
   $      d 
   $         _ENV E   G       @  B@            GetHandler    IsPreviousPosition       @           @$    F   F   F   F   F   F   G         e           tp           eg           ep           ev           re           r           rp            H   L    "   Μ @ @ έΫ   @Μ@@ A  έΫ    Ζΐ@ Η ΑAA  A έΑ ΜΐA έ  Μ B έ Ϋ    Μ@B A έ@ Γ@  Γ  ί          IsControler    IsLocation       0@   bit    band 
   GetReason       A   GetReasonCard    IsAbleToHand    IsHasEffect      0r@            @$ "   I   I   I   I   I   I   I   I   J   J   J   J   J   J   J   J   J   J   J   J   J   J   K   K   K   K   K   K   K   K   K   K   K   L         c     "      tp     "      fus     "         _ENV M   S        @  Μ@@ έ @ Α@@  AAA XAΑAB ABΑ   @   A              GetMaterial    GetSummonType    bit    band      ΐΠA	   GetCount         	   IsExists 	   c9992112    filter       π?            @$    N   N   O   O   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   Q   S         c           tp           mg          sumtype             _ENV T   Z   	     @@ C _ FB@ GΐΒ@  ΐ ][  @A BAΑ   @ΓΑ Α    B             	   c9992112 	   thfilter    GetHandler    Duel    SetOperationInfo        @	   GetCount             @$    U   U   U   U   V   V   V   V   V   V   W   W   X   X   X   X   X   X   X   X   X   X   Z   
      e           tp           eg           ep           ev           re           r           rp           chk           mg 
            _ENV [   a       @ B@L@ ]    FΒ@ GΑ Δ  C ]B FΒ@ GΑBΐ ]B     	   c9992112 	   thfilter    GetHandler    Duel    SendtoHand       P@   ConfirmCards       π?            @$    \   \   \   \   \   \   ]   ]   ^   ^   ^   ^   ^   ^   _   _   _   _   _   a   	      e           tp           eg           ep           ev           re           r           rp           mg             _ENV        @$ !               5      6   6   7   <   7   =   ?   =   @   D   @   E   G   E   H   L   H   M   S   M   T   Z   T   [   a   [   a             _ENV 